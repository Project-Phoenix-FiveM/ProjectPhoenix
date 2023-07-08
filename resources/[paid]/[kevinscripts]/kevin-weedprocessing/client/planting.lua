local QBCore = exports['qb-core']:GetCoreObject()

local weedPlants = {}

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerEvent('kevin-weedprocessing:refreshplants')
    PlayerData = QBCore.Functions.GetPlayerData()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerData = QBCore.Functions.GetPlayerData()
        TriggerEvent('kevin-weedprocessing:refreshplants')
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _, v in pairs(weedPlants) do
            if v.isRendered then
                SetEntityAsMissionEntity(v.plant, true, true)
                NetworkRequestControlOfEntity(v.plant)
                DeleteObject(v.plant)
            end
        end
    end
end)
-- 
-- THREADS
-- 

local spawnRange = 100
CreateThread(function()
    while true do
        for k, plant in pairs(weedPlants) do
            local player = PlayerPedId()
            local playerCoords = GetEntityCoords(player)
            local dist = #(playerCoords - plant.coords)

            if dist < spawnRange and not plant.isRendered then
                CreateWeedPlants(plant)
            elseif dist >= spawnRange and plant.isRendered then
                DeletePlants(k)
            end
        end
        Wait(1500)
    end
end)

function FindGround()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    local num = StartShapeTestCapsule(coords.x, coords.y, coords.z+4, coords.x, coords.y, coords.z-1.0, 1, 1, player, 7)
    local arg1, arg2, arg3, arg4, groundHash = GetShapeTestResultEx(num)

    local forward = GetEntityForwardVector(PlayerPedId())
    local x = coords.x + forward.x * 0.8
    local y = coords.y + forward.y * 0.8
    local z = coords.z + forward.z * 0.8
    local plantCoords = vector3(x, y, z)
    return plantCoords, groundHash
end

RegisterNetEvent('kevin-weedprocessing:useweedseed', function (itemName, gender)
    local player = PlayerPedId()
    if IsPedOnFoot(player) then
        local plantCoords, groundHash = FindGround()
        local zone = GetLabelText(GetNameOfZone(plantCoords.x, plantCoords.y, plantCoords.z))
        if Planting.GroundHashes[groundHash] then
            QBCore.Functions.Progressbar('plant_weed_plant', Lang:t('progressbar.planting'), 8000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'amb@world_human_gardener_plant@male@base',
                anim = 'base',
                flags = 1,
            }, {}, {}, function() -- Done
                ClearPedTasks(player)
                TriggerServerEvent('kevin-weedprocessing:placePlant', gender, itemName, json.encode(plantCoords), itemName, groundHash, zone)
            end, function() -- Cancel
                ClearPedTasks(player)
                QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
            end)
        else
            QBCore.Functions.Notify(Lang:t('warning.soil_unsuitable'), 'error', 4000)
        end
    end
end)

RegisterNetEvent('kevin-weedprocessing:refreshplants', function()
    QBCore.Functions.TriggerCallback('kevin-weedprocessing:getplants', function(plants)
        if plants then
            for _, plant in pairs(plants) do
                local id = tostring(plant.id)
                if weedPlants ~= nil then
                    if weedPlants[id] then
                        weedPlants[id].food = plant.food
                        weedPlants[id].water = plant.water
                        weedPlants[id].progress = plant.progress
                        weedPlants[id].health = plant.health
                        weedPlants[id].harvestable = plant.harvestable
                        weedPlants[id].plantdead = plant.plantdead
                        local plantName = Planting.Plants[plant.seedname].stage[plant.stage]
                        if weedPlants[id].plantmodel ~= plantName then
                            DeletePlants(id)
                            weedPlants[id].plantmodel = plant.plantmodel
                        end
                        weedPlants[id].stage = plant.stage
                        weedPlants[id].type = plant.type
                    else
                        weedPlants[id] = plant
                        weedPlants[id].seedname = Planting.Plants[plant.seedname].label
                        weedPlants[id].plantmodel = plant.plantmodel
                        weedPlants[id].coords = vector3(json.decode(plant.coords).x, json.decode(plant.coords).y, json.decode(plant.coords).z)
                    end
                end
            end
        end
    end)
end)

function AddPlantTarget(weedPlant, plant)
    local burning = false
    exports['qb-target']:AddTargetEntity(weedPlant, {
        options = {
            {
                num = 1,
                icon = 'fas fa-seedling',
                label = Lang:t('target.check'),
                action = function()
                    ShowPlantMenu(plant)
                end,
            },
            {
                num = 2,
                icon = 'fas fa-seedling',
                label = Lang:t('target.harvest'),
                canInteract = function()
                    return plant.harvestable and not plant.plantdead and plant.food and plant.water >= Planting.HarvestWaterFoodAmount
                end,
                action = function()
                    HarvestPlant(plant)
                end,
            },
            {
                num = 3,
                icon = 'fas fa-bottle-water',
                label = Lang:t('target.water'),
                canInteract = function()
                    return plant.water < Planting.WaterAmount and not plant.plantdead or plant.harvestable
                end,
                action = function()
                    WaterPlant(plant)
                end,
            },
            {
                num = 4,
                icon = 'fas fa-circle',
                label = Lang:t('target.fertilize'),
                canInteract = function()
                    return plant.food < Planting.FoodAmount and not plant.plantdead or plant.harvestable
                end,
                action = function()
                    FertilizePlant(plant)
                end,
            },
            {
                num = 5,
                icon = 'fas fa-scissors',
                label = Lang:t('target.destroy'),
                action = function()
                    DestroyPlant(plant)
                end,
            },
            {
                num = 6,
                icon = 'fas fa-fire',
                label = Lang:t('target.burn'),
                canInteract = function()
                    return CheckJobs()
                end,
                action = function()
                    burning = true
                    TriggerServerEvent('kevin-weedprocessing:deleteplant', burning, plant)
                end,
            },
        },
        distance = 2.5
    })
end

function CheckJobs()
    local playerName = PlayerData.job.name
    for key, jobName in pairs(Planting.PoliceJobs) do
        if playerName == jobName then
            return true
        end
    end
    return false
end

function DestroyPlant(plant)
    local player = PlayerPedId()
    QBCore.Functions.Progressbar('plant_weed_plant', Lang:t('progressbar.removing'), 8000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        anim = 'machinic_loop_mechandplayer',
        flags = 1,
    }, {}, {}, function() -- Done
        ClearPedTasks(player)
        TriggerServerEvent('kevin-weedprocessing:deleteplant', false, plant)
    end, function() -- Cancel
        ClearPedTasks(player)
        QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
    end)
end

function WaterPlant(plant)
    local player = PlayerPedId()
    local Item = QBCore.Functions.HasItem(Planting.WaterCanItem)
    if Item then
        QBCore.Functions.Progressbar('plant_weed_plant', Lang:t('progressbar.watering'), 8000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'weapon@w_sp_jerrycan',
            anim = 'fire',
            flags = 1,
        }, {}, {}, function() -- Done
            ClearPedTasks(player)
            TriggerServerEvent('kevin-weedprocessing:waterplant', plant)
        end, function() -- Cancel
            ClearPedTasks(player)
            QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
        end)
    else
        QBCore.Functions.Notify(Lang:t('warning.no_water'), 'error', 4000)
    end
end

function FertilizePlant(plant)
    local player = PlayerPedId()
    local Item = QBCore.Functions.HasItem(Planting.FertilizerItem)
    if Item then
        QBCore.Functions.Progressbar('plant_weed_plant', Lang:t('progressbar.fertilizing'), 8000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'weapon@w_sp_jerrycan',
            anim = 'fire',
            flags = 1,
        }, {}, {}, function() -- Done
            ClearPedTasks(player)
            TriggerServerEvent('kevin-weedprocessing:fertilizeplant', plant)
        end, function() -- Cancel
            ClearPedTasks(player)
            QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
        end)
    else
        QBCore.Functions.Notify(Lang:t('warning.no_food'), 'error', 4000)
    end
end

function HarvestPlant(plant)
    local player = PlayerPedId()
    QBCore.Functions.Progressbar('plant_weed_plant', Lang:t('progressbar.reaping'), 8000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@world_human_gardener_plant@male@base',
        anim = 'base',
        flags = 1,
    }, {}, {}, function() -- Done
        ClearPedTasks(player)
        local hasBuff = HasBuff(Config.WeedBuffs.name)
        TriggerServerEvent('kevin-weedprocessing:harvestplayerplants', hasBuff, plant)
    end, function() -- Cancel
        ClearPedTasks(player)
        QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
    end)
end

function ShowPlantMenu(plant)
    local plantstats = nil
    if plant.plantdead then plantstats = Lang:t('status.dead') else plantstats = Lang:t('status.alive') end
    lib.registerContext({
        id = 'plantmenu',
        title = Lang:t('menu.plant', {seedname = plant.seedname}),
        options = {
            {
                title = Lang:t('menu.status', {status = plantstats}),
                icon = 'fas fa-seedling',
            },
            {
                title = Lang:t('menu.stage', {stage = plant.stage}),
                icon = 'fas fa-seedling',
            },
            {
                title = Lang:t('menu.health', {health = plant.health}),
                icon = 'fas fa-seedling',
                progress = plant.health,
                colorScheme = Planting.Colors.health,
            },
            {
                title = Lang:t('menu.food', {food = plant.food}),
                icon = 'fas fa-seedling',
                progress = plant.food,
                colorScheme = Planting.Colors.food,
            },
            {
                title = Lang:t('menu.water', {water = plant.water}),
                icon = 'fas fa-seedling',
                progress = plant.water,
                colorScheme = Planting.Colors.water,
            },
            {
                title = Lang:t('menu.progress', {progress = plant.progress}),
                icon = 'fas fa-seedling',
                progress = plant.progress,
                colorScheme = Planting.Colors.progress,
            },
        }
    })
    lib.showContext('plantmenu')
end

function CreateWeedPlants(plant)
    local model = plant.plantmodel
    QBCore.Functions.LoadModel(model)
    local weedPlant = CreateObject(model, plant.coords.x, plant.coords.y, plant.coords.z, false, false, false)
    PlaceObjectOnGroundProperly(weedPlant)
    SetEntityRotation(weedPlant, 0.0, 0.0, 0.0, 0, true)
    SetModelAsNoLongerNeeded(weedPlant)
    FreezeEntityPosition(weedPlant, true)
    SetEntityAlpha(weedPlant, 0)

    for i = 0, 255, 51 do
        Wait(50)
        SetEntityAlpha(weedPlant, i, false)
    end
    plant.isRendered = true
    plant.plant = weedPlant

    AddPlantTarget(weedPlant, plant)
end

function DeletePlants(id)
    for i = 255, 0, -51 do
        Wait(50)
        SetEntityAlpha(weedPlants[id].plant, i)
    end
    NetworkRequestControlOfEntity(weedPlants[id].plant)
    SetEntityAsMissionEntity(weedPlants[id].plant, true, true)
    DeleteEntity(weedPlants[id].plant)
    DeleteObject(weedPlants[id].plant)
    weedPlants[id].isRendered = false
    weedPlants[id].plant = nil
end

RegisterNetEvent('kevin-weedprocessing:deleteplant', function(copsBurn, coords, id)
    if copsBurn then
        local asset = 'core'
        local effect = 'ent_ray_paleto_gas_flames'
        RequestNamedPtfxAsset(asset)
        while not HasNamedPtfxAssetLoaded(asset) do Wait(0) end
        SetPtfxAssetNextCall(asset)
        local fire = StartParticleFxLoopedAtCoord(effect , coords.x, coords.y, coords.z -1, 0.0, 0.0, 0.0, 0.6, false, false, false, false)
        Wait(10000)
        StopParticleFxLooped(fire, 0)
    end
    for k, v in pairs(weedPlants) do
        if k == id then
            for i = 255, 0, -51 do
                Wait(50)
                SetEntityAlpha(v.plant, i, false)
            end
            NetworkRequestControlOfEntity(v.plant)
            SetEntityAsMissionEntity(v.plant, true, true)
            DeleteEntity(v.plant)
            DeleteObject(v.plant)
            weedPlants[k] = nil
            TriggerEvent('kevin-weedprocessing:refreshplants')
            break
        end
    end
end)

RegisterNetEvent('kevin-weedprocessing:usewatercan', function (item)
    local player = PlayerPedId()
    if IsEntityInWater(player) then
        if item.info.uses < Planting.WaterCanUses then
            QBCore.Functions.Progressbar('plant_weed_plant', Lang:t('progressbar.refilling'), 4000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'weapon@w_sp_jerrycan',
                anim = 'fire',
                flags = 1,
            }, {}, {}, function() -- Done
                ClearPedTasks(player)
                TriggerServerEvent('kevin-weedprocessing:refillcan', item)
            end, function() -- Cancel
                ClearPedTasks(player)
                QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
            end)
        else
            QBCore.Functions.Notify(Lang:t('warning.can_full'), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t('warning.not_inwater'), 'error')
    end
end)