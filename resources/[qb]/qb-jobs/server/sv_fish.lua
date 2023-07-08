QBCore.Functions.CreateCallback('qb-fish-check-group', function(src, cb)
    local group = exports['qb-phone']:GetGroupByMembers(src)
    if group ~= nil then
        local size = exports['qb-phone']:getGroupSize(group)
        cb(true, size)
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-fish-start-job', function(needcatch, zone)
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    JOBSTABLE['Fishing'][groupID] = {
        ['catchable'] = needcatch,
        ['catched'] = 0
    }
    local Stages = {
        [1] = {name = "Head to the "..zone.name.." Zone", isDone = false , id = 1},
        [2] = {name = "Catch fishes (0/"..JOBSTABLE['Fishing'][groupID]['catchable']..")", isDone = false , id = 2},
        [3] = {name = "Head to the Fisher Man and give all the fish", isDone = false , id = 3},
    }
    exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)
    
    local m = exports['qb-phone']:getGroupMembers(groupID)
    if not m then return end
    local leader = exports['qb-phone']:GetGroupLeader(groupID)
    for i=1, #m do
        if m[i] then
            if leader == m[i] then
                TriggerClientEvent("qb-fishing-job-started", m[i], true, zone, true)
            else
                TriggerClientEvent("qb-fishing-job-started", m[i], true, zone, false)
            end
        end
    end
end)

RegisterServerEvent("qb-fishing-correct-zone", function(zone)
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    local Stages = {
        [1] = {name = "Head to the "..zone.name.." Zone", isDone = true , id = 1},
        [2] = {name = "Catch fishes (0/"..JOBSTABLE['Fishing'][groupID]['catchable']..")", isDone = false , id = 2},
        [3] = {name = "Head to the Fisher Man and give all the fish", isDone = false , id = 3},
    }
    exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)
    local m = exports['qb-phone']:getGroupMembers(groupID)
    if not m then return end
    for i=1, #m do
        if m[i] then
            TriggerClientEvent("qb-fishing-give-fishrod", m[i])
        end
    end
end)

RegisterServerEvent('qb-fishing-catch', function(zone)
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    if not JOBSTABLE['Fishing'][groupID] then return end
    JOBSTABLE['Fishing'][groupID]['catched'] = JOBSTABLE['Fishing'][groupID]['catched']+1
    
    if JOBSTABLE['Fishing'][groupID]['catched'] == JOBSTABLE['Fishing'][groupID]['catchable'] then
        local Stages = {
            [1] = {name = "Head to the "..zone.name.." Zone", isDone = true , id = 1},
            [2] = {name = "Catch fishes ("..JOBSTABLE['Fishing'][groupID]['catchable'].."/"..JOBSTABLE['Fishing'][groupID]['catchable']..")", isDone = true , id = 2},
            [3] = {name = "Head to the Fisher Man and give all the fish", isDone = false , id = 3},
        }
        exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)
        --blipdelete

        local m = exports['qb-phone']:getGroupMembers(groupID)
        if not m then return end
        for i=1, #m do
            if m[i] then
                TriggerClientEvent("qb-fishing-clear", m[i])
            end
        end

        TriggerEvent('qb-fishing-finished', src, zone)
    else
        local Stages = {
            [1] = {name = "Head to the "..zone.name.." Zone", isDone = true , id = 1},
            [2] = {name = "Catch fishes ("..JOBSTABLE['Fishing'][groupID]['catched'].."/"..JOBSTABLE['Fishing'][groupID]['catchable']..")", isDone = false , id = 2},
            [3] = {name = "Head to the Fisher Man and give all the fish", isDone = false , id = 3},
        }
        exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)
    end
end)

RegisterServerEvent('qb-fishing-finished', function(source, zone)
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    local Stages = {
        [1] = {name = "Head to the "..zone.name.." Zone", isDone = true , id = 1},
        [2] = {name = "Catch fishes ("..JOBSTABLE['Fishing'][groupID]['catchable'].."/"..JOBSTABLE['Fishing'][groupID]['catchable']..")", isDone = true , id = 2},
        [3] = {name = "Head to the Fisher Man and give all the fish", isDone = false , id = 3},
    }
    exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)
    local leader = exports['qb-phone']:GetGroupLeader(groupID)
    TriggerClientEvent("qb-fishing-need-finish", leader)
end)

RegisterServerEvent('qb-fish-finish', function()
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    local m = exports['qb-phone']:getGroupMembers(groupID)
    local fishes = JOBSTABLE['Fishing'][groupID]['catchable']
    -- JOBSTABLE['Fishing'][groupID] = nil
    table.remove(JOBSTABLE['Fishing'], groupID)
    if not m then return end
    local payam = fishes*25
    exports['qb-phone']:NotifyGroup(groupID, 'Job is finished You got $'..payam, 'success')
    for i=1, #m do
        if m[i] then
            local users = QBCore.Functions.GetPlayer(m[i])
            users.Functions.AddMoney('bank', payam)
        end
    end
    exports["qb-phone"]:resetJobStatus(groupID)
end)