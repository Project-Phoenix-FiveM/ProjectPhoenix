-- Notification
RegisterNetEvent('av_laptop:notification', function(title, description, type)
    lib.defaultNotify({
        title = title,
        description = description,
        status = type
    })
end)

-- Alert Owner Blip n Coords
RegisterNetEvent('av_laptop:alert', function(message,coords)
    TriggerEvent('av_laptop:notification',Lang['alert_title'], message, 'error')
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 2.0)
    SetBlipColour(blip, 3)
    PulseBlip(blip)
    Wait(60000)
    RemoveBlip(blip)
end)

-- Player Spawned
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Wait(500)
    TriggerEvent('av_laptop:playerSpawn')
end)

AddEventHandler('esx:playerLoaded', function(xPlayer)
    Wait(500)
    TriggerEvent('av_laptop:playerSpawn')
end)