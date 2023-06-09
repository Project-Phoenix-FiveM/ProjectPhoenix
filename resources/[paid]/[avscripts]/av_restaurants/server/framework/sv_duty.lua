RegisterServerEvent('av_restaurant:duty', function()
    local src = source
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            local status = Player.PlayerData.job.onduty
            status = not status
            Player.Functions.SetJobDuty(status)
            if status then
                TriggerClientEvent('av_restaurant:notification',src,'You are ON Duty')
            else
                TriggerClientEvent('av_restaurant:notification',src,'You are OFF Duty')
            end
        end
    end
end)