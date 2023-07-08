--- Anti Helicopter Guards

--- Method to alert the police for a prison break alert
--- @return nil
local AlertCops = function()
    -- exports['ps-dispatch']:PrisonBreak() -- ps-dispatch alert
    -- TriggerServerEvent('police:server:policeAlert', 'Jailbreak Alarm') -- Standard QBCore police alert
end

--- Method to spawn guards with rocket launchers to target the helicopter
--- @return nil
triggerAntiHeli = function()
    if not Config.AntiHelicopter then return end
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if GetPedInVehicleSeat(veh, -1) == ped then
        if IsPedInAnyPlane(ped) or IsPedInAnyHeli(ped) then
            QBCore.Functions.TriggerCallback('qb-jail:server:SpawnAntiHelicopterGuards', function(netIds)
                Wait(1000)
                for i=1, #netIds do
                    local guard = NetworkGetEntityFromNetworkId(netIds[i])
                    SetPedDropsWeaponsWhenDead(guard, false)
                    SetEntityInvincible(guard, true)
                    SetEntityMaxHealth(guard, 500)
                    SetEntityHealth(guard, 500)
                    SetCanAttackFriendly(guard, false, true)
                    SetPedCombatAttributes(guard, 46, true)
                    SetPedCombatAttributes(guard, 0, false)
                    SetPedCombatAbility(guard, 100)
                    SetPedAsCop(guard, true)
                    SetPedRelationshipGroupHash(guard, `HATES_PLAYER`)
                    SetPedAccuracy(guard, 100)
                    SetPedFleeAttributes(guard, 0, 0)
                    SetPedKeepTask(guard, true)
                end
            end)
        end
    end
end

--- Prison break

--- Sends server sided ptfx for the thermite charge
--- @return nil
local ThermiteEffect = function(index)
    RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') do Wait(10) end
    local ped = PlayerPedId()
    local ptfx = Config.JailBreak.Thermite[index][2]
    Wait(1500)
    TriggerServerEvent('qb-powerplant:server:ThermitePtfx', ptfx)
    Wait(500)
    TaskPlayAnim(ped, 'anim@heists@ornate_bank@thermal_charge', 'cover_eyes_intro', 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, 'anim@heists@ornate_bank@thermal_charge', 'cover_eyes_loop', 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Wait(25000)
    TriggerServerEvent('qb-doorlock:server:updateState', Config.JailBreak.Thermite[index][3], false, false, false, true, false, false)
end

--- Performs the PlantThermite function and starts the minigame for thermite
--- @return nil
local ThermitePlantCharge = function(index)
    RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
    RequestModel('hei_p_m_bag_var22_arm_s')
    RequestNamedPtfxAsset('scr_ornate_heist')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') and not HasModelLoaded('hei_p_m_bag_var22_arm_s') and not HasNamedPtfxAssetLoaded('scr_ornate_heist') do Wait(0) end
    local ped = PlayerPedId()
    local pos = Config.JailBreak.Thermite[index][1]
    SetEntityHeading(ped, pos.w)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(ped)))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(charge, false, true)
    AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, 'anim@heists@ornate_bank@thermal_charge', 'thermal_charge', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, 'anim@heists@ornate_bank@thermal_charge', 'bag_thermal_charge', 4.0, -8.0, 1)
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
end

RegisterNetEvent('qb-jail:client:SetPowerPlant', function(state)
    Config.JailBreak.PowerplantHit = state
end)

RegisterNetEvent('qb-jail:client:ThermiteHit', function(index)
    Config.JailBreak.Thermite[index][4] = true
end)

RegisterNetEvent('qb-jail:client:OutsideThermite', function(data)
    if Config.JailBreak.Thermite[data.index][4] then return end
    QBCore.Functions.TriggerCallback('qb-powerplant:server:getCops', function(cops)
        if data.index == 1 and cops < Config.JailBreakCops then
            QBCore.Functions.Notify('Not enough cops..', 'error', 2500)
            return
        else
            if QBCore.Functions.HasItem('thermite') then
                TriggerServerEvent('qb-powerplant:server:RemoveThermite')
                ThermitePlantCharge(data.index)
                exports['memorygame']:thermiteminigame(Config.Minigames.ThermiteSettings.correctBlocks, Config.Minigames.ThermiteSettings.incorrectBlocks, Config.Minigames.ThermiteSettings.timetoShow, Config.Minigames.ThermiteSettings.timetoLose, function()
                    TriggerServerEvent('qb-jail:server:ThermiteHit', data.index)
                    ThermiteEffect(data.index)
                end, function()
                    QBCore.Functions.Notify('Thermite failed..', 'error', 2500)
                end)
            else
                QBCore.Functions.Notify('You are missing the correct item(s)', 'error', 2500)
            end
        end
    end)
    
end)

RegisterNetEvent('qb-jail:client:OutsideHack', function()
    if not Config.JailBreak.PowerplantHit or not Config.JailBreak.Thermite[1][4] or Config.JailBreak.VARHack then return end

    local ped = PlayerPedId()
    local animDict = 'anim@heists@prison_heiststation@cop_reactions'
    local anim = 'cop_b_idle'

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(0) end
    TaskPlayAnim(ped, animDict, anim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)

    exports['varhack']:OpenHackingGame(function(success)
        StopAnimTask(ped, animDict, anim, 1.0)
        if success then
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            TriggerServerEvent('qb-doorlock:server:updateState', 'jail-gate2', false, false, false, true, false, false)
            AlertCops()
            TriggerServerEvent('qb-jail:server:OutsideHack')
        end
    end, Config.Minigames.VarSettings.varBlocks, 7)
end)

RegisterNetEvent('qb-jail:client:ActivateLockdown', function(state)
    Config.JailBreak.VARHack = state
    Config.JailBreak.JailBreakActive = state
    if state then
        local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")
        RefreshInterior(alarmIpl)
        EnableInteriorProp(alarmIpl, "prison_alarm")
        CreateThread(function()
            while not PrepareAlarm("PRISON_ALARMS") do
                Wait(100)
            end
            StartAlarm("PRISON_ALARMS", true)
        end)
    else
        local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")
        RefreshInterior(alarmIpl)
        DisableInteriorProp(alarmIpl, "prison_alarm")
        CreateThread(function()
            while not PrepareAlarm("PRISON_ALARMS") do
                Wait(100)
            end
            StopAllAlarms(true)
        end)
    end
end)

RegisterNetEvent('qb-jail:client:UnlockCellDoors', function()
    if not Config.JailBreak.JailBreakActive then return end

    local dialog = exports['qb-input']:ShowInput({
		header = 'Unlock Cell Door',
		submitText = 'Select',
		inputs = {
            {
				text = 'Select Cell',
				name = 'cell',
				type = 'select',
				options = {
                    { value = '1', text = 'Cell 1' },
                    { value = '2', text = 'Cell 2' },
                    { value = '3', text = 'Cell 3' },
                    { value = '4', text = 'Cell 4' },
                    { value = '5', text = 'Cell 5' },
                    { value = '6', text = 'Cell 6' },
                    { value = '7', text = 'Cell 7' },
                    { value = '8', text = 'Cell 8' },
                    { value = '9', text = 'Cell 9' },
                    { value = '10', text = 'Cell 10' },
                    { value = '11', text = 'Cell 11' },
                    { value = '12', text = 'Cell 12' },
                    { value = '13', text = 'Cell 13' },
                    { value = '14', text = 'Cell 14' },
                    { value = '15', text = 'Cell 15' },
                    { value = '16', text = 'Cell 16' },
                    { value = '17', text = 'Cell 17' },
                    { value = '18', text = 'Cell 18' },
                    { value = '19', text = 'Cell 19' },
                    { value = '20', text = 'Cell 20' },
                    { value = '21', text = 'Cell 21' },
                    { value = '22', text = 'Cell 22' },
                    { value = '23', text = 'Cell 23' },
                    { value = '24', text = 'Cell 24' },
                    { value = '25', text = 'Cell 25' },
                    { value = '26', text = 'Cell 26' },
                    { value = '27', text = 'Cell 27' }
				},
                isRequired = true
			},
        }
	})

    if not dialog or not next(dialog) then return end
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'DoorOpen', 0.5)
    TriggerServerEvent('qb-doorlock:server:updateState', 'cell_door_' .. dialog.cell, false, false, false, true, false, false)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('jailbreak_outsidethermite_1', vector3(1846.61, 2571.43, 45.67), 1.4, 0.5, {
        name = 'jailbreak_outsidethermite_1',
        heading = 0,
        debugPoly = false,
        minZ = 44.67,
        maxZ = 46.47
    }, {
        options = { 
            {
                type = 'client',
                event = 'qb-jail:client:OutsideThermite',
                icon = 'fas fa-user-secret',
                label = 'Tamper Security',
                index = 1,
                canInteract = function()
                    return Config.JailBreak.PowerplantHit and not Config.JailBreak.Thermite[1][4] and not Config.JailBreak.VARHack
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone('jailbreak_outsidethermite_2', vector3(1791.74, 2612.13, 45.57), 0.5, 0.4, {
        name = 'jailbreak_outsidethermite_2',
        heading = 0,
        debugPoly = false,
        minZ = 45.20,
        maxZ = 46.20
    }, {
        options = { 
            {
                type = 'client',
                event = 'qb-jail:client:OutsideThermite',
                icon = 'fas fa-user-secret',
                label = 'Tamper Security',
                index = 2,
                canInteract = function()
                    return Config.JailBreak.PowerplantHit and not Config.JailBreak.Thermite[2][4]
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone('jailbreak_outsidethermite_3', vector3(1761.29, 2517.19, 45.57), 1.0, 0.5, {
        name = 'jailbreak_outsidethermite_3',
        heading = 345,
        debugPoly = false,
        minZ = 45.20,
        maxZ = 46.80
    }, {
        options = { 
            {
                type = 'client',
                event = 'qb-jail:client:OutsideThermite',
                icon = 'fas fa-user-secret',
                label = 'Tamper Security',
                index = 3,
                canInteract = function()
                    return Config.JailBreak.PowerplantHit and not Config.JailBreak.Thermite[3][4] and Config.JailBreak.VARHack
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone('jailbreak_outsidehack_1', vector3(1831.31, 2603.95, 45.89), 0.6, 0.4, {
        name = 'jailbreak_outsidehack_1',
        heading = 280,
        debugPoly = false,
        minZ = 45.57,
        maxZ = 46.27
    }, {
        options = { 
            {
                type = 'client',
                event = 'qb-jail:client:OutsideHack',
                icon = 'fas fa-user-secret',
                label = 'Tamper Security',
                canInteract = function()
                    return Config.JailBreak.PowerplantHit and Config.JailBreak.Thermite[1][4]
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone('jailbreak_cell_panel', vector3(1775.0, 2492.35, 49.67), 2.2, 0.4, {
        name = 'jailbreak_cell_panel',
        heading = 30,
        debugPoly = false,
        minZ = 49.67,
        maxZ = 50.87
    }, {
        options = { 
            {
                type = 'client',
                event = 'qb-jail:client:UnlockCellDoors',
                icon = 'fas fa-user-secret',
                label = 'Unlock Cell Doors',
                canInteract = function()
                    return Config.JailBreak.JailBreakActive and Config.JailBreak.Thermite[3][4]
                end
            },
            {
                type = 'server',
                event = 'qb-jail:server:ClearLockDown',
                icon = 'fas fa-user-shield',
                label = 'Clear Lockdown',
                canInteract = function()
                    return PlayerData.job.type == 'leo' and Config.JailBreak.JailBreakActive
                end
            }
        },
        distance = 1.5,
    })

end)
