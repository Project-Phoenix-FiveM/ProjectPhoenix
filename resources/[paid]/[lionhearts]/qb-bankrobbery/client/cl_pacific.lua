local lasersActive = false
local lasers = {}

--- Functions

local enableLasers = function()
    for _, laser in ipairs(lasers) do 
        laser.setActive(true)
        laser.setMoving(true)
    end

    while Shared.Banks['Pacific'].lockdown and lasersActive do
        for _, laser in ipairs(lasers) do laser.setVisible(true) end
        Wait(500)
        for _, laser in ipairs(lasers) do laser.setVisible(false) end
        Wait(500)
    end
end

local disableLasers = function()
    for _, laser in ipairs(lasers) do 
        laser.setActive(false)
        laser.setMoving(false)
    end
end

local enterVault = function()
    if Shared.Banks['Pacific'].laserPanel and exports['qb-powerplant']:getPowerPlantState('city') then
        print('Do not start lasers')
    else
        lasersActive = true
        enableLasers()
    end
end

local exitVault = function()
    if lasersActive then
        lasersActive = false
        disableLasers()
    end
end

--- Events

RegisterNetEvent('qb-bankrobbery:client:PacificSideHack', function(data)
    if Shared.Banks['Pacific'].sideEntrance.hacked then return end
    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:CanAttemptPacificHack', function(canAttempt)
        if canAttempt then
            local ped = PlayerPedId()
            TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
            QBCore.Functions.Progressbar('pacific_hack', _U('pacific_progressbar_sidehack'), math.random(5000, 10000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                CallCops(Shared.Banks['Pacific'].type)
                exports['varhack']:OpenHackingGame(function(success)
                    if success then 
                        PlaySound(-1, 'Lose_1st', 'GTAO_FM_Events_Soundset', 0, 0, 1)
                        TriggerServerEvent('qb-bankrobbery:server:SetPacificSideHacked')
                    else
                        QBCore.Functions.Notify(_U('pacific_sidehack_fail'), 'error', 2500)
                    end
                end, Shared.MinigameSettings.varHack.blocks, 7)
            end, function() -- Cancel
                StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
            end)
        end
    end)
end)

RegisterNetEvent('qb-bankrobbery:client:SetPacificSideHacked', function()
    Shared.Banks['Pacific'].sideEntrance.hacked = true
end)

RegisterNetEvent('qb-bankrobbery:client:PacificMainComputer', function()
    if Shared.Banks['Pacific'].computers['main'].hacked then return end
    RequestAnimDict('anim@heists@prison_heiststation@cop_reactions')
    while not HasAnimDictLoaded('anim@heists@prison_heiststation@cop_reactions') do Wait(0) end
    local ped = PlayerPedId()
    TaskPlayAnim(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0, 1.0, -1, 1, 0, 0, 0, 0)
    local result = exports['lightsout']:StartLightsOut(Shared.MinigameSettings.lightsOut.grid, Shared.MinigameSettings.lightsOut.maxClicks)
    if result then
        TriggerServerEvent('qb-bankrobbery:server:SetPacificComputerHacked', 'main')
    else
        QBCore.Functions.Notify(_U('hack_failed'), 'error', 2500)
    end
    StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
end)

RegisterNetEvent('qb-bankrobbery:client:SetPacificComputerHacked', function(computer)
    Shared.Banks['Pacific'].computers[computer].hacked = true
end)

RegisterNetEvent('qb-bankrobbery:client:PacificComputer', function(data)
    local key = Shared.Banks['Pacific'].computers[data.computer].key
    if not QBCore.Functions.HasItem(key) then
        QBCore.Functions.Notify(_U('pacific_need_datakey'), 'error', 2500)
        return
    end

    RequestAnimDict('anim@heists@prison_heiststation@cop_reactions')
    while not HasAnimDictLoaded('anim@heists@prison_heiststation@cop_reactions') do Wait(0) end
    local ped = PlayerPedId()
    TaskPlayAnim(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0, 1.0, -1, 1, 0, 0, 0, 0)

    if data.computer == 'office1' then -- varhack
        exports['varhack']:OpenHackingGame(function(success)
            if success then 
                PlaySound(-1, 'Lose_1st', 'GTAO_FM_Events_Soundset', 0, 0, 1)
                StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
                TriggerServerEvent('qb-bankrobbery:server:SetPacificComputerHacked', data.computer)
            else
                StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
            end
        end, Shared.MinigameSettings.varHack.blocks, 7)
    elseif data.computer == 'office2' then -- bank hack, paleto difficulty
        exports['hacking']:OpenHackingGame(Shared.MinigameSettings.laptop['paleto'].time, Shared.MinigameSettings.laptop['paleto'].blocks, Shared.MinigameSettings.laptop['paleto'].amount, function(success)
            if success then 
                TriggerServerEvent('qb-bankrobbery:server:SetPacificComputerHacked', data.computer)
                StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
            else
                StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
            end
        end)
    elseif data.computer == 'office3' then -- maze hack
        exports['casinohack']:OpenHackingGame(function(success)
            if success then 
                TriggerServerEvent('qb-bankrobbery:server:SetPacificComputerHacked', data.computer)
                StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
            else
                StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
            end
        end, Shared.MinigameSettings.mazeHack.time)
    elseif data.computer == 'office4' then
        exports['memorygame']:thermiteminigame(Shared.MinigameSettings.thermite.correctBlocks, Shared.MinigameSettings.thermite.incorrectBlocks, Shared.MinigameSettings.thermite.timetoShow, Shared.MinigameSettings.thermite.timetoLose, function()
            TriggerServerEvent('qb-bankrobbery:server:SetPacificComputerHacked', data.computer)
            StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
        end, function()
            StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
        end)
    end
end)

RegisterNetEvent('qb-bankrobbery:client:SearchDrawer', function(data)
    if not Shared.Banks['Pacific'].computers['main'].hacked then return end
    QBCore.Functions.Progressbar('pacific_searchdrawer', _U('pacific_search_drawer'), 7800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@bodysearch@',
        anim = 'player_search',
        flags = 16,
    }, {}, {}, function()
        TriggerServerEvent('qb-bankrobbery:server:SearchDrawer', data.drawer)
    end, function() -- Cancel
        QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
    end)
end)

RegisterNetEvent('qb-bankrobbery:client:EnterPacificCode', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = _U('pacific_input_header'),
        submitText = _U('input_submit'),
        inputs = {
            {
                text = 'XXXX',
                name = 'password',
                type = 'text',
                isRequired = true
            }
        }
    })
    if not dialog or not next(dialog) then return end
    local input = string.upper(dialog.password)
    TriggerServerEvent('qb-bankrobbery:server:EnterPacificCode', data.panel, input)
end)

RegisterNetEvent('qb-bankrobbery:client:SetLockdownActive', function()
    Shared.Banks['Pacific'].lockdown = true
    while Shared.Banks['Pacific'].lockdown and lasersActive do
        for _, laser in ipairs(lasers) do laser.setVisible(true) end
        Wait(500)
        for _, laser in ipairs(lasers) do laser.setVisible(false) end
        Wait(500)
    end
end)

AddEventHandler('qb-powerplant:client:PowerPlantHit', function(plant)
    if lasersActive and plant == 'city' and Shared.Banks['Pacific'].laserPanel then
        disableLasers()
    end
end)

RegisterNetEvent('qb-bankrobbery:client:DisableLasers', function()
    if Shared.Banks['Pacific'].lockdown then
        QBCore.Functions.Notify(_U('pacific_lockdown_active'), 'error', 2500)
        return
    end

    if not exports['qb-powerplant']:getPowerPlantState('city') then
        QBCore.Functions.Notify(_U('pacific_cannot_disable_laser'), 'error', 2500)
        return
    end

    if Shared.Banks['Pacific'].laserPanel then
        QBCore.Functions.Notify(_U('pacific_already_disable_laser'), 'error', 2500)
        return
    end

    local ped = PlayerPedId()
    RequestAnimDict('anim_heist@hs3f@ig11_steal_painting@male@')
    while not HasAnimDictLoaded('anim_heist@hs3f@ig11_steal_painting@male@') do Wait(0) end
    TaskPlayAnim(ped, 'anim_heist@hs3f@ig11_steal_painting@male@', 'with_painting_exit', 8.0, 8.0, -1, 0, 0, 0, 0, 0)
    local result = exports['hackingdevice']:StartHackingDevice(Shared.MinigameSettings.hackingdevice.timer, Shared.MinigameSettings.hackingdevice.characters)
    if result then
        TriggerServerEvent('qb-bankrobbery:server:LaserPowerSupplyDisabled')
    end

end)

RegisterNetEvent('qb-bankrobbery:client:LaserPowerSupplyDisabled', function()
    Shared.Banks['Pacific'].laserPanel = true
    if lasersActive and exports['qb-powerplant']:getPowerPlantState('city') then
        disableLasers()
    end
end)

RegisterNetEvent('qb-bankrobbery:client:UseRedLaptop', function(data)
    if Shared.Banks['Pacific'].lockdown then
        QBCore.Functions.Notify(_U('pacific_lockdown_active'), 'error', 2500)
        return
    end

    if QBCore.Functions.HasItem('laptop_red') then
        local ped = PlayerPedId()
        TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
        QBCore.Functions.Progressbar('redlaptop_hack', _U('progressbar_laptop'), math.random(5000, 10000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@gangops@facility@servers@',
            anim = 'hotwire',
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
            TriggerServerEvent('qb-bankrobbery:server:LaptopDamage', 'laptop_red')
            LaptopAnimation('Pacific')
        end, function() -- Cancel
            StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
            QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
        end)
    else
        QBCore.Functions.Notify(_U('missing_items'), 'error', 2500)
    end
end)

RegisterNetEvent('qb-bankrobbery:client:PacificSideVault', function(data)
    if Shared.Banks['Pacific'].lockdown then
        QBCore.Functions.Notify(_U('pacific_lockdown_active'), 'error', 2500)
        return
    end

    if not Shared.Banks['Pacific'].hacked then
        QBCore.Functions.Notify(_U('pacific_vault_not_hit'), 'error', 2500)
        return
    end

    if Shared.Banks['Pacific'].sideVaults[data.vault].hacked then
        QBCore.Functions.Notify(_U('laptop_hit'), 'error', 2500)
        return
    end

    if QBCore.Functions.HasItem('laptop_red') then
        local ped = PlayerPedId()
        TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
        QBCore.Functions.Progressbar('redlaptop_hack', _U('progressbar_laptop'), math.random(5000, 10000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@gangops@facility@servers@',
            anim = 'hotwire',
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
            TriggerServerEvent('qb-bankrobbery:server:LaptopDamage', 'laptop_red')
            RequestAnimDict('anim@heists@ornate_bank@hack')

            RequestModel('hei_prop_hst_laptop')
            RequestModel('hei_p_m_bag_var22_arm_s')

            while 
                not HasAnimDictLoaded('anim@heists@ornate_bank@hack') or
                not HasModelLoaded('hei_prop_hst_laptop') or
                not HasModelLoaded('hei_p_m_bag_var22_arm_s') 
            do 
                Wait(0) 
            end
            
            local ped = PlayerPedId()
            local loc = Shared.Banks['Pacific'].sideVaults[data.vault].laptop
            LocalPlayer.state:set('inv_busy', true, true)
            local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
            
            if not QBCore.Functions.IsWearingGloves() then
                TriggerServerEvent('evidence:server:CreateFingerDrop', targetPosition)
            end

            local animPos = GetAnimInitialOffsetPosition('anim@heists@ornate_bank@hack', 'hack_enter', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
            local animPos2 = GetAnimInitialOffsetPosition('anim@heists@ornate_bank@hack', 'hack_loop', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
            local animPos3 = GetAnimInitialOffsetPosition('anim@heists@ornate_bank@hack', 'hack_exit', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
            FreezeEntityPosition(ped, true)
            SetEntityHeading(ped, loc.w)

            local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
            local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)
            local laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)
            NetworkAddPedToSynchronisedScene(ped, netScene, 'anim@heists@ornate_bank@hack', 'hack_enter', 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(bag, netScene, 'anim@heists@ornate_bank@hack', 'hack_enter_bag', 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(laptop, netScene, 'anim@heists@ornate_bank@hack', 'hack_enter_laptop', 4.0, -8.0, 1)

            local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, netScene2, 'anim@heists@ornate_bank@hack', 'hack_loop', 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(bag, netScene2, 'anim@heists@ornate_bank@hack', 'hack_loop_bag', 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(laptop, netScene2, 'anim@heists@ornate_bank@hack', 'hack_loop_laptop', 4.0, -8.0, 1)

            local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, netScene3, 'anim@heists@ornate_bank@hack', 'hack_exit', 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(bag, netScene3, 'anim@heists@ornate_bank@hack', 'hack_exit_bag', 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(laptop, netScene3, 'anim@heists@ornate_bank@hack', 'hack_exit_laptop', 4.0, -8.0, 1)

            Wait(200)
            NetworkStartSynchronisedScene(netScene)
            Wait(6300)
            NetworkStartSynchronisedScene(netScene2)
            Wait(2000)
            exports['hacking']:OpenHackingGame(Shared.MinigameSettings.laptop['pacific'].time, Shared.MinigameSettings.laptop['pacific'].blocks, Shared.MinigameSettings.laptop['pacific'].amount, function(Success)
                if Success then
                    TriggerServerEvent('qb-bankrobbery:server:PacificSideVaultHacked', data.vault)
                end
                LocalPlayer.state:set('inv_busy', false, true)
                NetworkStartSynchronisedScene(netScene3)
                Wait(4600)
                NetworkStopSynchronisedScene(netScene3)
                DeleteObject(bag)
                DeleteObject(laptop)
                FreezeEntityPosition(ped, false)
            end)
        end, function() -- Cancel
            StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
            QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
        end)
    else
        QBCore.Functions.Notify(_U('missing_items'), 'error', 2500)
    end
end)

RegisterNetEvent('qb-bankrobbery:client:PacificSideVaultHacked', function(vault)
    Shared.Banks['Pacific'].sideVaults[vault].hacked = true
end)

--- Threads

CreateThread(function()
    -- Static Lasers
    lasers[#lasers + 1] = Laser.new(vector3(256.538, 217.67, 96.75), {vector3(239.378, 223.97, 96.75)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'vault_laser1', maxDistance = 19.0})
    lasers[#lasers + 1] = Laser.new(vector3(256.538, 217.67, 97.50), {vector3(239.378, 223.97, 97.50)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'vault_laser2', maxDistance = 19.0})
    lasers[#lasers + 1] = Laser.new(vector3(256.538, 217.67, 98.25), {vector3(239.378, 223.97, 98.25)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'vault_laser3', maxDistance = 19.0})

    lasers[#lasers + 1] = Laser.new(vector3(259.199, 224.98, 96.75), {vector3(242.047, 231.302, 96.75)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'vault_laser4', maxDistance = 19.0})
    lasers[#lasers + 1] = Laser.new(vector3(259.199, 224.98, 97.50), {vector3(242.047, 231.302, 97.50)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'vault_laser5', maxDistance = 19.0})
    lasers[#lasers + 1] = Laser.new(vector3(259.199, 224.98, 98.25), {vector3(242.047, 231.302, 98.25)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'vault_laser6', maxDistance = 19.0})

    lasers[#lasers + 1] = Laser.new(vector3(254.608, 224.312, 96.75), {vector3(253.448, 221.156, 96.75)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'vault_laser7', maxDistance = 3.5})
    lasers[#lasers + 1] = Laser.new(vector3(254.608, 224.312, 97.50), {vector3(253.448, 221.156, 97.50)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'vault_laser8', maxDistance = 3.5})
    lasers[#lasers + 1] = Laser.new(vector3(254.608, 224.312, 98.25), {vector3(253.448, 221.156, 98.25)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = false, name = 'vault_laser9', maxDistance = 3.5})

    -- Moving Lasers
    lasers[#lasers + 1] = Laser.new({
        vector3(260.829, 224.373, 96.75),
        vector3(260.829, 224.373, 97.50),
        vector3(260.829, 224.373, 98.25)
    }, {
        vector3(263.908, 223.289, 96.75),
        vector3(263.908, 223.289, 97.50),
        vector3(263.908, 223.289, 98.25)
    }, {
        travelTimeBetweenTargets = {0.5, 0.5}, 
        waitTimeAtTargets = {0.0, 0.0}, 
        randomTargetSelection = false, 
        name = 'vault_laser10', 
        maxDistance = 3.5
    })

    lasers[#lasers + 1] = Laser.new({
        vector3(261.238, 215.957, 98.25),
        vector3(261.238, 215.957, 97.50),
        vector3(261.238, 215.957, 96.75)
    }, {
        vector3(258.157, 217.033, 98.25),
        vector3(258.157, 217.033, 97.50),
        vector3(258.157, 217.033, 96.75)
    }, {
        travelTimeBetweenTargets = {0.5, 0.5}, 
        waitTimeAtTargets = {0.0, 0.0}, 
        randomTargetSelection = false, 
        name = 'vault_laser11', 
        maxDistance = 3.5
    })


    for _, laser in ipairs(lasers) do 
        laser.onPlayerHit(function(playerBeingHit, hitPos)
            if playerBeingHit then
                if not Shared.Banks['Pacific'].lockdown then
                    TriggerServerEvent('qb-bankrobbery:server:HitByLaser')
                end
                laser.clearOnPlayerHit()
            end
        end)
    end
    
    -- Vault Polyzone
    local vaultZone = PolyZone:Create({
        vector2(266.50, 201.01),
        vector2(218.86, 216.76),
        vector2(232.22, 249.76),
        vector2(278.16, 230.26)
    }, {
        name = 'pacific_vaultZone',
        minZ = 96,
        maxZ = 99,
        debugPoly = false
    })

    vaultZone:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            enterVault()
        else
            exitVault()
        end
    end)

    -- Side Entrance Panel
    exports['qb-target']:AddBoxZone('bankrobbery_sidepanel_pacific', vector3(271.13, 206.89, 106.28), 0.4, 0.2, {
        name = 'bankrobbery_sidepanel_pacific',
        heading = 250,
        debugPoly = Shared.Debug,
        minZ = 106.6,
        maxZ = 107.0
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PacificSideHack',
                icon = 'fas fa-user-secret',
                label = _U('pacific_target_sidehack'),
                canInteract = function()
                    return not Shared.Banks['Pacific'].sideEntrance.hacked
                end
            }
        },
        distance = 1.0,
    })

    -- Main Office Computer
    exports['qb-target']:AddBoxZone('bankrobbery_main_pacific', vector3(278.78, 213.07, 110.17), 0.5, 0.5, {
        name = 'bankrobbery_main_pacific',
        heading = 9,
        debugPoly = Shared.Debug,
        minZ = 110.05,
        maxZ = 119.05
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PacificMainComputer',
                icon = 'fas fa-user-secret',
                label = _U('pacific_target_hackcomputer'),
                canInteract = function()
                    return Shared.Banks['Pacific'].sideEntrance.hacked and not Shared.Banks['Pacific'].computers['main'].hacked
                end
            }
        },
        distance = 1.5,
    })

    -- Computer 1
    exports['qb-target']:AddBoxZone('bankrobbery_office1_pacific', vector3(260.54, 205.56, 110.17), 0.7, 0.7, {
        name = 'bankrobbery_office1_pacific',
        heading = 340,
        debugPoly = Shared.Debug,
        minZ = 110.05,
        maxZ = 119.05
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PacificComputer',
                icon = 'fas fa-user-secret',
                label = _U('pacific_target_decryptkey'),
                canInteract = function()
                    return Shared.Banks['Pacific'].computers['main'].hacked and not Shared.Banks['Pacific'].computers['office1'].hacked
                end,
                computer = 'office1',
            }
        },
        distance = 1.5,
    })

    -- Computer 2
    exports['qb-target']:AddBoxZone('bankrobbery_office2_pacific', vector3(252.04, 208.66, 110.17), 0.7, 0.7, {
        name = 'bankrobbery_office2_pacific',
        heading = 340,
        debugPoly = Shared.Debug,
        minZ = 110.05,
        maxZ = 119.05
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PacificComputer',
                icon = 'fas fa-user-secret',
                label = _U('pacific_target_decryptkey'),
                canInteract = function()
                    return Shared.Banks['Pacific'].computers['main'].hacked and not Shared.Banks['Pacific'].computers['office2'].hacked
                end,
                computer = 'office2',
            }
        },
        distance = 1.5,
    })
    
    -- Computer 3
    exports['qb-target']:AddBoxZone('bankrobbery_office3_pacific', vector3(270.14, 231.59, 110.17), 0.7, 0.7, {
        name = 'bankrobbery_office3_pacific',
        heading = 340,
        debugPoly = Shared.Debug,
        minZ = 110.05,
        maxZ = 119.05
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PacificComputer',
                icon = 'fas fa-user-secret',
                label = _U('pacific_target_decryptkey'),
                canInteract = function()
                    return Shared.Banks['Pacific'].computers['main'].hacked and not Shared.Banks['Pacific'].computers['office3'].hacked
                end,
                computer = 'office3',
            }
        },
        distance = 1.5,
    })

    -- Computer 4
    exports['qb-target']:AddBoxZone('bankrobbery_office4_pacific', vector3(261.65, 234.7, 110.17), 0.7, 0.7, {
        name = 'bankrobbery_office4_pacific',
        heading = 340,
        debugPoly = Shared.Debug,
        minZ = 110.05,
        maxZ = 119.05
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PacificComputer',
                icon = 'fas fa-user-secret',
                label = _U('pacific_target_decryptkey'),
                canInteract = function()
                    return Shared.Banks['Pacific'].computers['main'].hacked and not Shared.Banks['Pacific'].computers['office4'].hacked
                end,
                computer = 'office4',
            }
        },
        distance = 1.5,
    })

    -- Drawers
    for k, v in pairs(Shared.Banks['Pacific'].searchDrawers) do
        exports['qb-target']:AddBoxZone('pacific_drawer_' .. k, v.coords.xyz, 0.4, 1.2, {
            name = 'pacific_drawer_' .. k,
            heading = v.coords.w,
            debugPoly = Shared.Debug,
            minZ = v.coords.z - 1.0,
            maxZ = v.coords.z + 1.0
        }, {
            options = { 
                {
                    type = 'client',
                    event = 'qb-bankrobbery:client:SearchDrawer',
                    icon = 'fas fa-user-secret',
                    label = _U('pacific_target_drawers'),
                    canInteract = function()
                        return Shared.Banks['Pacific'].computers['main'].hacked
                    end,
                    drawer = k,
                }
            },
            distance = 1.5,
        })
    end

    -- Vault Entrance Panels
    exports['qb-target']:AddBoxZone('bankrobbery_pacific_panel1', vector3(267.51, 213.26, 97.12), 0.6, 0.4, {
        name = 'bankrobbery_pacific_panel1',
        heading = 340,
        debugPoly = Shared.Debug,
        minZ = 97.20,
        maxZ = 98.0
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:EnterPacificCode',
                icon = 'fas fa-terminal',
                label = _U('pacific_input_header'),
                canInteract = function()
                    return Shared.Banks['Pacific'].computers['main'].hacked
                end,
                panel = 1
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone('bankrobbery_pacific_panel2', vector3(270.55, 221.28, 97.12), 0.6, 0.4, {
        name = 'bankrobbery_pacific_panel2',
        heading = 340,
        debugPoly = Shared.Debug,
        minZ = 97.20,
        maxZ = 98.0
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:EnterPacificCode',
                icon = 'fas fa-terminal',
                label = _U('pacific_input_header'),
                canInteract = function()
                    return Shared.Banks['Pacific'].computers['main'].hacked
                end,
                panel = 2
            }
        },
        distance = 1.5,
    })

    -- Vault Laser Disable
    exports['qb-target']:AddBoxZone('bankrobbery_pacific_laserpanel', vector3(260.64, 213.09, 97.12), 0.7, 0.3, {
        name = 'bankrobbery_pacific_laserpanel',
        heading = 340,
        debugPoly = Shared.Debug,
        minZ = 98.30,
        maxZ = 99.30
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:DisableLasers',
                icon = 'fas fa-bolt',
                label = _U('pacific_target_disablepower'),
                canInteract = function()
                    return not Shared.Banks['Pacific'].laserPanel
                end
            }
        },
        distance = 2.0,
    })

    -- Vault Panel
    exports['qb-target']:AddBoxZone('bankrobbery_panel_pacific1', vector3(236.4, 231.73, 97.12), 0.6, 0.4, {
        name = 'bankrobbery_panel_pacific1',
        heading = 340,
        debugPoly = Shared.Debug,
        minZ = 97.20,
        maxZ = 97.90
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:UseRedLaptop',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Pacific'].hacked
                end
            },
            {
                type = 'server',
                event = 'qb-bankrobbery:server:PDClose',
                icon = 'fas fa-door-closed',
                label = _U('panel_target_pd'),
                canInteract = function()
                    return Shared.Banks['Pacific'].hacked
                end,
                bank = 'Pacific',
                job = 'police'
            }
        },
        distance = 1.5,
    })

    -- Side Vault Panels
    exports['qb-target']:AddBoxZone('bankrobbery_panel_pacific2', vector3(241.84, 218.64, 97.12), 0.6, 0.4, {
        name = 'bankrobbery_panel_pacific2',
        heading = 250,
        debugPoly = Shared.Debug,
        minZ = 97.20,
        maxZ = 97.90
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PacificSideVault',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Pacific'].sideVaults[1].hacked
                end,
                vault = 1
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone('bankrobbery_panel_pacific3', vector3(247.37, 233.82, 97.12), 0.6, 0.4, {
        name = 'bankrobbery_panel_pacific3',
        heading = 250,
        debugPoly = Shared.Debug,
        minZ = 97.20,
        maxZ = 97.90
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PacificSideVault',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Pacific'].sideVaults[2].hacked
                end,
                vault = 2
            }
        },
        distance = 1.5,
    })

end)
