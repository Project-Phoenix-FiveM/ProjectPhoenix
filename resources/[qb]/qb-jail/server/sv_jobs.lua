local jobGroups = {
    gardening = {},
    running = {},
    scrapyard = {},
    cleaning = {},
    workout = {},
    kitchen = {},
    electrical = {},
    lockup = {}
}

--- Method to add a player to a job group, removes the player from his or her current group
--- @param playerId number - playerId
--- @param group string - job group
--- @return nil
local addToJobGroup = function(playerId, group)
    local current = getPlayerJobGroup(playerId)
    if current then
        removeFromJobGroup(playerId, current)
    end
    
    jobGroups[group][#jobGroups[group]+1] = playerId
    debugPrint('Added ' .. GetPlayerName(playerId) .. ' (' .. playerId .. ')' .. ' to group ' .. group)
end

--- Method to remove a player from a job group
--- @param playerId number - playerId
--- @param group string - job group
--- @return nil
removeFromJobGroup = function(playerId, group)
    if not isJobGroupMember(playerId, group) then return end
    for k, v in pairs(jobGroups[group]) do
        if v == playerId then
            table.remove(jobGroups[group], k)
            debugPrint('Removed ' .. GetPlayerName(playerId) .. ' (' .. playerId .. ')' .. ' from group ' .. group)
        end
    end
end

--- Method to return a players job group
--- @param playerId number - playerId
--- @return string | boolean - returns the players group or false if not in one
getPlayerJobGroup = function(playerId)
    for group, v in pairs(jobGroups) do
        for i=1, #v do
            if v[i] == playerId then
                return group
            end
        end
    end
    return false
end

--- Method to return all players in a job group
--- @param group string - job group
--- @return array - array with player ids
local getGroupMembers = function(group)
    return jobGroups[group]
end

--- Method to check if a player is part of a specific group
--- @param playerId number - player id
--- @param group string - job group
--- @return boolean - is member part of group
isJobGroupMember = function(playerId, group)
    return getPlayerJobGroup(playerId) == group
end

RegisterNetEvent('qb-jail:server:ChangeJob', function(selectedJob)
    local src = source
    if not selectedJob or not jobGroups[selectedJob] then return end
    if isPlayerInJail(src) then
        addToJobGroup(src, selectedJob)
    end
end)

QBCore.Functions.CreateCallback('qb-jail:server:GetGroupData', function(source, cb)
    local temp = {
        [1] = {
            job = 'gardening',
            amount = #jobGroups.gardening,
            label = 'Gardening'
        },
        [2] = {
            job = 'running',
            amount = #jobGroups.running,
            label = 'Running Track'
        },
        [3] = {
            job = 'scrapyard',
            amount = #jobGroups.scrapyard,
            label = 'Scrapyard'
        },
        [4] = {
            job = 'cleaning',
            amount = #jobGroups.cleaning,
            label = 'Cleaning Cells'
        },
        [5] = {
            job = 'workout',
            amount = #jobGroups.workout,
            label = 'Workout'
        },
        [6] = {
            job = 'kitchen',
            amount = #jobGroups.kitchen,
            label = 'Kitchen'
        },
        [7] = {
            job = 'electrical',
            amount = #jobGroups.electrical,
            label = 'Electrical'
        },
        [8] = {
            job = 'lockup',
            amount = #jobGroups.lockup,
            label = 'Lockup'
        }
    }
    cb(temp)
end)

--- Skatepark stuff

skateParkObjects = {}
skateParkSetup = {
    [1] = {
        model = `prop_skate_quartpipe`,
        coords = vector3(1642.85, 2621.0, 45.9),
        heading = 0.0
    },
    [2] = {
        model = `prop_skate_halfpipe`,
        coords = vector3(1628.16, 2632.34, 44.56),
        heading = 90.0
    },
    [3] = {
        model = `prop_skate_quartpipe`,
        coords = vector3(1642.85, 2590.16, 45.9),
        heading = 180.0
    },
    [4] = {
        model = `prop_skate_flatramp`,
        coords = vector3(1640.90, 2608.73, 44.56),
        heading = 180.0
    },
    [5] = {
        model = `prop_skate_kickers`,
        coords = vector3(1640.90, 2603.87, 44.56),
        heading = 0.0
    },
    [6] = {
        model = `prop_skate_quartpipe`,
        coords = vector3(1657.85, 2621.0, 45.9),
        heading = 0.0
    },
    [7] = {
        model = `prop_skate_quartpipe`,
        coords = vector3(1657.85, 2590.66, 45.9),
        heading = 180.0
    },
    [8] = {
        model = `prop_skate_spiner`,
        coords = vector3(1657.85, 2606.21, 44.56),
        heading = 180.0
    },
    [9] = {
        model = `prop_skate_funbox`,
        coords = vector3(1649.61, 2605.36, 44.56),
        heading = 180.0
    },
    [10] = {
        model = `xm3_prop_xm3_tent_01a`,
        coords = vector3(1634.35, 2606.28, 48.56),
        heading = 180.0
    }
}

setupSkatePark = function()
    for k, v in pairs(skateParkSetup) do
        local created_object = CreateObjectNoOffset(v.model, v.coords.x, v.coords.y, v.coords.z, true, true, false)
        SetEntityHeading(created_object, v.heading)
        FreezeEntityPosition(created_object, true)
        skateParkObjects[#skateParkObjects + 1] = created_object
    end
end

CreateThread(setupSkatePark)

--- Kitchen Job Related St00f

kitchenTasks = {
    [1] = {
        label = 'Prepare Food',
        current = 0,
        max = 38, -- After current reaches max, the task will change and reset current to 0
        chance = 5,
        chanceItems = {'plastic', 'prisonbag'}
    },
    [2] = {
        label = 'Clean Dishes & Sort Shelves',
        current = 0,
        max = 34,
        chance = 7,
        chanceItems = {'prisonchemicals', 'prisonbag', 'prisonfruit', 'prisonjuice', 'prisonsugar'}
    },
    [3] = {
        label = 'Clean Tables',
        current = 0,
        max = 18,
        chance = 5,
        chanceItems = {'prisonspoon', 'prisonfruit', 'prisonjuice', 'prisonsugar'}
    }
}

currentKitchenTask = math.random(#kitchenTasks) -- Pick random currentTask on start-up

RegisterNetEvent('qb-jail:server:FinishKitchenTask', function(task, success)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not kitchenTasks[task] or not isJobGroupMember(src, 'kitchen') then return end
    if task ~= currentKitchenTask then
        TriggerClientEvent('QBCore:Notify', src, 'You are doing the wrong task!', 'error', 2500)
        return
    end

    kitchenTasks[task].current += 1
    if kitchenTasks[task].current >= kitchenTasks[task].max then 
        kitchenTasks[task].current = 0
        local new = math.random(#kitchenTasks)
        while new == currentKitchenTask do
            new = math.random(#kitchenTasks)
        end
        currentKitchenTask = new
        debugPrint('Changed Kitchen Task to ' .. kitchenTasks[currentKitchenTask].label)
        reduceJailSentenceAttempt(src)
        for k, v in pairs(getGroupMembers('kitchen')) do
            TriggerClientEvent('qb-core:client:DrawText', v, 'Current Task: ' .. kitchenTasks[currentKitchenTask].label, 'left')
        end
    else
        -- Update All groups members with progress
        local progress = math.floor(100 * kitchenTasks[currentKitchenTask].current / kitchenTasks[currentKitchenTask].max)
        for k, v in pairs(getGroupMembers('kitchen')) do
            TriggerClientEvent('qb-core:client:DrawText', v, kitchenTasks[currentKitchenTask].label .. ' - Progress: ' .. progress .. '%', 'left')
        end
    end

    -- Chance to get an item
    if success and kitchenTasks[task].chance and kitchenTasks[task].chance >= math.random(100) then
        local item = kitchenTasks[task].chanceItems[math.random(#kitchenTasks[task].chanceItems)]
        if Config.Inventory == 'exports' then
            exports['qb-inventory']:AddItem(src, item, Config.KitchenRewardAmount, false)
        elseif Config.Inventory == 'player' then
            Player.Functions.AddItem(item, Config.KitchenRewardAmount, false)
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', Config.KitchenRewardAmount)
    end
end)

QBCore.Functions.CreateCallback('qb-jail:server:GetCurrentKitchenTask', function(source, cb)
    local src = source
    if not isJobGroupMember(src, 'kitchen') then cb(nil) return end
    local progress = math.floor(100 * kitchenTasks[currentKitchenTask].current / kitchenTasks[currentKitchenTask].max)
    cb(kitchenTasks[currentKitchenTask].label, progress)
end)

--- Cleaning Job

cleaningActives = nil
cleaningSetup = {
    [1] = {
        model = `prop_big_shit_01`,
        coords = vector3(1767.826, 2502.826, 45.0),
        handle = 0,
        active = false
    },
    [2] = {
        model = `prop_big_shit_02`,
        coords = vector3(1767.58, 2501.183, 44.74),
        handle = 0,
        active = false
    },
    [3] = {
        model = `ng_proc_litter_plasbot2`,
        coords = vector3(1768.65, 2490.387, 45.56),
        handle = 0,
        active = false
    },
    [4] = {
        model = `ng_proc_litter_plasbot3`,
        coords = vector3(1763.913, 2483.16, 44.74),
        handle = 0,
        active = false
    },
    [5] = {
        model = `prop_big_shit_02`,
        coords = vector3(1764.34, 2499.057, 44.74),
        handle = 0,
        active = false
    },
    [6] = {
        model = `prop_big_shit_01`,
        coords = vector3(1761.585, 2499.193, 45.0),
        handle = 0,
        active = false
    },
    [7] = {
        model = `prop_big_shit_01`,
        coords = vector3(1752.115, 2493.738, 45.0),
        handle = 0,
        active = false
    },
    [8] = {
        model = `ng_proc_litter_plasbot2`,
        coords = vector3(1749.706, 2492.559, 44.74),
        handle = 0,
        active = false
    },
    [9] = {
        model = `prop_big_shit_02`,
        coords = vector3(1748.582, 2490.014, 44.74),
        handle = 0,
        active = false
    },
    [10] = {
        model = `prop_big_shit_01`,
        coords = vector3(1758.009, 2470.543, 45.0),
        handle = 0,
        active = false
    },
    [11] = {
        model = `prop_big_shit_01`,
        coords = vector3(1761.177, 2472.377, 45.0),
        handle = 0,
        active = false
    },
    [12] = {
        model = `prop_big_shit_01`,
        coords = vector3(1764.304, 2474.206, 45.0),
        handle = 0,
        active = false
    },
    [12] = {
        model = `prop_big_shit_01`,
        coords = vector3(1767.447, 2476.022, 45.0),
        handle = 0,
        active = false
    },
    [13] = {
        model = `prop_big_shit_02`,
        coords = vector3(1771.150, 2479.514, 44.74),
        handle = 0,
        active = false
    },
    [14] = {
        model = `prop_big_shit_01`,
        coords = vector3(1773.699, 2479.665, 45.0),
        handle = 0,
        active = false
    },
    [15] = {
        model = `prop_big_shit_01`,
        coords = vector3(1776.896, 2481.472, 45.0),
        handle = 0,
        active = false
    },
    [16] = {
        model = `ng_proc_litter_plasbot2`,
        coords = vector3(1775.387, 2484.792, 44.74),
        handle = 0,
        active = false
    },
    [17] = {
        model = `ng_proc_cigpak01c`,
        coords = vector3(1759.069, 2484.628, 45.56),
        handle = 0,
        active = false
    },
    [18] = {
        model = `ng_proc_cigpak01c`,
        coords = vector3(1765.612, 2501.742, 48.69),
        handle = 0,
        active = false
    },
    [19] = {
        model = `prop_big_shit_01`,
        coords = vector3(1767.871, 2502.861, 49.00),
        handle = 0,
        active = false
    },
    [20] = {
        model = `prop_big_shit_02`,
        coords = vector3(1762.477, 2500.059, 48.69),
        handle = 0,
        active = false
    },
    [21] = {
        model = `prop_big_shit_01`,
        coords = vector3(1761.552, 2499.216, 49.0),
        handle = 0,
        active = false
    },
    [22] = {
        model = `prop_big_shit_01`,
        coords = vector3(1758.40, 2497.418, 49.0),
        handle = 0,
        active = false
    },
    [23] = {
        model = `prop_big_shit_01`,
        coords = vector3(1755.25, 2495.568, 49.0),
        handle = 0,
        active = false
    },
    [24] = {
        model = `prop_big_shit_02`,
        coords = vector3(1751.83, 2491.953, 48.69),
        handle = 0,
        active = false
    },
    [25] = {
        model = `prop_big_shit_01`,
        coords = vector3(1748.95, 2491.959, 49.0),
        handle = 0,
        active = false
    },
    [26] = {
        model = `prop_big_shit_01`,
        coords = vector3(1758.00, 2470.617, 49.0),
        handle = 0,
        active = false
    },
    [27] = {
        model = `prop_big_shit_01`,
        coords = vector3(1761.17, 2472.427, 49.0),
        handle = 0,
        active = false
    },
    [28] = {
        model = `prop_big_shit_02`,
        coords = vector3(1763.75, 2476.044, 48.69),
        handle = 0,
        active = false
    },
    [29] = {
        model = `prop_big_shit_01`,
        coords = vector3(1767.44, 2476.01, 49.00),
        handle = 0,
        active = false
    },
    [30] = {
        model = `prop_big_shit_01`,
        coords = vector3(1770.60, 2477.81, 49.00),
        handle = 0,
        active = false
    },
    [31] = {
        model = `ng_proc_litter_plasbot2`,
        coords = vector3(1771.93, 2478.40, 48.69),
        handle = 0,
        active = false
    },
    [32] = {
        model = `prop_big_shit_01`,
        coords = vector3(1773.76, 2479.68, 49.00),
        handle = 0,
        active = false
    },
    [33] = {
        model = `prop_big_shit_01`,
        coords = vector3(1776.85, 2481.50, 49.00),
        handle = 0,
        active = false
    }
}

createCleaningObjects = function()
    local temp = {}
    cleaningActives = Config.CleaningTaskAmount
    for i=1, Config.CleaningTaskAmount, 1 do -- grab Config.CleaningTaskAmount random objects that need to be cleaned
        local random = math.random(#cleaningSetup)
        while temp[random] do
            random = math.random(#cleaningSetup)
        end
        temp[random] = true
        local created_object = CreateObjectNoOffset(cleaningSetup[random].model, cleaningSetup[random].coords.x, cleaningSetup[random].coords.y, cleaningSetup[random].coords.z, true, true, false)
        FreezeEntityPosition(created_object, true)
        cleaningSetup[random].handle = created_object
        cleaningSetup[random].active = true
    end
end

RegisterNetEvent('qb-jail:server:FinishCleaningTask', function(netId, success)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if type(netId) ~= 'number' or not Player or not isJobGroupMember(src, 'cleaning') then return end
    local entity = NetworkGetEntityFromNetworkId(netId)

    for i=1, #cleaningSetup do
        if cleaningSetup[i].handle == entity and cleaningSetup[i].active then
            DeleteEntity(entity)
            cleaningSetup[i].active = false
            cleaningSetup[i].handle = 0
            cleaningActives -= 1
            reduceJailSentenceAttempt(src)
            for k, v in pairs(getGroupMembers('cleaning')) do
                TriggerClientEvent('qb-jail:client:FinishCleaningTask', v, cleaningSetup[i].coords)
            end
            break
        end
    end

    if cleaningActives <= 0 then
        createCleaningObjects()
        local temp = {}
        for k, v in pairs(cleaningSetup) do
            if v.active then
                temp[#temp + 1] = v.coords
            end
        end
        for k, v in pairs(getGroupMembers('cleaning')) do
            TriggerClientEvent('qb-jail:client:CompletedCleaningTask', v, temp)
        end
    else
        local progress = math.floor(100 * (Config.CleaningTaskAmount - cleaningActives) / Config.CleaningTaskAmount)
        for k, v in pairs(getGroupMembers('cleaning')) do
            TriggerClientEvent('qb-core:client:DrawText', v, 'Current Task: Cleaning Cells - Progress: ' .. progress .. '%', 'left')
        end
    end
end)

QBCore.Functions.CreateCallback('qb-jail:server:GetActiveCleaningTasks', function(source, cb)
    local temp = {}
    for k, v in pairs(cleaningSetup) do
        if v.active then
            temp[#temp + 1] = v.coords
        end
    end
    cb(temp)
end)

CreateThread(function()
    if Config.CleaningTaskAmount > #cleaningSetup then
        debugPrint('Error: Config.CleaningTaskAmount too high!')
        return
    end
    createCleaningObjects()
end)

--- Scrapyard

scrapYardObjects = {}
scrapYardSetup = {
    [1] = {
        model = `prop_pile_dirt_03`,
        coords = vector3(1658.67, 2519.24, 44.56),
        heading = 90.00,
        rewards = {'metalscrap', 'steel', 'iron', 'copper', 'prisonrock'}
    },
    [2] = {
        model = `prop_rub_pile_01`,
        coords = vector3(1649.94, 2511.99, 44.56),
        heading = 90.00,
        rewards = {'rubber'}
    },
    [3] = {
        model = `prop_pile_dirt_02`,
        coords = vector3(1656.75, 2509.28, 44.56),
        heading = 90.00,
        rewards = {'rubber'} -- unused
    }
}

setupScrapyard = function()
    for k, v in pairs(scrapYardSetup) do
        local created_object = CreateObjectNoOffset(v.model, v.coords.x, v.coords.y, v.coords.z, true, true, false)
        SetEntityHeading(created_object, v.heading)
        FreezeEntityPosition(created_object, true)
        scrapYardObjects[#scrapYardObjects + 1] = created_object
    end
end

CreateThread(setupScrapyard)

RegisterNetEvent('qb-jail:server:PrisonScrap', function(index, success)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if type(index) ~= 'number' or not Player or not isJobGroupMember(src, 'scrapyard') then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - scrapYardSetup[index].coords) > 25 then return end
    reduceJailSentenceAttempt(src)
    if success and Config.ScrapRewardChance >= math.random(100) then
        local item = scrapYardSetup[index].rewards[math.random(#scrapYardSetup[index].rewards)]
        if Config.Inventory == 'exports' then
            exports['qb-inventory']:AddItem(src, item, Config.ScrapRewardAmount, false)
        elseif Config.Inventory == 'player' then
            Player.Functions.AddItem(item, Config.ScrapRewardAmount, false)
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', Config.ScrapRewardAmount)
    end
end)

--- Electrical

checkElectricalCompleted = function()
    for i=1, #Config.Electrical do
        if not Config.Electrical[i].completed then
            return false
        end
    end
    return true
end

RegisterNetEvent('qb-jail:server:CompleteElectrical', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Config.Electrical[index] or not Player or not isJobGroupMember(src, 'electrical') then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Config.Electrical[index].coords.xyz) > 25 then return end

    if not Config.Electrical[index].completed then
        Config.Electrical[index].completed = true
        reduceJailSentenceAttempt(src)
        if checkElectricalCompleted() then
            for i=1, #Config.Electrical do
                Config.Electrical[i].completed = false
            end

            for k, v in pairs(getGroupMembers('electrical')) do
                TriggerClientEvent('qb-jail:client:ResetElectrical', v)
            end
        else
            for k, v in pairs(getGroupMembers('electrical')) do
                TriggerClientEvent('qb-jail:client:CompleteElectrical', v, index)
            end
        end
    end
end)

QBCore.Functions.CreateCallback('qb-jail:server:GetActiveElectricalTasks', function(source, cb)
    local temp = {}
    for k, v in pairs(Config.Electrical) do
        if not v.completed then
            temp[#temp + 1] = k
        end
    end
    cb(temp)
end)

--- Gardening

farmingStages = { -- You can change these props if you have better farming props available to you
    [1] = `prop_veg_crop_04`,
    [2] = `prop_veg_crop_04_leaf`,
    [3] = `prop_veg_crop_02`,
    [4] = `prop_plant_cane_02a`
}

farmingSetup = {
    [1] = {
        coords = vector4(1689.88, 2545.67, 44.56, 90.00),
        handle = 0,
        planted = false,
        dead = false,
        growth = 0,
        stage = 1,
        health = 100,
        water = 0,
        fertilizer = 0
    },
    [2] = {
        coords = vector4(1695.45, 2553.88, 44.56, 180.00),
        handle = 0,
        planted = false,
        dead = false,
        growth = 0,
        stage = 1,
        health = 100,
        water = 0,
        fertilizer = 0
    },
    [3] = {
        coords = vector4(1695.21, 2548.71, 44.56, 90.00),
        handle = 0,
        planted = false,
        dead = false,
        growth = 0,
        stage = 1,
        health = 100,
        water = 0,
        fertilizer = 0
    }
}

setupFarming = function()
    for k, v in pairs(farmingSetup) do
        local created_object = CreateObjectNoOffset(farmingStages[v.stage], v.coords.x, v.coords.y, v.coords.z, true, true, false)
        SetEntityHeading(created_object, v.coords.w)
        FreezeEntityPosition(created_object, true)
        farmingSetup[k].handle = created_object
    end
end

farmingLoop = function()
    for k, v in pairs(farmingSetup) do
        if v.planted and not v.dead and v.growth ~= 100 then
            if v.water > 0 and v.fertilizer > 0 then
                v.growth = v.growth + math.random(10, 15)
            end

            v.water = v.water - math.random(20, 30)
            v.fertilizer = v.fertilizer - math.random(14, 26)

            if v.water <= 20 then
                v.health = v.health - 12
            elseif v.water <= 40 then
                v.health = v.health - 8
            end

            if v.fertilizer <= 25 then
                v.health = v.health - 14
            elseif v.fertilizer <= 50 then
                v.health = v.health - 10
            end

            if v.health < 0 then v.health = 0 end
            if v.water < 0 then v.water = 0 end
            if v.fertilizer < 0 then v.fertilizer = 0 end
            if v.growth > 100 then v.growth = 100 end

            local newStage = math.ceil(v.growth / 25)
            if newStage > 4 then newStage = 4 elseif newStage == 0 then newStage = 1 end
            if newStage ~= v.stage then
                local created_object = CreateObjectNoOffset(farmingStages[newStage], v.coords.x, v.coords.y, v.coords.z, true, true, false)
                SetEntityHeading(created_object, v.coords.w)
                FreezeEntityPosition(created_object, true)
                DeleteEntity(v.handle)
                v.handle = created_object
            end
            v.stage = newStage
            if v.health == 0 then v.dead = true end
        end
    end
    SetTimeout(Config.FarmingLoopInterval * 60 * 1000, farmingLoop)
end

CreateThread(setupFarming)
CreateThread(farmingLoop)

RegisterNetEvent('qb-jail:server:PlantSeed', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not isJobGroupMember(src, 'gardening') or not farmingSetup[index] then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - farmingSetup[index].coords.xyz) > 25 then return end

    if Config.Inventory == 'exports' and exports['qb-inventory']:RemoveItem(src, 'prisonfarmseeds', 1) then
        farmingSetup[index].planted = true
        farmingSetup[index].health = 100
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonfarmseeds'], 'remove', 1)
        TriggerClientEvent('QBCore:Notify', src, 'You\'ve planted some seeds..', 'success', 2500)
    elseif Config.Inventory == 'player' and Player.Functions.RemoveItem('prisonfarmseeds', 1) then
        farmingSetup[index].planted = true
        farmingSetup[index].health = 100
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonfarmseeds'], 'remove', 1)
        TriggerClientEvent('QBCore:Notify', src, 'You\'ve planted some seeds..', 'success', 2500)
    end
end)

RegisterNetEvent('qb-jail:server:ClearPlant', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not isJobGroupMember(src, 'gardening') or not farmingSetup[index] then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - farmingSetup[index].coords.xyz) > 25 then return end

    farmingSetup[index].planted = false
    farmingSetup[index].dead = false
    farmingSetup[index].growth = 0
    farmingSetup[index].stage = 1
    farmingSetup[index].health = 100
    farmingSetup[index].water = 0
    farmingSetup[index].fertilizer = 0

    DeleteEntity(farmingSetup[index].handle)
    local created_object = CreateObjectNoOffset(farmingStages[1], farmingSetup[index].coords.x, farmingSetup[index].coords.y, farmingSetup[index].coords.z, true, true, false)
    SetEntityHeading(created_object, farmingSetup[index].coords.w)
    FreezeEntityPosition(created_object, true)
    farmingSetup[index].handle = created_object
end)

RegisterNetEvent('qb-jail:server:HarvestPlant', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not isJobGroupMember(src, 'gardening') or not farmingSetup[index] then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - farmingSetup[index].coords.xyz) > 25 then return end

    if Config.Inventory == 'exports' then
        exports['qb-inventory']:AddItem(src, 'prisonfruit', Config.FarmingHarvestAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonfruit'], 'add', Config.FarmingHarvestAmount)
        TriggerClientEvent('QBCore:Notify', src, 'You\'ve harvested some fruits..', 'success', 2500)
    elseif Config.Inventory == 'player' then
        Player.Functions.AddItem('prisonfruit', Config.FarmingHarvestAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonfruit'], 'add', Config.FarmingHarvestAmount)
        TriggerClientEvent('QBCore:Notify', src, 'You\'ve harvested some fruits..', 'success', 2500)
    end

    farmingSetup[index].planted = false
    farmingSetup[index].dead = false
    farmingSetup[index].growth = 0
    farmingSetup[index].stage = 1
    farmingSetup[index].health = 100
    farmingSetup[index].water = 0
    farmingSetup[index].fertilizer = 0

    DeleteEntity(farmingSetup[index].handle)
    local created_object = CreateObjectNoOffset(farmingStages[1], farmingSetup[index].coords.x, farmingSetup[index].coords.y, farmingSetup[index].coords.z, true, true, false)
    SetEntityHeading(created_object, farmingSetup[index].coords.w)
    FreezeEntityPosition(created_object, true)
    farmingSetup[index].handle = created_object
end)

RegisterNetEvent('qb-jail:server:GiveWater', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not isJobGroupMember(src, 'gardening') or not farmingSetup[index] then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - farmingSetup[index].coords.xyz) > 25 then return end

    if Config.Inventory == 'exports' and exports['qb-inventory']:GetItemByName(src, 'prisonwateringcan', 1) then
        farmingSetup[index].water += 70
        if farmingSetup[index].water > 100 then
            farmingSetup[index].water = 100
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonwateringcan'], 'remove', 1)
        TriggerClientEvent('QBCore:Notify', src, 'You\'ve watered the patch..', 'success', 2500)
    elseif Config.Inventory == 'player' and Player.Functions.GetItemByName('prisonwateringcan') then
        farmingSetup[index].water += 70
        if farmingSetup[index].water > 100 then
            farmingSetup[index].water = 100
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonwateringcan'], 'remove', 1)
        TriggerClientEvent('QBCore:Notify', src, 'You\'ve watered the patch..', 'success', 2500)
    end
end)

RegisterNetEvent('qb-jail:server:GiveFertilizer', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not isJobGroupMember(src, 'gardening') or not farmingSetup[index] then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - farmingSetup[index].coords.xyz) > 25 then return end

    if Config.Inventory == 'exports' and exports['qb-inventory']:RemoveItem(src, 'prisonfarmnutrition', 1) then
        farmingSetup[index].fertilizer += 70
        if farmingSetup[index].fertilizer > 100 then
            farmingSetup[index].fertilizer = 100
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonfarmnutrition'], 'remove', 1)
        TriggerClientEvent('QBCore:Notify', src, 'You\'ve watered the patch..', 'success', 2500)
    elseif Config.Inventory == 'player' and Player.Functions.RemoveItem('prisonfarmnutrition', 1) then
        farmingSetup[index].fertilizer += 70
        if farmingSetup[index].fertilizer > 100 then
            farmingSetup[index].fertilizer = 100
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonfarmnutrition'], 'remove', 1)
        TriggerClientEvent('QBCore:Notify', src, 'You\'ve watered the patch..', 'success', 2500)
    end
end)

QBCore.Functions.CreateCallback('qb-jail:server:GetFarmingStatus', function(source, cb, index)
    local src = source
    if not isJobGroupMember(src, 'gardening') or not farmingSetup[index] then cb(nil) return end
    local temp = {
        planted = farmingSetup[index].planted,
        dead = farmingSetup[index].dead,
        growth = farmingSetup[index].growth,
        stage = farmingSetup[index].stage,
        health = farmingSetup[index].health,
        water = farmingSetup[index].water,
        fertilizer = farmingSetup[index].fertilizer
    }
    cb(temp)
end)

--- Exports

exports('getPlayerJobGroup', getPlayerJobGroup)
exports('getGroupMembers', getGroupMembers)
exports('isJobGroupMember', isJobGroupMember)
