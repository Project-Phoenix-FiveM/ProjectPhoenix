local MagnetSettings = {
    correctBlocks = 6, -- = Number of correct blocks the player needs to click
    incorrectBlocks = 3, -- = number of incorrect blocks after which the game will fail
    timetoShow = 6, -- = time in secs for which the right blocks will be shown
    timetoLose = 18 -- = maximum time after timetoshow expires for player to select the right blocks
}

local elevatorPoly = PolyZone:Create({
    vector2(1017.3177490234, 29.786653518677),
    vector2(1017.3177490234, 29.786653518677),
    vector2(1015.3139038086, 26.040702819824),
    vector2(1007.864440918, 31.052526473999),
    vector2(1010.2924804688, 34.230827331543)
  }, {
    name="casinoh_elevatorshaft",
    debugPoly = false,
    minZ = -13.90,
    maxZ = 77.50
})

local lasersActive = false
local lasers = {}


--- Method to enable or disable elevator shaft EnableLasers
--- @param state boolean - true or false
--- @return nil
local EnableLasers = function(state)
    if state then
        if lasersActive then return end
        lasersActive = state
        for k, v in ipairs(lasers) do 
            v.setActive(true)
            v.setMoving(true)
        end
    else
        if not lasersActive then return end
        lasersActive = state

        for k, v in ipairs(lasers) do 
            v.setActive(false)
            v.setMoving(false)
        end
    end
end

elevatorPoly:onPlayerInOut(function(isPointInside)
    EnableLasers(isPointInside)
end)

--- Method to grab usb and delete
--- @param usb number - entity id of usb object
--- @return nil
local TakeUSB = function(usb)
    if not DoesEntityExist(usb) then return end
    local netId = NetworkGetNetworkIdFromEntity(usb)
    TriggerServerEvent('qb-casinoheist:server:GrabUSB', netId)
end

--- Method to perform planting a magnet charge animation and performing memorygame for given magnet index number
--- @param index number - Index number of electricity cabinet
--- @return nil
local StartMagnet = function(index)
    local ped = PlayerPedId()
    local prop = `hei_prop_heist_thermite` -- prop_phone_proto_battery meh idk

    TriggerServerEvent('qb-casinoheist:server:RemoveMagnet')
    TriggerServerEvent('qb-casinoheist:server:SetMagnetBusy', index, true)

    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasNamedPtfxAssetLoaded("scr_ornate_heist") do Wait(10) end
    
    if math.random(1, 100) <= 65 and not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(ped))
    end
    SetEntityHeading(ped, Shared.Magnets[index].animation.w)
    local pos = Shared.Magnets[index].animation.xyz
    Wait(100)

    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(prop, x, y, z + 0.2, true, true, true)
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

    exports["memorygame"]:thermiteminigame(MagnetSettings.correctBlocks, MagnetSettings.incorrectBlocks, MagnetSettings.timetoShow, MagnetSettings.timetoLose, function()
        ClearPedTasks(ped)
        TriggerServerEvent('qb-casinoheist:server:MagnetHit', index)
        Wait(2000)
        DeleteEntity(charge)
        TriggerServerEvent('qb-casinoheist:server:SetMagnetBusy', index, false)
    end, function()
        QBCore.Functions.Notify("You failed...", "error")
        Wait(2000)
        DeleteEntity(charge)
        TriggerServerEvent('qb-casinoheist:server:SetMagnetBusy', index, false)
    end)
end
--- Method to perform rappel animation in elevator shaft
--- @return nil
local RappelAnimation = function()
    local ped = PlayerPedId()
    local hatch = vector3(1014.54, 29.88, -6.00)
    local top = 70.21
    local start = 60.21
    local bot = -5.0
    local length = (top - bot)

    -- Create Rope
    RopeLoadTextures()
    local rope = AddRope(hatch.x, hatch.y, top, 0.0, 0.0, 0.0, length, 2, length, length, 1.0, false, false, true, 20.0, false)
    PinRopeVertex(rope, (GetRopeVertexCount(rope) - 1), vector3(hatch.x, hatch.y, top+1.0))
    PinRopeVertex(rope, 0, vector3(hatch.x, hatch.y, bot-1.0))

    -- Start Rappel
    DoScreenFadeIn(250)
    SetEntityCoords(ped, vector3(hatch.x, hatch.y, start))
    TaskRappelDownWall(ped, vector3(hatch.x, hatch.y, top), vector3(hatch.x, hatch.y, top), bot, rope, 'clipset@anim_heist@hs3f@ig1_rappel@male', 1)

    -- While Rappelling
    while true do
        Wait(10)
        SetEntityHeading(ped, 335.0)
        if #(GetEntityCoords(ped) - vector3(hatch.x, hatch.y, bot)) < 0.1 then
            -- Detach
            Wait(250)
            ClearPedTasksImmediately(ped)
            return
        end
    end

    -- Delete
    Wait(3000)
    DeleteRope(rope)
    RopeUnloadTextures()
end

--- Method to enable or disable qb-target interaction for USB based on state parameter
--- @param state boolean - true or false state
--- @return nil
EnableUSB = function(state)
    if state then
        exports['qb-target']:AddTargetModel('tr_prop_tr_usb_drive_01a', {
            options = {
                {
                    action = function(entity) TakeUSB(entity) end,
                    icon = 'fas fa-user-secret',
                    label = 'Grab USB',
                    canInteract = function() return Shared.USBSpawned end,
                },
            },
            distance = 1.5,
        })
    else
        exports['qb-target']:RemoveTargetModel('tr_prop_tr_usb_drive_01a', 'casinoheist_usb_off')
    end
end

RegisterNetEvent('qb-casinoheist:client:SecurityComputer', function()
    QBCore.Functions.TriggerCallback('qb-casinoheist:server:CanVarHack', function(result)
        if result then
            local ped = PlayerPedId()
            local animDict = 'anim@heists@prison_heiststation@cop_reactions'
            local anim = 'cop_b_idle'

            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do Wait(10) end
            TaskPlayAnim(ped, animDict, anim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)

            exports['varhack']:OpenHackingGame(function(success)
                TriggerServerEvent('qb-casinoheist:server:CompleteVarHack', success)
                if success then
                    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
                end
                StopAnimTask(ped, animDict, anim, 1.0)
            end, 2, 7)
        else
            QBCore.Functions.Notify('Computer is in lockdown..', 'error', 2500)
        end
    end)
end)

RegisterNetEvent('qb-casinoheist:client:MagnetsEnabled', function(state)
    Shared.MagnetsEnabled = state
end)

RegisterNetEvent('qb-casinoheist:client:SetMagnetBusy', function(index, state)
    Shared.Magnets[index].busy = state
end)

RegisterNetEvent('qb-casinoheist:client:UseMagnets', function()
    if not Shared.MagnetsEnabled then return end
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    
    for i=1, #Shared.Magnets do
        if #(pos - Shared.Magnets[i].coords) < 2.0 then
            if Shared.Magnets[i].busy then
                QBCore.Functions.Notify("Someone is already tampering with this..", "error", 2500)
            else
                StartMagnet(i)
            end
            break
        end
    end
end)

RegisterNetEvent('qb-casinoheist:client:EnableUSB', function(state)
    Shared.USBSpawned = state
    EnableUSB(state)
end)

RegisterNetEvent('qb-casinoheist:client:ManagementComputer', function()
    local ped = PlayerPedId()
    local animDict = 'anim@heists@prison_heiststation@cop_reactions'
    local anim = 'cop_b_idle'

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(10) end
    TaskPlayAnim(ped, animDict, anim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)

    exports['chesshack']:OpenHackingGame(function(success)
        if success then 
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            TriggerServerEvent('qb-casinoheist:server:ManagementComputer')
        end
        StopAnimTask(ped, animDict, anim, 1.0)
    end, 24)
end)

RegisterNetEvent('qb-casinoheist:client:SecretaryComputer', function()
    local ped = PlayerPedId()
    local animDict = 'anim@heists@prison_heiststation@cop_reactions'
    local anim = 'cop_b_idle'

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(10) end
    TaskPlayAnim(ped, animDict, anim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)

    exports['chesshack']:OpenHackingGame(function(success)
        if success then
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            TriggerServerEvent('qb-casinoheist:server:SecretaryComputer')
        end
        StopAnimTask(ped, animDict, anim, 1.0)
    end, 24)
end)

RegisterNetEvent('qb-casinoheist:client:EnterKeyCardCode', function()
    local keyboard, input = exports["var-password"]:Keyboard({header = "Password", rows = {""}})
    if keyboard then
        QBCore.Functions.TriggerCallback('qb-casinoheist:server:KeycardCode', function(result)
            if result then
                TriggerServerEvent('qb-doorlock:server:updateState', 'lh34casino-keycardvault', false, false, false, true, false, false)
                QBCore.Functions.Notify('Access Granted', 'success', 3500)
            else
                QBCore.Functions.Notify('Invalid Access Code', 'error', 3500)
            end
        end, input)
    end
end)

RegisterNetEvent('qb-casinoheist:client:KeycardTaken', function(state)
    Shared.KeycardTaken = state
end)

RegisterNetEvent('qb-casinoheist:client:OpenElevator', function()
    local result = QBCore.Functions.HasItem({'casino_keycard', 'weapon_crowbar'})
    if result then
        QBCore.Functions.Progressbar("casino_openelevator", "Forcing Open..", math.random(10000, 12000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "missheistfbi3b_ig7",
            anim = "lift_fibagent_loop",
            flags = 1,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), 'missheistfbi3b_ig7', 'lift_fibagent_loop', 1.0)
            Wait(1000)
            TriggerServerEvent('qb-doorlock:server:updateState', 'lh34casino-elevatorshaft1', false, false, false, true, false, false)
        end, function() -- Cancel
            QBCore.Functions.Notify("Cancelled..", "error", 2500)
            StopAnimTask(PlayerPedId(), 'missheistfbi3b_ig7', 'lift_fibagent_loop', 1.0)
        end)
    else
        QBCore.Functions.Notify('You are missing the correct tool(s) to open this..', 'error', 3500)
    end
end)

RegisterNetEvent('qb-casinoheist:client:ElevatorRappel', function()
    if Shared.SetLadder then return end
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("casinoh_rappel", "Attaching Rope..", 5000, true, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 1,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
        DoScreenFadeOut(250)
        Wait(250)
        RappelAnimation()
    end)
end)

RegisterNetEvent('qb-casinoheist:client:OpenElevatorHatch', function()
    TriggerServerEvent('qb-doorlock:server:updateState', 'lh34casino-elevator_hatch', false, false, false, true, false, false)
end)

RegisterNetEvent('qb-casinoheist:client:OpenElevator2', function()
    if Shared.SetLadder then return end
    local result = QBCore.Functions.HasItem({'casino_keycard', 'weapon_crowbar'})
    if result then
        QBCore.Functions.Progressbar("casino_openelevator", "Forcing Open..", math.random(10000, 12000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "missheistfbi3b_ig7",
            anim = "lift_fibagent_loop",
            flags = 1,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), 'missheistfbi3b_ig7', 'lift_fibagent_loop', 1.0)
            TriggerServerEvent('qb-casinoheist:server:SetLadderActive', true)
            Wait(1000)
            TriggerServerEvent('qb-doorlock:server:updateState', 'lh34casino-bottom_elevator', false, false, false, true, false, false)
        end, function() -- Cancel
            QBCore.Functions.Notify("Cancelled..", "error", 2500)
            StopAnimTask(PlayerPedId(), 'missheistfbi3b_ig7', 'lift_fibagent_loop', 1.0)
        end)
    else
        QBCore.Functions.Notify('You are missing the correct tool(s) to open this..', 'error', 3500)
    end
end)

CreateThread(function()
    -- Management Office USB Hack 1
    exports['qb-target']:AddBoxZone("casinoh_mgmt1", vector3(997.75, 53.92, 75.07), 1.0, 0.5, {
        name = "casinoh_mgmt1",
        heading = 212,
        debugPoly = false,
        minZ = 74.07,
        maxZ = 75.67
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:ManagementComputer',
                icon = 'fas fa-user-secret',
                label = 'Access Computer',
                item = 'casino_usb1'
            }
        },
        distance = 1.5,
    })

    -- Management Office USB Hack 2
    exports['qb-target']:AddBoxZone("casinoh_mgmt2", vector3(1006.69, 60.14, 75.07), 1.0, 0.6, {
        name = "casinoh_mgmt2",
        heading = 298,
        debugPoly = false,
        minZ = 74.07,
        maxZ = 75.67
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:SecretaryComputer',
                icon = 'fas fa-user-secret',
                label = 'Access Computer',
                item = 'casino_usb2'
            }
        },
        distance = 1.5,
    })

    -- Security Room VAR Hack
    exports['qb-target']:AddBoxZone("casinoh_securityroom", vector3(1016.4, 10.03, 71.47), 1.0, 0.6, {
        name = "casinoh_securityroom",
        heading = 328,
        debugPoly = false,
        minZ = 71.07,
        maxZ = 71.87
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:SecurityComputer',
                icon = 'fas fa-user-secret',
                label = 'Access Computer'
            }
        },
        distance = 1.5,
    })

    -- Keycard Code
    exports['qb-target']:AddBoxZone("casinoh_keycardcode", vector3(1004.98, 9.15, 71.47), 0.4, 0.2, {
        name = "casinoh_keycardcode",
        heading = 238,
        debugPoly = false,
        minZ = 71.67,
        maxZ = 72.17
      }, {
        options = { 
            {
                type = 'false',
                event = 'qb-casinoheist:client:EnterKeyCardCode',
                icon = 'fas fa-user-secret',
                label = 'Input Access Code'
            }
        },
        distance = 1.5,
    })

    -- Keycard
    exports['qb-target']:AddBoxZone("casinoh_keycard", vector3(1003.21, 7.52, 71.47), 0.5, 0.5, {
        name = "casinoh_keycard",
        heading = 33,
        debugPoly = false,
        minZ = 70.87,
        maxZ = 71.87
      }, {
        options = { 
            {
                type = 'server',
                event = 'qb-casinoheist:server:GrabKeyCard',
                icon = 'fas fa-user-secret',
                label = 'Take Keycard',
                canInteract = function()
                    return not Shared.KeycardTaken
                end
            }
        },
        distance = 1.5,
    })

    -- Top Elevator Door
    exports['qb-target']:AddBoxZone("casinoh_elevatorshaft", vector3(1014.6, 30.51, 75.06), 1.2, 0.4, {
        name = "casinoh_elevatorshaft",
        heading = 238,
        debugPoly = false,
        minZ = 74.26,
        maxZ = 76.26
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:OpenElevator',
                icon = 'fas fa-circle',
                label = 'Force Open',
                item = 'casino_keycard'
            }
        },
        distance = 1.5,
    })

    -- Rappel
    exports['qb-target']:AddBoxZone("casinoh_rappel", vector3(1015.41, 31.17, 63.41), 1.6, 1.0, {
        name = "casinoh_rappel",
        heading = 331,
        debugPoly = false,
        minZ = 62.36,
        maxZ = 64.26
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:ElevatorRappel',
                icon = 'fas fa-user-secret',
                label = 'Attach Rope',
                canInteract = function()
                    return not Shared.SetLadder
                end
            }
        },
        distance = 1.5,
    })

    -- Elevator Hatch
    exports['qb-target']:AddBoxZone("casinoh_hatch", vector3(1014.71, 30.08, -7.00), 0.3, 0.5, {
        name = "casinoh_hatch",
        heading = 328.00,
        debugPoly = false,
        minZ = -7.10,
        maxZ = -6.50
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:OpenElevatorHatch',
                icon = 'fas fa-circle',
                label = 'Unlock Hatch'
            }
        },
        distance = 1.5,
    })

    -- Bottom Elevator Door
    exports['qb-target']:AddBoxZone("casinoh_botelevator", vector3(1013.11, 27.61, -8.53), 1.2, 0.4, {
        name = "casinoh_botelevator",
        heading = 238,
        debugPoly = false,
        minZ = -9.33,
        maxZ = -7.33
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:OpenElevator2',
                icon = 'fas fa-circle',
                label = 'Force Open',
                item = 'casino_keycard'
            }
        },
        distance = 1.5,
    })
end)

CreateThread(function()
    lasers[#lasers+1] = Laser.new(vector3(1011.802, 28.328, 54.271), {vector3(1014.853, 30.435, 54.243), vector3(1013.383, 31.349, 54.224)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "casino_elevator1"})
    lasers[#lasers+1] = Laser.new(vector3(1011.834, 32.31, 54.259), {vector3(1011.004, 28.823, 54.232), vector3(1009.423, 29.806, 54.252)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "casino_elevator2"})
    lasers[#lasers+1] = Laser.new(vector3(1014.588, 26.598, 33.521), {vector3(1016.2, 32.037, 31.269), vector3(1008.845, 31.526, 31.047), vector3(1010.279, 33.7, 30.95), vector3(1014.82, 32.894, 31.302)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "casino_elevator3"})
    lasers[#lasers+1] = Laser.new(vector3(1011.07, 34.963, 33.716), {vector3(1009.178, 30.034, 30.995), vector3(1011.744, 28.364, 29.251), vector3(1013.556, 27.315, 31.772), vector3(1015.542, 27.22, 30.466), vector3(1016.069, 27.801, 32.595)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "casino_elevator4"})
    lasers[#lasers+1] = Laser.new(vector3(1013.634, 27.191, 25.569), {vector3(1009.4, 33.421, 23.609), vector3(1012.807, 31.463, 23.71), vector3(1015.193, 31.171, 22.432)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "casino_elevator5"})
    lasers[#lasers+1] = Laser.new(vector3(1009.487, 33.563, 27.346), {vector3(1009.497, 29.836, 23.987), vector3(1011.047, 28.874, 22.852), vector3(1012.046, 28.176, 21.368)}, {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "casino_elevator6"})
end)
