local societies = {}

CreateThread(function()
    if Config.Framework == 'QBCore' then
        QBCore.Commands.Add(Config.Command, "AV Restaurants", {}, false, function(source, args)
            TriggerClientEvent('av_restaurant:adminMenu',source)
        end, Config.AdminLevel)
    elseif Config.Framework == 'ESX' then
        if Config.UsingOldESX then 
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        else
            ESX = exports['es_extended']:getSharedObject()
        end
        ESX.RegisterCommand(Config.Command, 'admin', function(xPlayer, args, showError)
            TriggerClientEvent('av_restaurant:adminMenu',xPlayer.source)
        end, true, {help = "AV Restaurants"})
        lib.callback.register('av_restaurant:GetESXJobs', function(source)
            local data = ESX.GetJobs()
            return data or {}
        end)
    end
end)

function GetJob(source)
    if Config.Framework == 'QBCore' then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player.PlayerData.job.name
    elseif Config.Framework == 'ESX' then
		local xPlayer = ESX.GetPlayerFromId(source)
		return xPlayer.job.name
    end
    return false
end

function isBoss(source)
    if Config.Framework == 'QBCore' then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player.PlayerData.job.isboss
    elseif Config.Framework == 'ESX' then
		local xPlayer = ESX.GetPlayerFromId(source)
		return (xPlayer.job.grade_name == "boss")
    end
    return false
end

function AddMoney(source,type,amount)
    if Config.Framework == 'QBCore' then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player.Functions.AddMoney(type,amount)
    elseif Config.Framework == 'ESX' then
		local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addAccountMoney(type, amount)
    end
end

function RemoveMoney(source,type,amount)
    if Config.Framework == 'QBCore' then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player.Functions.RemoveMoney(type,amount)
    elseif Config.Framework == 'ESX' then
		local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getAccount(type).money >= tonumber(amount) then
            xPlayer.removeAccountMoney(type, amount)
            return true
        end
    end
    return false
end

function removeItem(src, item, amount, slot)
    local amount = amount or 1
    if Config.Framework == "QBCore" then
        if Config.Inventory == "ox_inventory" then
            exports.ox_inventory:RemoveItem(src, item, amount, nil, slot)
        else
            local Player = QBCore.Functions.GetPlayer(src)
            Player.Functions.RemoveItem(item,amount,slot)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if Config.Inventory == "ox_inventory" then
            exports.ox_inventory:RemoveItem(src, item, amount, nil, slot)
        elseif Config.Inventory == "qs-inventory" then
            TriggerEvent('inventory:server:removeItem', src, item, amount)
        else
            xPlayer.removeInventoryItem(item,amount)
        end 
    end
end

function hasItem(src,name)
    if Config.Framework == "QBCore" then
        if Config.Inventory == "ox_inventory" then
            local item = exports.ox_inventory:GetItem(src, name, nil, true)
            if item and tonumber(item) > 0 then
                return true 
            end
        else
            return exports[Config.Inventory]:HasItem(src,name)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local item = xPlayer.getInventoryItem(name)
        if item and item['count'] > 0 then
            return true
        end
    end
    return false
end

function AddItem(src,name,amount,type)
    if Config.Framework == 'QBCore' then
        local Player = QBCore.Functions.GetPlayer(src)
        local info = {}
        info.type = type
        if Config.Inventory == 'ox_inventory' then
            if exports.ox_inventory:CanCarryItem(src, name, amount) then
                exports.ox_inventory:AddItem(src, name, amount, info)
            end
        else
            if Player.Functions.AddItem(name,amount,false,info) then
                TriggerClientEvent('inventory:client:ItemBox',Player.PlayerData.source, QBCore.Shared.Items[name], 'add', amount)
            end
        end
    elseif Config.Framework == 'ESX' then
		local xPlayer = ESX.GetPlayerFromId(src)
		if Config.Inventory == 'default' then
		    xPlayer.addInventoryItem(name, amount)
        elseif Config.Inventory == 'ox_inventory' then
            if exports.ox_inventory:CanCarryItem(src, name, amount) then
                exports.ox_inventory:AddItem(src, name, amount)
            end
		elseif Config.Inventory == 'mf-inventory' then
            xPlayer.addInventoryItem(name,amount,100)
        elseif Config.Inventory == 'qs-inventory' then
            xPlayer.addInventoryItem(name, amount)
        end
		return true
    end
    return false
end

function RegisterItem(name,type)
    if Config.Framework == 'QBCore' then
        QBCore = exports['qb-core']:GetCoreObject()
        if type ~= "others" then
            QBCore.Functions.CreateUseableItem(name, function(source, item)
                local Player = QBCore.Functions.GetPlayer(source)
                if Player.Functions.RemoveItem(item.name,1) then
                    if Config.Inventory == "ox_inventory" then
                        TriggerClientEvent('av_restaurant:useItem',source,item['metadata']['type'])
                    else
                        TriggerClientEvent('av_restaurant:useItem',source,item['info']['type'])
                    end
                end
            end)
        end
    elseif Config.Framework == 'ESX' then
        if Config.UsingOldESX then TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) end
		if type ~= "others" then
			ESX.RegisterUsableItem(name, function(source)
				local xPlayer = ESX.GetPlayerFromId(source)
                xPlayer.removeInventoryItem(name, 1)
                TriggerClientEvent('av_restaurant:useItem',source,ESXItems[name]['type'])
			end)
		end
    end
end

function RegisterStash(name, job, type)
    -- Here you can register your stash using inventory events/exports
    if Config.Framework == 'ESX' then
        if type == 'stash' then
            if Config.Inventory == 'ox_inventory' then
                exports.ox_inventory:RegisterStash(name, name, Config.StashSlots, Config.StashWeight)
            elseif Config.Inventory == 'mf-inventory' then
                exports["mf-inventory"]:onReady(function()
                    local inv = exports["mf-inventory"]:getInventory(name)
                    if not inv then
                        exports["mf-inventory"]:createInventory(name, "inventory", "item", "item_inv", Config.StashWeight, Config.StashSlots, {})
                    end
                end)
			end
        else
            if Config.Inventory == 'ox_inventory' then
                exports.ox_inventory:RegisterStash(name, name, Config.TraySlots, Config.TrayWeight)
            elseif Config.Inventory == 'mf-inventory' then
                exports["mf-inventory"]:onReady(function()
                    local inv = exports["mf-inventory"]:getInventory(name)
                    if not inv then
                        exports["mf-inventory"]:createTemporaryInventory(name, "inventory", "item", "item_inv", Config.TrayWeight, Config.TraySlots, {})
                    end
                end)
			end
        end
    elseif Config.Framework == "QBCore" then
        if type == 'stash' then
            if Config.Inventory == 'ox_inventory' then
                exports.ox_inventory:RegisterStash(name, name, Config.StashSlots, Config.StashWeight)
            end
        else
            if Config.Inventory == 'ox_inventory' then
                exports.ox_inventory:RegisterStash(name, name, Config.TraySlots, Config.TrayWeight)
            end
        end
    end
end

function UpdateSociety(job,amount)
    if not societies[job] then
        local exists = MySQL.single.await('SELECT * FROM av_society WHERE job = ?', {job})
        if not exists then
            MySQL.insert.await('INSERT INTO av_society (job, money) VALUES (?, ?)', {job, 0})
        end
        societies[job] = true
    end
    MySQL.update.await('UPDATE av_society SET money = (money + ?) WHERE job = ?', {amount, job})
end

function VerifyItem(name)
    if Config.Framework == 'QBCore' then
        if QBCore.Shared.Items[name] then
            if Config.itemsWhitelist[name] then
                return false
            else
                return true
            end
        else
            return false
        end
    elseif Config.Framework == 'ESX' then
        if ESX.Items and ESX.Items[name] then
            if Config.itemsWhitelist[name] then
                return false
            else
                return true
            end
        else
            return false
        end
    end
end

function fireOnlineEmployee(xTarget)
    if Config.Framework == "QBCore" then
        xTarget.Functions.SetJob(Config.UnemployedJobName,0)
    elseif Config.Framework == "ESX" then
        xTarget.setJob(Config.UnemployedJobName,0)
        MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', {Config.UnemployedJobName,0,xTarget.identifier})
    end
end

function fireOfflineEmployee(identifier)
    if Config.Framework == "QBCore" then
        local job = QBCore.Shared.Jobs[Config.UnemployedJobName]
        local newJob = {
            name = Config.UnemployedJobName,
            label = job['label'],
            isboss = false,
            payment = job['grades']['0']['payment'],
            grade = {name = job['grades']['0']['name'], level = 0}
        }
        MySQL.update.await('UPDATE players SET job = ? WHERE citizenid = ?', {json.encode(newJob),identifier})
    elseif Config.Framework == "ESX" then
        MySQL.update.await('UPDATE users SET job = ? AND job_grade = ? WHERE identifier = ?', {Config.UnemployedJobName, 0, identifier})
    end
end

-- Get Player money
function getMoney(src, account)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        return Player.PlayerData.money[account]
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        return xPlayer.getAccount(account).money
    end
end

exports('UpdateSociety', UpdateSociety)