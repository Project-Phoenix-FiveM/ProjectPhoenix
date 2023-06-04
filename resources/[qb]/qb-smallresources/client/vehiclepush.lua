local bones = {'bonnet', 'boot'}
local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)
local IsInFront = false

local function loadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

RegisterNetEvent('vehiclepush:client:push', function(veh)
    if veh then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(veh)
        local dimension = GetModelDimensions(GetEntityModel(veh), First, Second)
        local vehClass = GetVehicleClass(veh)
        if not IsEntityAttachedToEntity(ped, veh) and IsVehicleSeatFree(veh, -1) and GetVehicleEngineHealth(veh) <= Config.DamageNeeded and GetVehicleEngineHealth(veh) >= 0 then
            if vehClass ~= 13 or vehClass ~= 14 or vehClass ~= 15 or vehClass ~= 16 then
                NetworkRequestControlOfEntity(veh)
                if #(pos - vehpos) < 3.0 and not IsPedInAnyVehicle(ped, false) then
                    if #(vehpos + GetEntityForwardVector(veh) - pos) > #(vehpos + GetEntityForwardVector(veh) * -1 - pos) then
                        IsInFront = false
                        AttachEntityToEntity(ped, veh, GetPedBoneIndex(ped, 6286), 0.0, dimension.y - 0.3, dimension.z + 1.0, 0.0, 0.0, 0.0, false, false, false, true, 0, true)
                        else
                        IsInFront = true
                        AttachEntityToEntity(ped, veh, GetPedBoneIndex(ped, 6286), 0.0, dimension.y * -1 + 0.1, dimension.z + 1.0, 0.0, 0.0, 180.0, false, false, false, true, 0, true)
                    end
                    loadAnimDict('missfinale_c2ig_11')
                    TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, false, false, false)
                    exports['qb-core']:DrawText(Lang:t('pushcar.stop_push'),'left')
                    while true do
                        Wait(0)
                        if IsDisabledControlPressed(0, 34) then
                            TaskVehicleTempAction(ped, veh, 11, 1000)
                        end

                        if IsDisabledControlPressed(0, 9) then
                            TaskVehicleTempAction(ped, veh, 10, 1000)
                        end

                        if IsInFront then
                            SetVehicleForwardSpeed(veh, -1.0)
                        else
                            SetVehicleForwardSpeed(veh, 1.0)
                        end

                        if HasEntityCollidedWithAnything(veh) then
                            SetVehicleOnGroundProperly(veh)
                        end

                        if IsControlJustPressed(0, 38) then
                            exports['qb-core']:HideText()
                            DetachEntity(ped, false, false)
                            StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                            FreezeEntityPosition(ped, false)
                            break
                        end
                    end
                end
            end
        end
    end
end)

CreateThread(function()
    exports['qb-target']:AddTargetBone(bones, {
        options = {
            ["Push Vehicle"] = {
                icon = "fas fa-wrench",
                label = "Push Vehicle",
                action = function(entity)
                    TriggerEvent('vehiclepush:client:push', entity)
                end,
                distance = 1.3
            }
        }
    })
end)
