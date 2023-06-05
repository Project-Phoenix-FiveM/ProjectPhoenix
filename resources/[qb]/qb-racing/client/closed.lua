local QBCore = exports['qb-core']:GetCoreObject()
local phasePlates = {}
local start = false
RegisterNetEvent("Pug:client:ToggleCollision")
AddEventHandler("Pug:client:ToggleCollision", function(racerplates)
    if racerplates then
        start = true
        Wait(400)
        table.insert(phasePlates, racerplates)
        local myplate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId()))
        for t,w in pairs(phasePlates) do
            if w == myplate then
                table.remove(phasePlates, t)
            end
        end
    end
    while start do
        Wait(5)
        for k, v in pairs(GetGamePool('CVehicle')) do
            for c, j in pairs(phasePlates) do
                if GetVehicleNumberPlateText(v) == j then
                    if DoesEntityExist(v) then
                        local veh = GetVehiclePedIsIn(PlayerPedId())
                        local vehCoords = GetEntityCoords(v)
                        local pos = GetEntityCoords(PlayerPedId())
                        local close = #(pos - vehCoords) <= 20.0
                        if close then
                            SetEntityNoCollisionEntity(v, veh, false)
                            DisableCamCollisionForEntity(v)
                        end
                    end
                end
            end
        end
    end
    if start then
    else
        for k, v in pairs(GetGamePool('CVehicle')) do
            for c, j in pairs(phasePlates) do
                if GetVehicleNumberPlateText(v) == j then
                    local veh = GetVehiclePedIsIn(PlayerPedId())
                    SetEntityNoCollisionEntity(v, veh, true)
                end
            end
        end
    end
end)
function StartFalse()
    start = false
end
function nilplates()
    phasePlates = {}
end
function ClosedRaceInfo()
    local info = {
        yes = start,
    }
    return info
end
Citizen.CreateThread(function()
    while true do

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        if OpenRaceInfo().data.RaceName ~= nil then
            if OpenRaceInfo().data.Started then
                local cp = 0
                if OpenRaceInfo().data.CurrentCheckpoint + 1 > #OpenRaceInfo().data.Checkpoints then
                    cp = 1
                else
                    cp = OpenRaceInfo().data.CurrentCheckpoint + 1
                end
                local data = OpenRaceInfo().data.Checkpoints[cp]
                local CheckpointDistance = #(pos - vector3(data.coords.x, data.coords.y, data.coords.z))
                local MaxDistance = GetMaxDistance(OpenRaceInfo().data.Checkpoints[cp].offset)

                if CheckpointDistance < MaxDistance then
                    if OpenRaceInfo().data.TotalLaps == 0 then
                        if OpenRaceInfo().data.CurrentCheckpoint + 1 < #OpenRaceInfo().data.Checkpoints then
                            print"this is here1"
                            OpenRaceInfo().data.CurrentCheckpoint = OpenRaceInfo().data.CurrentCheckpoint + 1
                            RemoveBlip(CurrentBlip)
                            -- SetNewWaypoint(CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1].coords.x, CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1].coords.y)
                            TriggerServerEvent('qb-lapraces:server:UpdateRacerData', OpenRaceInfo().data.RaceId, OpenRaceInfo().data.CurrentCheckpoint, OpenRaceInfo().data.Lap, false)
                            DoPilePfx()
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                            SetBlipScale(OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint].blip, 0.6)
                            SetBlipScale(OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 1].blip, 1.2)
                            if OpenRaceInfo().data.CurrentCheckpoint + 2 > #OpenRaceInfo().data.Checkpoints then
                                RemoveBlip(CurrentBlip)
                                SetBlipRoute(OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 1].blip, true)
                                SetBlipRouteColour(OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 1].blip, 27)
                                print"removed blip if"
                            else
                                CurrentBlip = AddBlipForCoord(OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 2].coords.x, CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 2].coords.y)
                                SetBlipColour(CurrentBlip, 27)
                                SetBlipRoute(CurrentBlip, true)
                                SetBlipRouteColour(CurrentBlip, 27)
                            end
                        else -- spints else statement
                            print"this is here2"
                            DoPilePfx()
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                            OpenRaceInfo().data.CurrentCheckpoint = OpenRaceInfo().data.CurrentCheckpoint + 1
                            TriggerServerEvent('qb-lapraces:server:UpdateRacerData', OpenRaceInfo().data.RaceId, OpenRaceInfo().data.CurrentCheckpoint, OpenRaceInfo().data.Lap, true)
                            RemoveBlip(CurrentBlip)
                            FinishRace()
                        end
                    else
                        if OpenRaceInfo().data.CurrentCheckpoint + 1 > #OpenRaceInfo().data.Checkpoints then
                            if OpenRaceInfo().data.Lap + 1 > OpenRaceInfo().data.TotalLaps then
                                print"this is here3"
                                DoPilePfx()
                                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                OpenRaceInfo().data.CurrentCheckpoint = OpenRaceInfo().data.CurrentCheckpoint + 1
                                TriggerServerEvent('qb-lapraces:server:UpdateRacerData', OpenRaceInfo().data.RaceId, OpenRaceInfo().data.CurrentCheckpoint, OpenRaceInfo().data.Lap, true)
                                RemoveBlip(CurrentBlip)
                                FinishRace()
                            else
                                print"this is here4" -- this is when you start a new lap and begin to head to checkpoint 1
                                DoPilePfx()
                                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                if OpenRaceInfo().data.RaceTime < OpenRaceInfo().data.BestLap then
                                    OpenRaceInfo().data.BestLap = OpenRaceInfo().data.RaceTime
                                elseif OpenRaceInfo().data.BestLap == 0 then
                                    OpenRaceInfo().data.BestLap = OpenRaceInfo().data.RaceTime
                                end
                                OpenRaceInfo().data.RaceTime = 0
                                OpenRaceInfo().data.Lap = OpenRaceInfo().data.Lap + 1
                                OpenRaceInfo().data.CurrentCheckpoint = 1
                                SetBlipRouteColour(OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 1].blip, 27)
                                -- SetNewWaypoint(CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1].coords.x, CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1].coords.y)
                                TriggerServerEvent('qb-lapraces:server:UpdateRacerData', OpenRaceInfo().data.RaceId, OpenRaceInfo().data.CurrentCheckpoint, OpenRaceInfo().data.Lap, false)
                                RemoveBlip(CurrentBlip) -- removes the blip of last checkpoint that just went through
                                if OpenRaceInfo().data.CurrentCheckpoint + 1 < #OpenRaceInfo().data.Checkpoints then
                                    CurrentBlip = AddBlipForCoord(CurrentRaceData.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 2].coords.x, OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 2].coords.y)
                                    SetBlipColour(CurrentBlip, 27)
                                    SetBlipRoute(CurrentBlip, true)
                                    SetBlipRouteColour(CurrentBlip, 27)
                                else
                                    RemoveBlip(CurrentBlip) -- removes the blip at last checkpoint of the race so dont get error
                                end
                            end
                        else
                            OpenRaceInfo().data.CurrentCheckpoint = OpenRaceInfo().data.CurrentCheckpoint + 1
                            if OpenRaceInfo().data.CurrentCheckpoint ~= #OpenRaceInfo().data.Checkpoints then
                                print"this is here5"
                                -- SetNewWaypoint(CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1].coords.x, CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1].coords.y)
                                TriggerServerEvent('qb-lapraces:server:UpdateRacerData', OpenRaceInfo().data.RaceId, OpenRaceInfo().data.CurrentCheckpoint, OpenRaceInfo().data.Lap, false)
                                SetBlipScale(OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint].blip, 0.6)
                                SetBlipScale(OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 1].blip, 1.2)
                                SetBlipColour(OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 1].blip, 27)
                                RemoveBlip(CurrentBlip)
                                if OpenRaceInfo().data.CurrentCheckpoint + 1 < #OpenRaceInfo().data.Checkpoints then
                                    RemoveBlip(CurrentBlip)
                                    CurrentBlip = AddBlipForCoord(OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 2].coords.x, OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint + 2].coords.y)
                                    SetBlipColour(CurrentBlip, 27)
                                    SetBlipRoute(CurrentBlip, true)
                                    SetBlipRouteColour(CurrentBlip, 27)
                                else
                                    RemoveBlip(CurrentBlip)
                                    CurrentBlip = AddBlipForCoord(OpenRaceInfo().data.Checkpoints[1].coords.x, OpenRaceInfo().data.Checkpoints[1].coords.y)
                                    SetBlipColour(CurrentBlip, 27)
                                    SetBlipRoute(CurrentBlip, true)
                                    SetBlipRouteColour(CurrentBlip, 27) -- removes the blip at last checkpoint of the race so dont get error
                                end
                                -- this section is the next checkpoint after you go through one
                            else
                                print"this is here6" -- this is when you are on the last checkpoint and begin to head to the finish line but there are more than 1 lap
                                -- SetNewWaypoint(CurrentRaceData.Checkpoints[1].coords.x, CurrentRaceData.Checkpoints[1].coords.y)
                                TriggerServerEvent('qb-lapraces:server:UpdateRacerData', OpenRaceInfo().data.RaceId, OpenRaceInfo().data.CurrentCheckpoint, OpenRaceInfo().data.Lap, false)
                                SetBlipScale(OpenRaceInfo().data.Checkpoints[#OpenRaceInfo().data.Checkpoints].blip, 0.6)
                                SetBlipScale(OpenRaceInfo().data.Checkpoints[1].blip, 1.0)
                                SetBlipColour(OpenRaceInfo().data.Checkpoints[1].blip, 27)
                                RemoveBlip(CurrentBlip)
                                if OpenRaceInfo().data.Lap == OpenRaceInfo().data.TotalLaps then
                                    RemoveBlip(CurrentBlip)
                                    SetBlipRoute(OpenRaceInfo().data.Checkpoints[1].blip, true)
                                    SetBlipRouteColour(OpenRaceInfo().data.Checkpoints[1].blip, 27)
                                else
                                    RemoveBlip(CurrentBlip)
                                    CurrentBlip = AddBlipForCoord(OpenRaceInfo().data.Checkpoints[2].coords.x, OpenRaceInfo().data.Checkpoints[2].coords.y)
                                    SetBlipColour(CurrentBlip, 27)
                                    SetBlipRoute(CurrentBlip, true)
                                    SetBlipRouteColour(CurrentBlip, 27)
                                end
                            end
                            DoPilePfx()
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        end
                    end
                end
            else
                local data = OpenRaceInfo().data.Checkpoints[OpenRaceInfo().data.CurrentCheckpoint]
                -- DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'Ga hier staan')
                DrawMarker(4, data.coords.x, data.coords.y, data.coords.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.9, 1.5, 1.5, 255, 255, 255, 255, 0, 1, 0, 0, 0, 0, 0)
            end
        else
            Wait(1000)
        end

        Wait(3)
    end
end)