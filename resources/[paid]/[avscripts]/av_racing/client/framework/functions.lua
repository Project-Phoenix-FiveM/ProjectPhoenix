function isClose(coords)
    local dist = #(GetEntityCoords(PlayerPedId()) - vector3(coords.x, coords.y, coords.z))
    if dist > Config.JoinDistance then
        return false
    end
    return true
end

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle then
        for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
            if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
        end
    end
    return -2
end

function DeleteAllCheckpoints()
    if CreatorData then
        for k, v in pairs(CreatorData.Checkpoints) do
            local CurrentCheckpoint = CreatorData.Checkpoints[k]

            if CurrentCheckpoint then
                local LeftPile = CurrentCheckpoint.pileleft
                local RightPile = CurrentCheckpoint.pileright

                if LeftPile then
                    DeleteClosestObject(CurrentCheckpoint.offset.left, Config.StartAndFinishModel)
                    DeleteClosestObject(CurrentCheckpoint.offset.left, Config.CheckpointPileModel)
                    LeftPile = nil
                end
                if RightPile then
                    DeleteClosestObject(CurrentCheckpoint.offset.right, Config.StartAndFinishModel)
                    DeleteClosestObject(CurrentCheckpoint.offset.right, Config.CheckpointPileModel)
                    RightPile = nil
                end
            end
        end
    end
    if CurrentRaceData then
        for k, v in pairs(CurrentRaceData.Checkpoints) do
            local CurrentCheckpoint = CurrentRaceData.Checkpoints[k]

            if CurrentCheckpoint then
                local LeftPile = CurrentCheckpoint.pileleft
                local RightPile = CurrentCheckpoint.pileright

                if LeftPile then
                    DeleteClosestObject(CurrentRaceData.Checkpoints[k].offset.left, Config.StartAndFinishModel)
                    DeleteClosestObject(CurrentRaceData.Checkpoints[k].offset.left, Config.CheckpointPileModel)
                    LeftPile = nil
                end

                if RightPile then
                    DeleteClosestObject(CurrentRaceData.Checkpoints[k].offset.right, Config.StartAndFinishModel)
                    DeleteClosestObject(CurrentRaceData.Checkpoints[k].offset.right, Config.CheckpointPileModel)
                    RightPile = nil
                end
            end
        end
    end
end

function AddCheckpoint(checkpointId)
    local PlayerPed = PlayerPedId()
    local PlayerPos = GetEntityCoords(PlayerPed)
    local PlayerVeh = GetVehiclePedIsIn(PlayerPed)
    local Offset = {
        left = {
            x = (GetOffsetFromEntityInWorldCoords(PlayerVeh, -CreatorData.TireDistance, 0.0, 0.0)).x,
            y = (GetOffsetFromEntityInWorldCoords(PlayerVeh, -CreatorData.TireDistance, 0.0, 0.0)).y,
            z = (GetOffsetFromEntityInWorldCoords(PlayerVeh, -CreatorData.TireDistance, 0.0, 0.0)).z
        },
        right = {
            x = (GetOffsetFromEntityInWorldCoords(PlayerVeh, CreatorData.TireDistance, 0.0, 0.0)).x,
            y = (GetOffsetFromEntityInWorldCoords(PlayerVeh, CreatorData.TireDistance, 0.0, 0.0)).y,
            z = (GetOffsetFromEntityInWorldCoords(PlayerVeh, CreatorData.TireDistance, 0.0, 0.0)).z
        }
    }
    if checkpointId then
        RemoveBlip(tonumber(CreatorData.Checkpoints[tonumber(checkpointId)].blip))
        local PileLeft = CreatorData.Checkpoints[tonumber(checkpointId)].pileleft
        if PileLeft then
            DeleteClosestObject(CreatorData.Checkpoints[tonumber(checkpointId)].offset.left, Config.StartAndFinishModel)
            DeleteClosestObject(CreatorData.Checkpoints[tonumber(checkpointId)].offset.left, Config.CheckpointPileModel)
            PileLeft = nil
        end

        local PileRight = CreatorData.Checkpoints[tonumber(checkpointId)].pileright
        if PileRight then
            DeleteClosestObject(CreatorData.Checkpoints[tonumber(checkpointId)].offset.right, Config.StartAndFinishModel)
            DeleteClosestObject(CreatorData.Checkpoints[tonumber(checkpointId)].offset.right, Config.CheckpointPileModel)
            PileRight = nil
        end

        CreatorData.Checkpoints[tonumber(checkpointId)] = {
            coords = {
                x = PlayerPos.x,
                y = PlayerPos.y,
                z = PlayerPos.z
            },
            offset = Offset
        }
    else
        CreatorData.Checkpoints[#CreatorData.Checkpoints + 1] = {
            coords = {
                x = PlayerPos.x,
                y = PlayerPos.y,
                z = PlayerPos.z
            },
            offset = Offset
        }
    end
    redrawBlips()
end

function DeleteCheckpoint()
    local NewCheckpoints = {}
    if RaceData.ClosestCheckpoint ~= 0 then
        local ClosestCheckpoint = CreatorData.Checkpoints[RaceData.ClosestCheckpoint]
        if ClosestCheckpoint then
            local Blip = ClosestCheckpoint.blip
            if Blip then
                RemoveBlip(Blip)
                Blip = nil
            end

            local PileLeft = ClosestCheckpoint.pileleft
            if PileLeft then
                DeleteClosestObject(ClosestCheckpoint.offset.left, Config.StartAndFinishModel)
                DeleteClosestObject(ClosestCheckpoint.offset.left, Config.CheckpointPileModel)
                PileLeft = nil
            end

            local PileRight = ClosestCheckpoint.pileright
            if PileRight then
                DeleteClosestObject(ClosestCheckpoint.offset.right, Config.StartAndFinishModel)
                DeleteClosestObject(ClosestCheckpoint.offset.right, Config.CheckpointPileModel)
                PileRight = nil
            end

            for id, data in pairs(CreatorData.Checkpoints) do
                if id ~= RaceData.ClosestCheckpoint then
                    NewCheckpoints[#NewCheckpoints + 1] = data
                end
            end
            CreatorData.Checkpoints = NewCheckpoints
        else
            print("slow_down")
        end
    else
        print("slow_down")
    end
end

function SaveRace()
    lib.hideTextUI()
    local RaceDistance = 0
    for k, v in pairs(CreatorData.Checkpoints) do
        if k + 1 <= #CreatorData.Checkpoints then
            local checkpointdistance = #(vector3(v.coords.x, v.coords.y, v.coords.z) - vector3(CreatorData.Checkpoints[k + 1].coords.x, CreatorData.Checkpoints[k + 1].coords.y, CreatorData.Checkpoints[k + 1].coords.z))
            RaceDistance = RaceDistance + checkpointdistance
        end
    end
    if Config.DistanceUnit == "KM" then
        RaceDistance = RaceDistance / 1000
    else
        RaceDistance = RaceDistance * 0.000621
    end
    CreatorData.RaceDistance = Round(RaceDistance,3)
    TriggerServerEvent("av_racing:createCircuit", CreatorData)
    DeleteCreatorCheckpoints()
    cleanupObjects()
    inCreator = false
    CreatorData.RaceName = nil
    CreatorData.RaceDescription = nil
    CreatorData.Checkpoints = {}
end

function Round(value, numDecimalPlaces)
    if not numDecimalPlaces then return math.floor(value + 0.5) end
    local power = 10 ^ numDecimalPlaces
    return math.floor((value * power) + 0.5) / (power)
end

function redrawBlips()
    for id, CheckpointData in pairs(CreatorData.Checkpoints) do
        RemoveBlip(CheckpointData.blip)
        CheckpointData.blip = CreateCheckpointBlip(CheckpointData.coords, id)
    end
end

function CreateCheckpointBlip(coords, id)
    local Blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(Blip, 1)
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 0.6)
    SetBlipAsShortRange(Blip, true)
    SetBlipColour(Blip, Config.BlipColor)
    ShowNumberOnBlip(Blip, id)
    SetBlipShowCone(Blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Lang['checkpoint'])
    EndTextCommandSetBlipName(Blip)
    return Blip
end

function DeleteCreatorCheckpoints()
    for id, _ in pairs(CreatorData.Checkpoints) do
        local CurrentCheckpoint = CreatorData.Checkpoints[id]
        local Blip = CurrentCheckpoint.blip
        if Blip then
            RemoveBlip(Blip)
            Blip = nil
        end
        if CurrentCheckpoint then
            local PileLeft = CurrentCheckpoint.pileleft
            if PileLeft then
                DeleteClosestObject(CurrentCheckpoint.offset.left, Config.CheckpointPileModel)
                DeleteClosestObject(CurrentCheckpoint.offset.left, Config.StartAndFinishModel)
                PileLeft = nil
            end

            local PileRight = CurrentCheckpoint.pileright
            if PileRight then
                DeleteClosestObject(CurrentCheckpoint.offset.right, Config.CheckpointPileModel)
                DeleteClosestObject(CurrentCheckpoint.offset.right, Config.StartAndFinishModel)
                PileRight = nil
            end
        end
    end
end

function GetClosestCheckpoint()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for id, _ in pairs(CreatorData.Checkpoints) do
        if current ~= nil then
            if #(pos -
                vector3(CreatorData.Checkpoints[id].coords.x, CreatorData.Checkpoints[id].coords.y,
                    CreatorData.Checkpoints[id].coords.z)) < dist then
                current = id
                dist = #(pos -
                           vector3(CreatorData.Checkpoints[id].coords.x, CreatorData.Checkpoints[id].coords.y,
                        CreatorData.Checkpoints[id].coords.z))
            end
        else
            dist = #(pos -
                       vector3(CreatorData.Checkpoints[id].coords.x, CreatorData.Checkpoints[id].coords.y,
                    CreatorData.Checkpoints[id].coords.z))
            current = id
        end
    end
    RaceData.ClosestCheckpoint = current
end

function SetupPiles()
    for k, v in pairs(CreatorData.Checkpoints) do
        if not CreatorData.Checkpoints[k].pileleft then
            CreatorData.Checkpoints[k].pileleft = CreatePile(v.offset.left, Config.CheckpointPileModel)
        end

        if not CreatorData.Checkpoints[k].pileright then
            CreatorData.Checkpoints[k].pileright = CreatePile(v.offset.right, Config.CheckpointPileModel)
        end
    end
end

function CreatePile(offset, model)
    ClearAreaOfObjects(offset.x, offset.y, offset.z, 50.0, 0)
    lib.requestModel(model)
    local Obj = CreateObject(model, offset.x, offset.y, offset.z, 0, 0, 0) -- CHANGE ONE OF THESE TO MAKE NETWORKED???
    PlaceObjectOnGroundProperly(Obj)
    SetEntityAsMissionEntity(Obj, 1, 1)
    SetEntityCollision(Obj,false,true)
    return Obj
end

function DeleteClosestObject(coords, model)
    local Obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 5.0, model, 0, 0, 0)
    DeleteObject(Obj)
    ClearAreaOfObjects(coords.x, coords.y, coords.z, 50.0, 0)
end

function cleanupObjects()
    DeleteObject(creatorObjectLeft)
    DeleteObject(creatorObjectRight)
    creatorObjectLeft, creatorObjectRight = nil, nil
end

function doGPSForRace(started)
    ClearGpsMultiRoute()
    StartGpsMultiRoute(Config.Blips['Route']['color'], started , false)
    local limit = 0
    for k, v in pairs(CurrentRaceData.Checkpoints) do
        limit += 1
        if limit <= 3 then
            AddPointToGpsMultiRoute(CurrentRaceData.Checkpoints[k].coords.x,CurrentRaceData.Checkpoints[k].coords.y)
        end
        if started then
            ClearAreaOfObjects(v.offset.right.x, v.offset.right.y, v.offset.right.z, 50.0, 0)
            if isFinishOrStart(CurrentRaceData,k) then
                CurrentRaceData.Checkpoints[k].pileleft = CreatePile(v.offset.left, Config.StartAndFinishModel)
                CurrentRaceData.Checkpoints[k].pileright = CreatePile(v.offset.right, Config.StartAndFinishModel)
            else
                CurrentRaceData.Checkpoints[k].pileleft = CreatePile(v.offset.left, Config.CheckpointPileModel)
                CurrentRaceData.Checkpoints[k].pileright = CreatePile(v.offset.right, Config.CheckpointPileModel)
            end
            CurrentRaceData.Checkpoints[k].blip = CreateCheckpointBlip(v.coords, k)
        end
    end
    -- if CurrentRaceData.TotalLaps > 0 then 
    --     for k=1, CurrentRaceData.TotalLaps-1, 1 do
    --         for k=1, #CurrentRaceData.Checkpoints, 1 do
    --             AddPointToGpsMultiRoute(CurrentRaceData.Checkpoints[k].coords.x,CurrentRaceData.Checkpoints[k].coords.y)
    --         end
    --     end
    --     AddPointToGpsMultiRoute(CurrentRaceData.Checkpoints[1].coords.x,CurrentRaceData.Checkpoints[1].coords.y)
    -- end
    SetGpsMultiRouteRender(true)
end

function isFinishOrStart(CurrentRaceData, checkpoint)
    if CurrentRaceData.TotalLaps == 0 then
        if checkpoint == 1 or checkpoint == #CurrentRaceData.Checkpoints then
            return true
        else 
            return false
        end
    else
        if checkpoint == 1 then
            return true
        else 
            return false
        end  
    end
end

function getIndex(Positions)
    for k,v in pairs(Positions) do
        if v.identifier == CurrentRaceData.Identifier then return k end
    end
end

function showNonLoopParticle(dict, particleName, coords, scale, time)
    while not HasNamedPtfxAssetLoaded(dict) do
        RequestNamedPtfxAsset(dict)
        Wait(0)
    end

    UseParticleFxAssetNextCall(dict)

    local particleHandle = StartParticleFxLoopedAtCoord(particleName, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0,
    scale, false, false, false)
    SetParticleFxLoopedColour(particleHandle,0.0,0.0,1.0)
    return particleHandle
end

function handleFlare (checkpoint)
    -- QBCore.Functions.Notify('Lighting '..checkpoint, 'success')

    local Size = 1.0
    local left = showNonLoopParticle('core', 'exp_grd_flare',
        CurrentRaceData.Checkpoints[checkpoint].offset.left, Size)
    local right = showNonLoopParticle('core', 'exp_grd_flare',
        CurrentRaceData.Checkpoints[checkpoint].offset.right, Size)

    SetTimeout(Config.FlareTime * 1000, function()
        StopParticleFxLooped(left, false)
        StopParticleFxLooped(right, false)
    end)
end

function DoPilePfx()
    if CurrentRaceData.Checkpoints[CurrentRaceData.CurrentCheckpoint + 1] ~= nil then
        handleFlare(CurrentRaceData.CurrentCheckpoint + 1)
    end
    if CurrentRaceData.CurrentCheckpoint == 1 then -- start
        if useDebug then
           print('start')
        end
        -- QBCore.Functions.Notify('Lighting start '..CurrentRaceData.CurrentCheckpoint, 'success')
        handleFlare(CurrentRaceData.CurrentCheckpoint)

    end
    if CurrentRaceData.TotalLaps > 0 and CurrentRaceData.CurrentCheckpoint == #CurrentRaceData.Checkpoints then -- finish
        if useDebug then
           print('finish')
        end
        --QBCore.Functions.Notify('Lighting finish/startline '..CurrentRaceData.CurrentCheckpoint + 1, 'success')
        handleFlare(1)
        if CurrentRaceData.Lap ~= CurrentRaceData.TotalLaps then
            if useDebug then
               print('not last lap')
            end
            handleFlare(2)
        end
    end
end

function GetMaxDistance(OffsetCoords)
    local Distance = #(vector3(OffsetCoords.left.x, OffsetCoords.left.y, OffsetCoords.left.z) -
                         vector3(OffsetCoords.right.x, OffsetCoords.right.y, OffsetCoords.right.z))
    local Retval = 7
    if Distance > 20.0 then
        Retval = 18.5
    end
    return Retval
end

function MilliToTime(milli)
    local milliseconds = milli % 1000;
    milliseconds = tostring(milliseconds)
    local seconds = math.floor((milli / 1000) % 60);
    local minutes = math.floor((milli / (60 * 1000)) % 60);
    if minutes < 10 then
        minutes = "0"..tostring(minutes);
    else
        minutes = tostring(minutes)
    end
    if seconds < 10 then
        seconds = "0"..tostring(seconds);
    else
        seconds = tostring(seconds)
    end
    return minutes..":"..seconds.."."..milliseconds;
end

function DeleteCurrentRaceCheckpoints()
    for k, v in pairs(CurrentRaceData.Checkpoints) do
        local CurrentCheckpoint = CurrentRaceData.Checkpoints[k]
        local Blip = CurrentCheckpoint.blip
        if Blip then
            RemoveBlip(Blip)
            Blip = nil
        end

        local PileLeft = CurrentCheckpoint.pileleft
        if PileLeft then
            DeleteClosestObject(CurrentCheckpoint.offset.left, Config.StartAndFinishModel)
            DeleteClosestObject(CurrentCheckpoint.offset.left, Config.CheckpointPileModel)
            PileLeft = nil
        end

        local PileRight = CurrentCheckpoint.pileright
        if PileRight then
            DeleteClosestObject(CurrentCheckpoint.offset.right, Config.StartAndFinishModel)
            DeleteClosestObject(CurrentCheckpoint.offset.right, Config.CheckpointPileModel)
            PileRight = nil
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
    CurrentRaceData.RacerName = nil
    RaceData.InRace = false
end

function FinishRace()
    ClearGpsMultiRoute()
    DeleteCurrentRaceCheckpoints()
    EndGhostLoop()
end