local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem("lotto", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-lotto:usar", source)
    end
end)


RegisterServerEvent('qb-lotto:win')
AddEventHandler('qb-lotto:win', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local money = math.random(100, 200)
	Player.Functions.AddMoney('cash', money)
end)
