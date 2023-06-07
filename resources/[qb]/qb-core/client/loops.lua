
CreateThread(function() 
    while true do
        local sleep = 0
        if LocalPlayer.state.isLoggedIn then
            sleep = (1000 * 60) * QBCore.Config.UpdateInterval
            local hungerRate = 0
            local thirstRate = 0
            if exports["ps-buffs"]:HasBuff("super-hunger") then hungerRate = QBCore.Config.Player.HungerRate/2 else hungerRate = QBCore.Config.Player.HungerRate end
            if exports["ps-buffs"]:HasBuff("super-thirst") then thirstRate = QBCore.Config.Player.ThirstRate/2 else thirstRate = QBCore.Config.Player.ThirstRate end
            TriggerServerEvent('QBCore:UpdatePlayer', hungerRate, thirstRate)
        end
        Wait(sleep)
    end
end) 

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            if (QBCore.PlayerData.metadata['hunger'] <= 0 or QBCore.PlayerData.metadata['thirst'] <= 0) and not (QBCore.PlayerData.metadata['isdead'] or QBCore.PlayerData.metadata["inlaststand"]) then
                local ped = PlayerPedId()
                local currentHealth = GetEntityHealth(ped)
                local decreaseThreshold = math.random(5, 10)
                SetEntityHealth(ped, currentHealth - decreaseThreshold)
            end
        end
        Wait(QBCore.Config.StatusInterval)
    end
end)

