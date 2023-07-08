RegisterNUICallback('distCheck', function(_, cb)
    local inZone = exports['qb-hotspot']:inBennys()
    cb(inZone)
end)

RegisterNUICallback('connectHotspot', function(data, cb)
    if not data then return end
    TriggerEvent('qb-hotspot:client:connectToHotspot', data)
    cb('ok')
end)

RegisterNUICallback('isConnected', function(_, cb)
    local connected = exports['qb-hotspot']:isConnected()
    cb(connected)
end)

RegisterNUICallback('getMilkItems', function(_, cb)
    cb(Config.Milkroad)
end)

RegisterNUICallback('purchaseMilkroadItems', function(data, cb)
    if not data then return end
    TriggerServerEvent('qb-hotspot:server:purchaseMilkroadItems', data)
    cb('ok')
end)


