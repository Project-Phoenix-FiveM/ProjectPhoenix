local QBCore = exports['qb-core']:GetCoreObject()

local targetBusy = false
local plants = {}
local plantObject = nil
local dryingWeed = false
local weedPed = nil
local pedWeedBucket = nil
local weedBucket = nil
local hasBucket = false
local driedWeedReady = false
local weedPedBlip = nil
local bucketItem = nil
local bucketItemAmount = 0

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteEntity(pedWeedBucket)
        for _, v in pairs(plants) do
            SetEntityAsMissionEntity(v, true, true)
            NetworkRequestControlOfEntity(v)
            DeleteObject(v)
        end
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Player = QBCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Player = QBCore.Functions.GetPlayerData().job
end)

local function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end

local function ItemAmount(itemName, itemAmount)
    local playeritems = QBCore.Functions.GetPlayerData().items
    for _, v in pairs(playeritems) do
        if v.name == itemName then
            return v.amount >= itemAmount
        end
    end
    return false
end

local function DryWeed(entity, weedPlant, selectedAmount)
    local playerPed = PlayerPedId()
    dryingWeed = true
    QBCore.Functions.Progressbar('reap_crop', Lang:t('progressbar.handing'), math.random(2500, 3500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('kevin-weed:removeplants', weedPlant, selectedAmount)
        QBCore.Functions.Notify(Lang:t('progressbar.plants_drying'), 'primary')
        Wait(Config.DryWeedTimer * 60000)
        weedPedBlip = AddBlipForEntity(entity)
        SetBlipSprite(weedPedBlip, 140)
        SetBlipColour(weedPedBlip, 43)
        SetBlipScale(weedPedBlip, 0.55)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Lang:t('blip.dried_blip'))
        EndTextCommandSetBlipName(weedPedBlip)

        QBCore.Functions.Notify(Lang:t('success.dried_ready'), 'primary')
        driedWeedReady = true
    end, function() -- Cancel
        dryingWeed = false
        ClearPedTasks(playerPed)
        QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
    end)
end

local function ShowInput(entity)
    local playeritems = QBCore.Functions.GetPlayerData().items
    local bucketData = Config.WeedBucketDrying['weed_bucket'].items
    local itemOptions = {}

    for itemName, itemData in pairs(bucketData) do
        for _, v in pairs(playeritems) do
            if v.name == itemName then
                if v.amount >= itemData.minamount then
                    itemOptions[#itemOptions+1] = {
                        label = QBCore.Shared.Items[v.name]['label']..' (Max: '..itemData.maxamount..')',
                        value = v.name,
                    }
                end
            end
        end
    end

    if #itemOptions > 0 then
        local header = Lang:t('input.select_plant')
        local input = lib.inputDialog(header, {
            { type = 'select', label = Lang:t('input.item'), options = itemOptions, icon = 'fab fa-pagelines'},
            { type = 'number', label = Lang:t('input.dry_amount'), icon = 'hashtag'},
        })

        if not input then return end
        local weedPlant = input[1]
        bucketItemAmount = input[2]
        local maxAmount = bucketData[weedPlant].maxamount
        local minAmount = bucketData[weedPlant].minamount
        bucketItem = bucketData[weedPlant].buditemname
        local itemAmount = ItemAmount(weedPlant, bucketItemAmount)
        if weedPlant then
            if itemAmount then
                if bucketItemAmount == 0 or bucketItemAmount == nil then return end
                if bucketItemAmount <= maxAmount  and bucketItemAmount >= minAmount then
                    DryWeed(entity, weedPlant, bucketItemAmount)
                else
                    QBCore.Functions.Notify(Lang:t('warning.bottle_exceed'), 'error')
                end
            else
                QBCore.Functions.Notify(Lang:t('warning.insufficentamount'), 'error')
            end
        end
    else
        QBCore.Functions.Notify(Lang:t('warning.unselected'), 'error')
    end
end


local function TrevorWeedPed()
    local hash = Config.WeedPed.hash
    QBCore.Functions.LoadModel(hash)
    weedPed = CreatePed(0, hash, Config.WeedPed.location.x, Config.WeedPed.location.y, Config.WeedPed.location.z-1.0, Config.WeedPed.location.w, false, false)
    FreezeEntityPosition(weedPed, true)
	SetEntityInvincible(weedPed, true)
	SetBlockingOfNonTemporaryEvents(weedPed, true)

    exports['qb-target']:AddTargetEntity(weedPed, {
        options = {
            {
                icon = 'fas fa-circle',
                label = Lang:t('target.dry_weed'),
                canInteract = function()
                    return not hasBucket and not dryingWeed
                end,
                action = function(entity)
                    ShowInput(entity)
                end,
            },
            {
                icon = 'fas fa-circle',
                label = Lang:t('target.collect_bucket'),
                canInteract = function()
                    return driedWeedReady
                end,
                action = function()
                    TriggerServerEvent('kevin-weed:giveweedbucket', bucketItem, bucketItemAmount)
                end,
            },
        },
        distance = 2.0
    })
end

local function SpawnPlants(data)
    if not data.spawn then return end
    local plantObjects = {}
    for i = 1, data.amount do
        local plantModel = `prop_weed_01`
        local x = data.coords.x + (i * 0.5) + math.random(-data.radius, data.radius)
        local y = data.coords.y + (i * 0.5) + math.random(-data.radius, data.radius)
        local z = data.coords.z + 999.0
        local ground, safe = GetGroundZFor_3dCoord(x + .0, y + .0, z, 1)
        if ground then
            local specialPlant = data.plant
            Wait(0)
            QBCore.Functions.LoadModel(specialPlant)
            plantObject = CreateObject(plantModel, x, y, safe, false, true, false)
            PlaceObjectOnGroundProperly(plantObject)
            SetEntityAsMissionEntity(plantObject, true, true)
            SetEntityRotation(plantObject, 0.0, 0.0, 0.0, 0, true)
            FreezeEntityPosition(plantObject, true)
            plants[#plants + 1] = plantObject
            table.insert(plantObjects, plantObject)
        end
    end

    if not DoesEntityExist(plantObject) then return end
    if data.replaceamount < data.amount then
        for i = 1, data.replaceamount do
            local replacePlantIndex = math.random(#plantObjects)
            local replacePlantObject = plantObjects[replacePlantIndex]
            local newModel = data.plant
            Wait(0)
            local plantCoords = GetEntityCoords(replacePlantObject)
            QBCore.Functions.LoadModel(newModel)
            local specialPlant = CreateObject(newModel, plantCoords, false, true, false)
            SetEntityAsMissionEntity(specialPlant, true, true)
            SetEntityRotation(specialPlant, 0.0, 0.0, 0.0, 0, true)
            FreezeEntityPosition(specialPlant, true)
            SetModelAsNoLongerNeeded(newModel)
            DeleteObject(replacePlantObject)
            plants[#plants + 1] = specialPlant
            if #plantObjects > 0 then
                table.remove(plantObjects, replacePlantIndex)
            end
        end
    end
end

function HasBuff(buff)
    return exports['ps-buffs']:HasBuff(buff)
end

local function ReapAnimation()
    local player = PlayerPedId()
    LoadAnim('amb@world_human_gardener_plant@male@enter')
    LoadAnim('amb@world_human_gardener_plant@male@base')
    TaskPlayAnim(player, 'amb@world_human_gardener_plant@male@enter', 'enter', 1.0, 1.0, -1, 1, 0, false, false, false)
    Wait(2800)
    TaskPlayAnim(player, 'amb@world_human_gardener_plant@male@base', 'base', 1.0, 1.0, -1, 1, 0, false, false, false)
end

local function HarvestPlant(entity)
    local playerPed = PlayerPedId()
    local plantModel = GetEntityModel(entity)
    local hasBuff = HasBuff(Config.WeedBuffs.name)
    targetBusy = true
    TaskTurnPedToFaceEntity(playerPed, entity, -1)
    Wait(1500)
    ReapAnimation()
    QBCore.Functions.Progressbar('reap_crop', Lang:t('progressbar.reaping'), math.random(1000, 2500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        LoadAnim('amb@world_human_gardener_plant@male@exit')
        TaskPlayAnim(playerPed, 'amb@world_human_gardener_plant@male@exit', 'exit', 1.0, 1.0, -1, 1, 0, false, false, false)
        Wait(5000)
        ClearPedTasksImmediately(playerPed)
        SetEntityAsMissionEntity(entity, true, true)
        NetworkRequestControlOfEntity(entity)
        Wait(500)
        targetBusy = false
        TriggerServerEvent('kevin-weed:giveweedleaves', hasBuff, plantModel)
        DeleteEntity(entity)
        SetEntityAsNoLongerNeeded(entity)
    end, function() -- Cancel
        targetBusy = false
        ClearPedTasks(playerPed)
        QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
    end)
end

CreateThread(function ()
    TrevorWeedPed()
    exports['qb-target']:AddTargetModel(Config.PlantModels, {
        options = {
            {
                icon = 'fas fa-circle',
                label = Lang:t('target.harvest'),
                action = function(entity)
                    if Config.JobProperties['jobneeded'] then
                        if Player.job.name == Config.JobProperties['job'] then
                            HarvestPlant(entity)
                        end
                    else
                        HarvestPlant(entity)
                    end
                end,
                canInteract = function(entity)
                    for _, plant in ipairs(plants) do
                        if entity == plant and not hasBucket and not targetBusy then
                            return true
                        end
                    end
                    return false
                end
            },
        },
        distance = 2.5
    })

    for k, data in pairs(Config.WeedPlantSpawnProperties.locations) do
        local weedZone = CircleZone:Create(data.coords, 100.0, {
            name = 'weed-zone'..k,
            debugPoly = false
        })
        weedZone:onPlayerInOut(function(isPointInside, point, zone)
            if isPointInside then
                Wait(1000)
                SpawnPlants(data)
            else
                for _, v in pairs(plants) do
                    SetEntityAsMissionEntity(v, true, true)
                    NetworkRequestControlOfEntity(v)
                    DeleteObject(v)
                end
            end
        end)

        if data.showblip then
            local weedFieldBlips = AddBlipForCoord(data.coords)
            SetBlipSprite(weedFieldBlips, data.blipsprite)
            SetBlipColour(weedFieldBlips, data.blipcolor)
            SetBlipScale(weedFieldBlips, data.blipscale)
            SetBlipAsShortRange(weedFieldBlips, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(data.blipname)
            EndTextCommandSetBlipName(weedFieldBlips)

            local weedFieldArea = AddBlipForRadius(data.coords, data.blipradius)
            SetBlipColour(weedFieldArea, data.blipcolor)
            SetBlipAlpha(weedFieldArea, data.blipzoneopacity)
        end
    end
end)

RegisterNetEvent('kevin-weedprocessing:clearweedped', function ()
    driedWeedReady = false
    dryingWeed = false
    RemoveBlip(weedPedBlip)
end)

RegisterNetEvent('kevin-weedprocessing:usebuditem', function (item, data)
    local playerPed = PlayerPedId()
    QBCore.Functions.Progressbar('reap_crop', Lang:t('progressbar.cleaning'), math.random(1500, 3500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('kevin-weed:removeandgiveitem', 1, item, data)
    end, function() -- Cancel
        ClearPedTasks(playerPed)
        QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
    end)
end)


RegisterNetEvent('kevin-weedprocessing:useemptyjar', function (item)
    if not item then return end
    local playeritems = QBCore.Functions.GetPlayerData().items
    local emptyJarItems = Config.UseableEmptyJar['emptyweed_jar'].items
    local itemOptions = {}

    for itemName, itemData in pairs(emptyJarItems) do
        for _, v in pairs(playeritems) do
            if v.name == itemName then
                if v.amount >= itemData.minamount then
                    itemOptions[#itemOptions+1] = {
                        label = QBCore.Shared.Items[v.name]['label']..Lang:t('input.max', {maxamount = itemData.maxamount}),
                        value = v.name,
                    }
                end
            end
        end
    end

    if #itemOptions > 0 then
        local header = Lang:t('input.select_nugget')
        local input = lib.inputDialog(header, {
            { type = 'select', label = Lang:t('input.item'), options = itemOptions, icon = 'fab fa-pagelines'},
            { type = 'number', label = Lang:t('input.bottle_amount'), icon = 'hashtag'},
        })

        if not input then return end
        local itemName = input[1]
        local selectedAmount = input[2]
        local maxAmount = emptyJarItems[itemName].maxamount
        local minAmount = emptyJarItems[itemName].minamount
        local itemAmount = ItemAmount(itemName, selectedAmount)
        if itemName then
            if itemAmount then
                if selectedAmount == 0 or selectedAmount == nil then return end
                if selectedAmount <= maxAmount  and selectedAmount >= minAmount then
                    TriggerServerEvent('kevin-weedprocessing:packemptyjar', itemName, selectedAmount)
                else
                    QBCore.Functions.Notify(Lang:t('warning.bottle_exceed'), 'error')
                end
            else
                QBCore.Functions.Notify(Lang:t('warning.insufficentamount'), 'error')
            end
        end
    else
        QBCore.Functions.Notify(Lang:t('warning.unselected'), 'error')
    end
end)

RegisterNetEvent('kevin-weedprocessing:usenuggetitem', function (item, data)
    local playerPed = PlayerPedId()
    QBCore.Functions.Progressbar('reap_crop', Lang:t('progressbar.packing_cone'), math.random(1500, 3500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('kevin-weed:removeandgiveitem', 2 , item, data)
    end, function() -- Cancel
        ClearPedTasks(playerPed)
        QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
    end)
end)

local function DisableControls()
    CreateThread(function ()
        while hasBucket do
            DisableControlAction(0, 21, true) -- Sprinting
            DisableControlAction(0, 22, true) -- Jumping
            DisableControlAction(0, 23, true) -- Vehicle Entering
            DisableControlAction(0, 36, true) -- Ctrl
            DisableControlAction(0, 24, true) -- Disable Attack
            DisableControlAction(0, 25, true) -- Disable Aim
            Wait(0)
        end
    end)
end

local function CarryAnimation()
    local player = PlayerPedId()
    LoadAnim('anim@heists@box_carry@')
    TaskPlayAnim(player, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
    DisableControls()
    CreateThread( function ()
        while hasBucket do
            if not IsEntityPlayingAnim(player, 'anim@heists@box_carry@', 'idle', 3) then
                TaskPlayAnim(player, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
            end
            Wait(1000)
        end
    end)
end

CreateThread(function()
    while true do
        local isLoggedIn = LocalPlayer.state['isLoggedIn']
        if isLoggedIn then
            local player = PlayerPedId()
            local WeedPlantItem = QBCore.Functions.HasItem(Config.WeedBucktItem)
            if WeedPlantItem then
                if not hasBucket then
                    hasBucket = true
                    CarryAnimation()
                    QBCore.Functions.LoadModel(`bkr_prop_weed_bucket_open_01a`)
                    weedBucket = CreateObject(`bkr_prop_weed_bucket_open_01a`, 0, 0, 0, true, true, true)
                    AttachEntityToEntity(weedBucket, player, GetPedBoneIndex(player, 28422), 0.0, -0.1000, -0.1800, 0.0, 0.0, 0.0, true, true, false, false, 0, true)
                end
            elseif hasBucket then
                ClearPedTasks(player)
                DeleteEntity(weedBucket)
                hasBucket = false
            end
        end
        Wait(1000)
    end
end)

