inVehicle = false
local currentVehicle = nil

CreateThread(function()
    local w = 1000
    while true do
        w = 1000
        if IsPedInAnyVehicle(PlayerPedId()) then
            inVehicle = true
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
			local seat = GetPedVehicleSeat(PlayerPedId())
            TriggerEvent("av_boosting:enterVehicle", veh, seat)
            while inVehicle do
                if not IsPedInAnyVehicle(PlayerPedId()) then
                    TriggerEvent("av_boosting:exitvehicle")
                    inVehicle = false
                end
                Wait(50)
            end
        end
        Wait(w)
    end
end)

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end

AddEventHandler('av_boosting:enterVehicle', function(veh, seat)
    local state = Entity(veh).state
    local plates = GetVehicleNumberPlateText(veh)
    if seat == -1 then
        if state and state.boosting then
            currentVehicle = veh
            if missionBlip and DoesBlipExist(missionBlip) then
                RemoveBlip(missionBlip)
                missionBlip = nil
            end
            if state.hacks and state.hacks > 0 then
                while inVehicle do
                    if not state.hacks or state.hacks <= 0 then
                        TriggerServerEvent('av_boosting:removeBlip',plates)
                        break
                    end
                    if not state.cooldown then
                        DisplayText(Lang['hack_msg']..' ('..state.hacks..')',"show")
                        TriggerServerEvent('av_boosting:sendBlip',GetEntityCoords(PlayerPedId()), plates)
                    end
                    Wait(3000)
                end
            end
            if not state.hacks or state.hacks <= 0 then
                DisplayText(1,"close")
                Wait(500)
                TriggerEvent('av_boosting:setDelivery',currentVehicle,state.boosting)
            end
        end
    end
    if seat == 0 then
        if state and state.boosting then
            currentVehicle = veh
            if missionBlip and DoesBlipExist(missionBlip) then
                RemoveBlip(missionBlip)
                missionBlip = nil
            end
            if state.hacks and state.hacks > 0 then
                while inVehicle do
                    DisplayText(Lang['hack_msg']..' ('..state.hacks..')',"show")
                    if not state.hacks or state.hacks <= 0 then
                        local coords = getDeliveryCoords(plates)
                        if coords then
                            CreateDeliveryBlip(coords)
                            DisplayText(Lang['bring_vehicle'],"show")
                            Wait(4000)
                        end
                        DisplayText(false,"close")
                        TriggerServerEvent('av_boosting:removeBlip',plates)
                        break
                    end
                    Wait(1000)
                    if state.cooldown then
                        DisplayText(Lang['in_cooldown']..' ('..Config.HackingCooldown..') '..Lang['seconds'],"show")
                        Wait(Config.HackingCooldown * 1000)
                        local netId = NetworkGetNetworkIdFromEntity(currentVehicle)
                        TriggerServerEvent('av_boosting:removeHack',netId,false,false,plates)
                    end
                    if (GetPedVehicleSeat(PlayerPedId()) == -1) and not state.cooldown then
                        TriggerServerEvent('av_boosting:sendBlip',GetEntityCoords(PlayerPedId()), plates)
                    end
                end
            end
        end
    end
end)

AddEventHandler('av_boosting:exitvehicle', function()
    if currentVehicle then
        currentVehicle = nil
        DisplayText(false,"close")
    end
end)