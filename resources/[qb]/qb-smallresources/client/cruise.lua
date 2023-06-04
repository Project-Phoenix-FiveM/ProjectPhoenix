local QBCore = exports['qb-core']:GetCoreObject()
local vehicleClasses = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = false,
    [14] = false,
    [15] = false,
    [16] = false,
    [17] = true,
    [18] = true,
    [19] = true,
    [20] = true,
    [21] = false
}

local function IsTurningOrHandBraking() return IsControlPressed(2, 76) or IsControlPressed(2, 63) or IsControlPressed(2, 64) end

local function TransformToSpeed(speed)
    local mult = 3.6
    if Config.Cruise == 'mp/h' then
        mult = 2.2369
    end
    return math.floor(speed * mult + 0.5)
end

local function TriggerCruiseControl(veh)
    local ped = PlayerPedId()
    local speed = GetEntitySpeed(veh)
    if IsPedInAnyVehicle(ped, false) then
        if speed > 0 and GetVehicleCurrentGear(veh) > 0 then
            speed = GetEntitySpeed(veh)
            local TransformedSpeed = TransformToSpeed(speed) -- Comment me for mp/h
            TriggerEvent('seatbelt:client:ToggleCruise')
            QBCore.Functions.Notify(Lang:t('cruise.activated') .. TransformedSpeed .." "..Config.Cruise) -- Comment me for mp/h
            CreateThread(function()
                while speed > 0 and GetPedInVehicleSeat(veh, -1) == ped do
                    Wait(0)
                    if not IsTurningOrHandBraking() and GetEntitySpeed(veh) < speed - 1.5 then
                        speed = 0
                        TriggerEvent('seatbelt:client:ToggleCruise')
                        QBCore.Functions.Notify(Lang:t('cruise.deactivated'), "error")
                        Wait(2000)
                        break
                    end
                    if not IsTurningOrHandBraking() and IsVehicleOnAllWheels(veh) and GetEntitySpeed(veh) < speed then
                        SetVehicleForwardSpeed(veh, speed)
                    end
                    if IsControlJustPressed(1, 246) then
                        TriggerEvent('seatbelt:client:ToggleCruise')
                        speed = GetEntitySpeed(veh) -- Comment me for mp/h
                    end
                    if IsControlJustPressed(2, 72) then
                        speed = 0
                        TriggerEvent('seatbelt:client:ToggleCruise')
                        QBCore.Functions.Notify(Lang:t('cruise.deactivated'), "error")
                        Wait(2000)
                        break
                    end
                end
            end)
        end
    end
end

RegisterCommand('togglecruise', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local driver = GetPedInVehicleSeat(veh, -1)
    local vehClass = GetVehicleClass(veh)
    if ped == driver then
        if vehicleClasses[vehClass] then
            TriggerCruiseControl(veh)
        else
            QBCore.Functions.Notify(Lang:t('cruise.unavailable'), "error")
        end
    end
end, false)

RegisterKeyMapping('togglecruise', 'Toggle Cruise Control', 'keyboard', 'Y')
