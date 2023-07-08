QBCore = exports['qb-core']:GetCoreObject()

local ThermiteSettings = {
    correctBlocks = 18, -- = Number of correct blocks the player needs to click
    incorrectBlocks = 4, -- = number of incorrect blocks after which the game will fail
    timetoShow = 7, -- = time in secs for which the right blocks will be shown
    timetoLose = 30 -- = maximum time after timetoshow expires for player to select the right blocks
}

--- Method to perform planting a thermite charge animation and performing memorygame for given electrical box index number
--- @param index number - Index number of electricity cabinet
--- @return nil
local TamperSecurity = function(index)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if #(pos - Shared.Wiring[index].coords.xyz) > 3 then return end
    if Shared.Wiring[index].thermited then
        -- Reconnect wires
        local hasItem = QBCore.Functions.HasItem('copper_wires')
        if not hasItem then
            QBCore.Functions.Notify('You could try fixing the circuit..', 'error', 2500)
            return
        end

        QBCore.Functions.Progressbar("hlabs_wires", "Connecting wires..", math.random(5000, 10000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@gangops@facility@servers@",
            anim = "hotwire",
            flags = 16,
        }, {}, {}, function() -- Done
            TriggerServerEvent('qb-humanelabsheist:server:RemoveCopperWires')
            exports['casinohack']:OpenHackingGame(function(success)
                if success then
                    for i=1, #Shared.Wiring[index].lockDoors do
                        TriggerServerEvent("doors:change-lock-state", Shared.Wiring[index].lockDoors[i])
                        --TriggerServerEvent('qb-doorlock:server:updateState', Shared.Wiring[index].lockDoors[i], true, false, false, true, false, false)
                    end

                    for i=1, #Shared.Wiring[index].unlockDoors do
                        --TriggerServerEvent('qb-doorlock:server:updateState', Shared.Wiring[index].unlockDoors[i], false, false, false, true, false, false)
                        TriggerServerEvent("doors:change-lock-state", Shared.Wiring[index].unlockDoors[i])
                    end
                    QBCore.Functions.Notify('You diverted all power to circuit '..index, 'error', 2500)
                    TriggerServerEvent('qb-humanelabsheist:server:ToggleWires', index)
                    TriggerServerEvent("InteractSound_SV:PlayOnSource", "elec_buzz_glitch", 0.1)
                end
            end, 20) -- 20 seconds time
            StopAnimTask(ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
        end, function() -- Cancel
            StopAnimTask(ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
            QBCore.Functions.Notify("Canceled..", "error")
        end)
    else
        -- Thermite
        local hasItem = QBCore.Functions.HasItem('thermite')
        if not hasItem then
            QBCore.Functions.Notify('You are missing some item(s)..', 'error', 2500)
            return
        end
        TriggerServerEvent('qb-humanelabsheist:server:RemoveThermite')
        RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
        RequestModel("hei_p_m_bag_var22_arm_s")
        RequestNamedPtfxAsset("scr_ornate_heist")
        while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
        local ped = PlayerPedId()
        if math.random(1, 100) <= 65 and not QBCore.Functions.IsWearingGloves() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(ped))
        end
        SetEntityHeading(ped, Shared.Wiring[index].thermiteAnimation.w)
        local pos = Shared.Wiring[index].thermiteAnimation.xyz
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
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        NetworkStartSynchronisedScene(bagscene)
        Wait(5000)
        DetachEntity(charge, 1, 1)
        FreezeEntityPosition(charge, true)
        DeleteObject(bag)
        NetworkStopSynchronisedScene(bagscene)
        CreateThread(function()
            Wait(15000)
            DeleteEntity(charge)
        end)

        exports["memorygame"]:thermiteminigame(ThermiteSettings.correctBlocks, ThermiteSettings.incorrectBlocks, ThermiteSettings.timetoShow, ThermiteSettings.timetoLose, function()
            RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
            while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do Wait(50) end
            Wait(1500)
            TriggerServerEvent("qb-humanelabsheist:server:ThermitePtfx", Shared.Wiring[index].thermitePtfx)
            Wait(500)
            TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
            TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
            Wait(5000)
            ClearPedTasks(ped)
            Wait(2000)
            for i=1, #Shared.Wiring[index].lockDoors do
                --TriggerServerEvent('qb-doorlock:server:updateState', Shared.Wiring[index].lockDoors[i], true, false, false, true, false, false)
                TriggerServerEvent("doors:change-lock-state", Shared.Wiring[index].lockDoors[i])
            end

            for i=1, #Shared.Wiring[index].unlockDoors do
                TriggerServerEvent("doors:change-lock-state", Shared.Wiring[index].unlockDoors[i])
                --TriggerServerEvent('qb-doorlock:server:updateState', Shared.Wiring[index].unlockDoors[i], false, false, false, true, false, false)
            end
            QBCore.Functions.Notify('You diverted all power to circuit '..index, 'error', 2500)
            TriggerServerEvent('qb-humanelabsheist:server:ToggleWires', index)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "elec_buzz_glitch", 0.1)
        end, function()
            QBCore.Functions.Notify("You failed...", "error")
        end)
    end
end

RegisterNetEvent('qb-humanelabsheist:client:ToggleWires', function(index, bool)
    Shared.Wiring[index].thermited = bool
end)

RegisterNetEvent("explosive:UseExplosive", function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if #(pos - Shared.Explosive.coords) < 2 then
        QBCore.Functions.TriggerCallback('qb-humanelabsheist:server:getCops', function(copCount)
            if copCount >= Shared.MinimumPolice then
                if Shared.Explosive.hit then return end
                LocalPlayer.state:set("inv_busy", true, true)
                -- EVIDENCE
                if math.random(1, 100) <= 85 and not QBCore.Functions.IsWearingGloves() then
                    TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                end
                -- REMOVE ITEM
                AlertCops()
                TriggerServerEvent('qb-humanelabsheist:server:RemoveExplosive')
                -- ANIMATION
                local plantcoords = vector4(3525.29, 3702.42, 21.09, 168.79)
                RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
                RequestModel("hei_p_m_bag_var22_arm_s")
                while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do Wait(10) end
                SetEntityHeading(ped, plantcoords.w)
                local pos = plantcoords.xyz
                Wait(100)
                local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
                local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
                local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
                SetEntityCollision(bag, false, true)
                local x, y, z = table.unpack(GetEntityCoords(ped))
                local charge = CreateObject(`prop_bomb_01`, x, y, z + 0.2,  true,  true, true)
                SetEntityCollision(charge, false, true)
                AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
                NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
                NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
                SetPedComponentVariation(ped, 5, 0, 0, 0)
                NetworkStartSynchronisedScene(bagscene)
                Wait(5000)
                DetachEntity(charge, 1, 1)
                FreezeEntityPosition(charge, true)
                DeleteObject(bag)
                NetworkStopSynchronisedScene(bagscene)
                LocalPlayer.state:set("inv_busy", false, true)
                -- Explosion
                local chargepos = GetEntityCoords(charge)
                Wait(8000)
                AddExplosion(chargepos.x, chargepos.y, chargepos.z, 16, 16.0, true, false, 20.0)
                DeleteObject(charge)
                TriggerServerEvent('qb-humanelabsheist:server:ExplosiveHit')
                -- Spawn Guards
                QBCore.Functions.TriggerCallback('qb-humanelabsheist:server:SpawnNPC', function(netIds)
                    Wait(1000)
                    for i=1, #netIds do
                        local guard = NetworkGetEntityFromNetworkId(netIds[i])
                        SetPedDropsWeaponsWhenDead(guard, false)
                        SetEntityMaxHealth(guard, 500)
                        SetEntityHealth(guard, 500)
                        SetCanAttackFriendly(guard, false, true)
                        SetPedCombatAttributes(guard, 46, true)
                        SetPedCombatAttributes(guard, 0, false)
                        SetPedCombatAbility(guard, 100)
                        SetPedAsCop(guard, true)
                        SetPedRelationshipGroupHash(guard, `HATES_PLAYER`)
                        SetPedAccuracy(guard, 60)
                        SetPedFleeAttributes(guard, 0, 0)
                        SetPedKeepTask(guard, true)
                    end
                end)
                --TriggerServerEvent('qb-doorlock:server:updateState', Shared.Explosive.doorId, false, false, false, true, false, false)
                TriggerServerEvent("doors:change-lock-state", Shared.Explosive.doorId)
                
                CreateThread(function()
                    Wait(10*60*1000) -- Alert cops after 10 minutes
                    AlertCops()
                end)
            else
                QBCore.Functions.Notify('Not enough cops..', 'error', 2500)
            end
        end)
    end
end)

RegisterNetEvent('qb-humanelabsheist:client:ExplosiveHit', function()
    Shared.Explosive.hit = true
end)

RegisterNetEvent('qb-humanelabsheist:client:ThermitePtfx', function(coords)
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(50) end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(7500)
    StopParticleFxLooped(effect, 0)
end)

CreateThread(function()
    QBCore.Functions.TriggerCallback('qb-humanelabsheist:server:GetShared', function(result)
        Shared = result
    end)
end)

CreateThread(function()
	exports['qb-target']:SpawnPed({
        model = 's_m_y_dealer_01',
        coords = Shared.Laptop,
        minusOne = true,
        freeze = true,
        invincible = true,
        blockevents = true,
        animDict = "anim@mp_celebration@idles@female",
        anim = "celebration_idle_f_a",
        flag = 0,
        target = {
            options = {
                {
                    type = "server",
                    event = "qb-humanelabsheist:server:BuyPurpleLaptop",
                    icon = 'fas fa-hand-holding',
                    label = 'Offer Item',
                    item = "usb_purple"
                }
            },
            distance = 1.5
        },
    })

    for i=1, #Shared.Wiring do
        exports["qb-target"]:AddBoxZone("hlabselec"..i, Shared.Wiring[i].coords.xyz, Shared.Wiring[i].length, Shared.Wiring[i].width, {
            name = "hlabselec"..i,
            heading = Shared.Wiring[i].coords.w,
            minZ = Shared.Wiring[i].coords.z - 0.5,
            maxZ = Shared.Wiring[i].coords.z + 0.3,
            debugPoly = false
         }, {
            options = {
                {
                    action = function()
                        TamperSecurity(i)
                    end,
                    icon = "fas fa-user-secret",
                    label = 'Tamper with security',
                    canInteract = function()
                        return Shared.Explosive.hit
                    end,
                }
            },
            distance = 1.5
        })
    end
end)

-- For testing purposes
-- RegisterCommand('hlabs_test', function(source, args, rawCommand)
--     if not args[1] then return end
--     local index = tonumber(args[1])

--     for i=1, #Shared.Wiring[index].lockDoors do
--         TriggerServerEvent('qb-doorlock:server:updateState', Shared.Wiring[index].lockDoors[i], true, false, false, true, false, false)
--     end

--     for i=1, #Shared.Wiring[index].unlockDoors do
--         TriggerServerEvent('qb-doorlock:server:updateState', Shared.Wiring[index].unlockDoors[i], false, false, false, true, false, false)
--     end

--     QBCore.Functions.Notify('Imitated tampering with electrical box: '..index, 'success', 3500)
-- end)
