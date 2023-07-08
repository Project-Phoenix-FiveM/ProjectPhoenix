local PoolCues = {}

RegisterNetEvent('rcore_pool:requestPoolCue', function()
    PoolCues[source] = true
    TriggerClientEvent('rcore_pool:setPoolCueInHand', -1, source)
end)

RegisterNetEvent('rcore_pool:requestRemoveCue', function()
    PoolCues[source] = nil
    TriggerClientEvent('rcore_pool:unsetPoolCueInHand', -1, source)
    PoolCueTable[source] = nil -- used to remove pool cue when leaving position
end)

AddEventHandler('playerDropped', function()
    PoolCues[source] = nil
    TriggerClientEvent('rcore_pool:unsetPoolCueInHand', -1, source)
end)

AddEventHandler('playerJoining', function()
    local Source = source
    TriggerClientEvent('rcore_pool:setAllPoolCueInHand', Source, PoolCues)
end)

