-- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
local ConfigHacks = {
    ["D"] = {type = "numeric", time = 15, mirrored = 0},
    ["B"] = {type = "numeric", time = 15, mirrored = 0},
    ["C"] = {type = "alphanumeric", time = 15, mirrored = 0},
    ["A"] = {type = "alphanumeric", time = 15, mirrored = 1},
    ["A+"] = {type = "greek", time = 15, mirrored = 0},
    ["S"] = {type = "greek", time = 15, mirrored = 1},
    ["S+"] = {type = "runes", time = 15, mirrored = 1},
}

RegisterNetEvent('av_boosting:trackerMinigame', function()
    local veh = GetVehiclePedIsIn(PlayerPedId(),false)
    if veh and (GetPedVehicleSeat(PlayerPedId()) == 0) then
        local speed = GetEntitySpeed(veh)
        if speed < Config.MinSpeedHack then return end
        local state = Entity(veh).state
        if state and state.hacks then
            if state.cooldown then
                TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['hacking_cooldown'],"error")
                return 
            end
            local class = state.class
            exports['ps-ui']:Scrambler(function(success)
                if success then
                    local plates = GetVehicleNumberPlateText(veh)
                    local netId = NetworkGetNetworkIdFromEntity(veh)
                    TriggerServerEvent('av_boosting:removeHack',netId,true,true,plates)
                end
            end, ConfigHacks['type'], ConfigHacks['time'], ConfigHacks['mirrored'])
        end
    end
end)