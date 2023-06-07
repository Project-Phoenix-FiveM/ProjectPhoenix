
local QBCore = exports['qb-core']:GetCoreObject()

--req tow
RegisterServerEvent('tow:sendTowRequest')
AddEventHandler('tow:sendTowRequest', function(plate, coords)
    local src = source
    local players = QBCore.Functions.GetPlayers()
    for _, playerId in ipairs(players) do
        local player = QBCore.Functions.GetPlayer(playerId)
        if player ~= nil and player.PlayerData.job.name == 'tow' then
            TriggerClientEvent('tow:receiveTowRequest', playerId, src, plate, coords)
        end
    end
end)

RegisterServerEvent('tow:sendTowResponse')
AddEventHandler('tow:sendTowResponse', function(target, accepted)
    local towDriver = QBCore.Functions.GetPlayer(source)
    local towDriverName = towDriver.PlayerData.charinfo.firstname

    TriggerClientEvent('tow:requestResponse', target, towDriverName, accepted)
end)