RacketEntity = nil

SpawnedRackets = {}
PlayerTennisRackets = {}

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local timeout = 5

        local mePed = PlayerPedId()
        local meCoords = GetEntityCoords(mePed)

        for _, ply in pairs(GetActivePlayers()) do
            HandleTennisRacket(mePed, meCoords, GetPlayerServerId(ply))

            timeout = timeout - 1

            if timeout < 0 then
                Wait(0)
                timeout = 5
            end
        end
    end
end)

function HandleTennisRacket(mePed, meCoords, targetServerId)
    local playerId = GetPlayerFromServerId(targetServerId)
    
    if playerId <= 0 then
        return
    end

    local ped = GetPlayerPed(playerId)
    local coords = GetEntityCoords(ped)

    local distToPlayer = #(coords - meCoords)
    local hasRacket = PlayerTennisRackets[targetServerId] and distToPlayer < 100

    if SpawnedRackets[targetServerId] and not hasRacket then
        DeleteTennisRacket(targetServerId, mePed, ped)
    elseif not SpawnedRackets[targetServerId] and hasRacket then
        CreateAndAttachRacket(targetServerId, ped, coords)

        if ped == mePed then
            RacketEntity = SpawnedRackets[targetServerId]
        end
    end
end

function DeleteTennisRacket(serverId, mePed, ped)
    DeleteEntity(SpawnedRackets[serverId])
    SpawnedRackets[serverId] = nil

    if ped == mePed then
        RacketEntity = nil
    end
end

function CreateAndAttachRacket(serverId, ped, coords)
    SpawnedRackets[serverId] = CreateObject(
        `prop_tennis_rack_01b`, 
        coords + vector3(0.0, 1.0, 0.0), false, false, false
    )
    AttachEntityToEntity(
        SpawnedRackets[serverId], 
        ped, GetPedBoneIndex(ped, 28422), 
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 0, 0, 0, 2, 1
    )
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    for _, obj in pairs(SpawnedRackets) do
        DeleteEntity(obj)
    end
end)

RegisterNetEvent('rcore_tennis:setTennisRacketInHand', function(serverId)
    PlayerTennisRackets[serverId] = true
    local ped = PlayerPedId()
    HandleTennisRacket(ped, GetEntityCoords(ped), serverId)
end)

RegisterNetEvent('rcore_tennis:unsetTennisRacketInHand', function(serverId)
    PlayerTennisRackets[serverId] = nil
    local ped = PlayerPedId()
    HandleTennisRacket(ped, GetEntityCoords(ped), serverId)
end)

RegisterNetEvent('rcore_tennis:setAllTennisRacketInHand', function(pc)
    PlayerTennisRackets = pc
end)
