QBCore = exports['qb-core']:GetCoreObject()


-- Events

local obj = {}



RegisterNetEvent('qb-parkingmeter:client:payParking', function()
    local pos = GetEntityCoords(PlayerPedId())
    TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
    local playerPed = GetPlayerPed(-1)
    local prop = GetClosestObjectOfType(GetEntityCoords(playerPed), 3.0, GetHashKey("prop_parknmeter_01"), false, false, false)
    local prop2 = GetClosestObjectOfType(GetEntityCoords(playerPed), 3.0, GetHashKey("prop_parknmeter_02"), false, false, false)

    QBCore.Functions.Progressbar("drilling", "Making payment...", 3000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStop')
        QBCore.Functions.TriggerCallback('qb-parkingmeter:server:checkParking', function(isPaid)
            if isPaid then
                QBCore.Functions.Notify('Parking is already paid!', 'error', 5000)
            else
                TriggerServerEvent('qb-parkingmeter:server:payParking', pos)
                if DoesEntityExist(prop) then
                    local propCoords = GetEntityCoords(prop)
                    obj.text = "$ PAID" 
                    obj.color = "#00a500"
                    obj.viewdistance = 7
                    obj.expiration = 1
                    obj.fontsize = 0.4
                    obj.fontstyle = 4
                    obj.coords = vector3(propCoords.x , propCoords.y, propCoords.z+1)
                end
                if DoesEntityExist(prop2) then
                    local propCoords = GetEntityCoords(prop2)
                    obj.text = "$ PAID" 
                    obj.color = "#00a500"
                    obj.viewdistance = 2
                    obj.expiration = 1
                    obj.fontsize = 0.4
                    obj.fontstyle = 4
                    obj.coords = vector3(propCoords.x , propCoords.y, propCoords.z+1)
                end
                TriggerServerEvent("qb-scenes:server:CreateScene",obj)
            end
        end, pos)
    end, function()
        TriggerEvent('animations:client:EmoteCommandStop')
        QBCore.Functions.Notify('Canceled!', 'error', 5000)
    end)
end)

RegisterNetEvent('qb-parkingmeter:client:checkParking', function()
    local pos = GetEntityCoords(PlayerPedId())
    TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
    QBCore.Functions.Progressbar("drilling", "Checking payment...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStop')
        QBCore.Functions.TriggerCallback('qb-parkingmeter:server:checkParking', function(isPaid)
            if isPaid then
                QBCore.Functions.Notify('Parking is paid!', 'success', 5000)
            else
                QBCore.Functions.Notify('Parking is not paid!', 'error', 5000)
            end
        end, pos)
    end, function()
        TriggerEvent('animations:client:EmoteCommandStop')
        QBCore.Functions.Notify('Canceled!', 'error', 5000)
    end)
end)

local ParkingMeters = {
    -1940238623,
    2108567945,
}

exports['qb-target']:AddTargetModel(ParkingMeters, {
    options = {
        {
        type = "client",
        event = "qb-parkingmeter:client:payParking",
        icon = "fas fa-parking",
        label = "Pay Parking ($5)",
        },
        { 	
            type = "client",
            event = "qb-parkingmeter:client:checkParking",
            icon = "fas fa-parking",
            label = "Check payment (Police)",
            job = "police",
        },
    },
    distance = 2.5,
})