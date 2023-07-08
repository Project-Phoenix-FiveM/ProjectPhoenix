local QBCore = exports['qb-core']:GetCoreObject()

local CoolDown = false

RegisterServerEvent('qb-banktrucks:server:coolout', function()
    CoolDown = true
    local timer = Config.CoolDown
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            CoolDown = false
        end
    end
end)

QBCore.Functions.CreateCallback("qb-banktrucks:server:coolc",function(source, cb)
    if CoolDown then
        cb(true)
    else
        cb(false) 
    end
end)

QBCore.Functions.CreateCallback('qb-banktrucks:server:hasItem', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local hasItem = Player.Functions.GetItemByName("laptop")
    if hasItem then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-banktrucks:server:giveitem', function ()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("gps-device", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["gps-device"], "add")
end)

RegisterServerEvent('qb-banktrucks:server:Payouts', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local rewardamt = math.random(Config.MinReward,Config.MaxReward)
	local info = {
		worth = math.random(Config.MinPayout, Config.MaxPayout)
	}
    local rareamt = Config.RareItemAmt
	Player.Functions.AddItem(Config.Reward, rewardamt, false, info)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Reward], "add",rewardamt)

	local chance = math.random(1, 100)
	if chance >= 95 then
		Player.Functions.AddItem(Config.RareItem, rareamt)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.RareItem], "add", rareamt)
	end
	Wait(2500)
end)

RegisterServerEvent('qb-banktrucks:server:DeliveryPayouts', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local rewardamt = math.random(Config.DeliveryMinReward,Config.DeliveryMaxReward)
	local info = {
		worth = math.random(Config.DeliveryMinPayout, Config.DeliveryMaxPayout)
	}
    local rareamt = Config.DeliveryRareItemAmt
	Player.Functions.AddItem(Config.DeliveryReward, rewardamt, false, info)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.DeliveryReward], "add",rewardamt)

	local chance = math.random(1, 100)
	if chance >= 95 then
		Player.Functions.AddItem(Config.DeliveryRareItem, rareamt)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.DeliveryRareItem], "add", rareamt)
	end
	Wait(2500)
end)

QBCore.Functions.CreateUseableItem("gps-device", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item.name, 1) then
        TriggerClientEvent("qb-banktrucks:client:gettruck", src, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("kthermite", function(source, item)
    local src = source
    TriggerClientEvent("qb-banktrucks:client:usethermite", src, item.name)
end)

RegisterNetEvent('banktrucks:policegps', function (TruckPos)
    TriggerClientEvent('banktrucks:policegps', -1, TruckPos)
end)