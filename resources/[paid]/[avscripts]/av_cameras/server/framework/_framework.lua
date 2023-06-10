CreateThread(function()
    if Cams.Framework == "QBCore" then
        QBCore = exports['qb-core']:GetCoreObject()
        QBCore.Functions.CreateUseableItem(Cams.ItemName, function(source, item)
            TriggerClientEvent('av_cameras:install',source)
        end)
    elseif Cams.Framework == "ESX" then
        ESX.RegisterUsableItem(Cams.ItemName, function(source)
            TriggerClientEvent('av_cameras:install',source)
        end)
    end
end)