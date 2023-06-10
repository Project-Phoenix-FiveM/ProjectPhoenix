local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('tow:requestTow')
AddEventHandler('tow:requestTow', function()
    local player = PlayerPedId()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local coords = GetEntityCoords(player)
    if vehicle ~= 0 then
        QBCore.Functions.Notify('Requested Tow Worker', 'success')
        TriggerServerEvent('tow:sendTowRequest', GetVehicleNumberPlateText(vehicle), coords)
        exports['qb-phone']:PhoneNotification('Tow Request Outgoing', 'Please wait for a response', '#9f0e63', "NONE", 10000)
    else
        QBCore.Functions.Notify('No vehicle found', 'error')
    end
end)

RegisterNetEvent('tow:requestResponse')
AddEventHandler('tow:requestResponse', function(towDriverName, accepted)
    if accepted then
        exports['qb-phone']:PhoneNotification('Tow request accepted by ' .. towDriverName, 'They will be there shortly!', '#9f0e63', "NONE", 10000)
    else
        exports['qb-phone']:PhoneNotification('Tow request declined.', 'Declined.', '#9f0e63', "NONE", 5000)
    end
end)

RegisterNetEvent('tow:receiveTowRequest')
AddEventHandler('tow:receiveTowRequest', function(target, plate, coords)

    local success = exports['qb-phone']:PhoneNotification('Tow Request: ', 'Vehicle Plate: ' .. plate, '#9f0e63', "NONE", 15000, 'fas fa-check-circle', 'fas fa-times-circle')
    if success then
        TriggerServerEvent('tow:sendTowResponse', target, true)
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipAsShortRange(blip, false)
        SetBlipSprite(blip, 68)
        SetBlipColour(blip, 0)
        SetBlipScale(blip, 0.6)
        SetBlipDisplay(blip, 6)
        Wait(130000)
        RemoveBlip(blip)
    else
        TriggerServerEvent('tow:sendTowResponse', target, false)
    end
end)