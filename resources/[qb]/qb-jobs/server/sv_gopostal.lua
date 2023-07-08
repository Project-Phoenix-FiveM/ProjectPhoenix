local QBCore = exports['qb-core']:GetCoreObject()

local JobCarTable = {}

QBCore.Functions.CreateCallback('jd-postop-check-group', function(src, cb)
    local group = exports['qb-phone']:GetGroupByMembers(src)
    if group ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('jd-postop-startjobforgroup', function(street)
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    local Stages = {
        [1] = {name = "Load packages to the car (0/5)", isDone = false , id = 1},
        [2] = {name = "Head to the "..street.." Zone", isDone = false , id = 2},
        [3] = {name = "Deliver packages to the customers (0/5)", isDone = false , id = 3},
        [4] = {name = "Head to the GoPostal Warehouse and take the payment", isDone = false , id = 4},
    }
    exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)
    
    local m = exports['qb-phone']:getGroupMembers(groupID)
    if not m then return end
    JobCarTable[groupID] = {
        ['loaded'] = 0,
        ['delivered'] = 0,
        ['cangrab'] = 5,
        ['customer'] = 1 
    }
    for i=1, #m do
        if m[i] then
            TriggerClientEvent("jd-postop-jobstatus", m[i], true, street)
        end
    end
end)

QBCore.Functions.CreateCallback('jd-postop-check-grab-package', function(src, cb)
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    if JobCarTable[groupID]['cangrab'] ~= 0 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('jd-postop-grabbed', function()
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    JobCarTable[groupID]['cangrab'] = JobCarTable[groupID]['cangrab']-1
end)

RegisterServerEvent('jd-postop-loadcar', function(street)
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    if not JobCarTable[groupID] then return end
    JobCarTable[groupID]['loaded'] = JobCarTable[groupID]['loaded']+1
    local Stages = {
        [1] = {name = "Load packages to the car ("..JobCarTable[groupID]['loaded'].."/5)", isDone = false , id = 1},
        [2] = {name = "Head to the "..street.." Zone", isDone = false , id = 2},
        [3] = {name = "Deliver packages to the customers (0/5)", isDone = false , id = 3},
        [4] = {name = "Head to the GoPostal Warehouse and take the payment", isDone = false , id = 4},
    }
    exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)
    if JobCarTable[groupID]['loaded'] == 5 and JobCarTable[groupID]['cangrab'] == 0 then
        local Stages = {
            [1] = {name = "Load packages to the car (5/5)", isDone = true , id = 1},
            [2] = {name = "Head to the "..street.." Zone", isDone = false , id = 2},
            [3] = {name = "Deliver packages to the customers (0/5)", isDone = false , id = 3},
            [4] = {name = "Head to the GoPostal Warehouse and take the payment", isDone = false , id = 4},
        }
        exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)

        local m = exports['qb-phone']:getGroupMembers(groupID)
        if not m then return end
        for i=1, #m do
            if m[i] then
                TriggerClientEvent("jd-postop-loaded", m[i])
            end
        end
    end
end)

RegisterNetEvent('jd-postop-correctzone', function(street) 
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    local Stages = {
        [1] = {name = "Load packages to the car (5/5)", isDone = true , id = 1},
        [2] = {name = "Head to the "..street.." Zone", isDone = true , id = 2},
        [3] = {name = "Deliver packages to the customers (0/5)", isDone = false , id = 3},
        [4] = {name = "Head to the GoPostal Warehouse and take the payment", isDone = false , id = 4},
    }
    exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)
    local m = exports['qb-phone']:getGroupMembers(groupID)
    if not m then return end
    local i = math.random(1, #Shared['GoPostal']['CustomerPeds'])
    local ped_hash = GetHashKey(Shared['GoPostal']['CustomerPeds'][i])
    local coord = Shared['GoPostal']['Customers'][street][JobCarTable[groupID]['customer']]['Start']
    local coord2 = Shared['GoPostal']['Customers'][street][JobCarTable[groupID]['customer']]['End']
    for i=1, #m do
        if m[i] then
            TriggerClientEvent("jd-postop-postop-customer", m[i], coord, coord2, ped_hash)
        end
    end
end)

RegisterNetEvent('jd-postop-delivered', function(street)
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    if not JobCarTable[groupID] then return end
    JobCarTable[groupID]['loaded'] = JobCarTable[groupID]['loaded']-1
    JobCarTable[groupID]['delivered'] = JobCarTable[groupID]['delivered']+1
    JobCarTable[groupID]['customer'] = JobCarTable[groupID]['customer']+1
    if JobCarTable[groupID]['delivered'] == 5 and JobCarTable[groupID]['loaded'] == 0 then
        local Stages = {
            [1] = {name = "Load packages to the car (5/5)", isDone = true , id = 1},
            [2] = {name = "Head to the "..street.." Zone", isDone = true , id = 2},
            [3] = {name = "Deliver packages to the customers (5/5)", isDone = true , id = 3},
            [4] = {name = "Head to the GoPostal Warehouse and take the payment", isDone = false , id = 4},
        }
        exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)
        local m = exports['qb-phone']:getGroupMembers(groupID)
        for i=1, #m do
            if m[i] then
                TriggerClientEvent("jd-postop-clear", m[i])
            end
        end
        TriggerEvent('jd-postop-finished', src, street)
    elseif JobCarTable[groupID]['delivered'] ~= 5 then
        local Stages = {
            [1] = {name = "Load packages to the car (5/5)", isDone = true , id = 1},
            [2] = {name = "Head to the "..street.." Zone", isDone = true , id = 2},
            [3] = {name = "Deliver packages to the customers ("..JobCarTable[groupID]['delivered'].."/5)", isDone = false , id = 3},
            [4] = {name = "Head to the GoPostal Warehouse and take the payment", isDone = false , id = 4},
        }
        exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages)
        local i = math.random(1, #Shared['GoPostal']['CustomerPeds'])
        local ped_hash = GetHashKey(Shared['GoPostal']['CustomerPeds'][i])
        local coord = Shared['GoPostal']['Customers'][street][JobCarTable[groupID]['customer']]['Start']
        local coord2 = Shared['GoPostal']['Customers'][street][JobCarTable[groupID]['customer']]['End']
        local m = exports['qb-phone']:getGroupMembers(groupID)
        for i=1, #m do
            if m[i] then
                TriggerClientEvent("jd-postop-postop-customer", m[i], coord, coord2, ped_hash)
            end
        end
    end
end)

RegisterServerEvent('jd-postop-finished', function(source, street)
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    local Stages = {
        [1] = {name = "Load packages to the car (5/5)", isDone = true , id = 1},
        [2] = {name = "Head to the "..street.." Zone", isDone = true , id = 2},
        [3] = {name = "Deliver packages to the customers ("..JobCarTable[groupID]['delivered'].."/5)", isDone = true , id = 3},
        [4] = {name = "Head to the GoPostal Warehouse and take the payment", isDone = false , id = 4},
    }
    JobCarTable[groupID] = nil
    exports['qb-phone']:setJobStatus(groupID, "Fishing Job", Stages) 
    local leader = exports['qb-phone']:GetGroupLeader(groupID)
    TriggerClientEvent("jd-postop-need-finish", leader) 
end)

RegisterServerEvent('jd-postop-finished2', function(street)
    local src = source
    local groupID = exports['qb-phone']:GetGroupByMembers(src)
    local m = exports['qb-phone']:getGroupMembers(groupID)
    if not m then return end
    exports['qb-phone']:NotifyGroup(groupID, 'Job is finished You got $'..Shared['GoPostal']['PayOut'][street], 'success')
    for i=1, #m do
        if m[i] then
            local users = QBCore.Functions.GetPlayer(m[i])
            users.Functions.AddMoney('bank', Shared['GoPostal']['PayOut'][street])
            TriggerClientEvent("jd-postop-finish-for-group", m[i])
        end
    end
    exports["qb-phone"]:resetJobStatus(groupID)
end)