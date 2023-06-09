CreateThread(function()
    if Config.Framework == "QBCore" and not Config.AVBoosting then
        QBCore = exports['qb-core']:GetCoreObject()
        QBCore.Functions.CreateUseableItem(Config.DongleItem, function(source, item)
            local src = source
            local identifier = exports['av_laptop']:getIdentifier(src)
            local metadata, slot = exports['av_laptop']:getMetadata(item,item)
            if metadata and not metadata.serial then
                local info = {}
                info['serial'] = identifier
                exports['av_laptop']:removeItem(src,Config.DongleItem, 1, slot)
                exports['av_laptop']:addItem(src,Config.DongleItem, 1, info)
                TriggerClientEvent('av_racing:dongle',src)
            else
                if metadata.serial == identifier then
                    TriggerClientEvent('av_racing:dongle',src)
                else
                    TriggerClientEvent('av_laptop:notification',src,"Error",Lang['not_yours'])
                end
            end
        end)
    elseif Config.Framework == "ESX" and not Config.AVBoosting then
        ESX = exports["es_extended"]:getSharedObject()
        ESX.RegisterUsableItem(Config.DongleItem, function(source, item, info)
            local src = source
            local identifier = exports['av_laptop']:getIdentifier(src)
            local metadata, slot = exports['av_laptop']:getMetadata(item,info)
            if metadata and not metadata.serial then
                local info = {}
                info['serial'] = identifier
                exports['av_laptop']:removeItem(src,Config.DongleItem, 1, slot)
                exports['av_laptop']:addItem(src,Config.DongleItem, 1, info)
                TriggerClientEvent('av_racing:dongle',src)
            else
                if metadata.serial == identifier then
                    TriggerClientEvent('av_racing:dongle',src)
                else
                    TriggerClientEvent('av_laptop:notification',src,"Error",Lang['not_yours'])
                end
            end
        end)
    end
end)