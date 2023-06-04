local vehiclemeters = -1
local previousvehiclepos = nil
local CheckDone = false
DrivingDistance = {}

-- Functions

local function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
      local mult = 10^numDecimalPlaces
      return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

local function GetDamageMultiplier(meters)
    local check = round(meters / 1000, -2)
    local retval = nil
    for k, v in pairs(Config.MinimalMetersForDamage) do
        if check >= v.min and check <= v.max then
            retval = k
            break
        elseif check >= Config.MinimalMetersForDamage[#Config.MinimalMetersForDamage].min then
            retval = #Config.MinimalMetersForDamage
            break
        end
    end
    return retval
end

local function trim(plate)
    if not plate then return nil end
    return (string.gsub(plate, '^%s*(.-)%s*$', '%1'))
end

-- Events

RegisterNetEvent('qb-vehicletuning:client:UpdateDrivingDistance', function(amount, plate)
    DrivingDistance[plate] = amount
end)

-- Threads

CreateThread(function()
    Wait(500)
    while true do
        local ped = PlayerPedId()
        local invehicle = IsPedInAnyVehicle(ped, true)
        if invehicle then
            local veh = GetVehiclePedIsIn(ped)
            local seat = GetPedInVehicleSeat(veh, -1)
            local pos = GetEntityCoords(ped)
            local plate = trim(GetVehicleNumberPlateText(veh))
            if plate ~= nil then
                if seat == ped then
                    if not CheckDone then
                        if vehiclemeters == -1 then
                            CheckDone = true
                            QBCore.Functions.TriggerCallback('qb-vehicletuning:server:IsVehicleOwned', function(IsOwned)
                                if IsOwned then
                                    if DrivingDistance[plate] ~= nil then
                                        vehiclemeters = DrivingDistance[plate]
                                    else
                                        DrivingDistance[plate] = 0
                                        vehiclemeters = DrivingDistance[plate]
                                    end
                                else
                                    if DrivingDistance[plate] ~= nil then
                                        vehiclemeters = DrivingDistance[plate]
                                    else
                                        DrivingDistance[plate] = math.random(111111, 999999)
                                        vehiclemeters = DrivingDistance[plate]
                                    end
                                end
                            end, plate)
                        end
                    end
                else
                    if vehiclemeters == -1 then
                        if DrivingDistance[plate] ~= nil then
                            vehiclemeters = DrivingDistance[plate]
                        end
                    end
                end

                if vehiclemeters ~= -1 then
                    if seat == ped then
                        if previousvehiclepos ~= nil then
                            local Distance = #(pos - previousvehiclepos)
                            local DamageKey = GetDamageMultiplier(vehiclemeters)

                            vehiclemeters = vehiclemeters + ((Distance / 100) * 325)
                            DrivingDistance[plate] = vehiclemeters

                            if DamageKey ~= nil then
                                local DamageData = Config.MinimalMetersForDamage[DamageKey]
                                local chance = math.random(3)
                                local odd = math.random(3)
                                local CurrentData = VehicleStatus[plate]
                                if chance == odd then
                                    for k, _ in pairs(Config.Damages) do
                                        local randmultiplier = (math.random(DamageData.multiplier.min, DamageData.multiplier.max) / 100)
                                        local newDamage = 0
                                        if CurrentData[k] - randmultiplier >= 0 then
                                            newDamage = CurrentData[k] - randmultiplier
                                        end
                                        TriggerServerEvent('qb-vehicletuning:server:SetPartLevel', plate, k, newDamage)
                                    end
                                end
                            end

                            local amount = round(DrivingDistance[plate] / 1000, -2)

                            TriggerEvent('hud:client:UpdateDrivingMeters', true, amount)
                            TriggerServerEvent('qb-vehicletuning:server:UpdateDrivingDistance', DrivingDistance[plate], plate)
                        end
                    else
                        if invehicle then
                            if DrivingDistance[plate] ~= nil then
                                local amount = round(DrivingDistance[plate] / 1000, -2)
                                TriggerEvent('hud:client:UpdateDrivingMeters', true, amount)
                            end
                        else
                            if vehiclemeters ~= -1 then
                                vehiclemeters = -1
                            end
                            if CheckDone then
                                CheckDone = false
                            end
                        end
                    end
                end

                previousvehiclepos = pos
            end
        else
            if vehiclemeters ~= -1 then
                vehiclemeters = -1
            end
            if CheckDone then
                CheckDone = false
            end
            if previousvehiclepos ~= nil then
                previousvehiclepos = nil
            end
        end

        if invehicle then
            Wait(2000)
        else
            Wait(500)
        end
    end
end)