if Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

lib.callback.register('av_restaurant:getBusiness', function(source, job)
    local money = 0
    local data = MySQL.single.await('SELECT * FROM av_society WHERE job = ?', {job})
    if data and data.money then
        money = data.money
    end
    return money
end)

RegisterServerEvent('av_restaurant:getItems')
AddEventHandler('av_restaurant:getItems', function(data)
    local src = source
    local job = GetJob(src)
    local type = data['type']
    local items = MySQL.query.await('SELECT * FROM av_items WHERE job = ? AND type = ?', {job,type})
    TriggerClientEvent('av_restaurant:listItems',src,items,job)
end)

RegisterServerEvent('av_restaurant:deleteItem')
AddEventHandler('av_restaurant:deleteItem', function(data)
    local src = source
    local name = data['name']
    if isBoss(src) then
        MySQL.query('DELETE FROM av_items WHERE name = ?', {name}, function(result)
            if result then
                TriggerClientEvent('av_restaurant:notification',src,Lang['item_deleted'])
            end
        end)
    end
end)

RegisterServerEvent('av_restaurant:bossWithdraw')
AddEventHandler('av_restaurant:bossWithdraw', function(laptop)
    local src = source
    if isBoss(src) then
        local job = GetJob(src)
        if job then
            if not society[job] then
                return 
            end
            local societyMoney = MySQL.single.await('SELECT * FROM av_society WHERE job = ?', {job})
            if societyMoney and tonumber(societyMoney['money']) > 0 then
                MySQL.update.await('UPDATE av_society SET money = ? WHERE job = ?', {0, job})
                AddMoney(src, "bank", tonumber(societyMoney['money']))
                if not laptop then
                    TriggerClientEvent('av_restaurant:notification',src,Lang['boss_withdrawn']..tonumber(societyMoney['money']))
                    TriggerClientEvent('av_restaurant:boss',src)
                else
                    TriggerClientEvent('av_laptop:notificationUI', src, Lang['boss_withdrawn']..tonumber(societyMoney['money']), 'success')
                end
                SaveResourceFile(GetCurrentResourceName(), "society.json", json.encode(society), -1)
            end
        end
    end
end)