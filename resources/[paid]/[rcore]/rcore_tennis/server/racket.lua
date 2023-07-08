local TennisRackets = {}


RegisterNetEvent('rcore_tennis:requestRacket', function()
    TennisRackets[source] = true
    TriggerClientEvent('rcore_tennis:setTennisRacketInHand', -1, source)
end)

RegisterNetEvent('rcore_tennis:deleteRacket', function()
    TennisRackets[source] = nil
    TriggerClientEvent('rcore_tennis:unsetTennisRacketInHand', -1, source)
end)

AddEventHandler('playerDropped', function()
    TennisRackets[source] = nil
    TriggerClientEvent('rcore_tennis:unsetTennisRacketInHand', -1, source)
end)

AddEventHandler('playerJoining', function()
    local Source = source
    TriggerClientEvent('rcore_tennis:setAllTennisRacketInHand', Source, TennisRackets)
end)


