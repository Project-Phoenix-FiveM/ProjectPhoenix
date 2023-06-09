currentCops = 0

CreateThread(function()
    if not Corners.UsingAVBoosting then
        while true do
            if Corners.Framework == "ESX" then
                local xPlayers = ESX.GetExtendedPlayers("job", Corners.PoliceJobName)
                if xPlayers then
                    for i = 1, #xPlayers do
                        currentCops += 1
                    end
                end
                TriggerClientEvent("police:SetCopCount", -1, currentCops)
            end
            Wait(5 * 60 * 1000) -- Sync cops count every 5 minutes
        end
    end
end)