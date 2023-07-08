local QBCore = exports['qb-core']:GetCoreObject()

for name, data in pairs(Config.BuffItems) do
	QBCore.Functions.CreateUseableItem(name, function(source, item)
        local PlayerId = source
        local Player = QBCore.Functions.GetPlayer(PlayerId)
        if Player.Functions.RemoveItem(name, 1, false) then
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[name], 'remove')
            TriggerClientEvent('kevin-buffconsumables:consume', source, name, data)
        end
    end)
end