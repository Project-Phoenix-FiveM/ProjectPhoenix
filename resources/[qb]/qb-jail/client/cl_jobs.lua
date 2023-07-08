local isBusy = false
currentZone = nil

--- Skatepark

RegisterNetEvent('qb-jail:client:GrabBMX', function()
    local ped = PlayerPedId()
    if isBusy then return end
    isBusy = true
    QBCore.Functions.SpawnVehicle('bmx', function(veh)
        TaskWarpPedIntoVehicle(ped, veh, -1)
        Wait(2000)
        isBusy = false
    end, Config.SpawnBMX, true)
end)

CreateThread(function()
    local pedModel = `a_m_y_skater_01`
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do Wait(0) end
    local bmxPed = CreatePed(0, pedModel, Config.BMXCoords.x, Config.BMXCoords.y, Config.BMXCoords.z, Config.BMXCoords.w, false, false)
    FreezeEntityPosition(bmxPed, true)
    SetEntityInvincible(bmxPed, true)
    SetBlockingOfNonTemporaryEvents(bmxPed, true)
    
    exports['qb-target']:AddTargetEntity(bmxPed, {
        options = {
            {
                type = "client",
                event = "qb-jail:client:GrabBMX",
                icon = 'fas fa-bicycle',
                label = 'Grab BMX',
            }
        },
        distance = 2.5,
    })
end)

--- Running

local obstacles = {
    [1] = {
        coords = vector4(1752.39, 2530.19, 44.57, 114.4),
        prop = 'prop_barier_conc_02b',
        propheading = 114.4,
    },
    [2] = {
        coords = vector4(1733.28, 2520.6, 44.56, 114.5),
        prop = 'prop_cons_ply02',
        propheading =  204.5,
    },
    [3] = {
        coords = vector4(1713.74, 2504.28, 44.56, 175.38),
        prop = 'prop_drywallpile_01',
        propheading = 265.38,
    },
    [4] = {
        coords = vector4(1688.8, 2493.79, 44.56, 89.37),
        prop = 'prop_barier_conc_01a',
        propheading = 89.37,
    },
    [5] = {
        coords = vector4(1653.45, 2502.17, 44.56, 48.29),
        prop = 'prop_logpile_05',
        propheading = 138.29,
    },
    [6] = {
        coords = vector4(1622.93, 2540.7, 44.56, 359.57),
        prop = 'prop_mc_conc_barrier_01',
        propheading = 359.57,
    },
    [7] = {
        coords = vector4(1643.49, 2560.98, 44.56, 270.52),
        prop = 'prop_pipes_01a',
        propheading = 180.52,
    },
    [8] = {
        coords = vector4(1690.35, 2560.85, 44.56, 269.94),
        prop = 'prop_shuttering03',
        propheading = 359.94,
    },
    [9] = {
        coords = vector4(1719.48, 2560.92, 44.56, 268.6),
        prop = 'prop_woodpile_03a',
        propheading = 178.6,
    },
    [10] = {
        coords = vector4(1754.04, 2560.93, 44.57, 268.61),
        prop = 'prop_barier_conc_02b',
        propheading = 268.61,
    }
}

local currentCheckpoint = 1

--- Method generate a blip, obstacle prop and polyzone for a new running checkpoint, reset lap if last checkpoint
--- @param checkpoint number - checkpoint number
--- @return nil
createCheckpoint = function(checkpoint)
    -- Blip
    createJobTaskBlip(obstacles[checkpoint].coords.xyz, 'Checkpoint ' .. checkpoint, 126, false)

    -- New Obstacle
    RequestModel(obstacles[checkpoint].prop)
	while not HasModelLoaded(obstacles[checkpoint].prop) do Wait(10) end
	if not HasModelLoaded(obstacles[checkpoint].prop) then
		SetModelAsNoLongerNeeded(obstacles[checkpoint].prop)
	else
        local created_object = CreateObjectNoOffset(obstacles[checkpoint].prop, obstacles[checkpoint].coords.xyz, false, false, true)
        SetEntityHeading(created_object, obstacles[checkpoint].propheading)
        FreezeEntityPosition(created_object, true)
        SetEntityInvincible(created_object, true)
        SetModelAsNoLongerNeeded(obstacles[checkpoint].prop)
        jobObjects[1] = created_object
    end

    -- PolyZone around object to mark next obstacle
    currentZone = BoxZone:Create(obstacles[checkpoint].coords.xyz, 2.5, 5.0, {
        name = "prison_running_obstacle",
        heading = obstacles[checkpoint].coords.w,
        debugPoly = false,
        minZ = obstacles[checkpoint].coords.z - 0.5,
        maxZ = obstacles[checkpoint].coords.z + 3.8,
    })

    currentZone:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            currentZone:destroy()
            currentCheckpoint += 1
            if currentCheckpoint > #obstacles then -- Completed Lap
                currentCheckpoint = 1
                TriggerServerEvent('qb-jail:server:RequestSentenceReduction', currentJob)
            end

            exports['qb-core']:DrawText('Progress: ' .. math.floor((currentCheckpoint - 1) * 100 / #obstacles) .. '%', 'left')

            -- Delete Existing Obstacle
            Wait(2000)
            destroyJobBlips()
            if jobObjects[1] and DoesEntityExist(jobObjects[1]) then DeleteEntity(jobObjects[1]) end

            -- Create New Checkpoint
            createCheckpoint(currentCheckpoint)
        end
    end)    
end

--- Method to start the running job at prison by creating the first checkpoint
--- @return nil
startRunningJob = function()
    currentCheckpoint = 1
    createCheckpoint(currentCheckpoint)
    QBCore.Functions.Notify('Make your way to the yard for some running!', 'primary', 2500)
end

--- Workout

--- Method to perform the situp animation at a given entity
--- @param entity number - entity handle
--- @return nil
local SitUp = function(entity)
    if currentJob ~= 'workout' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end
    if entity == 0 then return end
    if isBusy then return end
    isBusy = true
    local ped = PlayerPedId()
    local coords = GetEntityCoords(entity)

    RequestAnimDict("amb@world_human_sit_ups@male@enter")
    RequestAnimDict("amb@world_human_sit_ups@male@base")
    RequestAnimDict("amb@world_human_sit_ups@male@exit")

    while 
        not HasAnimDictLoaded("amb@world_human_sit_ups@male@enter") or
        not HasAnimDictLoaded("amb@world_human_sit_ups@male@base") or
        not HasAnimDictLoaded("amb@world_human_sit_ups@male@exit")
    do 
        Wait(0) 
    end

    TaskPlayAnimAdvanced(ped, "amb@world_human_sit_ups@male@enter", 'enter', coords.x, coords.y, coords.z, 0.0, 0.0, 120.0, 1.0, 1.0, -1, 0, 0, 0, 0)
    Wait(GetAnimDuration("amb@world_human_sit_ups@male@enter", 'enter') * 1000)

    TaskPlayAnim(ped, "amb@world_human_sit_ups@male@base", 'base', 8.0, 8.0, -1, 0, 0.0, false, false, false)
    Wait(GetAnimDuration("amb@world_human_sit_ups@male@base", 'base') * 1000)
        
    TaskPlayAnim(ped, "amb@world_human_sit_ups@male@exit", 'exit', 8.0, 8.0, -1, 0, 0.0, false, false, false)
    Wait(GetAnimDuration("amb@world_human_sit_ups@male@exit", 'exit') * 1000)

    RemoveAnimDict("amb@world_human_sit_ups@male@enter")
    RemoveAnimDict("amb@world_human_sit_ups@male@base")
    RemoveAnimDict("amb@world_human_sit_ups@male@exit")

    -- Reward Completion
    TriggerServerEvent('qb-jail:server:RequestSentenceReduction', currentJob)
    isBusy = false
end

--- Method to perform the pushup animation at a given entity
--- @param entity number - entity handle
--- @return nil
local Pushup = function(entity)
    if currentJob ~= 'workout' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end
    if entity == 0 then return end
    if isBusy then return end
    isBusy = true
    local ped = PlayerPedId()
    local coords = GetEntityCoords(entity)

    RequestAnimDict("amb@world_human_push_ups@male@enter")
    RequestAnimDict("amb@world_human_push_ups@male@base")
    RequestAnimDict("amb@world_human_push_ups@male@exit")

    while 
        not HasAnimDictLoaded("amb@world_human_push_ups@male@enter") or
        not HasAnimDictLoaded("amb@world_human_push_ups@male@base") or
        not HasAnimDictLoaded("amb@world_human_push_ups@male@exit")
    do 
        Wait(0) 
    end

    TaskPlayAnimAdvanced(ped, "amb@world_human_push_ups@male@enter", 'enter', coords.x, coords.y, coords.z, 0.0, 0.0, 120.0, 1.0, 1.0, -1, 0, 0, 0, 0)
    Wait(GetAnimDuration("amb@world_human_push_ups@male@enter", 'enter') * 1000)

    TaskPlayAnim(ped, "amb@world_human_push_ups@male@base", 'base', 8.0, 8.0, -1, 0, 0.0, false, false, false)
    Wait(GetAnimDuration("amb@world_human_push_ups@male@base", 'base') * 1000)
        
    TaskPlayAnim(ped, "amb@world_human_push_ups@male@exit", 'exit', 8.0, 8.0, -1, 0, 0.0, false, false, false)
    Wait(GetAnimDuration("amb@world_human_push_ups@male@exit", 'exit') * 1000)

    RemoveAnimDict("amb@world_human_push_ups@male@enter")
    RemoveAnimDict("amb@world_human_push_ups@male@base")
    RemoveAnimDict("amb@world_human_push_ups@male@exit")

    -- Reward Completion
    TriggerServerEvent('qb-jail:server:RequestSentenceReduction', currentJob)
    isBusy = false
end

--- Method to perform the dumbbells animation at a given entity
--- @param entity number - entity handle
--- @return nil
local Dumbbells = function(entity)
    if currentJob ~= 'workout' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end
    if entity == 0 then return end
    local ped = PlayerPedId()
    if isBusy then return end
    isBusy = true

    local weight = CreateObject(`prop_barbell_01`, GetEntityCoords(ped), true, true, true)
    AttachEntityToEntity(weight, ped, GetPedBoneIndex(ped, 28422), 0.25, 0.0, -0.05, 0.0, 15.0, 0.0 , 1, 1, 0, 1, 0, 1)
    local weight2 = CreateObject(`prop_barbell_01`, GetEntityCoords(ped), true, true, true)
    AttachEntityToEntity(weight2, ped, GetPedBoneIndex(ped, 28422), -0.25, 0.0, -0.05, 0.0, -15.0, 0.0 , 1, 1, 0, 1, 0, 1)
    RequestAnimDict('amb@world_human_muscle_free_weights@male@barbell@base')
    while not HasAnimDictLoaded('amb@world_human_muscle_free_weights@male@barbell@base') do Wait(0) end
    TaskPlayAnim(ped, 'amb@world_human_muscle_free_weights@male@barbell@base', 'base', 8.0, 8.0, -1, 1, 0.0, false, false, false)
    Wait(15000)
    -- Complete Reward
    TriggerServerEvent('qb-jail:server:RequestSentenceReduction', currentJob)
    DeleteEntity(weight)
    DeleteEntity(weight2)
    ClearPedTasks(ped)
    isBusy = false
end

--- Method to perform the bench press animation at a given entity
--- @param entity number - entity handle
--- @return nil
local BenchPress = function(entity)
    if currentJob ~= 'workout' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end
    if entity == 0 then return end
    if isBusy then return end
    isBusy = true
    local ped = PlayerPedId()
    local coords = GetEntityCoords(entity)
    local heading = GetEntityHeading(entity)

    local offset = -0.25
    if GetEntityModel(entity) == `prop_weight_bench_02` then offset = 0.6 end -- #DifferentBenchesDifferentOffsets
    TaskStartScenarioAtPosition(ped, "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS_PRISON", coords.x, coords.y, coords.z + offset, heading + 180.0, 0, false, true)
    Wait(8 * 1000)
    while IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS_PRISON") do
        exports['ps-ui']:Circle(function(success)
            if success then
                -- Complete Set Reward
                TriggerServerEvent('qb-jail:server:RequestSentenceReduction', currentJob)
            end
        end, 1, 15)
        Wait(15 * 1000)
    end
    RemovePropType(-1711403533)
    isBusy = false
end

RegisterNetEvent('qb-jail:client:ChinUp', function(data)
    if currentJob ~= 'workout' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end
    if isBusy then return end
    isBusy = true
    local ped = PlayerPedId()
    
    RequestAnimDict('amb@prop_human_muscle_chin_ups@male@enter')
    RequestAnimDict('amb@prop_human_muscle_chin_ups@male@base')
    RequestAnimDict('amb@prop_human_muscle_chin_ups@male@exit')

    while 
        not HasAnimDictLoaded('amb@prop_human_muscle_chin_ups@male@enter') or
        not HasAnimDictLoaded('amb@prop_human_muscle_chin_ups@male@base') or
        not HasAnimDictLoaded('amb@prop_human_muscle_chin_ups@male@exit')
    do 
        Wait(0) 
    end

    local progress = 0
    exports['qb-core']:DrawText('Progress: ' .. progress .. '%', 'left')

    if data.index == 1 then
        TaskPlayAnimAdvanced(ped, 'amb@prop_human_muscle_chin_ups@male@enter', 'enter', 1643.44, 2527.82, 45.56, 0.0, 0.0, 50.0, 1.0, 1.0, -1, 0, 0, 0, 0)
    elseif data.index == 2 then
        TaskPlayAnimAdvanced(ped, 'amb@prop_human_muscle_chin_ups@male@enter', 'enter', 1648.93, 2529.77, 45.56, 0.0, 0.0, 230.0, 1.0, 1.0, -1, 0, 0, 0, 0)
    end
    Wait(GetAnimDuration('amb@prop_human_muscle_chin_ups@male@enter', 'enter') * 1000)
    progress += 15.4
    exports['qb-core']:DrawText('Progress: ' .. progress .. '%', 'left')

    CreateThread(function()
        local totalWait = GetAnimDuration('amb@prop_human_muscle_chin_ups@male@base', 'base') * 1000
        for i=1, 5 do
            Wait(totalWait / 5)
            progress += (72.85 / 5)
            exports['qb-core']:DrawText('Progress: ' .. progress .. '%', 'left')
        end
    end)

    TaskPlayAnim(ped, 'amb@prop_human_muscle_chin_ups@male@base', 'base', 8.0, 8.0, -1, 0, 0.0, false, false, false)
    Wait(GetAnimDuration('amb@prop_human_muscle_chin_ups@male@base', 'base') * 1000)
        
    TaskPlayAnim(ped, 'amb@prop_human_muscle_chin_ups@male@exit', 'exit', 8.0, 8.0, -1, 0, 0.0, false, false, false)
    Wait(GetAnimDuration('amb@prop_human_muscle_chin_ups@male@exit', 'exit') * 1000)
    exports['qb-core']:HideText()

    RemoveAnimDict('amb@prop_human_muscle_chin_ups@male@enter')
    RemoveAnimDict('amb@prop_human_muscle_chin_ups@male@base')
    RemoveAnimDict('amb@prop_human_muscle_chin_ups@male@exit')

    -- Reward Completion
    TriggerServerEvent('qb-jail:server:RequestSentenceReduction', currentJob)
    isBusy = false
end)

CreateThread(function()
    local mats = {`prop_yoga_mat_01`, `prop_yoga_mat_02`, `prop_yoga_mat_03`}
    exports['qb-target']:AddTargetModel(mats, {
        options = {
            {
                action = function(entity)
                    SitUp(entity)
                end,
                icon = 'fas fa-circle-chevron-right',
                label = 'Do Situps',
                canInteract = function(entity)
                    return insidePrisonZone
                end,
            },
            {
                action = function(entity)
                    Pushup(entity)
                end,
                icon = 'fas fa-circle-chevron-right',
                label = 'Do Pushups',
                canInteract = function(entity)
                    return insidePrisonZone
                end,
            }
        },
        distance = 2.5, 
    })

    local benches = {`prop_pris_bench_01`, `prop_weight_bench_02`}
    exports['qb-target']:AddTargetModel(benches, {
        options = {
            {
                action = function(entity)
                    BenchPress(entity)
                end,
                icon = 'fas fa-dumbbell',
                label = 'Bench Press',
                canInteract = function(entity)
                    return insidePrisonZone
                end,
            }
        },
        distance = 2.5, 
    })

    exports['qb-target']:AddTargetModel(`prop_weight_rack_02`, {
        options = {
            {
                action = function(entity)
                    Dumbbells(entity)
                end,
                icon = 'fas fa-dumbbell',
                label = 'Lift Weights',
                canInteract = function(entity)
                    return insidePrisonZone
                end,
            }
        },
        distance = 2.5, 
    })

    exports['qb-target']:AddBoxZone("prison_workout_chinup1", vector3(1643.27, 2527.85, 45.56), 1.4, 0.4, {
        name = "prison_workout_chinup1",
        heading = 140,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 47.50
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:ChinUp",
                icon = 'fas fa-dumbbell',
                label = 'Chin Ups',
                index = 1
            }
        },
        distance = 2.5,
    })

    exports['qb-target']:AddBoxZone("prison_workout_chinup2", vector3(1649.05, 2529.64, 45.56), 1.4, 0.4, {
        name = "prison_workout_chinup2",
        heading = 140,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 47.50
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:ChinUp",
                icon = 'fas fa-dumbbell',
                label = 'Chin Ups',
                index = 2
            }
        },
        distance = 2.5,
    })
end)

--- Kitchen

local cafeteriaTables = {
    [1] = {completed = false, coords = vector3(1780.96, 2554.46, 45.08)},
    [2] = {completed = false, coords = vector3(1780.96, 2550.85, 45.08)},
    [3] = {completed = false, coords = vector3(1780.96, 2547.30, 45.08)},
    [4] = {completed = false, coords = vector3(1786.77, 2547.30, 45.08)},
    [5] = {completed = false, coords = vector3(1786.77, 2550.85, 45.08)},
    [6] = {completed = false, coords = vector3(1786.77, 2554.46, 45.08)}
}

local taskCompleted = false

--- Method to return the closest cafetariaTable index for given coordinates
--- @param coords vector3 - location coordinates
--- @return k number - CafeteriaTable index
local getClosestCafeteriaTable = function(coords)
    for k, v in pairs(cafeteriaTables) do
        if #(coords - v.coords) < 2.0 then
            return k
        end
    end
end

--- Method to check if all tables have been completed, if so, reset the tables so they can be cleaned again
--- @return nil
local checkTables = function()
    local reset = true
    for i=1, #cafeteriaTables do
        if not cafeteriaTables[i].completed then
            reset = false
            break
        end
    end

    if reset then
        for i=1, #cafeteriaTables do
            cafeteriaTables[i].completed = false
        end
        QBCore.Functions.Notify('The guards are not content, do the tables again!', 'error', 2500)
    end
end

RegisterNetEvent('qb-jail:client:CleanDishes', function()
    if currentJob ~= 'kitchen' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    elseif taskCompleted == 'clean' then
        QBCore.Functions.Notify('You have already done this task..', 'error', 2500)
        return
    end
    if isBusy then return end
    isBusy = true

    QBCore.Functions.Progressbar("prison_cleandishes", "Cleaning Dishes..", 7800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@bodysearch@',
        anim = "player_search",
        flags = 16,
    }, {}, {}, function()
        exports['ps-ui']:Circle(function(success)
            TriggerServerEvent('qb-jail:server:FinishKitchenTask', 2, success)
        end, 1, 14)
        isBusy = false
        taskCompleted = 'clean'
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        isBusy = false
    end)
end)

RegisterNetEvent('qb-jail:client:SortShelf', function()
    if currentJob ~= 'kitchen' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    elseif taskCompleted == 'sort' then
        QBCore.Functions.Notify('You have already done this task..', 'error', 2500)
        return
    end
    if isBusy then return end
    isBusy = true

    QBCore.Functions.Progressbar("prison_sortshelf", "Sorting shelf..", 7800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@bodysearch@',
        anim = "player_search",
        flags = 16,
    }, {}, {}, function()
        exports['ps-ui']:Circle(function(success)
            TriggerServerEvent('qb-jail:server:FinishKitchenTask', 2, success)
        end, 1, 14)
        isBusy = false
        taskCompleted = 'sort'
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        isBusy = false
    end)
end)

RegisterNetEvent('qb-jail:client:MakeFoodShelf', function()
    if currentJob ~= 'kitchen' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    elseif taskCompleted == 'shelf' then
        QBCore.Functions.Notify('You have already done this task..', 'error', 2500)
        return
    end
    if isBusy then return end
    isBusy = true
    
    QBCore.Functions.Progressbar("prison_prepfood", "Preparing Food..", 7800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@bodysearch@',
        anim = "player_search",
        flags = 16,
    }, {}, {}, function()
        exports['ps-ui']:Circle(function(success)
            TriggerServerEvent('qb-jail:server:FinishKitchenTask', 1, success)
        end, 1, 14)
        isBusy = false
        taskCompleted = 'shelf'
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        isBusy = false
    end)
end)

RegisterNetEvent('qb-jail:client:MakeFoodCounter', function()
    if currentJob ~= 'kitchen' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    elseif taskCompleted == 'counter' then
        QBCore.Functions.Notify('You have already done this task..', 'error', 2500)
        return
    end
    if isBusy then return end
    isBusy = true
    
    QBCore.Functions.Progressbar("prison_prepfood", "Preparing Food..", 7800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@bodysearch@',
        anim = "player_search",
        flags = 16,
    }, {}, {}, function()
        exports['ps-ui']:Circle(function(success)
            TriggerServerEvent('qb-jail:server:FinishKitchenTask', 1, success)
        end, 1, 14)
        isBusy = false
        taskCompleted = 'counter'
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        isBusy = false
    end)
end)

RegisterNetEvent('qb-jail:client:MakeFoodStove', function()
    if currentJob ~= 'kitchen' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    elseif taskCompleted == 'stove' then
        QBCore.Functions.Notify('You have already done this task..', 'error', 2500)
        return
    end
    if isBusy then return end
    isBusy = true
    
    QBCore.Functions.Progressbar("prison_prepfood", "Preparing Food..", 7800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 16,
    }, {}, {}, function()
        exports['ps-ui']:Circle(function(success)
            TriggerServerEvent('qb-jail:server:FinishKitchenTask', 1, success)
        end, 1, 14)
        isBusy = false
        taskCompleted = 'stove'
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        isBusy = false
    end)
end)

RegisterNetEvent('qb-jail:client:CleanTables', function(data)
    if currentJob ~= 'kitchen' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end
    if isBusy then return end
    local tableCoords = GetEntityCoords(data.entity)
    local table = getClosestCafeteriaTable(tableCoords)
    if cafeteriaTables[table].completed then
        QBCore.Functions.Notify('You already cleaned this table!', 'error', 2500)
        return
    end
    isBusy = true

    local ped = PlayerPedId()
    TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
    Wait(1500)

    QBCore.Functions.Progressbar("prison_cleantable", "Cleaning Table..", 7800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@bodysearch@',
        anim = "player_search",
        flags = 16,
    }, {}, {}, function() -- Done
        exports['ps-ui']:Circle(function(success)
            cafeteriaTables[table].completed = true
            TriggerServerEvent('qb-jail:server:FinishKitchenTask', 3, success)
            checkTables()
        end, 1, 14)
        isBusy = false
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        isBusy = false
    end)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("prison_kitchen_clean", vector3(1778.68, 2565.07, 45.67), 1.5, 0.8, {
        name = "prison_kitchen_clean",
        heading = 270,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 46.50
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:CleanDishes",
                icon = 'fas fa-hand-sparkles',
                label = 'Clean Dishes',
            }
        },
        distance = 2.5,
    })

    exports['qb-target']:AddBoxZone("prison_kitchen_shelves", vector3(1787.01, 2564.73, 45.67), 2.4, 0.4, {
        name = "prison_kitchen_shelves",
        heading = 270,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 46.50
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:SortShelf",
                icon = 'fas fa-boxes-packing',
                label = 'Sort Shelf',
            },
            {
                type = "client",
                event = "qb-jail:client:MakeFoodShelf",
                icon = 'fas fa-utensils',
                label = 'Make Food',
            }
        },
        distance = 2.5,
    })

    exports['qb-target']:AddBoxZone("prison_kitchen_counter", vector3(1776.83, 2563.69, 45.67), 2.0, 0.8, {
        name = "prison_kitchen_counter",
        heading = 0,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 46.50
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:MakeFoodCounter",
                icon = 'fas fa-utensils',
                label = 'Make Food',
            }
        },
        distance = 2.5,
    })

    exports['qb-target']:AddBoxZone("prison_kitchen_stove", vector3(1780.84, 2565.03, 45.67), 1.4, 0.8, {
        name = "prison_kitchen_stove",
        heading = 270,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 46.50
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:MakeFoodStove",
                icon = 'fas fa-utensils',
                label = 'Make Food',
            }
        },
        distance = 2.5,
    })

    exports['qb-target']:AddTargetModel(`sanhje_Prison_Cafeteria_table`, {
        options = {
            {
                type = 'client',
                event = 'qb-jail:client:CleanTables',
                icon = 'fas fa-hand-sparkles',
                label = 'Clean Table',
                canInteract = function(entity)
                    return insidePrisonZone
                end,
            }
        },
        distance = 2.5, 
    })    
end)

--- Cleaning

--- Method to perform the cleaning animation, circle minigame for time reduction and sends the netId of the entity to the server to delete
--- @param entity number - entity handle
--- @return nil
local CleanUp = function(entity)
    if currentJob ~= 'cleaning' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end
    if entity == 0 then return end
    if isBusy then return end
    isBusy = true

    local ped = PlayerPedId()
    local netId = NetworkGetNetworkIdFromEntity(entity)
    TaskTurnPedToFaceEntity(ped, entity, 1.0)
    Wait(1500)

    QBCore.Functions.Progressbar("prison_cleancell", "Cleaning..", 7800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@bodysearch@',
        anim = "player_search",
        flags = 16,
    }, {}, {}, function() -- Done
        exports['ps-ui']:Circle(function(success)
            TriggerServerEvent('qb-jail:server:FinishCleaningTask', netId, success)
        end, 1, 14)
        isBusy = false
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        isBusy = false
    end)
end

RegisterNetEvent('qb-jail:client:FinishCleaningTask', function(coords)
    for i=1, #jobBlips do
        if GetBlipInfoIdCoord(jobBlips[i]) == coords then
            if DoesBlipExist(jobBlips[i]) then
                RemoveBlip(jobBlips[i])
                table.remove(jobBlips, i)
                return  
            end
        end
    end
end)

RegisterNetEvent('qb-jail:client:CompletedCleaningTask', function(result)
    exports['qb-core']:DrawText('Current Task: Cleaning Cells - Progress: COMPLETED', 'left')
    for i=1, #result do
        createJobTaskBlip(result[i], 'Cleaning Cells', 456, false)
    end
    Wait(4000)
    exports['qb-core']:DrawText('Current Task: Cleaning Cells - Progress: 0%', 'left')
end)

CreateThread(function()
    local objects = {
        `prop_big_shit_01`, 
        `prop_big_shit_02`, 
        `ng_proc_litter_plasbot2`, 
        `ng_proc_litter_plasbot3`, 
        `ng_proc_cigpak01c`
    }

    exports['qb-target']:AddTargetModel(objects, {
        options = {
            {
                action = function(entity)
                    CleanUp(entity)
                end,
                icon = 'fas fa-hand-sparkles',
                label = 'Clean Up',
                canInteract = function(entity)
                    return insidePrisonZone
                end,
            },
        },
        distance = 2.5,
    })
end)

--- Scrapyard

RegisterNetEvent('qb-jail:client:PrisonScrap', function(data)
    if currentJob ~= 'scrapyard' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end
    if entity == 0 then return end
    if isBusy then return end
    isBusy = true

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
    Wait(1500)
    
    local animation = {
        [1] = {"amb@world_human_welding@male@base", "base", 1, true},
        [2] = {"pickup_object", "pickup_low", 0, false}
    }
    local welder = nil
    local effect = nil
    if animation[data.index][4] then
        welder = CreateObject(`prop_weld_torch`, coords, 1, 1, 1)
        AttachEntityToEntity(welder, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.25 , 1, 1, 0, 1, 0, 1)    
    end

    QBCore.Functions.Progressbar("prison_cleancell", "Searching for useful stuff..", 7800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = animation[data.index][1],
        anim = animation[data.index][2],
        flags = animation[data.index][3],
    }, {}, {}, function() -- Done
        exports['ps-ui']:Circle(function(success)
            TriggerServerEvent('qb-jail:server:PrisonScrap', data.index, success)
            isBusy = false
            if welder then DeleteEntity(welder) end
            ClearPedTasks(ped)
        end, 1, 14)
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        isBusy = false
    end)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("prison_scrap_1", vector3(1658.67, 2519.24, 44.56), 7.0, 7.0, {
        name = "prison_scrap_1",
        heading = 90,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 47.50
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:PrisonScrap",
                icon = 'fas fa-person-digging',
                label = 'Search Pile',
                index = 1
            }
        },
        distance = 2.5,
    })

    exports['qb-target']:AddBoxZone("prison_scrap_2", vector3(1649.94, 2511.99, 44.56), 3.0, 3.0, {
        name = "prison_scrap_2",
        heading = 90,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 45.50
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:PrisonScrap",
                icon = 'fas fa-person-digging',
                label = 'Search Pile',
                index = 2
            }
        },
        distance = 2.5,
    })
end)

--- Electrical

--- Method to perform the welding animation and request the server for time reduction
--- @param index number - electrical box config index
--- @param entity number - entity handle
--- @return nil
ElectricalJob = function(index, entity)
    if currentJob ~= 'electrical' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end
    if Config.Electrical[index].completed then
        QBCore.Functions.Notify('There is nothing to fix here..', 'error', 2500)
        return
    end
    if entity == 0 then return end
    if isBusy then return end
    isBusy = true

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TaskTurnPedToFaceEntity(ped, entity, 1.0)
    Wait(1500)
    
    local welder = CreateObject(`prop_weld_torch`, coords, true, true, true)
    AttachEntityToEntity(welder, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.25 , 1, 1, 0, 1, 0, 1)    

    QBCore.Functions.Progressbar("prison_electrical", "Repairing Electrical Box..", 7800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_welding@male@base",
        anim = "base",
        flags = 1,
    }, {}, {}, function() -- Done
        TriggerServerEvent('qb-jail:server:CompleteElectrical', index)
        isBusy = false
        if welder then DeleteEntity(welder) end
        ClearPedTasks(ped)
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        isBusy = false
    end)
end

RegisterNetEvent('qb-jail:client:CompleteElectrical', function(index)
    Config.Electrical[index].completed = true
    for i=1, #jobBlips do
        if GetBlipInfoIdCoord(jobBlips[i]) == Config.Electrical[index].coords.xyz then
            if DoesBlipExist(jobBlips[i]) then
                RemoveBlip(jobBlips[i])
                table.remove(jobBlips, i)
                break  
            end
        end
    end

    local amount = 0
    for i=1, #Config.Electrical do
        if not Config.Electrical[i].completed then
            amount += 1
        end
    end

    exports['qb-core']:DrawText('Current Task: Electrical - Progress: ' .. math.floor(100 * (#Config.Electrical - amount) / #Config.Electrical) .. '%', 'left')
end)

RegisterNetEvent('qb-jail:client:ResetElectrical', function()
    destroyJobBlips()
    for i=1, #Config.Electrical do
        Config.Electrical[i].completed = false
        createJobTaskBlip(Config.Electrical[i].coords.xyz, 'Electrical', 354, false)
    end
    exports['qb-core']:DrawText('Current Task: Electrical - Progress: COMPLETED', 'left')
    Wait(4000)
    exports['qb-core']:DrawText('Current Task: Electrical - Progress: 0%', 'left')
end)

CreateThread(function()
    for k, v in pairs(Config.Electrical) do
        exports['qb-target']:AddBoxZone("prison_electrical_" .. k, v.coords.xyz, 0.5, 1.0, {
            name = "prison_electrical_" .. k,
            heading = v.coords.w,
            debugPoly = false,
            minZ = v.coords.z - 0.25,
            maxZ = v.coords.z + 0.75
        }, {
            options = { 
                {
                    icon = 'fas fa-bolt',
                    label = 'Fix Electrical',
                    action = function(entity)
                        ElectricalJob(k, entity)
                    end
                }
            },
            distance = 2.5,
        })
    end
end)

--- Gardening

RegisterNetEvent('qb-jail:client:FarmingSupplies', function()
    if currentJob ~= 'gardening' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end
    
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Gardening Supplies", {
        label = "Gardening Supplies",
        slots = 3,
        items = {
            [1] = { 
                name = "prisonfarmseeds", 
                price = 0, 
                amount = 10, 
                info = {}, 
                type = "item", 
                slot = 1, 
            },
            [2] = { 
                name = "prisonwateringcan", 
                price = 0, 
                amount = 10, 
                info = {}, 
                type = "item", 
                slot = 2, 
            },
            [3] = { 
                name = "prisonfarmnutrition", 
                price = 0, 
                amount = 10, 
                info = {}, 
                type = "item", 
                slot = 3, 
            },
        }
    })
end)

RegisterNetEvent('qb-jail:client:InspectFarming', function(data)
    if currentJob ~= 'gardening' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end

    local index = data.index
    if not index then return end
    QBCore.Functions.TriggerCallback('qb-jail:server:GetFarmingStatus', function(result)
        if not result then end
        if not result.planted then
            exports['qb-menu']:openMenu({
                {
                    header = "Gardening Patch",
                    txt = "ESC or click to close",
                    icon = "fas fa-chevron-left",
                    params = {
                        event = "qb-menu:closeMenu",
                    }
                },
                {
                    header = "Plant Seeds",
                    txt = "Plant a few seeds in this patch",
                    icon = "fas fa-seedling",
                    params = {
                        event = "qb-jail:client:PlantSeed",
                        args = index
                    }
                }
            })
        elseif result.dead then
            exports['qb-menu']:openMenu({
                {
                    header = "Gardening Patch",
                    txt = "ESC or click to close",
                    icon = "fas fa-chevron-left",
                    params = {
                        event = "qb-menu:closeMenu",
                    }
                },
                {
                    header = "Clear Plant",
                    txt = "The plant is dead..",
                    icon = "fas fa-ban",
                    params = {
                        event = "qb-jail:client:ClearPlant",
                        args = index
                    }
                }
            })
        elseif result.growth == 100 then
            exports['qb-menu']:openMenu({
                {
                    header = "Gardening Patch",
                    txt = "ESC or click to close",
                    icon = "fas fa-chevron-left",
                    params = {
                        event = "qb-menu:closeMenu",
                    }
                },
                {
                    header = "Stage: " .. result.stage .. " Health: " .. result.health,
                    txt = "This patch is ready for harvest!",
                    icon = 'fas fa-hand',
                    params = {
                        event = "qb-jail:client:HarvestPlant",
                        args = index
                    }
                }
            })
        else
            exports['qb-menu']:openMenu({
                {
                    header = "Gardening Patch",
                    txt = "ESC or click to close",
                    icon = "fas fa-chevron-left",
                    params = {
                        event = "qb-menu:closeMenu"
                    }
                },
                {
                    header = "Growth: " .. result.growth .. "% " .. "- Stage: " .. result.stage,
                    txt = "Health: " .. result.health,
                    icon = "fas fa-chart-simple",
                    isMenuHeader = true
                },
                {
                    header = "Water: " .. result.water .. "%",
                    txt = "Add water to the patch",
                    icon = "fas fa-shower",
                    params = {
                        event = "qb-jail:client:GiveWater",
                        args = index
                    }
                },
                {
                    header = "Fertilizer: " .. result.fertilizer .. "%",
                    txt = "Add fertilizer to the patch",
                    icon = "fab fa-nutritionix",
                    params = {
                        args = index,
                        event = "qb-jail:client:GiveFertilizer",
                    }
                }
            })
        end
    end, index)    
end)

RegisterNetEvent('qb-jail:client:PlantSeed', function(index)
    if currentJob ~= 'gardening' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end

    local hasItem = QBCore.Functions.HasItem('prisonfarmseeds')
    if hasItem then
        local ped = PlayerPedId()
        RequestAnimDict("amb@medic@standing@kneel@base")
        RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
        while 
            not HasAnimDictLoaded("amb@medic@standing@kneel@base") or
            not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")
        do 
            Wait(0) 
        end
        TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, 8.0, -1, 1, 0, false, false, false)
        TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, 8.0, -1, 48, 0, false, false, false)
        QBCore.Functions.Progressbar("jail_gardening", "Planting Seed", 8500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerServerEvent('qb-jail:server:PlantSeed', index)
            ClearPedTasks(ped)
            RemoveAnimDict("amb@medic@standing@kneel@base")
            RemoveAnimDict("anim@gangops@facility@servers@bodysearch@")
        end, function()
            QBCore.Functions.Notify("Cancelled..", "error", 2500)
            ClearPedTasks(ped)
            RemoveAnimDict("amb@medic@standing@kneel@base")
            RemoveAnimDict("anim@gangops@facility@servers@bodysearch@")
        end)
    else
        QBCore.Functions.Notify('You don\'t have any seeds on you..', 'error', 2500)
    end
end)

RegisterNetEvent('qb-jail:client:ClearPlant', function(index)
    if currentJob ~= 'gardening' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end

    local ped = PlayerPedId()
    RequestAnimDict("amb@medic@standing@kneel@base")
    RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
    while 
        not HasAnimDictLoaded("amb@medic@standing@kneel@base") or
        not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")
    do 
        Wait(0) 
    end
    TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, 8.0, -1, 1, 0, false, false, false)
    TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, 8.0, -1, 48, 0, false, false, false)
    QBCore.Functions.Progressbar("jail_gardening", "Clearing Patch", 8500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent('qb-jail:server:ClearPlant', index)
        ClearPedTasks(ped)
        RemoveAnimDict("amb@medic@standing@kneel@base")
        RemoveAnimDict("anim@gangops@facility@servers@bodysearch@")
    end, function()
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        ClearPedTasks(ped)
        RemoveAnimDict("amb@medic@standing@kneel@base")
        RemoveAnimDict("anim@gangops@facility@servers@bodysearch@")
    end)
end)

RegisterNetEvent('qb-jail:client:HarvestPlant', function(index)
    if currentJob ~= 'gardening' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end

    local ped = PlayerPedId()
    RequestAnimDict("amb@medic@standing@kneel@base")
    RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
    while 
        not HasAnimDictLoaded("amb@medic@standing@kneel@base") or
        not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")
    do 
        Wait(0) 
    end
    TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, 8.0, -1, 1, 0, false, false, false)
    TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, 8.0, -1, 48, 0, false, false, false)
    QBCore.Functions.Progressbar("jail_gardening", "Clearing Patch", 8500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent('qb-jail:server:HarvestPlant', index)
        ClearPedTasks(ped)
        RemoveAnimDict("amb@medic@standing@kneel@base")
        RemoveAnimDict("anim@gangops@facility@servers@bodysearch@")
    end, function()
        QBCore.Functions.Notify("Cancelled..", "error", 2500)
        ClearPedTasks(ped)
        RemoveAnimDict("amb@medic@standing@kneel@base")
        RemoveAnimDict("anim@gangops@facility@servers@bodysearch@")
    end)
end)

RegisterNetEvent('qb-jail:client:GiveWater', function(index)
    if currentJob ~= 'gardening' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end

    local hasItem = QBCore.Functions.HasItem('prisonwateringcan')
    if hasItem then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local model = `prop_wateringcan`
        RequestModel(model)
        RequestNamedPtfxAsset("core")
        while not HasModelLoaded(model) or not HasNamedPtfxAssetLoaded("core") do Wait(10) end
        SetPtfxAssetNextCall("core")
        local created_object = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
        AttachEntityToEntity(created_object, ped, GetPedBoneIndex(ped, 28422), 0.4, 0.1, 0.0, 90.0, 180.0, 0.0, true, true, false, true, 1, true)
        local effect = StartParticleFxLoopedOnEntity("ent_sht_water", created_object, 0.35, 0.0, 0.25, 0.0, 0.0, 0.0, 2.0, false, false, false)
        QBCore.Functions.Progressbar("jail_gardening", "Watering the patch", 6000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "weapon@w_sp_jerrycan",
            anim = "fire",
            flags = 1,
        }, {}, {}, function()
            TriggerServerEvent('qb-jail:server:GiveWater', index)
            ClearPedTasks(ped)
            DeleteEntity(created_object)
            StopParticleFxLooped(effect, 0)
        end, function()
            ClearPedTasks(ped)
            DeleteEntity(created_object)
            StopParticleFxLooped(effect, 0)
            QBCore.Functions.Notify("Cancelled..", "error", 2500)
        end)
    else
        QBCore.Functions.Notify('So how exactly are you going to do this?', 'error', 2500)
    end
end)

RegisterNetEvent('qb-jail:client:GiveFertilizer', function(index)
    if currentJob ~= 'gardening' then
        QBCore.Functions.Notify('You are not part of this group!', 'error', 2500)
        return
    end

    local hasItem = QBCore.Functions.HasItem('prisonfarmnutrition')
    if hasItem then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local model = `w_am_jerrycan_sf`
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(10) end
        local created_object = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
        AttachEntityToEntity(created_object, ped, GetPedBoneIndex(ped, 28422), 0.3, 0.1, 0.0, 90.0, 180.0, 0.0, true, true, false, true, 1, true)
        QBCore.Functions.Progressbar("jail_gardening", "Adding fertilizer to the patch", 6000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "weapon@w_sp_jerrycan",
            anim = "fire",
            flags = 1,
        }, {}, {}, function()
            TriggerServerEvent('qb-jail:server:GiveFertilizer', index)
            ClearPedTasks(ped)
            DeleteEntity(created_object)
        end, function()
            ClearPedTasks(ped)
            DeleteEntity(created_object)
            QBCore.Functions.Notify("Cancelled..", "error", 2500)
        end)
    else
        QBCore.Functions.Notify('So how exactly are you going to do this?', 'error', 2500)
    end
end)

CreateThread(function()
    local pedModel = `s_m_m_gardener_01`
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do Wait(0) end
    local farmingPed = CreatePed(0, pedModel, Config.GardeningPed.x, Config.GardeningPed.y, Config.GardeningPed.z, Config.GardeningPed.w, false, false)
    FreezeEntityPosition(farmingPed, true)
    SetEntityInvincible(farmingPed, true)
    SetBlockingOfNonTemporaryEvents(farmingPed, true)
    
    exports['qb-target']:AddTargetEntity(farmingPed, {
        options = {
            {
                type = "client",
                event = "qb-jail:client:FarmingSupplies",
                icon = 'fas fa-trowel',
                label = 'Grab Tools',
            }
        },
        distance = 2.5,
    })

    exports['qb-target']:AddBoxZone("prison_farming_1", vector3(1689.88, 2545.67, 44.56), 3.5, 3.5, {
        name = "prison_farming_1",
        heading = 90.0,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 45.75
    }, {
        options = { 
            {
                type = 'client',
                event = 'qb-jail:client:InspectFarming',
                icon = 'fas fa-trowel',
                label = 'Gardening',
                index = 1
            }
        },
        distance = 3.5,
    })

    exports['qb-target']:AddBoxZone("prison_farming_2", vector3(1695.45, 2553.88, 44.56), 3.5, 3.5, {
        name = "prison_farming_2",
        heading = 180.0,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 45.75
    }, {
        options = { 
            {
                type = 'client',
                event = 'qb-jail:client:InspectFarming',
                icon = 'fas fa-trowel',
                label = 'Gardening',
                index = 2
            }
        },
        distance = 3.5,
    })

    exports['qb-target']:AddBoxZone("prison_farming_3", vector3(1695.21, 2548.71, 44.56), 3.5, 3.5, {
        name = "prison_farming_3",
        heading = 180.0,
        debugPoly = false,
        minZ = 44.50,
        maxZ = 45.75
    }, {
        options = { 
            {
                type = 'client',
                event = 'qb-jail:client:InspectFarming',
                icon = 'fas fa-trowel',
                label = 'Gardening',
                index = 3
            }
        },
        distance = 3.5,
    })
end)
