creatorObjectLeft = nil
creatorObjectRight = nil
CreatorData = {
    RaceName = nil,
    RaceDescription = nil,
    Checkpoints = {},
    TireDistance = 3.0,
}
local creatorBlips = {}
inCreator = false

RegisterNetEvent("av_racing:createCircuit", function(name,description)
    if inCreator then return end
    local exist = lib.callback.await('av_racing:exists', false, name)
    if exist then
        TriggerEvent('av_laptop:notificationUI',Lang['duplicated_name'], "error")
        return
    end
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        TriggerEvent("av_laptop:notificationUI", Lang['not_in_vehicle'], "error")
        return
    end
    if GetPedVehicleSeat(PlayerPedId()) ~= -1 then
        TriggerEvent("av_laptop:notificationUI", Lang['not_driver'], "error")
        return
    end
    CreatorData['RaceName'] = name
    CreatorData['RaceDescription'] = description
    inCreator = true
    TriggerEvent("av_laptop:close")
    Wait(200)
    clearAll()
    CreatorLoop()
end)

function CreatorLoop()
    DrawText()
    CreateThread(function()
        while inCreator do
            if IsControlJustPressed(0, Config.EditorKeys['add']['key']) or IsDisabledControlJustPressed(0, Config.EditorKeys['add']['key']) then
                AddCheckpoint()
                DrawText()
            end

            if IsControlJustPressed(0, Config.EditorKeys['delete']['key']) or IsDisabledControlJustPressed(0, Config.EditorKeys['delete']['key']) then
                if CreatorData.Checkpoints and next(CreatorData.Checkpoints) then
                    DeleteCheckpoint()
                    DrawText()
                else
                    TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['no_checkpoint'],"error")
                end
            end

            if IsControlJustPressed(0, Config.EditorKeys['save']['key']) or IsDisabledControlJustPressed(0, Config.EditorKeys['save']['key']) then
                if CreatorData.Checkpoints and #CreatorData.Checkpoints >= Config.MinimumCheckpoints then
                    SaveRace()
                else
                    TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['not_enough_checkpoints'],"error")
                end
            end

            if IsControlJustPressed(0, Config.EditorKeys['distance']['key']['increase']) or IsDisabledControlJustPressed(0, Config.EditorKeys['distance']['key']['increase']) then
                if CreatorData.TireDistance < Config.MaxTireDistance then
                    CreatorData.TireDistance = CreatorData.TireDistance + 1.0
                else
                    TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['max_distance'],"error")
                end
            end

            if IsControlJustPressed(0, Config.EditorKeys['distance']['key']['decrease']) or IsDisabledControlJustPressed(0, Config.EditorKeys['distance']['key']['decrease']) then
                if CreatorData.TireDistance > Config.MinTireDistance then
                    CreatorData.TireDistance = CreatorData.TireDistance - 1.0
                else
                    TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['min_distance'],"error")
                end
            end
            if IsControlJustPressed(0, Config.EditorKeys['cancel']['key']) or IsDisabledControlJustPressed(0, Config.EditorKeys['cancel']['key']) then
                DeleteCreatorCheckpoints()
                cleanupObjects()
                inCreator = false
                CreatorData.RaceName = nil
                CreatorData.Checkpoints = {}
                lib.hideTextUI()
            end
            Wait(1)
        end
    end)
    CreateThread(function()
        lib.requestModel(Config.CheckpointPileModel)
        while inCreator do
            local PlayerPed = PlayerPedId()
            local PlayerVeh = GetVehiclePedIsIn(PlayerPed)
            if creatorObjectLeft and creatorObjectRight ~= nil then
                cleanupObjects()
            end
            if PlayerVeh ~= 0 then
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
                creatorObjectLeft = CreateObjectNoOffset(Config.CheckpointPileModel, Offset.left.x, Offset.left.y, Offset.left.z, false, false, false)
                creatorObjectRight = CreateObjectNoOffset(Config.CheckpointPileModel, Offset.right.x, Offset.right.y, Offset.right.z, false, false, false)
                PlaceObjectOnGroundProperly(creatorObjectLeft)
                PlaceObjectOnGroundProperly(creatorObjectRight)

                SetEntityCollision(creatorObjectLeft, false, false)
                SetEntityCollision(creatorObjectRight, false, false)
            end
            Wait(1)
        end
        SetModelAsNoLongerNeeded(Config.CheckpointPileModel)
    end)
    CreateThread(function()
        while inCreator do
            GetClosestCheckpoint()
            SetupPiles()
            Wait(1000)
        end
    end)
end