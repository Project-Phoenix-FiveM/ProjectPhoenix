deliveryBlip = nil
local deliveryCoords = nil
local closeCops = false
local deliveryPoint = nil
local deliveryVehicle = nil
local sameVehicle = false
local vinTarget = false

AddEventHandler('av_boosting:setDelivery', function(vehicle,type)
    if not type then return end
    if deliveryBlip and DoesBlipExist(deliveryBlip) then
        RemoveBlip(deliveryBlip)
        deliveryBlip = nil
    end
    if deliveryCoords then
        deliveryCoords = nil
    end
    if deliveryPoint then
        deliveryPoint:remove()
    end
    deliveryVehicle = nil
    if not deliveryBlip and not isCop() then
        local plate = GetVehicleNumberPlateText(vehicle)
        deliveryCoords = getDeliveryCoords(plate)
        if deliveryCoords and deliveryCoords[1] then
            deliveryVehicle = vehicle
            CreateDeliveryBlip(deliveryCoords)
            deliveryPoint = lib.points.new(vector3(deliveryCoords[1], deliveryCoords[2], deliveryCoords[3]), 15, {
                vehicle = vehicle,
            })
            DisplayText(Lang['bring_vehicle'],"show")
            CreateThread(function()
                while inVehicle do
                    local vehicles = GetGamePool('CVehicle')
                    local myCoords = GetEntityCoords(PlayerPedId())
                    local count = 0
                    for i=1, #vehicles do
                        if vehicles[i] ~= vehicle then
                            local dist = #(vector3(myCoords.x, myCoords.y, myCoords.z) - GetEntityCoords(vehicles[i]))
                            if dist <= Config.PoliceRadiusCheck then
                                local class = GetVehicleClass(vehicles[i])
                                if class == 17 or class == 18 then
                                    count = count + 1
                                end
                            end
                        end
                    end
                    if count > 0 then
                        closeCops = true
                        DisplayText(Lang['lose_cops'],"show")
                    end
                    Wait(2000)
                    if count == 0 and closeCops then
                        closeCops = false
                        DisplayText(Lang['bring_vehicle'],"show")
                    end
                end
            end)
            function deliveryPoint:onEnter()
                if not inVehicle then return end
                if closeCops then
                    DisplayText(Lang['lose_cops'])
                else
                    local veh = GetVehiclePedIsIn(PlayerPedId(),false)
                    local state = Entity(veh).state
                    if not state.boosting then
                        DisplayText(Lang['wrong_vehicle'])
                    end
                    if state.boosting == "vin" then
                        CreateVinTarget(veh)
                        vinTarget = true
                        DisplayText(Lang['scratch_target'])
                    else
                        DisplayText(Lang['leave_vehicle'])
                        sameVehicle = true
                    end
                end
            end
            function deliveryPoint:onExit()
                if vinTarget then
                    vinTarget = false
                    RemoveVinTarget()
                else
                    if not inVehicle and not closeCops and sameVehicle then
                        if deliveryVehicle then
                            local netId = NetworkGetNetworkIdFromEntity(deliveryVehicle)
                            local plates = GetVehicleNumberPlateText(deliveryVehicle)
                            TriggerServerEvent('av_boosting:pay',netId,plates)
                        end
                        DisplayText(1,"close")
                    end
                end
                DisplayText(false,"close")
                sameVehicle = false
                deliveryVehicle = nil
            end
        end
    end
end)

RegisterNetEvent('av_boosting:wipe', function()
    if deliveryBlip and DoesBlipExist(deliveryBlip) then
        RemoveBlip(deliveryBlip)
        deliveryBlip = nil
    end
    if missionBlip and DoesBlipExist(missionBlip) then
        RemoveBlip(missionBlip)
        missionBlip = nil
    end
    if deliveryCoords then
        deliveryCoords = nil
    end
    if deliveryPoint then
        deliveryPoint:remove()
    end
    deliveryVehicle = nil
    DisplayText(false,"close")
    inMission = false
end)

function getDeliveryCoords(plate)
    return lib.callback.await('av_boosting:getDeliveryCoords', false, plate)
end

function CreateDeliveryBlip(coords)
    if not coords then return end
    deliveryBlip = AddBlipForCoord(coords[1], coords[2], coords[3])
    SetBlipSprite(deliveryBlip,Config.DeliveryBlip['sprite'])
    SetBlipAlpha(deliveryBlip, 255)
    SetBlipScale(deliveryBlip,Config.DeliveryBlip['scale'])
    SetBlipHighDetail(deliveryBlip, true)
    SetBlipColour(deliveryBlip, Config.DeliveryBlip['color'])
    SetBlipAsShortRange(deliveryBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Lang['blip_text'])
    EndTextCommandSetBlipName(deliveryBlip) 
end