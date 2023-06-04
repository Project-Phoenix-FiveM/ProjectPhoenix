local QBCore = exports['qb-core']:GetCoreObject()
local washingVehicle = false
local listen = false
local washPoly = {}

function WashLoop()
    CreateThread(function()
        while listen do
            local PlayerPed = PlayerPedId()
            local PedVehicle = GetVehiclePedIsIn(PlayerPed, false)
            local Driver = GetPedInVehicleSeat(PedVehicle, -1)
            local dirtLevel = GetVehicleDirtLevel(PedVehicle)
            if Driver == PlayerPed and not washingVehicle then
                if IsControlPressed(0, 38) then
                    if dirtLevel > Config.DirtLevel then
                        TriggerServerEvent('qb-carwash:server:washCar')
                    else
                        QBCore.Functions.Notify(Lang:t('wash.dirty'), 'error')
                    end
                    listen = false
                    break
                end
            end
            Wait(0)
        end
    end)
end

RegisterNetEvent('qb-carwash:client:washCar', function()
    local PlayerPed = PlayerPedId()
    local PedVehicle = GetVehiclePedIsIn(PlayerPed, false)
    washingVehicle = true
    QBCore.Functions.Progressbar("search_cabin", Lang:t('wash.in_progress'), math.random(4000, 8000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        SetVehicleDirtLevel(PedVehicle, 0.0)
        SetVehicleUndriveable(PedVehicle, false)
        WashDecalsFromVehicle(PedVehicle, 1.0)
        washingVehicle = false
    end, function() -- Cancel
        QBCore.Functions.Notify(Lang:t('wash.cancel'), "error")
        washingVehicle = false
    end)
end)

CreateThread(function()
    for k,v in pairs(Config.CarWash) do
        if Config.UseTarget then
            exports["qb-target"]:AddBoxZone('carwash_'..k, v['poly'].coords, v['poly'].length, v['poly'].width, {
                name = 'carwash_'..k,
                debugPoly = false,
                heading = v['poly'].heading,
                minZ = v['poly'].coords.z - 5,
                maxZ = v['poly'].coords.z + 5,
            }, {
                    options = {
                        {
                            action = function()
                                local PlayerPed = PlayerPedId()
                                local PedVehicle = GetVehiclePedIsIn(PlayerPed, false)
                                local Driver = GetPedInVehicleSeat(PedVehicle, -1)
                                local dirtLevel = GetVehicleDirtLevel(PedVehicle)
                                if Driver == PlayerPed and not washingVehicle then
                                    if dirtLevel > Config.DirtLevel then
                                        TriggerServerEvent('qb-carwash:server:washCar')
                                    else
                                        QBCore.Functions.Notify(Lang:t('wash.dirty'), 'error')
                                    end
                                end
                            end,
                            icon = "fa-car-wash",
                            label = Lang:t('wash.wash_vehicle_target'),
                        }
                    },
                distance = 3
            })
        else
            washPoly[#washPoly+1] = BoxZone:Create(vector3(v['poly'].coords.x, v['poly'].coords.y, v['poly'].coords.z), v['poly'].length, v['poly'].width, {
                heading = v['poly'].heading,
                name = 'carwash',
                debugPoly = false,
                minZ = v['poly'].coords.z - 5,
                maxZ = v['poly'].coords.z + 5,
            })
            local washCombo = ComboZone:Create(washPoly, {name = "washPoly"})
            washCombo:onPlayerInOut(function(isPointInside)
                if isPointInside then
                    exports['qb-core']:DrawText(Lang:t('wash.wash_vehicle'),'left')
                    if not listen then
                        listen = true
                        WashLoop()
                    end
                else
                    listen = false
                    exports['qb-core']:HideText()
                end
            end)
        end
    end
end)

CreateThread(function()
    for k in pairs(Config.CarWash) do
        local coords = Config.CarWash[k]["poly"]["coords"]
        local carWash = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite (carWash, 100)
        SetBlipDisplay(carWash, 4)
        SetBlipScale  (carWash, 0.75)
        SetBlipAsShortRange(carWash, true)
        SetBlipColour(carWash, 37)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.CarWash[k]["label"])
        EndTextCommandSetBlipName(carWash)
    end
end)
