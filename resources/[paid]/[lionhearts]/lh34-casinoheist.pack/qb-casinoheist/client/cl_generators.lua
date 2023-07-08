local ThermiteSettings = {
    correctBlocks = 1, -- = Number of correct blocks the player needs to click
    incorrectBlocks = 4, -- = number of incorrect blocks after which the game will fail
    timetoShow = 12, -- = time in secs for which the right blocks will be shown
    timetoLose = 24 -- = maximum time after timetoshow expires for player to select the right blocks
}

--- Method to perform planting a thermite charge animation and performing memorygame for given generator index number
--- @param index number - Index number of electricity cabinet
--- @return nil
local StartThermite = function(index)
    TriggerServerEvent('qb-casinoheist:server:RemoveThermite')
    TriggerServerEvent('qb-casinoheist:server:SetThermiteBusy', index, true)

    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(10) end
    
    local ped = PlayerPedId()
    if math.random(1, 100) <= 65 and not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(ped))
    end
    SetEntityHeading(ped, Shared.Thermite[index].thermiteAnimation.w)
    local pos = Shared.Thermite[index].thermiteAnimation.xyz
    Wait(100)

    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(charge, false, true)
    AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(bagscene)
    
    Wait(5000)
    DetachEntity(charge, 1, 1)
    FreezeEntityPosition(charge, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)

    exports["memorygame"]:thermiteminigame(ThermiteSettings.correctBlocks, ThermiteSettings.incorrectBlocks, ThermiteSettings.timetoShow, ThermiteSettings.timetoLose, function()
        TriggerServerEvent('qb-casinoheist:server:SetThermiteHit', index, true)
        RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
        while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do Wait(0) end
        Wait(1500)
        TriggerServerEvent("qb-casinoheist:server:ThermitePtfx", Shared.Thermite[index].thermitePtfx)
        Wait(500)
        TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
        TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
        Wait(5000)
        ClearPedTasks(ped)
        DeleteEntity(charge)
        Wait(2000)
        TriggerServerEvent('qb-casinoheist:server:SetThermiteBusy', index, false)
    end, function()
        QBCore.Functions.Notify("You failed...", "error")
        DeleteEntity(charge)
        TriggerServerEvent('qb-casinoheist:server:SetThermiteBusy', index, false)
    end)
end

RegisterNetEvent('thermite:UseThermite', function()
    local pos = GetEntityCoords(PlayerPedId())
    for i=1, #Shared.Thermite do
        if #(pos - Shared.Thermite[i].coords) < 2.0 then
            if Shared.Thermite[i].busy then
                QBCore.Functions.Notify('Someone is already attempting this..', 'error', 2500)
            elseif Shared.Thermite[i].hit then
                QBCore.Functions.Notify('Someone already tampered with this..', 'error', 2500)
            else
                StartThermite(i)
            end
            break
        end
    end
end)

RegisterNetEvent('qb-casinoheist:client:SetThermiteBusy', function(index, state)
    Shared.Thermite[index].busy = state
end)

RegisterNetEvent('qb-casinoheist:client:SetThermiteHit', function(index, state)
    Shared.Thermite[index].hit = state
end)

RegisterNetEvent('qb-casinoheist:client:ThermitePtfx', function(coords)
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(0) end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(7500)
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('qb-casinoheist:client:ThermiteGenerator', function(data)
    local index = data.generator
    if Shared.Generators[index].busy then
        QBCore.Functions.Notify('Somebody is already tampering with this..', 'error', 2500)
        return
    elseif Shared.Generators[index].hit then
        QBCore.Functions.Notify('Somebody already tampered with this..', 'error', 2500)
        return
    elseif Shared.Generators[index].currentAttempt >= Shared.Generators[index].maxAttempt then
        QBCore.Functions.Notify('Generator controls offline due to tampering..', 'error', 2500)
        return
    end

    TriggerServerEvent('qb-casinoheist:server:SetGeneratorBusy', index, true)

    exports['casinohack']:OpenHackingGame(function(success)
        if success then
            TriggerServerEvent('qb-casinoheist:server:SetGeneratorHit', index, true)
        end
        TriggerServerEvent('qb-casinoheist:server:SetGeneratorBusy', index, false)
    end, 17)
end)

RegisterNetEvent('qb-casinoheist:client:SetGeneratorBusy', function(index, state)
    Shared.Generators[index].busy = state
    if state then
        Shared.Generators[index].currentAttempt += 1 
    end
end)

RegisterNetEvent('qb-casinoheist:client:SetGeneratorHit', function(index, state)
    Shared.Generators[index].hit = state
end)

CreateThread(function()
    -- Generator Room 1
    exports['qb-target']:AddBoxZone("casinoh_generator1", vector3(994.54, 18.88, 63.46), 0.4, 1.0, {
        name = "casinoh_generator1",
        heading = 58,
        debugPoly = false,
        minZ = 60.06,
        maxZ = 64.06
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:ThermiteGenerator',
                icon = 'fas fa-user-secret',
                label = 'Configure Panel',
                generator = 1
            }
        },
        distance = 1.5,
    })

    -- Generator Room 2
    exports['qb-target']:AddBoxZone("casinoh_generator2", vector3(996.19, 21.68, 63.46), 0.4, 1.0, {
        name = "casinoh_generator2",
        heading = 58,
        debugPoly = false,
        minZ = 60.06,
        maxZ = 64.06
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:ThermiteGenerator',
                icon = 'fas fa-user-secret',
                label = 'Configure Panel',
                generator = 2
            }
        },
        distance = 1.5,
    })

    -- Generator Room 3
    exports['qb-target']:AddBoxZone("casinoh_generator3", vector3(1001.7, 27.13, 63.46), 0.4, 1.0, {
        name = "casinoh_generator3",
        heading = 328,
        debugPoly = false,
        minZ = 60.06,
        maxZ = 64.06
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:ThermiteGenerator',
                icon = 'fas fa-user-secret',
                label = 'Configure Panel',
                generator = 3
            }
        },
        distance = 1.5,
    })

    -- Generator Room 4
    exports['qb-target']:AddBoxZone("casinoh_generator4", vector3(1004.77, 25.16, 63.46), 0.4, 1.0, {
        name = "casinoh_generator4",
        heading = 328,
        debugPoly = false,
        minZ = 60.06,
        maxZ = 64.06
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:ThermiteGenerator',
                icon = 'fas fa-user-secret',
                label = 'Configure Panel',
                generator = 4
            }
        },
        distance = 1.5,
    })
end)
