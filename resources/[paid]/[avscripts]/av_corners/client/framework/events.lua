currentCoords = nil
canSell = false
currentDrug = nil
offering = false

AddEventHandler('av_corners:sell', function(data)
    if tonumber(copsCount) >= tonumber(Corners.Drugs[data.name]['minCops']) then
        local vehicle = data.entity
        currentCoords = GetEntityCoords(PlayerPedId())
        local zone = GetNameOfZone(currentCoords)
        if Corners.Drugs[data.name]['zones'][zone] or Corners.Drugs[data.name]['zones']["ALL"] then
            if vehicle then
                currentDrug = data.name
                canSell = true
                SetVehicleDoorOpen(vehicle,5,false,false)
                StartThread()
            end
        else
            TriggerEvent('av_laptop:notification',Lang['title'],Lang['valid_zone'],"error")
        end
    else
        TriggerEvent('av_laptop:notification',Lang['title'],Lang['not_enough_cops'],"error")
    end
end)

AddEventHandler('av_corners:stop', function()
    currentCoords = nil
    canSell = false
    currentDrug = nil
    offering = false
    RemoveNPC()
end)

AddEventHandler('av_corners:offer', function(data)
    if offering then return end
    if tonumber(copsCount) >= tonumber(Corners.Drugs[currentDrug]['minCops']) then
        offering = true
        if exports['av_laptop']:hasItem(currentDrug) then
            local player = PlayerPedId()
            local entity = data.entity
            TaskStandStill(entity, 5000.0)
            local ped_pos = GetEntityCoords(entity)
            local coords = GetEntityCoords(player)
            SetEntityHeading(entity, GetHeadingFromVector_2d(ped_pos.x-coords.x,ped_pos.y-coords.y)+180)
            SetEntityHeading(player, GetHeadingFromVector_2d(ped_pos.x-coords.x,ped_pos.y-coords.y))
            local cops = math.random(1,20)
            if cops == 3 then
                exports['ps-dispatch']:SuspiciousActivity()
            end
            lib.requestAnimDict('mp_common')
            TaskPlayAnim(player, "mp_common", "givetake2_a", 8.0, 8.0, 2000, 0, 1, 0,0,0)
            TaskPlayAnim(entity, "mp_common", "givetake2_a", 8.0, 8.0, 2000, 0, 1, 0,0,0)
            local netId = NetworkGetNetworkIdFromEntity(entity)
            local gangZone = false
            if Corners.GangZoneMultiplier then
                gangZone = exports['av_gangs']:myZone()
            end
            TriggerServerEvent('av_corners:sell',netId,currentDrug,gangZone,GetNameOfZone(coords))
            RemoveNPC()
            offering = false
        else
            TriggerEvent('av_corners:stop')
            TriggerEvent('av_laptop:notification',Lang['title'],Lang['no_drugs'],"error")
        end
    else
        TriggerEvent('av_laptop:notification',Lang['title'],Lang['not_enough_cops'],"error")
        TriggerEvent('av_corners:stop')
    end
end)