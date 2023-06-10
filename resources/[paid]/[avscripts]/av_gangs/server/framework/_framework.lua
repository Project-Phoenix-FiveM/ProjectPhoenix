RegisterCommand(Gangs.RegisterGangCommand, function(source, args)
    local src = source
    local permission = exports['av_laptop']:getPermission(src, Gangs.AdminLevel)
    if permission then
        TriggerClientEvent('av_gangs:register',src)
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['no_access'],"error")
    end
end)

RegisterCommand(Gangs.SetGangBossCommand, function(source, args)
    local src = source
    local permission = exports['av_laptop']:getPermission(src, Gangs.AdminLevel)
    if permission then
        TriggerClientEvent('av_gangs:addBoss',src,gangs_names)
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['no_access'],"error")
    end
end)

RegisterCommand(Gangs.RemoveGangMember, function(source, args)
    local src = source
    local permission = exports['av_laptop']:getPermission(src, Gangs.AdminLevel)
    if permission then
        TriggerClientEvent('av_gangs:removeMember',src,gangs_names)
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['no_access'],"error")
    end
end)

RegisterCommand(Gangs.DeleteGang, function(source, args)
    local src = source
    local permission = exports['av_laptop']:getPermission(src, Gangs.AdminLevel)
    if permission then
        TriggerClientEvent('av_gangs:deleteGang',src,gangs_names)
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['no_access'],"error")
    end
end)

CreateThread(function()
    if Gangs.Framework == "QBCore" then
        QBCore = exports['qb-core']:GetCoreObject()
        QBCore.Functions.CreateUseableItem(Gangs.SprayItem, function(source, item)
            local src = source
            local metadata = exports['av_laptop']:getMetadata(item,item)
            if metadata.gang and Gangs.Sprays[metadata.gang] then
                if GetMembersCount(metadata.gang) >= Gangs.MinMembersForSpray then
                    TriggerClientEvent('av_gangs:sprayItem',src,metadata.gang)
                else
                    TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['not_enough_members'],"error")
                end
            end
        end)
        QBCore.Functions.CreateUseableItem(Gangs.SprayRemover, function(source, item)
            local src = source
            local metadata = exports['av_laptop']:getMetadata(item,item)
            if metadata.gang and Gangs.Sprays[metadata.gang] then
                TriggerClientEvent('av_gangs:removerItem',src,metadata.gang)
            end
        end)
    elseif Gangs.Framework == "ESX" then
        ESX = exports['es_extended']:getSharedObject()
        ESX.RegisterUsableItem(Gangs.SprayItem, function(source, item, info)
            local src = source
            local metadata = exports['av_laptop']:getMetadata(item,info)
            if metadata and Gangs.Sprays[metadata.gang] then
                if GetMembersCount(metadata.gang) >= Gangs.MinMembersForSpray then
                    TriggerClientEvent('av_gangs:sprayItem',src,metadata.gang)
                else
                    TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['not_enough_members'],"error")
                end
            end
        end)
        ESX.RegisterUsableItem(Gangs.SprayRemover, function(source, item, info)
            local src = source
            local metadata = exports['av_laptop']:getMetadata(item,info)
            if metadata and Gangs.Sprays[metadata.gang] then
                TriggerClientEvent('av_gangs:removerItem',src,metadata.gang)
            end
        end)
    end
end)