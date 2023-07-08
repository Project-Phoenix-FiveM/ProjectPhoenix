local QBCore = exports['qb-core']:GetCoreObject()
local firstAlarm = false
local smashing = false

-- Functions
local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then RequestNamedPtfxAsset("scr_jewelheist") end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do Wait(0) end
    SetPtfxAssetNextCall("scr_jewelheist")
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(3)
    end
end

local function validWeapon()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, v in pairs(Config.WhitelistedWeapons) do
        if pedWeapon == k then
            return true
        end
    end
    return false
end

local function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

local function smashVitrine(k)
    if validWeapon() then
        local animDict = "missheist_jewel"
        local animName = "smash_case"
        local ped = PlayerPedId()
        local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
        local pedWeapon = GetSelectedPedWeapon(ped)
        if math.random(1, 100) <= 80 and not IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
        elseif math.random(1, 100) <= 5 and IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
            QBCore.Functions.Notify("You've left a fingerprint on the glass", "error")
        end
        smashing = true
        QBCore.Functions.Progressbar("smash_vitrine", "Looting case", Config.WhitelistedWeapons[pedWeapon]["timeOut"], false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('qb-jewellery:server:setVitrineState', "isOpened", true, k)
            TriggerServerEvent('qb-jewellery:server:setVitrineState', "isBusy", false, k)
            TriggerServerEvent('qb-jewellery:server:vitrineReward')
            TriggerServerEvent('qb-jewellery:server:setTimeout')
            exports['ps-dispatch']:VangelicoRobbery()
            smashing = false
            TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
        end, function() -- Cancel
            TriggerServerEvent('qb-jewellery:server:setVitrineState', "isBusy", false, k)
            smashing = false
            TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
        end)
        TriggerServerEvent('qb-jewellery:server:setVitrineState', "isBusy", true, k)

        CreateThread(function()
            while smashing do
                loadAnimDict(animDict)
                TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
                Wait(500)
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
                loadParticle()
                StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                Wait(2500)
            end
        end)
    else
        QBCore.Functions.Notify('Your weapon does not seem strong enough..', 'error')
    end
end

local ThermiteEffect = function()
    local ped = PlayerPedId()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do Wait(50) end
    Wait(1500)
    TriggerServerEvent("qb-jewellery:server:ThermitePtfx")
    Wait(500)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Wait(25000)
    ClearPedTasks(ped)
    Wait(2000)
    if Config.DoorLock == 'qb' then
        TriggerServerEvent('qb-doorlock:server:updateState', Config.DoorId, false, false, false, true, false, false)
    elseif Config.DoorLock == 'nui' then
        TriggerServerEvent('nui_doorlock:server:updateState', Config.DoorId, false, false, false, true)
    end
end

local PlantThermite = function()
    TriggerServerEvent("QBCore:Server:RemoveItem", "thermite", 1)
    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["thermite"], "remove")
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
    local ped = PlayerPedId()
    local pos = vector4(-596.09, -283.64, 50.42, 301.38)
    SetEntityHeading(ped, pos.w)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local netscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local thermite = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(thermite, false, true)
    AttachEntityToEntity(thermite, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, netscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(netscene)
    Wait(5000)
    DetachEntity(thermite, 1, 1)
    FreezeEntityPosition(thermite, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(netscene)
    CreateThread(function()
        Wait(15000)
        DeleteEntity(thermite)
    end)
end

-- Events
RegisterNetEvent('qb-jewellery:client:Thermite', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then 
            if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
                TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(PlayerPedId()))
            end
            QBCore.Functions.TriggerCallback('qb-jewellery:server:getCops', function(cops)
                if cops >= Config.RequiredCops then
                    PlantThermite()
                    exports["memorygame"]:thermiteminigame(12, 4, 4, 120,
                    function()
                        ThermiteEffect()
                    end,
                    function()
                        QBCore.Functions.Notify("Thermite failed..", "error")
                    end)
                else
                    QBCore.Functions.Notify("Not enough police..", "error")
                end
            end)
        else
            QBCore.Functions.Notify("You are missing something(s)..", "error", 2500)
        end
    end, {"thermite", "lighter"})
end)

RegisterNetEvent('qb-jewellery:client:ThermitePtfx', function()
    local ptfx = vector3(-596.17, -282.62, 50.32)
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(27500)
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent("qb-jewellery:client:ThermitePtfx", function(coords)
    if not HasNamedPtfxAssetLoaded("scr_ornate_heist") then 
        RequestNamedPtfxAsset("scr_ornate_heist") 
    end
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(0) end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(27500)
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('qb-jewellery:client:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
end)

-- Threads
CreateThread(function()
    local Dealer = AddBlipForCoord(Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"])
    SetBlipSprite (Dealer, 617)
    SetBlipDisplay(Dealer, 4)
    SetBlipScale  (Dealer, 0.7)
    SetBlipAsShortRange(Dealer, true)
    SetBlipColour(Dealer, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Vangelico Jewelry")
    EndTextCommandSetBlipName(Dealer)
end)

CreateThread(function()
    for k, v in pairs(Config.Locations) do
        exports['qb-target']:AddBoxZone("JewelleryCase"..k, vector3(v.coords.x, v.coords.y, v.coords.z-1), 0.6, 1.2, {
            name = "JewelleryCase"..k,
            heading = v.coords.w,
            debugPoly = true,
            minZ = 37.65,
            maxZ = 38.35,
            }, {
                options = { 
                {
                    action = function()
                        smashVitrine(k)
                    end,
                    icon = 'fas fa-gem',
                    label = 'Smash Case',
                    canInteract = function()
                        if v["isOpened"] or v["isBusy"] then 
                            return false
                        end
                        return true
                    end,
                }
            },
            distance = 1.5,
        })
    end
    exports['qb-target']:AddBoxZone("JewelleryThermite", vector3(-595.94, -283.74, 50.32), 0.4, 0.8, {
        name = "JewelleryThermite",
        heading = 302.79,
        debugPoly = true,
        minZ = 50.25,
        maxZ = 51.35,
        }, {
            options = { 
            {
                type = "client",
                event = "qb-jewellery:client:Thermite",
                icon = 'fas fa-gem',
                label = 'Disable Security'
            }
        },
        distance = 1.5,
    })
end)
