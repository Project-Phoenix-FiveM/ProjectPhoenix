if Config.OldESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

if Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
    QBCore.Functions.CreateUseableItem(Config.LaptopItem, function(source, item)
        local src = source
        local identifier = getIdentifier(src)
        local metadata, slot = exports['av_laptop']:getMetadata(item,item)
        local isAdmin = getPermission(src, Config.AdminLevel)
        if metadata and not metadata.serial then
            local info = {}
            info['serial'] = identifier
            info['battery'] = 100
            removeItem(src, Config.LaptopItem, 1, slot)
            addItem(src, Config.LaptopItem, 1, info)
            TriggerClientEvent('av_laptop:notification', src, Lang['new_laptop'])
        else
            TriggerClientEvent("av_laptop:openUI", src, metadata, identifier, isAdmin)
        end
    end)
elseif Config.Framework == "ESX" then
    if not Config.OldESX then
        ESX = exports['es_extended']:getSharedObject()
    end
    ESX.RegisterUsableItem(Config.LaptopItem, function(source,item,info)
        local src = source
        local identifier = getIdentifier(src)
        local metadata, slot = exports['av_laptop']:getMetadata(item,info)
        local isAdmin = getPermission(src, Config.AdminLevel)
        if metadata and not metadata.serial then
            local info = {}
            info['serial'] = identifier
            info['battery'] = 100
            removeItem(src, Config.LaptopItem, 1, slot)
            addItem(src, Config.LaptopItem, 1, info)
            TriggerClientEvent('av_laptop:notification', src, Lang['new_laptop'])
        else
            TriggerClientEvent("av_laptop:openUI", src, metadata, identifier, isAdmin)
        end
    end)
end

lib.callback.register('av_laptop:getItem', function(source,item, amount)
    local src = source
    local qty = 1
    if tonumber(amount) then
        qty = tonumber(amount)
    end
    if type(item) == "table" then
        local count = 0
        for k, v in pairs(item) do
            if hasItem(src,v,qty) then
                count = count + 1
            end
        end
        if count == #item then
            return true
        else
            return false
        end
    end
    return hasItem(src,item,qty)
end)

lib.callback.register('av_laptop:removeItem', function(source,item,amount)
    local src = source
    return removeItem(src,item,amount)
end)