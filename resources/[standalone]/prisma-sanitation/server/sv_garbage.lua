QBCore.Functions.CreateCallback('prisma-sanitation-check-group', function(src, cb)
    local group = exports[Shared['PhoneScript']]:GetGroupByMembers(src)
    if group ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('prisma-sanitation-startjobforgroup', function(street, veh)
    local src = source
    local groupID = exports[Shared['PhoneScript']]:GetGroupByMembers(src)
    local Stages = {
        [1] = {name = "Get into the trash car", isDone = false , id = 1},
        [2] = {name = "Head to the "..street.." Zone", isDone = false , id = 2},
        [3] = {name = "Load trash bags to the truck (0/15)", isDone = false , id = 3},
        [4] = {name = "Head to the Garbage Warehouse and take the payment", isDone = false , id = 4},
    }
    exports[Shared['PhoneScript']]:setJobStatus(groupID, "Garbage", Stages)
    
    local m = exports[Shared['PhoneScript']]:getGroupMembers(groupID)
    if not m then return end
    JOBSTABLE['Garbage'][groupID] = {
        ['loaded'] = 0,
        ['cangrab'] = 15,
    }
    for i=1, #m do
        if m[i] then
            TriggerClientEvent("prisma-sanitation-jobstatus", m[i], true, street, veh)
        end
    end
end)

RegisterServerEvent('prisma-sanitation-getted-intothecar', function(street, garbageVehicle)
    local src = source
    local groupID = exports[Shared['PhoneScript']]:GetGroupByMembers(src)
    local Stages = {
        [1] = {name = "Get into the trash car", isDone = true , id = 1},
        [2] = {name = "Head to the "..street.." Zone", isDone = false , id = 2},
        [3] = {name = "Load trash bags to the truck (0/15)", isDone = false , id = 3},
        [4] = {name = "Head to the Garbage Warehouse and take the payment", isDone = false , id = 4},
    }
    exports[Shared['PhoneScript']]:setJobStatus(groupID, "Garbage", Stages)
    
    local m = exports[Shared['PhoneScript']]:getGroupMembers(groupID)
    if not m then return end
    for i=1, #m do
        if m[i] then
            TriggerClientEvent("prisma-sanitation-gotothezone", m[i], garbageVehicle)
        end
    end
end)

RegisterNetEvent('prisma-sanitation-correctzone', function(street)
    local src = source
    local groupID = exports[Shared['PhoneScript']]:GetGroupByMembers(src)
    local Stages = {
        [1] = {name = "Get into the trash car", isDone = true , id = 1},
        [2] = {name = "Head to the "..street.." Zone", isDone = true , id = 2},
        [3] = {name = "Load trash bags to the truck (0/15)", isDone = false , id = 3},
        [4] = {name = "Head to the Garbage Warehouse and take the payment", isDone = false , id = 4},
    }
    exports[Shared['PhoneScript']]:setJobStatus(groupID, "Garbage", Stages)
    local m = exports[Shared['PhoneScript']]:getGroupMembers(groupID)
    if not m then return end
    for i=1, #m do
        if m[i] then
            TriggerClientEvent("prisma-sanitation-start-zone", m[i])
        end
    end
end)

RegisterServerEvent('prisma-sanitation-trigger-target', function(x)
    local src = source
    local groupID = exports[Shared['PhoneScript']]:GetGroupByMembers(src)
    local m = exports[Shared['PhoneScript']]:getGroupMembers(groupID)
    if not m then return end
    for i=1, #m do
        if m[i] then
            TriggerClientEvent("prisma-sanitation-remove-target", m[i], x)
        end
    end
end)

RegisterNetEvent('prisma-sanitation-disposed-bag', function(street)
    local src = source
    local groupID = exports[Shared['PhoneScript']]:GetGroupByMembers(src)
    if not JOBSTABLE['Garbage'][groupID] then return end
    JOBSTABLE['Garbage'][groupID]['loaded'] = JOBSTABLE['Garbage'][groupID]['loaded']+1
    
    if JOBSTABLE['Garbage'][groupID]['loaded'] == JOBSTABLE['Garbage'][groupID]['cangrab'] then
        local Stages = {
            [1] = {name = "Get into the trash car", isDone = true , id = 1},
            [2] = {name = "Head to the "..street.." Zone", isDone = true , id = 2},
            [3] = {name = "Load trash bags to the truck (15/15)", isDone = true , id = 3},
            [4] = {name = "Head to the Garbage Warehouse and take the payment", isDone = false , id = 4},
        }
        exports[Shared['PhoneScript']]:setJobStatus(groupID, "Garbage", Stages)
        TriggerEvent('prisma-sanitation-finished', src)
        local m = exports[Shared['PhoneScript']]:getGroupMembers(groupID)
        if not m then return end
        for i=1, #m do
            if m[i] then
                TriggerClientEvent("prisma-sanitation-clear", m[i])
            end
        end
    elseif JOBSTABLE['Garbage'][groupID]['loaded'] ~= JOBSTABLE['Garbage'][groupID]['cangrab'] then
        local Stages = {
            [1] = {name = "Get into the trash car", isDone = true , id = 1},
            [2] = {name = "Head to the "..street.." Zone", isDone = true , id = 2},
            [3] = {name = "Load trash bags to the truck ("..JOBSTABLE['Garbage'][groupID]['loaded'].."/15)", isDone = false , id = 3},
            [4] = {name = "Head to the Garbage Warehouse and take the payment", isDone = false , id = 4},
        }
        exports[Shared['PhoneScript']]:setJobStatus(groupID, "Garbage", Stages)
    end
end)

RegisterServerEvent('prisma-sanitation-finished', function(source)
    local src = source
    local groupID = exports[Shared['PhoneScript']]:GetGroupByMembers(src)
    local leader = exports[Shared['PhoneScript']]:GetGroupLeader(groupID)
    TriggerClientEvent("prisma-sanitation-need-finish", leader)
end)

local function finish()
    local src = source
    local groupID = exports[Shared['PhoneScript']]:GetGroupByMembers(src)
    local m = exports[Shared['PhoneScript']]:getGroupMembers(groupID)
    if not m then return end
    local price = math.random(250,500)
    exports[Shared['PhoneScript']]:NotifyGroup(groupID, 'Job is finished You got $'..price, 'success')
    for i=1, #m do
        if m[i] then
            local users = QBCore.Functions.GetPlayer(m[i])
            users.Functions.AddMoney('bank', price)
            TriggerClientEvent("prisma-sanitation-finish-for-group", m[i])
        end
    end
    exports[Shared['PhoneScript']]:resetJobStatus(groupID)
end RegisterServerEvent('prisma-sanitation-job-finished', finish)