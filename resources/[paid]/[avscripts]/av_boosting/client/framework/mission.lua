inMission = false
missionBlip = nil
closeToZone = false
local vehicle = nil

RegisterNetEvent('av_boosting:search', function(type,contract)
    if inMission then return end
    inMission = true
    local vehicleCoords = {}
    if contract.class == "S" or contract.class == "S+" then
        local table = math.random(1,#Config.Spawns[2])
        vehicleCoords = Config.Spawns[2][table]
    else
        local table = math.random(1,#Config.Spawns[1])
        vehicleCoords = Config.Spawns[1][table]
    end
    missionBlip = AddBlipForRadius(vehicleCoords[1] + math.random(-100, 100), vehicleCoords[2] + math.random(-100, 100), vehicleCoords[3], 250.0)
    SetBlipAlpha(missionBlip, 150)
    SetBlipHighDetail(missionBlip, true)
    SetBlipColour(missionBlip, 7)
    SetBlipAsShortRange(missionBlip, true)
--    SetNewWaypoint(vehicleCoords[1], vehicleCoords[2])
    CreateThread(function()
        while not closeToZone do
            if not missionBlip then
                break
            end
            local dist = #(GetEntityCoords(PlayerPedId()) - vector3(vehicleCoords[1], vehicleCoords[2], vehicleCoords[3]))
            if dist < 100 then
                closeToZone = true
                local hash = GetHashKey(contract.name)
                lib.requestModel(hash)
                vehicle = CreateVehicle(hash, vehicleCoords[1], vehicleCoords[2], vehicleCoords[3], vehicleCoords[4], true, true)
                SetEntityAsMissionEntity(vehicle)
                SetVehicleNumberPlateText(vehicle,contract.plates)
                if contract.class == "A+" or contract.class == "S+" then
                    Tuning(vehicle)
                end
                SetFuel(vehicle)
                local netId = 0
                local count = 0
                while netId == 0 do
                    netId = NetworkGetNetworkIdFromEntity(vehicle)
                    Wait(500)
                    count += 1
                    if count == 20 then
                        break
                    end
                end
                if netId ~= 0 then
--                    print("[boosting] Vehicle created")
                    SetVehicleDoorsLockedForAllPlayers(vehicle,true)
                    TriggerServerEvent('av_boosting:setStateBag',netId,type,contract.class,contract.plates)
                else
                    print('[ERROR] Something went wrong with this contract vehicle, cancel to receive your crypto back.')
                end
                SetModelAsNoLongerNeeded(hash)
            end
            Wait(1000)
        end
        closeToZone = false
    end)
end)