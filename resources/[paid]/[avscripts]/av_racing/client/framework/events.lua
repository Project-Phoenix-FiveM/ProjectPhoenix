AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ClearGpsMultiRoute()
        DeleteAllCheckpoints()
        if inCreator then
            lib.hideTextUI()
        end
        EndGhostLoop()
    end
end)

RegisterNetEvent('av_racing:markGPS', function(coords)
    SetNewWaypoint(coords.x, coords.y)
end)

RegisterNetEvent('av_racing:dnf', function()
    FinishRace()
end)

RegisterNetEvent('av_racing:wipe', function(reason)
    FinishRace()
    if reason then
        TriggerEvent('av_laptop:notification',Lang['app_name'], reason, 'inform')
    end
end)