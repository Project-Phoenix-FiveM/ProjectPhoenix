local QBCore = exports['qb-core']:GetCoreObject()

RaceData = {
    InCreator = false,
    InRace = false,
    ClosestCheckpoint = 0,
}

CreatorData = {
    RaceName = nil,
    Checkpoints = {},
    TireDistance = 3.0,
    ConfirmDelete = false,
}

CurrentRaceData = {
    RaceId = nil,
    RaceName = nil,
    Checkpoints = {},
    Started = false,
    CurrentCheckpoint = nil,
    TotalLaps = 0,
    Lap = 0,
}

local Countdown = 10

function IsInRace()
    local retval = false
    if RaceData.InRace then
        retval = true
    end
    return retval
end

function IsInEditor()
    local retval = false
    if RaceData.InCreator then
        retval = true
    end
    return retval
end

RegisterNetEvent('qb-lapraces:client:StartRaceEditor')
AddEventHandler('qb-lapraces:client:StartRaceEditor', function(RaceName)
    if not RaceData.InCreator then
        CreatorData.RaceName = RaceName
        RaceData.InCreator = true
        CreatorUI()
        CreatorLoop()
    else
        QBCore.Functions.Notify('You are already making a race.', 'error')
    end 
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function GetClosestCheckpoint()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for id, house in pairs(CreatorData.Checkpoints) do
        if current ~= nil then
            if #(pos - vector3(CreatorData.Checkpoints[id].coords.x, CreatorData.Checkpoints[id].coords.y, CreatorData.Checkpoints[id].coords.z)) < dist then
                current = id
                dist = #(pos - vector3(CreatorData.Checkpoints[id].coords.x, CreatorData.Checkpoints[id].coords.y, CreatorData.Checkpoints[id].coords.z))
            end
        else
            dist = #(pos - vector3(CreatorData.Checkpoints[id].coords.x, CreatorData.Checkpoints[id].coords.y, CreatorData.Checkpoints[id].coords.z))
            current = id
        end
    end
    RaceData.ClosestCheckpoint = current
end

function CreatorUI()
    Citizen.CreateThread(function()
        while true do
            if RaceData.InCreator then
                SendNUIMessage({
                    action = "Update",
                    type = "creator",
                    data = CreatorData,
                    racedata = RaceData,
                    active = true,
                })
            else
                SendNUIMessage({
                    action = "Update",
                    type = "creator",
                    data = CreatorData,
                    racedata = RaceData,
                    active = false,
                })
                break
            end
            Wait(200)
        end
    end)
end

function CreatorLoop()
    Citizen.CreateThread(function()
        while RaceData.InCreator do
            local PlayerPed = PlayerPedId()
            local PlayerVeh = GetVehiclePedIsIn(PlayerPed)

            if PlayerVeh ~= 0 then
                if IsControlJustPressed(0, 161) or IsDisabledControlJustPressed(0, 161) then
                    AddCheckpoint()
                end

                if IsControlJustPressed(0, 162) or IsDisabledControlJustPressed(0, 162) then
                    if CreatorData.Checkpoints ~= nil and next(CreatorData.Checkpoints) ~= nil then
                        DeleteCheckpoint()
                    else
                        QBCore.Functions.Notify('You have not placed any checkpoints yet..', 'error')
                    end
                end

                if IsControlJustPressed(0, 311) or IsDisabledControlJustPressed(0, 311) then
                    if CreatorData.Checkpoints ~= nil and #CreatorData.Checkpoints >= 2 then
                        SaveRace()
                    else
                        QBCore.Functions.Notify('You must have at least 10 checkpoints', 'error')
                    end
                end

                if IsControlJustPressed(0, 40) or IsDisabledControlJustPressed(0, 40) then
                    if CreatorData.TireDistance + 1.0 ~= 32.0 then
                        CreatorData.TireDistance = CreatorData.TireDistance + 1.0
                    else
                        QBCore.Functions.Notify('You can not go higher than 15')
                    end
                end

                if IsControlJustPressed(0, 39) or IsDisabledControlJustPressed(0, 39) then
                    if CreatorData.TireDistance - 1.0 ~= 1.0 then
                        CreatorData.TireDistance = CreatorData.TireDistance - 1.0
                    else
                        QBCore.Functions.Notify('You cannot go lower than 2')
                    end
                end
            else
                local coords = GetEntityCoords(PlayerPedId())
                DrawText3Ds(coords.x, coords.y, coords.z, 'You must be in a vehicle')
            end

            if IsControlJustPressed(0, 163) or IsDisabledControlJustPressed(0, 163) then
                if not CreatorData.ConfirmDelete then
                    CreatorData.ConfirmDelete = true
                    QBCore.Functions.Notify('Press [9] again to confirm', 'error', 5000)
                else
                    for id, CheckpointData in pairs(CreatorData.Checkpoints) do
                        if CheckpointData.blip ~= nil then
                            RemoveBlip(CheckpointData.blip)
                        end
                    end

                    for id,_ in pairs(CreatorData.Checkpoints) do
                        if CreatorData.Checkpoints[id].pileleft ~= nil then
                            local coords = CreatorData.Checkpoints[id].offset.left
                            local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 8.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
                            DeleteObject(Obj)
                            ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
                            CreatorData.Checkpoints[id].pileleft = nil
                        end

                        if CreatorData.Checkpoints[id].pileright ~= nil then
                            local coords = CreatorData.Checkpoints[id].offset.right
                            local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 8.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
                            DeleteObject(Obj)
                            ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
                            CreatorData.Checkpoints[id].pileright = nil
                        end
                    end

                    RaceData.InCreator = false
                    CreatorData.RaceName = nil
                    CreatorData.Checkpoints = {}
                    QBCore.Functions.Notify('Race-editor canceled!', 'error')
                    CreatorData.ConfirmDelete = false
                end
            end
            Wait(3)
        end
    end)
end

function SaveRace()
    local RaceDistance = 0

    for k, v in pairs(CreatorData.Checkpoints) do
        if k + 1 <= #CreatorData.Checkpoints then
            local checkpointdistance = #(vector3(v.coords.x, v.coords.y, v.coords.z) - vector3(CreatorData.Checkpoints[k + 1].coords.x, CreatorData.Checkpoints[k + 1].coords.y, CreatorData.Checkpoints[k + 1].coords.z))
            RaceDistance = RaceDistance + checkpointdistance
        end
    end

    CreatorData.RaceDistance = RaceDistance

    TriggerServerEvent('qb-lapraces:server:SaveRace', CreatorData)

    QBCore.Functions.Notify('Race: '..CreatorData.RaceName..' is saved!', 'success')

    for id,_ in pairs(CreatorData.Checkpoints) do
        if CreatorData.Checkpoints[id].blip ~= nil then
            RemoveBlip(CreatorData.Checkpoints[id].blip)
            CreatorData.Checkpoints[id].blip = nil
        end
        if CreatorData.Checkpoints[id] ~= nil then
            if CreatorData.Checkpoints[id].pileleft ~= nil then
                local coords = CreatorData.Checkpoints[id].offset.left
                local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
                DeleteObject(Obj)
                ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
                CreatorData.Checkpoints[id].pileleft = nil
            end
            if CreatorData.Checkpoints[id].pileright ~= nil then
                local coords = CreatorData.Checkpoints[id].offset.right
                local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
                DeleteObject(Obj)
                ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
                CreatorData.Checkpoints[id].pileright = nil
            end
        end
    end

    RaceData.InCreator = false
    CreatorData.RaceName = nil
    CreatorData.Checkpoints = {}
end

function AddCheckpoint()
    local PlayerPed = PlayerPedId()
    local PlayerPos = GetEntityCoords(PlayerPed)
    local PlayerVeh = GetVehiclePedIsIn(PlayerPed)
    local Offset = {
        left = {
            x = (GetOffsetFromEntityInWorldCoords(PlayerVeh, -CreatorData.TireDistance, 0.0, 0.0)).x,
            y = (GetOffsetFromEntityInWorldCoords(PlayerVeh, -CreatorData.TireDistance, 0.0, 0.0)).y,
            z = (GetOffsetFromEntityInWorldCoords(PlayerVeh, -CreatorData.TireDistance, 0.0, 0.0)).z,
        },
        right = {
            x = (GetOffsetFromEntityInWorldCoords(PlayerVeh, CreatorData.TireDistance, 0.0, 0.0)).x,
            y = (GetOffsetFromEntityInWorldCoords(PlayerVeh, CreatorData.TireDistance, 0.0, 0.0)).y,
            z = (GetOffsetFromEntityInWorldCoords(PlayerVeh, CreatorData.TireDistance, 0.0, 0.0)).z,
        }
    }

    table.insert(CreatorData.Checkpoints, {
        coords = {
            x = PlayerPos.x,
            y = PlayerPos.y,
            z = PlayerPos.z,
        },
        offset = Offset,
    })


    for id, CheckpointData in pairs(CreatorData.Checkpoints) do
        if CheckpointData.blip ~= nil then
            RemoveBlip(CheckpointData.blip)
        end

        CheckpointData.blip = AddBlipForCoord(CheckpointData.coords.x, CheckpointData.coords.y, CheckpointData.coords.z)
        
        SetBlipSprite(CheckpointData.blip, 1)
        SetBlipDisplay(CheckpointData.blip, 4)
        SetBlipScale(CheckpointData.blip, 0.6)
        SetBlipAsShortRange(CheckpointData.blip, true)
        SetBlipColour(CheckpointData.blip, 26)
        ShowNumberOnBlip(CheckpointData.blip, id)
        SetBlipShowCone(CheckpointData.blip, false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Checkpoint: "..id)
        EndTextCommandSetBlipName(CheckpointData.blip)
    end
end

function DeleteCheckpoint()
    local NewCheckpoints = {}
    if RaceData.ClosestCheckpoint ~= 0 then
        if CreatorData.Checkpoints[RaceData.ClosestCheckpoint] ~= nil then
            if CreatorData.Checkpoints[RaceData.ClosestCheckpoint].blip ~= nil then
                RemoveBlip(CreatorData.Checkpoints[RaceData.ClosestCheckpoint].blip)
                CreatorData.Checkpoints[RaceData.ClosestCheckpoint].blip = nil
            end
            if CreatorData.Checkpoints[RaceData.ClosestCheckpoint].pileleft ~= nil then
                local coords = CreatorData.Checkpoints[RaceData.ClosestCheckpoint].offset.left
                local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
                DeleteObject(Obj)
                ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
                CreatorData.Checkpoints[RaceData.ClosestCheckpoint].pileleft = nil
            end
            if CreatorData.Checkpoints[RaceData.ClosestCheckpoint].pileright ~= nil then
                local coords = CreatorData.Checkpoints[RaceData.ClosestCheckpoint].offset.right
                local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
                DeleteObject(Obj)
                ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
                CreatorData.Checkpoints[RaceData.ClosestCheckpoint].pileright = nil
            end

            for id, data in pairs(CreatorData.Checkpoints) do
                if id ~= RaceData.ClosestCheckpoint then
                    table.insert(NewCheckpoints, data)
                end
            end
            CreatorData.Checkpoints = NewCheckpoints
        else
            QBCore.Functions.Notify('You cant go to fast', 'error')
        end
    else
        QBCore.Functions.Notify('You cant go too fast', 'error')
    end
end

RegisterNetEvent('qb-lapraces:client:UpdateRaceRacerData')
AddEventHandler('qb-lapraces:client:UpdateRaceRacerData', function(RaceId, RaceData)
    if (CurrentRaceData.RaceId ~= nil) and CurrentRaceData.RaceId == RaceId then
        CurrentRaceData.Racers = RaceData.Racers
    end
end)

Citizen.CreateThread(function()
    while true do
        if RaceData.InCreator then
            local PlayerPed = PlayerPedId()
            local PlayerVeh = GetVehiclePedIsIn(PlayerPed)

            if PlayerVeh ~= 0 then
                local Offset = {
                    left = {
                        x = (GetOffsetFromEntityInWorldCoords(PlayerVeh, -CreatorData.TireDistance, 0.0, 0.0)).x,
                        y = (GetOffsetFromEntityInWorldCoords(PlayerVeh, -CreatorData.TireDistance, 0.0, 0.0)).y,
                        z = (GetOffsetFromEntityInWorldCoords(PlayerVeh, -CreatorData.TireDistance, 0.0, 0.0)).z,
                    },
                    right = {
                        x = (GetOffsetFromEntityInWorldCoords(PlayerVeh, CreatorData.TireDistance, 0.0, 0.0)).x,
                        y = (GetOffsetFromEntityInWorldCoords(PlayerVeh, CreatorData.TireDistance, 0.0, 0.0)).y,
                        z = (GetOffsetFromEntityInWorldCoords(PlayerVeh, CreatorData.TireDistance, 0.0, 0.0)).z,
                    }
                }

                DrawText3Ds(Offset.left.x, Offset.left.y, Offset.left.z, 'Checkpoint L')
                DrawText3Ds(Offset.right.x, Offset.right.y, Offset.right.z, 'Checkpoint R')
            end
        else
            Wait(1000)
        end
        Wait(3)
    end
end)

function SetupPiles()
    for k, v in pairs(CreatorData.Checkpoints) do
        if CreatorData.Checkpoints[k].pileleft == nil then
            ClearAreaOfObjects(v.offset.left.x, v.offset.left.y, v.offset.left.z, 50.0, 0)
            CreatorData.Checkpoints[k].pileleft = CreateObject(GetHashKey("prop_offroad_tyres02"), v.offset.left.x, v.offset.left.y, v.offset.left.z, 0, 0, 0)
            PlaceObjectOnGroundProperly(CreatorData.Checkpoints[k].pileleft)
            -- FreezeEntityPosition(CreatorData.Checkpoints[k].pileleft, 1)
            SetEntityAsMissionEntity(CreatorData.Checkpoints[k].pileleft, 1, 1)
        end

        if CreatorData.Checkpoints[k].pileright == nil then
            ClearAreaOfObjects(v.offset.right.x, v.offset.right.y, v.offset.right.z, 50.0, 0)
            CreatorData.Checkpoints[k].pileright = CreateObject(GetHashKey("prop_offroad_tyres02"), v.offset.right.x, v.offset.right.y, v.offset.right.z, 0, 0, 0)
            PlaceObjectOnGroundProperly(CreatorData.Checkpoints[k].pileright)
            -- FreezeEntityPosition(CreatorData.Checkpoints[k].pileleft, 1)
            SetEntityAsMissionEntity(CreatorData.Checkpoints[k].pileleft, 1, 1)
        end
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(CreatorData.Checkpoints) do
            if CreatorData.Checkpoints[k].pileleft ~= nil then
                local coords = CreatorData.Checkpoints[k].offset.right
                local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
                DeleteObject(Obj)
                ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
                CreatorData.Checkpoints[k].pileright = nil
            end
            if CreatorData.Checkpoints[k].pileright ~= nil then
                local coords = CreatorData.Checkpoints[k].offset.right
                local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
                DeleteObject(Obj)
                ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
                CreatorData.Checkpoints[k].pileright = nil
            end
        end

        for k, v in pairs(CurrentRaceData.Checkpoints) do
            if CurrentRaceData.Checkpoints[k] ~= nil then
                if CurrentRaceData.Checkpoints[k].pileleft ~= nil then
                    local coords = CurrentRaceData.Checkpoints[k].offset.right
                    local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
                    DeleteObject(Obj)
                    ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
                    CurrentRaceData.Checkpoints[k].pileright = nil
                end
                if CurrentRaceData.Checkpoints[k].pileright ~= nil then
                    local coords = CurrentRaceData.Checkpoints[k].offset.right
                    local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
                    DeleteObject(Obj)
                    ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
                    CurrentRaceData.Checkpoints[k].pileright = nil
                end
            end
        end
    end
end)

RegisterNetEvent('qb-lapraces:client:JoinRace')
AddEventHandler('qb-lapraces:client:JoinRace', function(Data, Laps)
    if not RaceData.InRace then
        RaceData.InRace = true
        SetupRace(Data, Laps)
        TriggerServerEvent('qb-lapraces:server:UpdateRaceState', CurrentRaceData.RaceId, false, true)
    else
        QBCore.Functions.Notify('Youre already in a race..', 'error')
    end
end)

RegisterNetEvent('qb-lapraces:client:LeaveRace')
AddEventHandler('qb-lapraces:client:LeaveRace', function(data)
    QBCore.Functions.Notify('You have completed the race!')
    for k, v in pairs(CurrentRaceData.Checkpoints) do
        if CurrentRaceData.Checkpoints[k].blip ~= nil then
            RemoveBlip(CurrentRaceData.Checkpoints[k].blip)
            RemoveBlip(CurrentBlip)
            CurrentRaceData.Checkpoints[k].blip = nil
        end
        if CurrentRaceData.Checkpoints[k].pileleft ~= nil then
            local coords = CurrentRaceData.Checkpoints[k].offset.left
            local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
            DeleteObject(Obj)
            ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
            CurrentRaceData.Checkpoints[k].pileleft = nil
        end
        if CurrentRaceData.Checkpoints[k].pileright ~= nil then
            local coords = CurrentRaceData.Checkpoints[k].offset.right
            local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
            DeleteObject(Obj)
            ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
            CurrentRaceData.Checkpoints[k].pileright = nil
        end
    end
    CurrentRaceData.RaceName = nil
    CurrentRaceData.Checkpoints = {}
    CurrentRaceData.Started = false
    CurrentRaceData.CurrentCheckpoint = 0
    CurrentRaceData.TotalLaps = 0
    CurrentRaceData.Lap = 0
    CurrentRaceData.RaceTime = 0
    CurrentRaceData.TotalTime = 0
    CurrentRaceData.BestLap = 0
    CurrentRaceData.RaceId = nil
    if ClosedRaceInfo().yes then
        StartFalse()
        TriggerEvent("Pug:client:ToggleCollision")
    end
    nilplates()
    RaceData.InRace = false
    FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), false)
end)

local FinishedUITimeout = false

function RaceUI()
    Citizen.CreateThread(function()
        while true do
            if CurrentRaceData.Checkpoints ~= nil and next(CurrentRaceData.Checkpoints) ~= nil then
                if CurrentRaceData.Started then
                    CurrentRaceData.RaceTime = CurrentRaceData.RaceTime + 1
                    CurrentRaceData.TotalTime = CurrentRaceData.TotalTime + 1
                end
                SendNUIMessage({
                    action = "Update",
                    type = "race",
                    data = {
                        CurrentCheckpoint = CurrentRaceData.CurrentCheckpoint,
                        TotalCheckpoints = #CurrentRaceData.Checkpoints,
                        TotalLaps = CurrentRaceData.TotalLaps,
                        CurrentLap = CurrentRaceData.Lap,
                        RaceStarted = CurrentRaceData.Started,
                        RaceName = CurrentRaceData.RaceName,
                        Time = CurrentRaceData.RaceTime,
                        TotalTime = CurrentRaceData.TotalTime,
                        BestLap = CurrentRaceData.BestLap,
                        Position = CurrentRaceData.Position,
                        NumRacers = CurrentRaceData.NumRacers
                    },
                    racedata = RaceData,
                    active = true,
                })
            else
                if not FinishedUITimeout then
                    FinishedUITimeout = true
                    SetTimeout(10000, function()
                        FinishedUITimeout = false
                        SendNUIMessage({
                            action = "Update",
                            type = "race",
                            data = {},
                            racedata = RaceData,
                            active = false,
                        })
                    end)
                end
                break
            end
            Wait(12)
        end
    end)
end

function SetupRace(RaceData, Laps)
    RaceData.RaceId = RaceData.RaceId
    CurrentRaceData = {
        RaceId = RaceData.RaceId,
        Creator = RaceData.Creator,
        RaceName = RaceData.RaceName,
        Checkpoints = RaceData.Checkpoints,
        Started = false,
        CurrentCheckpoint = 1,
        TotalLaps = Laps,
        Lap = 1,
        RaceTime = 0,
        TotalTime = 0,
        BestLap = 0,
        Racers = {},
        Position = 0,
        NumRacers = 0
    }

    for k, v in pairs(CurrentRaceData.Checkpoints) do
        ClearAreaOfObjects(v.offset.left.x, v.offset.left.y, v.offset.left.z, 50.0, 0)
        CurrentRaceData.Checkpoints[k].pileleft = CreateObject(GetHashKey("prop_offroad_tyres02"), v.offset.left.x, v.offset.left.y, v.offset.left.z, 0, 0, 0)
        PlaceObjectOnGroundProperly(CurrentRaceData.Checkpoints[k].pileleft)
        -- FreezeEntityPosition(CurrentRaceData.Checkpoints[k].pileleft, 1)
        SetEntityAsMissionEntity(CurrentRaceData.Checkpoints[k].pileleft, 1, 1)

        ClearAreaOfObjects(v.offset.right.x, v.offset.right.y, v.offset.right.z, 50.0, 0)
        CurrentRaceData.Checkpoints[k].pileright = CreateObject(GetHashKey("prop_offroad_tyres02"), v.offset.right.x, v.offset.right.y, v.offset.right.z, 0, 0, 0)
        PlaceObjectOnGroundProperly(CurrentRaceData.Checkpoints[k].pileright)
        -- FreezeEntityPosition(CurrentRaceData.Checkpoints[k].pileright, 1)
        SetEntityAsMissionEntity(CurrentRaceData.Checkpoints[k].pileright, 1, 1)

        CurrentRaceData.Checkpoints[k].blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(CurrentRaceData.Checkpoints[k].blip, 1)
        SetBlipDisplay(CurrentRaceData.Checkpoints[k].blip, 4)
        SetBlipScale(CurrentRaceData.Checkpoints[k].blip, 0.05)
        SetBlipAsShortRange(CurrentRaceData.Checkpoints[k].blip, true)
        SetBlipColour(CurrentRaceData.Checkpoints[k].blip, 27)
        ShowNumberOnBlip(CurrentRaceData.Checkpoints[k].blip, k)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Checkpoint: "..k)
        EndTextCommandSetBlipName(CurrentRaceData.Checkpoints[k].blip)
    end

    RaceUI()
end

function showNonLoopParticle(dict, particleName, coords, scale, time)
    RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
    end
    UseParticleFxAssetNextCall(dict)
    local particleHandle = StartParticleFxLoopedAtCoord(particleName, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, scale, false, false, false)
    SetParticleFxLoopedColour(particleHandle, 0, 255, 0 ,0)
    return particleHandle
end

function DoPilePfx()
    if CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint] ~= nil then
        local Timeout = 500
        local Size = 2.0
        local left = showNonLoopParticle('core', 'ent_sht_flame', CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint].offset.left, Size)
        local right = showNonLoopParticle('core', 'ent_sht_flame', CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint].offset.right, Size)

        SetTimeout(Timeout, function()
            StopParticleFxLooped(left, false)
            StopParticleFxLooped(right, false)
        end)
    end
end

RegisterNetEvent("Pug:Client:UpdatePosition", function(place, totalcars)
    print'here'
    CurrentRaceData.Position = place
    CurrentRaceData.NumRacers = totalcars
end)

RegisterNetEvent('qb-lapraces:client:RaceCountdown')
AddEventHandler('qb-lapraces:client:RaceCountdown', function()
    TriggerServerEvent('qb-lapraces:server:UpdateRaceState', CurrentRaceData.RaceId, true, false)
    if CurrentRaceData.RaceId ~= nil then
        while Countdown ~= 0 do
            if CurrentRaceData.RaceName ~= nil then
                if Countdown == 10 then
                    QBCore.Functions.Notify('The race will start in 10 seconds', 'error', 2500)
                    PlaySound(-1, "slow", "SHORT_PLAYER_SWITCH_SOUND_SET", 0, 0, 1)
                elseif Countdown <= 5 then
                    QBCore.Functions.Notify(Countdown, 'error', 500)
                    PlaySound(-1, "slow", "SHORT_PLAYER_SWITCH_SOUND_SET", 0, 0, 1)
                end
                Countdown = Countdown - 1
                FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), true), true)
            else
                break
            end
            Wait(1000)
        end
        if CurrentRaceData.RaceName ~= nil then
            -- SetNewWaypoint(CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1].coords.x, CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1].coords.y)
            CurrentBlip = AddBlipForCoord(CurrentRaceData.Checkpoints[3].coords.x, CurrentRaceData.Checkpoints[3].coords.y)
            SetBlipColour(CurrentBlip, 27)
            SetBlipRoute(CurrentBlip, true)
            SetBlipRouteColour(CurrentBlip, 27)
            QBCore.Functions.Notify('GO!', 'success', 1000)
            SetBlipScale(CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1].blip, 1.2)
            SetBlipColour(CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1].blip, 27)
            FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), true), false)
            TriggerServerEvent("Pug:server:collisionOff", CurrentRaceData)
            DoPilePfx()
            CurrentRaceData.Started = true
            Countdown = 10
        else
            FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), true), false)
            Countdown = 10
        end
    else
        QBCore.Functions.Notify('You are not currently in a race..', 'error')
    end
end)

function IsRaceCreator(CitizenId)
    local retval = false
    if CurrentRaceData.RaceId ~= nil then
        if CurrentRaceData.Creator == CitizenId then
            retval = true
        end
    end
    return retval
end

function GetMaxDistance(OffsetCoords)
    local Distance = #(vector3(OffsetCoords.left.x, OffsetCoords.left.y, OffsetCoords.left.z) - vector3(OffsetCoords.right.x, OffsetCoords.right.y, OffsetCoords.right.z))
    local Retval = 7.5
    if Distance > 20.0 then
        Retval = 25.5
    end
    return Retval
end

function OpenRaceInfo()
    local info = {
        data = CurrentRaceData,
    }
    return info
end

function SecondsToClock(seconds)
    local seconds = tonumber(seconds)
    local retval = 0
    if seconds <= 0 then
        retval = "00:00:00";
    else
        hours = string.format("%02.f", math.floor(seconds/3600));
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
        secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
        retval = hours..":"..mins..":"..secs
    end
    return retval
end

function FinishRace()
    TriggerServerEvent('qb-lapraces:server:FinishPlayer', CurrentRaceData, CurrentRaceData.TotalTime, CurrentRaceData.TotalLaps, CurrentRaceData.BestLap)
    if CurrentRaceData.BestLap ~= 0 then
        QBCore.Functions.Notify('Race finished in '..SecondsToClock(CurrentRaceData.TotalTime)..', with the best lap: '..SecondsToClock(CurrentRaceData.BestLap))
    else
        QBCore.Functions.Notify('Race finished in '..SecondsToClock(CurrentRaceData.TotalTime))
    end
    for k, v in pairs(CurrentRaceData.Checkpoints) do
        if CurrentRaceData.Checkpoints[k].blip ~= nil then
            RemoveBlip(CurrentRaceData.Checkpoints[k].blip)
            CurrentRaceData.Checkpoints[k].blip = nil
        end
        if CurrentRaceData.Checkpoints[k].pileleft ~= nil then
            local coords = CurrentRaceData.Checkpoints[k].offset.left
            local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
            DeleteObject(Obj)
            ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
            CurrentRaceData.Checkpoints[k].pileleft = nil
        end
        if CurrentRaceData.Checkpoints[k].pileright ~= nil then
            local coords = CurrentRaceData.Checkpoints[k].offset.right
            local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, GetHashKey("prop_offroad_tyres02"), 0, 0, 0)
            DeleteObject(Obj)
            ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
            CurrentRaceData.Checkpoints[k].pileright = nil
        end
    end
    CurrentRaceData.RaceName = nil
    CurrentRaceData.Checkpoints = {}
    CurrentRaceData.Started = false
    CurrentRaceData.CurrentCheckpoint = 0
    CurrentRaceData.TotalLaps = 0
    CurrentRaceData.Lap = 0
    CurrentRaceData.RaceTime = 0
    CurrentRaceData.TotalTime = 0
    CurrentRaceData.BestLap = 0
    CurrentRaceData.RaceId = nil
    RaceData.InRace = false
    if ClosedRaceInfo().yes then
        StartFalse()
        TriggerEvent("Pug:client:ToggleCollision")
    end
    nilplates()
    return
end

RegisterNetEvent('qb-lapraces:client:PlayerFinishs')
AddEventHandler('qb-lapraces:client:PlayerFinishs', function(RaceId, Place, FinisherData)
    if CurrentRaceData.RaceId ~= nil then
        if CurrentRaceData.RaceId == RaceId then
            QBCore.Functions.Notify(FinisherData.PlayerData.metadata['alias']..' is finished on spot: '..Place, 'error', 3500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if RaceData.InCreator then
            GetClosestCheckpoint()
            SetupPiles()
        end
        Wait(1000)
    end
end)

local ToFarCountdown = 10

RegisterNetEvent('qb-lapraces:client:WaitingDistanceCheck')
AddEventHandler('qb-lapraces:client:WaitingDistanceCheck', function()
    Wait(1000)
    Citizen.CreateThread(function()
        while true do
            if not CurrentRaceData.Started then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                if CurrentRaceData.Checkpoints[1] ~= nil then
                    local cpcoords = CurrentRaceData.Checkpoints[1].coords
                    local dist = #(pos - vector3(cpcoords.x, cpcoords.y, cpcoords.z))
                    if dist > 115.0 then
                        if ToFarCountdown ~= 0 then
                            ToFarCountdown = ToFarCountdown - 1
                            QBCore.Functions.Notify('Go back to the start or you will be kicked from the race: '..ToFarCountdown..'s', 'error', 500)
                        else
                            TriggerServerEvent('qb-lapraces:server:LeaveRace', CurrentRaceData)
                            ToFarCountdown = 10
                            break
                        end
                        Wait(1000)
                    else
                        if ToFarCountdown ~= 10 then
                            ToFarCountdown = 10
                        end
                    end
                end
            else
                break
            end
            Wait(3)
        end
    end)
end)

CreateThread(function() 
    exports['qb-target']:AddBoxZone('limedoor', vector3(720.76, 1292.34, 360.3), 1.4, 1.0, { 
      name = 'limedoor', 
      heading=270,
      --debugPoly=true,
      minZ=359.3,
      maxZ=361.9,
    }, {
    options = { 
        {
			type = "client",
			event = "Pug:client:VPNDeliveryStart",
			icon = "fas fa-car",
			label = "DELIVERY DRIVERS ONLY",
		},
		-- {
		-- 	type = "server",
		-- 	event = "Pug:server:GetRacingSimulator",
		-- 	icon = "fa-brands fa-usb",
		-- 	label = "Get Race Simulator Ɍ250 RNE & $5000 CASH",
		-- },
    },
      distance = 1.0,
    })
end)

RegisterNetEvent("Pug:client:LimeGetAliasusb")
AddEventHandler("Pug:client:LimeGetAliasusb", function()
    exports['qb-target']:RemoveZone("LimeDoor1")
    exports['qb-target']:RemoveZone("LimeDoor2")
    exports['qb-target']:RemoveZone("LimeDoor3")
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['ausb2'], "add")
    TriggerServerEvent('Pug:server:AddUSB')
end)

RegisterNetEvent("Pug:client:VPNDeliveryStart")
AddEventHandler("Pug:client:VPNDeliveryStart", function()
    if QBCore.Functions.GetPlayerData().metadata['alias'] == 'NO ALIAS' or not Config.OneAliasEver then
        if exports['qb-inventory']:HasItem(Config.ItemNeededToGetAlias) then
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['usb_purple'], "remove")
            --TriggerServerEvent('QBCore:Server:RemoveItem', 'usb_purple', 1)
            --QBCore.Functions.RemoveItem('usb_purple')
            local luck = math.random(1, 3)
            if luck == 1 then -- Life invader
                QBCore.Functions.Notify("Waypoint Set ..")
                TriggerServerEvent('qb-phone:server:sendNewMail', {
                    sender = "Lime Lord",
                    subject = "Business...",
                    message = "COME ON DOWN TO THE WANNABE ZUCKERBERG SHOP, AND CHECK OUT THE TECH STOP",
                })
                SetNewWaypoint(-1082.68, -247.84)
                exports['qb-target']:RemoveZone("LimeDoor1")
                exports['qb-target']:RemoveZone("LimeDoor2")
                exports['qb-target']:RemoveZone("LimeDoor3")
                exports['qb-target']:AddBoxZone("LimeDoor1", vector3(-1082.55, -246.72, 37.77), 5.0, 3, {
                    name = "LimeDoor1",
                    heading=297,
                    --debugPoly=true,
                    minZ=36.77,
                    maxZ=38.17
                    }, {
                    options = {
                        {
                            type = "client",
                            event = "Pug:client:LimeGetAliasusb",
                            icon = "fas fa-wallet",
                            label = 'Pickup',
                        }
                    },
                    distance = 1.5,
                })
            elseif luck == 2 then  -- Trucker Docks
                QBCore.Functions.Notify("Waypoint Set ..")
                TriggerServerEvent('qb-phone:server:sendNewMail', {
                    sender = "Lime Lord",
                    subject = "Business...",
                    message = "THESE TRUCKERS DONT RUN THESE ROADS, RACERS DO, WATCH OUT FOR YOUR BLURAY PLAYERS",
                })
                SetNewWaypoint(861.17, -3184.72)
                exports['qb-target']:RemoveZone("LimeDoor1")
                exports['qb-target']:RemoveZone("LimeDoor2")
                exports['qb-target']:RemoveZone("LimeDoor3")
                exports['qb-target']:AddBoxZone("LimeDoor2", vector3(861.41, -3186.65, 6.03), 1.4, 1, {
                    name = "LimeDoor2",
                    heading=270,
                    --debugPoly=true,
                    minZ=5.03,
                    maxZ=7.43
                    }, {
                    options = {
                        {
                            type = "client",
                            event = "Pug:client:LimeGetAliasusb",
                            icon = "fas fa-wallet",
                            label = 'Pickup',
                        }
                    },
                    distance = 1.5,
                })
            elseif luck == 3 then -- Tuner Shop
                QBCore.Functions.Notify("Waypoint Set ..")
                TriggerServerEvent('qb-phone:server:sendNewMail', {
                    sender = "Lime Lord",
                    subject = "Business...",
                    message = "VEGA'S BABY. YOU DIDN'T HEAR IT FROM ME.PERFORMANCE WILL WIN YOU RACES",
                })
                SetNewWaypoint(143.22, -3004.88)
                exports['qb-target']:RemoveZone("LimeDoor1")
                exports['qb-target']:RemoveZone("LimeDoor2")
                exports['qb-target']:RemoveZone("LimeDoor3")
                exports['qb-target']:AddBoxZone("LimeDoor3", vector3(144.42, -3006.33, 7.03), 6.0, 1, {
                    name = "LimeDoor3",
                    heading=270,
                    --debugPoly=true,
                    minZ=6.03,
                    maxZ=9.63
                    }, {
                    options = {
                        {
                            type = "client",
                            event = "Pug:client:LimeGetAliasusb",
                            icon = "fas fa-wallet",
                            label = 'Pickup',
                        }
                    },
                    distance = 1.5,
                })
            end
        else			
            QBCore.Functions.Notify("You dont have what im looking for?", "error")
        end
    else
        QBCore.Functions.Notify("You already have a racing alias.", "error")
    end
end)

RegisterNetEvent("Pug:client:CreateRacerAlias", function()
    if not IsPedInAnyVehicle(PlayerPedId()) then
        if QBCore.Functions.GetPlayerData().metadata['alias'] == 'NO ALIAS' or not Config.OneAliasEver then
            --TriggerServerEvent('QBCore:Server:RemoveItem', "ausb2", 1)
            --QBCore.Functions.RemoveItem('ausb')
            LocalPlayer.state:set('inv_busy', true, true)
            TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_MOBILE', -1, true)
            Wait(2700)
            local dialog = exports['qb-input']:ShowInput({
                header = "Choose your racing alias",
                submitText = "Enter Alias",
                inputs = {
                    {
                        text = "Racer Alias",
                        name = "racingalias",
                        type = "text",
                        isRequired = true,
                    },
                }
            });

            if dialog ~= nil then
                if (dialog['racingalias']:len() > 1 and dialog['racingalias']:len() < 10) then
                    if(dialog['racingalias'] ~= nil and dialog['racingalias'] ~= '') then
                        TriggerServerEvent("QBCore:Server:SetMetaData", "alias", dialog['racingalias'])
                        TriggerEvent("chatMessage", dialog['racingalias'])
                        --TriggerServerEvent('QBCore:Server:RemoveItem', "ausb2", 1)
                        --QBCore.Functions.RemoveItem('ausb')
                        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ausb2"], "remove")
                        if Config.GiveRacingUSB then
                            TriggerServerEvent('Pug:server:AddUSB')
                            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.RacingUsbItem], "add")
                        end
                        LocalPlayer.state:set('inv_busy', false, true)
                        ClearPedTasks(PlayerPedId())
                    else
                        TriggerServerEvent('Pug:server:AddUSB')
                        LocalPlayer.state:set('inv_busy', false, true)
                    end
                else
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('Pug:server:AddUSB')
                    LocalPlayer.state:set('inv_busy', false, true)
                    QBCore.Functions.Notify('must be more than 1 character and less then 10', 'error')
                end
            else
                TriggerServerEvent('Pug:server:AddUSB')
                LocalPlayer.state:set('inv_busy', false, true)
                ClearPedTasks(PlayerPedId())
            end
        else
            QBCore.Functions.Notify('You can only set your racing name once', 'error')
        end
    else
        QBCore.Functions.Notify('You cant do this in a vehicle', 'error')
    end
end)