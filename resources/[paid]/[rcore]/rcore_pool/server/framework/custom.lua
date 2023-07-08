CreateThread(function()
    if Config.Framework == 3 or Config.Framework == 0 then
        UseFrameworkNotification = false
        
        PlayerHasMoney = function(serverId, amount)
            print("Checking has money", serverId, amount)
            return true
        end

        PlayerTakeMoney = function(serverId, amount)
            print("Deducting money", serverId, amount)
        end
    end
end)
