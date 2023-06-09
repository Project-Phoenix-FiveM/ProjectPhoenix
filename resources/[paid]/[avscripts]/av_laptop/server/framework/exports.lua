-- Get Player ID by identifier
function getSourceByIdentifier(identifier)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
        if Player then
            return Player.PlayerData.source
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            return xPlayer.source
        end
    end
    return false
end

function getPlayerByIdentifier(identifier)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
        if Player then
            return Player
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            return xPlayer
        end
    end
    return false
end

-- Get Player Permission Level
function getPermission(src, level)
    if Config.Framework == "QBCore" then
        return QBCore.Functions.HasPermission(src, level) 
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        return xPlayer.getGroup() == level
    end
end

-- Get Player Identifier
function getIdentifier(src)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.citizenid
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            return xPlayer.identifier
        end
    end
    return false
end

-- Get Player Object
function getPlayer(src)
    if Config.Framework == "QBCore" then
        return QBCore.Functions.GetPlayer(src)
    elseif Config.Framework == "ESX" then
        return ESX.GetPlayerFromId(src)
    end
end

-- Add Item to player
function addItem(src,item,amount,info)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.AddItem(item,amount,false,info) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
            return true
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer.canCarryItem(item,amount) then
            if Config.Inventory == "qs-inventory" then
                exports['qs-inventory']:AddItem(src, item, amount, nil, info)
            else
                xPlayer.addInventoryItem(item,amount,info)
            end
            return true
        end
    end
    return false
end

-- Remove Item from Player
function removeItem(src, item, amount, slot)
    local amount = amount or 1
    if Config.Framework == "QBCore" then
        if Config.Inventory == "ox_inventory" then
            exports.ox_inventory:RemoveItem(src, item, amount, nil, slot)
        else
            exports[Config.Inventory]:RemoveItem(src, item, amount, slot)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if Config.Inventory == "ox_inventory" then
            exports.ox_inventory:RemoveItem(src, item, amount, nil, slot)
        elseif Config.Inventory == "qs-inventory" then
            exports['qs-inventory']:RemoveItem(src, item, amount)
        end 
    end
end

-- Get Player money
function getMoney(src, account)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Config.UsingMetadataCrypto and Config.MetadataCryptos[account] then
            return Player.PlayerData.metadata.crypto[account]
        else
            return Player.PlayerData.money[account]
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        return xPlayer.getAccount(account).money
    end
end

-- Add Money
function addMoney(src, account, amount)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Config.UsingMetadataCrypto and Config.MetadataCryptos[account] then
            local Crypto = Player.PlayerData.metadata.crypto
            Crypto[account] = Crypto[account] + tonumber(amount)
            Player.Functions.SetMetaData("crypto", Crypto)
        else
            Player.Functions.AddMoney(account,amount)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.addAccountMoney(account,amount)
    end
end

-- Add Money to Offline Player
function addMoneyOffline(identifier, account, amount)
    if Config.Framework == "QBCore" then
        local result = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', {identifier})
        if result and result[1] then
            local RecieverMoney = json.decode(result[1].money)
            RecieverMoney[account] = (RecieverMoney[account] + amount)
            MySQL.update.await('UPDATE players SET money = ? WHERE citizenid = ?', {json.encode(RecieverMoney), identifier})
        end
    elseif Config.Framework == "ESX" then
        local result = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', {identifier})
        if result and result[1] then
            local RecieverMoney = json.decode(result[1].accounts)
            RecieverMoney[account] = (RecieverMoney[account] + amount)
            MySQL.update.await('UPDATE users SET accounts = ? WHERE identifier = ?', {json.encode(RecieverMoney), identifier})
        end
    end
end

-- Remove money from player
function removeMoney(src, account, amount)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Config.UsingMetadataCrypto and Config.MetadataCryptos[account] then
            local Crypto = Player.PlayerData.metadata.crypto
            if not Crypto[account] then return end
            Crypto[account] = Crypto[account] - amount
            Player.Functions.SetMetaData("crypto", Crypto)
        else
            Player.Functions.RemoveMoney(account,amount)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.removeAccountMoney(account,amount)
    end
end

-- Has item?
function hasItem(src,name,amount)
    local qty = 1
    if tonumber(amount) then
        qty = tonumber(amount)
    end
    if Config.Framework == "QBCore" then
        if Config.Inventory == "ox_inventory" then
            local item = exports.ox_inventory:GetItem(src, name, nil, true)
            if item and tonumber(item) >= qty then
                return true 
            end
        else
            return exports[Config.Inventory]:HasItem(src,name,qty)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local item = xPlayer.getInventoryItem(name)
        if item and item['count'] >= qty then
            return true
        end
    end
    return false
end

-- Get Player Job
function getJob(src)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        return Player.PlayerData.job
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        return xPlayer.getJob()
    end
end

-- Get Player Name
function getName(src)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            return xPlayer.getName()
        end
    end
    return false
end

function getMetadata(item,info)
    if item and item.info then
        return item.info, item.slot
    end
    if info and info.metadata then
        return info.metadata, info.slot
    end
end

function getInventoryItem(source,name)
    if Config.Framework == "QBCore" then
        if Config.Inventory == "ox_inventory" then
            return exports.ox_inventory:GetInventoryItems(source)
        else
            return exports[Config.Inventory]:GetItemsByName(source,name)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.getInventory()
    end
end

-- Get all players from X job
function getJobPlayers(job)
    if Config.Framework == "QBCore" then
        local data = {}
        local added = {}
        local Players = QBCore.Functions.GetQBPlayers()
        for k, v in pairs(Players) do
            if v['PlayerData']['job']['name'] == job then
                data[#data+1] = {
                    identifier = v['PlayerData']['citizenid'],
                    name = v.PlayerData.charinfo.firstname.. ' '..v.PlayerData.charinfo.lastname,
                    grade = v.PlayerData.job.grade,
                    photo = exports['av_restaurants']:getPhoto(v['PlayerData']['citizenid']),
                    online = true
                }
                added[v['PlayerData']['citizenid']] = true
            end
        end
        local Players2 = MySQL.query.await("SELECT * FROM players WHERE job LIKE '%".. job .."%'", {})
        for k, v in pairs(Players2) do
            if not added[v['citizenid']] then
                local Player = getPlayerByIdentifier(v['citizenid'])
                if Player then
                    if Player.PlayerData.job.name == job then              
                        data[#data+1] = {
                            identifier = v['citizenid'],
                            name = Player.PlayerData.charinfo.firstname.. ' '..Player.PlayerData.charinfo.lastname,
                            grade = Player.PlayerData.job.grade,
                            photo = exports['av_restaurants']:getPhoto(v['citizenid']),
                            online = true
                        }
                    end
                else
                    data[#data+1] = {
                        identifier = v['citizenid'],
                        name = json.decode(v['charinfo']).firstname .. ' ' .. json.decode(v['charinfo']).lastname,
                        grade = json.decode(v['job']).grade,
                        photo = exports['av_restaurants']:getPhoto(v['citizenid']),
                        online = false
                    }
                end
            end
        end
        return data
    elseif Config.Framework == "ESX" then
        local data = {}
        local Players = MySQL.query.await("SELECT * FROM users WHERE job = ?", {job})
        for k, v in pairs(Players) do
            local xPlayer = getPlayerByIdentifier(v['identifier'])
            if xPlayer then
                data[#data+1] = {
                    identifier = v['identifier'],
                    name = xPlayer.getName(),
                    grade = xPlayer.getJob().grade,
                    photo = exports['av_restaurants']:getPhoto(v['identifier']),
                    online = true
                }
            else
                data[#data+1] = {
                    identifier = v['identifier'],
                    name = v['firstname'].. ' ' ..v['lastname'],
                    grade = v['job_grade'],
                    photo = exports['av_restaurants']:getPhoto(v['identifier']),
                    online = false
                }
            end
        end
        return data
    end
end

function setJob(target,job)
    target = tonumber(target)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(target)
        if Player then
            Player.Functions.SetJob(job, 0)
            local jobData = QBCore.Shared.Jobs[job]['grades']['0']
            local info = {
                name = jobData['name'],
                onduty = true,
                isboss = false,
                payment = jobData['payment'],
                grade = {name = jobData['name'], level = 0}
            }
            MySQL.update.await('UPDATE players SET job = ? WHERE citizenid = ?', {json.encode(info),Player.PlayerData.citizenid})
            return true
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(target)
        if xPlayer then
            xPlayer.setJob(job,0)
            MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', {job,0,xPlayer.identifier})
            return true
        end
    end
    return false
end

function setJobGrade(identifier,job,grade)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
        local jobData = QBCore.Shared.Jobs[job]['grades'][grade]
        if Player then
            Player.Functions.SetJob(job,grade)
        end
        local info = {
            name = job,
            onduty = true,
            isboss = jobData['isboss'],
            payment = jobData['payment'],
            grade = {name = jobData['name'], level = 0}
        }
        MySQL.update.await('UPDATE players SET job = ? WHERE citizenid = ?', {json.encode(info),identifier})
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            xPlayer.setJob(job,grade)
        end
        MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', {job, grade, identifier})
    end
end

function Discord(webhook, message)
    PerformHttpRequest(webhook, function() end, 'POST', json.encode({ username = 'AV Scripts', embeds = message}), { ['Content-Type'] = 'application/json' })
end

function getPhone(source)
    local phone = ""
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            phone = Player.PlayerData.charinfo.phone
        end
    elseif Config.Framework == "ESX" then

    end
    return phone
end

-- Export List
exports('getSourceByIdentifier', getSourceByIdentifier)
exports('getPlayerByIdentifier', getPlayerByIdentifier)
exports('getPermission', getPermission)
exports('getIdentifier', getIdentifier)
exports('getPlayer', getPlayer)
exports('addItem', addItem)
exports('removeItem', removeItem)
exports('getMoney', getMoney)
exports('addMoney', addMoney)
exports('addMoneyOffline', addMoneyOffline)
exports('removeMoney', removeMoney)
exports('hasItem', hasItem)
exports('getJob', getJob)
exports('getName', getName)
exports('getMetadata', getMetadata)
exports('getItem', getItem)
exports('getInventoryItem', getInventoryItem)
exports('getJobPlayers', getJobPlayers)
exports('setJob', setJob)
exports('setJobGrade', setJobGrade)
exports('Discord', Discord)
exports('getPhone', getPhone)