local QBCore = exports['qb-core']:GetCoreObject()

local depotprice = 0

local billedplayer = nil

RegisterNetEvent('rhodinium-seizelot:client:GetSeizedList', function()
    QBCore.Functions.TriggerCallback('qb-garages:server:GetDepotVehiclesPD', function(vehcheck)   
        local vehiclelist = false

        local menu = {{
            header = "< Go Back",
            params = {
                event = "Garages:OpenDepot",
            }
        }}
        for i=1, #vehcheck do
            if vehcheck[i].state == 2 then
                table.insert(menu, {
                    header = QBCore.Shared.Vehicles[vehcheck[i].vehicle].name,
                    txt = "Plate: "..vehcheck[i].plate.." | Fine: "..vehcheck[i].depotprice.."$",
                    params = {
                        event = "rhodinium-seizelot:client:PoliceReturn",
                        args = {
                            plate = vehcheck[i].plate,
                                vehicle = vehcheck[i].vehicle,
                                engine = vehcheck[i].engine,
                                body = vehcheck[i].body,
                                fuel = vehcheck[i].fuel,
                                fine = vehcheck[i].depotprice,
                                garage = vehcheck[i].garage
                        }
                    }
                }) 
                depotprice = vehcheck[i].depotprice
                billedplayer = vehcheck[i].citizenid
                vehiclelist = true
            end
            if vehiclelist then 
                exports['qb-menu']:openMenu(menu)
                return
            end
        end
        if not vehiclelist then
            TriggerEvent('QBCore:Notify', "There are no seized vehicles", "error", 3000)
        end
    end)
end)

RegisterNetEvent('rhodinium-seizelot:client:PoliceReturn', function(data)
    local parking = vector3(449.60443, -1025.376, 28.582607)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local coords = GetEntityCoords(PlayerPedId())
    local model = GetHashKey(data.vehicle)
    if not IsModelInCdimage(model) then Citizen.Wait(10) end
    RequestModel(model)
    while not HasModelLoaded(model) do Citizen.Wait(10) end
    veh = CreateVehicle(model, parking.x, parking.y, parking.z, 3.7462151, true, false)
    local netid = NetworkGetNetworkIdFromEntity(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetNetworkIdCanMigrate(netid, true)
    SetModelAsNoLongerNeeded(model)
    QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
        QBCore.Functions.TriggerCallback('qb-garages:server:GetVehicleWheelfit', function(wheelfit)
            if wheelfit ~= nil then
                TriggerServerEvent('qb-wheelfitment_sv:setfit', wheelfit, veh)
            end
        end, data.plate)
        QBCore.Functions.SetVehicleProperties(veh, properties)
        SetVehicleNumberPlateText(veh, data.plate)
        exports['cdn-fuel']:SetFuel(veh, data.fuel)
        SetEntityAsMissionEntity(veh, true, true)
        SetVehicleEngineOn(veh, false, false)
        SetVehicleProperties(veh, properties)
    end, data.plate, false)
    QBCore.Functions.Notify('The seized vehicle is now outside and is locked', 'success')
    while true do
        local vcoords = GetEntityCoords(veh)
        local pcoords = GetEntityCoords(PlayerPedId())
        local distance = #(vcoords - pcoords)
        Wait(1000)
        if distance <= 5.0 then
            TriggerEvent('rhodinium-seizelot:client:ReturnVehicle', data)
            return false
        end
    end
end)

SetVehicleProperties = function(vehicle, vehicleProps)
    QBCore.Functions.SetVehicleProperties(vehicle, vehicleProps)

    if vehicleProps["windows"] then
        for windowId = 1, 13, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
end

RegisterNetEvent('rhodinium-seizelot:client:ReturnVehicle', function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()
    seizeinfo = exports['qb-input']:ShowInput({
        header = "Seize Decision",
        inputs = {
            {
                text = "Return Vehicle(Yes/No)",
                name = 'decision',
                type = 'text',
                isRequired = true
            },
        }
    })
    if seizeinfo == nil then
        return
    else
        if seizeinfo.decision == 'Yes' then
            TriggerServerEvent('rhodinium:server:CreateInvoice', billedplayer, PlayerData.job.name, PlayerData.charinfo.firstname, PlayerData.citizenid, depotprice)
            TriggerServerEvent('rhodinium-seizelot:server:ReturnVehicle', data)
            QBCore.Functions.Notify('Vehicle was returned', 'success')
        else
            if seizeinfo.decision == 'No' then
                QBCore.Functions.DeleteVehicle(veh)
                QBCore.Functions.Notify('Vehicle was not returned', 'error')
            end
        end
    end
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("PDSeized",vector3(444.59, -985.03, 30.69), 1.0, 1.4, {
        name = "PDSeized",
        debugPoly = false,
        heading = 2,
        minZ=27.69,
    maxZ=31.69,
    }, {
        options = {
            {
                type = "client",
                event = "rhodinium-seizelot:client:GetSeizedList",  
                icon = "fas fa-wrench", 
                label = "Seized Vehicle List",
                job = "police",
            }
        },
        distance = 2.5
    })
end)
