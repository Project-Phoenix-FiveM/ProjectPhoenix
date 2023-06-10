ESX, QBCore = nil, nil

CreateThread(function()
    if Config.Framework == "QBCore" then
        QBCore = exports['qb-core']:GetCoreObject()
    elseif Config.Framework == "ESX" then
        ESX = exports["es_extended"]:getSharedObject()
    else
        print('[^1 WRONG FRAMEWORK, VERIFY YOUR CONFIG]')
    end
end)

RegisterCommand(Config.AdminStorageCommand, function(source,_)
    local src = source
    if exports['av_laptop']:getPermission(src, Config.AdminRank) then
        TriggerClientEvent('av_realestate:adminCreator',src,"storages")
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'], Lang['no_permission'])
    end
end)

RegisterCommand(Config.AdminMotelsCommand, function(source,_)
    local src = source
    if exports['av_laptop']:getPermission(src, Config.AdminRank) then
        TriggerClientEvent('av_realestate:motelCreator',src,"motels")
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'], Lang['no_permission'])
    end
end)