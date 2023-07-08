IS_NETWORKED = true
NOT_NETWORKED = false

POOL_CUE_BONE = 28422

POOL_CUE_OFFSET_IDLE = vector3(0.06, 0.05, 0.0)
POOL_CUE_ROTATION_IDLE = vector3(-60.0, 0.0, 0.0)

POOL_CUE_OFFSET_AIM = vector3(0.199, 0.429, 0.119)
POOL_CUE_ROTATION_AIM = vector3(-65.0, 46.0, 0.0)

PickedPoolCueAtPos = nil

SpawnedPoolCues = {}
PlayerPoolCues = {}

Citizen.CreateThread(function()
    while true do
        Wait(2100)

        if PickedPoolCueAtPos and InHandPoolCue then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

            if #(coords - PickedPoolCueAtPos) > 20.0 then
                TriggerServerEvent('rcore_pool:requestRemoveCue')
            end
        end
    end
end)

function HandlePoolCueForServerId()
    local timeout = 5

    local mePed = PlayerPedId()
    local meCoords = GetEntityCoords(mePed)

    for _, ply in pairs(GetActivePlayers()) do
        local ped = GetPlayerPed(ply)
        local coords = GetEntityCoords(ped)

        local serverId = GetPlayerServerId(ply)
        local hasPoolCue = PlayerPoolCues[serverId]

        if #(coords - meCoords) > 100 then
            hasPoolCue = false
        end

        if hasPoolCue and not SpawnedPoolCues[serverId] then
            SpawnedPoolCues[serverId] = CreatePoolCueInHand(ped, coords)

            if ped == mePed then
                InHandPoolCue = SpawnedPoolCues[serverId]
                PickedPoolCueAtPos = coords
                HasPoolCueInHand = true
            end
        elseif not hasPoolCue and SpawnedPoolCues[serverId] then
            DeleteEntity(SpawnedPoolCues[serverId])
            SpawnedPoolCues[serverId] = nil

            if ped == mePed then
                InHandPoolCue = nil
                PickedPoolCueAtPos = nil
                HasPoolCueInHand = false
            end
        elseif hasPoolCue and SpawnedPoolCues[serverId] then
            if IsEntityPlayingAnim(ped, 'pool@cue_aim', 'myrpcuepool', 3) then
                AttachEntityToEntity(
                    SpawnedPoolCues[serverId], ped, GetPedBoneIndex(ped, POOL_CUE_BONE), 
                    POOL_CUE_OFFSET_AIM.x, POOL_CUE_OFFSET_AIM.y, POOL_CUE_OFFSET_AIM.z, 
                    POOL_CUE_ROTATION_AIM.x, POOL_CUE_ROTATION_AIM.y, POOL_CUE_ROTATION_AIM.z, 
                    true, true, false, true, 1, true
                )
            else
                AttachEntityToEntity(
                    SpawnedPoolCues[serverId], ped, GetPedBoneIndex(ped, POOL_CUE_BONE), 
                    POOL_CUE_OFFSET_IDLE.x, POOL_CUE_OFFSET_IDLE.y, POOL_CUE_OFFSET_IDLE.z, 
                    POOL_CUE_ROTATION_IDLE.x, POOL_CUE_ROTATION_IDLE.y, POOL_CUE_ROTATION_IDLE.z, 
                    true, true, false, true, 1, true
                )
            end
        end

        timeout = timeout - 1

        if timeout < 0 then
            Wait(0)
            timeout = 5
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        HandlePoolCueForServerId()
    end
end)

function CreatePoolCueInHand(ped, pedCoords)
    local poolCue = CreateObject(
        GetHashKey('prop_pool_cue'), 
        pedCoords.x, pedCoords.y, pedCoords.z, 
        NOT_NETWORKED, true, false
    )
    SetEntityCollision(poolCue, false, false)
    TriggerServerEvent('rcore_pool:internalPlayerHasTakenCue', pedCoords)

    AttachEntityToEntity(
        poolCue, ped, GetPedBoneIndex(ped, POOL_CUE_BONE), 
        POOL_CUE_OFFSET_IDLE.x, POOL_CUE_OFFSET_IDLE.y, POOL_CUE_OFFSET_IDLE.z, 
        POOL_CUE_ROTATION_IDLE.x, POOL_CUE_ROTATION_IDLE.y, POOL_CUE_ROTATION_IDLE.z, 
        true, true, false, true, 1, true
    )

    return poolCue
end

function RemovePoolCueInHand()
    HasPoolCueInHand = false
    PickedPoolCueAtPos = nil
    DeleteObject(InHandPoolCue)
    
    InHandPoolCue = nil

    TriggerServerEvent('rcore_pool:internalDeleteCue')
end

function PoolCueAnimReset()
    local ped = PlayerPedId()


    ClearPedTasksImmediately(ped)
    ResetEntityAlpha(ped)
    ResetEntityAlpha(InHandPoolCue)
end

function PoolCueAnimAim()
    local ped = PlayerPedId()
    local namespace = 'pool@cue_aim'
    local name = 'myrpcuepool'

    loadAnimDict(namespace)
    TaskPlayAnim(ped, namespace, name, 8.0, 8.0, -1, 16 + 1, 0, 0, 0, 0 )

    AttachEntityToEntity(
        InHandPoolCue, ped, GetPedBoneIndex(ped, POOL_CUE_BONE), 
        POOL_CUE_OFFSET_AIM.x, POOL_CUE_OFFSET_AIM.y, POOL_CUE_OFFSET_AIM.z, 
        POOL_CUE_ROTATION_AIM.x, POOL_CUE_ROTATION_AIM.y, POOL_CUE_ROTATION_AIM.z, 
        true, true, false, true, 1, true
    )
    SetEntityAlpha(ped, 0.0, false)
    SetEntityAlpha(InHandPoolCue, 0.0, false)
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    for _, obj in pairs(SpawnedPoolCues) do
        DeleteEntity(obj)
    end
end)

RegisterNetEvent('rcore_pool:setPoolCueInHand', function(serverId)
    PlayerPoolCues[serverId] = true
    HandlePoolCueForServerId()
end)

RegisterNetEvent('rcore_pool:unsetPoolCueInHand', function(serverId)
    PlayerPoolCues[serverId] = nil
    HandlePoolCueForServerId()
end)

RegisterNetEvent('rcore_pool:setAllPoolCueInHand', function(pc)
    PlayerPoolCues = pc
end)
