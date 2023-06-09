CreateThread(function()
    if Config.Framework == "QBCore" then
        QBCore = exports['qb-core']:GetCoreObject()
        QBCore.Functions.CreateUseableItem(Config.DongleName, function(source, item)
            local src = source
            local identifier = exports['av_laptop']:getIdentifier(src)
            local metadata, slot = exports['av_laptop']:getMetadata(item,item)
            if metadata and not metadata.serial then
                local info = {}
                info['serial'] = identifier
                exports['av_laptop']:removeItem(src,Config.DongleName, 1, slot)
                exports['av_laptop']:addItem(src,Config.DongleName, 1, info)
                TriggerClientEvent('av_boosting:dongle',src)
            else
                if metadata.serial == identifier then
                    if Config.RenewUserWithSameDongle then
                        TriggerClientEvent('av_boosting:dongle',src)
                        return
                    end
                    if not metadata.username then
                        TriggerClientEvent('av_boosting:dongle',src)
                    end
                else
                    TriggerClientEvent('av_laptop:notification',src,"Error",Lang['not_yours'])
                end
            end
        end)
        QBCore.Functions.CreateUseableItem(Config.TrackerItem, function(source, item)
            TriggerClientEvent('av_boosting:trackerMinigame',source)
        end)
        QBCore.Functions.CreateUseableItem(Config.CrackerItem, function(source, item)
            TriggerClientEvent('av_boosting:useCracker',source)
        end)
    elseif Config.Framework == "ESX" then
        ESX = exports['es_extended']:getSharedObject()
        ESX.RegisterUsableItem(Config.DongleName, function(source, item, info)
            local src = source
            local identifier = exports['av_laptop']:getIdentifier(src)
            local metadata, slot = exports['av_laptop']:getMetadata(item,info)
            if metadata and not metadata.serial then
                local info = {}
                info['serial'] = identifier
                exports['av_laptop']:removeItem(src,Config.DongleName, 1, slot)
                exports['av_laptop']:addItem(src,Config.DongleName, 1, info)
                TriggerClientEvent('av_boosting:dongle',src)
            else
                if metadata.serial == identifier then
                    if Config.RenewUserWithSameDongle then
                        TriggerClientEvent('av_boosting:dongle',src)
                        return
                    end
                    if not metadata.username then
                        TriggerClientEvent('av_boosting:dongle',src)
                    end
                else
                    TriggerClientEvent('av_laptop:notification',src,"Error",Lang['not_yours'])
                end
            end
        end)
        ESX.RegisterUsableItem(Config.TrackerItem, function(source, item)
            TriggerClientEvent('av_boosting:trackerMinigame',source)
        end)
        ESX.RegisterUsableItem(Config.CrackerItem, function(source, item)
            TriggerClientEvent('av_boosting:useCracker',source)
        end)
    end
end)