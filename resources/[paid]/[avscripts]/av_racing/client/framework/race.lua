startTime = 0
lapStartTime = 0

RegisterNetEvent("av_racing:start", function(raceInfo)
    local checkpoints = raceInfo['checkpoints']
    local class = raceInfo['class']
    local laps = raceInfo['laps']
    checkpoints = json.decode(checkpoints)
    if isClose(checkpoints[1]['coords']) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            local myClass = getClass(vehicle)
            if class == "All" or class == myClass then
                local model = GetEntityModel(vehicle)
                model = GetLabelText(GetDisplayNameFromVehicleModel(model))
                local netId = NetworkGetNetworkIdFromEntity(vehicle)
                if GetPedVehicleSeat(PlayerPedId()) == -1 then
                    TriggerServerEvent('av_racing:registerVehicle',netId,true)
                end
                TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['countdown'],'success')
                FreezeEntityPosition(vehicle,true)
                if raceInfo['phasing'] then
                    CreateThread(function()
                        GhostLoop()
                    end)
                end
                Wait(10000)
                SendNUIMessage({
                    action = "countdown"
                })
                Wait(3000)
                lapStartTime = GetGameTimer()
                startTime = GetGameTimer()
                handleFlare(1)
                FreezeEntityPosition(vehicle,false)
                CurrentRaceData.Started = true
                CurrentRaceData.TotalRacers = raceInfo['numRacers']
                CurrentRaceData.VehicleModel = model
            else
                TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['wrong_vehicle_class'],'error')
            end
        else
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['not_in_vehicle'],"error")
            TriggerEvent('av_racing:wipe')
        end
    else
        lib.callback('av_racing:quitRace', false, function()
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['out_of_range'],"error")
            TriggerEvent('av_racing:wipe')
        end, raceInfo['trackid'])
    end
end)