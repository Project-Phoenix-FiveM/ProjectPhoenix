spawnedGuards = {}

RegisterServerEvent('av_boosting:setStateBag', function(netId, type, class, serial)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if vehicle then
        Entity(vehicle).state.boosting = type
        Entity(vehicle).state.serial = serial
        Entity(vehicle).state.class = class
        Entity(vehicle).state.lockpick = false
        SetVehicleDoorsLocked(vehicle, true)
        if Config.Classes[class]["Hacks"] then
            local amount = math.random(Config.Classes[class]["Hacks"]['min'], Config.Classes[class]["Hacks"]['max'])
            Entity(vehicle).state.hacks = amount
        end
        AddContractMission(serial,type,netId)
    end
end)

RegisterServerEvent('av_boosting:removeHack', function(netId,hack,cooldown,plates)
    local src = source
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if vehicle then
        if hack then
            Entity(vehicle).state.hacks = Entity(vehicle).state.hacks - 1
            if startedContracts[plates] then
                local identifier = exports['av_laptop']:getIdentifier(src)
                startedContracts[plates]['hacker'] = identifier
            end
        end
        Entity(vehicle).state.cooldown = cooldown
    end
end)

RegisterServerEvent('av_boosting:lockpick', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if vehicle then
        Entity(vehicle).state.lockpick = true
        SetVehicleDoorsLocked(vehicle, false)
    end
end)

RegisterServerEvent('av_boosting:spawnGuards', function(netId)
    local src = source
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if vehicle then
        local state = Entity(vehicle).state
        if state.serial and not state.guards then
            local serial = state.serial
            local vehCoords = GetEntityCoords(vehicle)
            local guardsConfig = Config.Classes[state.class]
            local maxGuards = math.random(guardsConfig["Guards"]['min'], guardsConfig["Guards"]['max'])
            for i=1, maxGuards do
                local random = math.random(1,#Config.GuardModels)
                local model = Config.GuardModels[random]
                local coords = GenerateCoords(vehCoords)
                local guard = CreatePed(30, model, coords.x, coords.y, coords.z, 30, true, true)
                while not DoesEntityExist(guard) do Wait(25) end
                spawnedGuards[serial] = spawnedGuards[serial] or {}
                local index = #spawnedGuards[serial] + 1
                spawnedGuards[serial][index] = NetworkGetNetworkIdFromEntity(guard)
                Wait(250)
            end
            Wait(500)
            Entity(vehicle).state.guards = true
            TriggerClientEvent('av_boosting:guards',src,spawnedGuards[serial],state.class)
        end
    end
end)

function WipeGuards(serial)
    if spawnedGuards[serial] then
        for k, v in pairs(spawnedGuards[serial]) do
            if DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end
        spawnedGuards[serial] = nil
    end
end

function GenerateCoords(coords)
    local coordX, coordY
    coordX = coords[1] + math.random(Config.GuardSpawn[1],Config.GuardSpawn[2])
    coordY = coords[2] + math.random(Config.GuardSpawn[1],Config.GuardSpawn[2])
    local coordZ = coords.z + 0.20
    return {x = coordX, y = coordY, z = coordZ}
end