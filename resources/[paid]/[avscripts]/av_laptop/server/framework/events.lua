RegisterServerEvent('av_laptop:alertOwner', function(serial, coords)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayerByCitizenId(serial)
        if Player then
            TriggerClientEvent('av_laptop:alert', Player.PlayerData.source, Lang['alert_description'], coords)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromIdentifier(serial)
        if xPlayer then
            TriggerClientEvent('av_laptop:alert', xPlayer.source, Lang['alert_description'], coords)
        end
    end
end)

RegisterServerEvent('av_laptop:alertCops', function(msg,coords)
    if Config.Framework == "QBCore" then
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player ~= nil then
                if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                    TriggerClientEvent('av_laptop:alert', Player.PlayerData.source, msg, coords)
                end
            end
        end
    elseif Config.Framework == "ESX" then
        local xPlayers = ESX.GetExtendedPlayers('job', 'police')
        for i=1, #(xPlayers) do 
            local xPlayer = xPlayers[i]
            TriggerClientEvent('av_laptop:alert', xPlayer.source, msg, coords)
        end
    end
end)

-- Triggered when script is restarted to sync laptop data
CreateThread(function()
    Wait(500)
    TriggerClientEvent('av_laptop:playerSpawn',-1)
end)