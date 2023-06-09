-- NumberOfCircles, MS
local circleConfig = {
    ["D"] = {circles = 5, ms = 40},
    ["C"] = {circles = 6, ms = 40},
    ["B"] = {circles = 7, ms = 40},
}
-- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
local decrypterConfig = {
    ["A"] = {type = "alphanumeric", time = 15, mirrored = 1},
    ["A+"] = {type = "alphanumeric", time = 15, mirrored = 1},
    ["S"] = {type = "alphanumeric", time = 15, mirrored = 0},
    ["S+"] = {type = "runes", time = 15, mirrored = 1},
}

function GiveKeys(plates)
    -- Your give keys event/export goes here
    -- Example for qb-vehiclekeys:
    TriggerEvent("vehiclekeys:client:SetOwner", plates)
end

RegisterNetEvent('av_boosting:useCracker', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then return end
    local vehicle = lib.getClosestVehicle(GetEntityCoords(ped), 5, false)
    if vehicle then
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        local state = Entity(vehicle).state
        if state.boosting and state.class and not state.lockpick then
            local class = state.class
            local plates = GetPlate(vehicle)
            TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
            TriggerServerEvent('av_boosting:spawnGuards',netId)
	        Wait(3500)
            SetVehicleAlarm(vehicle,true)
            if circleConfig[class] then
                exports['ps-ui']:Circle(function(success)
                    local vehicle = QBCore.Functions.GetClosestVehicle()
                    exports['ps-dispatch']:VehicleTheft(vehicle)
                    if success then
                        SetVehicleDoorsLockedForAllPlayers(vehicle,false)
                        GiveKeys(plates)
                        TriggerServerEvent('av_boosting:lockpick',netId)
                    end
                    ClearPedTasks(ped)
                end, circleConfig[class]["circles"], circleConfig[class]["ms"])
            end
            if decrypterConfig[class] then
                exports['ps-ui']:Scrambler(function(success)
                    local vehicle = QBCore.Functions.GetClosestVehicle()
                    exports['ps-dispatch']:VehicleTheft(vehicle)                    
                    if success then
                        SetVehicleDoorsLockedForAllPlayers(vehicle,false)
                        GiveKeys(plates)
                        TriggerServerEvent('av_boosting:lockpick',netId)
                    end
                    ClearPedTasks(ped)
                end, decrypterConfig[class]['type'], decrypterConfig[class]['time'], decrypterConfig[class]['mirrored'])
            end
        else
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['lockpick_error'],"error")
        end
    end
end)

function GetPlate(vehicle)
    local value = GetVehicleNumberPlateText(vehicle)
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

exports('isBoosting', function()
    local vehicle = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 5, false)
    if vehicle then
        local state = Entity(vehicle).state
        if state.boosting then
            return true
        end
    end
    return false
end)