if Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'ESX' then
    ESXItems = {}
end

lib.callback.register('av_restaurant:getItems', function(source, data)
    local job = GetJob(source)
    local items = MySQL.query.await('SELECT * FROM av_items WHERE job = ? AND type = ?', {job, data['type']})
    return items
end)

RegisterServerEvent('av_restaurant:addItem')
AddEventHandler('av_restaurant:addItem', function(item)
    local src = source
    if not isBoss(src) then return end
    local job = GetJob(src)
    local name = item['name']:gsub("[%c%p%s]", "")
    local label = item['label']
    local type = item['type']
    local image = item['image']
    local description = item['description']
    local matches = MySQL.query.await("SELECT name FROM av_items WHERE name = ?", {name})
    local weight = Config.ItemsWeight[type]
    if not matches[1] and not VerifyItem(name) then
        MySQL.insert('INSERT INTO av_items (job, name, label, type, image, description) VALUES (:job, :name, :label, :type, :image, :description)', {
            job = job,
            name = name,
            label = label,
            type = type,
            image = image,
            description = description
        }, function(res)
            if res then
                if Config.Framework == 'QBCore' then
                    TriggerEvent('av_restaurant:QBItem',{name = name, label = label, weight = weight, image = image, description = description})
                    if Config.Framework == "ox_inventory" then
                        TriggerClientEvent('av_restaurant:notification',src,Lang['ESX_Restart'])
                    else
                        TriggerClientEvent('av_restaurant:notification',src,Lang['item_added'])
                    end
                elseif Config.Framework == 'ESX' then
                    TriggerClientEvent('av_restaurant:notification',src,Lang['ESX_Restart'])
                end
                TriggerEvent('inventory:refresh')
                RegisterItem(name,type)
            end
        end)
    else
        TriggerClientEvent('av_restaurant:notification',src,Lang['item_duplicated'])
    end
end)

RegisterServerEvent('av_restaurant:craftEnd')
AddEventHandler('av_restaurant:craftEnd', function(job,item,type)
    local src = source
    local job = GetJob(src)
    if item and job then
        if Config.Ingredients[type] then
            if not hasItem(src,Config.Ingredients[type]) then
                TriggerClientEvent('av_restaurant:notification',src,Lang['missing_ingredients'])
                return
            end
            removeItem(src, Config.Ingredients[type], 1)
        end
        if Config.Framework == 'ESX' then
            if ESXItems[item] then
                AddItem(src,item,1,type)
            else
                TriggerClientEvent('av_restaurant:notification',src,Lang['ESX_Restart'])
            end
        else
            AddItem(src,item,1,type)
        end
    end
end)