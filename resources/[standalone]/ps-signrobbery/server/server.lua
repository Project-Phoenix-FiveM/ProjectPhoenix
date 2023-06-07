local QBCore = exports['qb-core']:GetCoreObject()
local objects = {}

QBCore.Functions.CreateCallback("qb-signrobbery:server:GetObjects", function(source, cb)
    cb(objects)
end)


local table = {
    ["obj"] = {
        [-949234773] = {"stopsign"},
        [1502931467] = {"walkingmansign"},
        [1191039009] = {"dontblockintersectionsign"},
        [4138610559] = {"uturnsign"},
        [3830972543] = {"noparkingsign"},
        [2643325436] = {"leftturnsign"},
        [793482617] = {"rightturnsign"},
        [1021214550] = {"notrespassingsign"},
        [3654973172] = {"yieldsign"},
    },
    ["Items"] = {
        ["stopsign"] = {"StopSign"},
        ["walkingmansign"] = {"WalkingManSign"},
        ["dontblockintersectionsign"] = {"DontBlockIntersectionSign"},
        ["uturnsign"] = {"UturnSign"},
        ["noparkingsign"] = {"NoParkingSign"},
        ["leftturnsign"] = {"LeftTurnSign"},
        ["rightturnsign"] = {"RightTurnSign"},
        ["notrespassingsign"] = {"NoTrespassingSign"},
        ["yieldsign"] = {"YieldSign"},
    }
}

RegisterNetEvent('qb-signrobbery:server:delete')
AddEventHandler('qb-signrobbery:server:delete', function(object)
    local src = source
    local sourceCoords = GetEntityCoords(GetPlayerPed(src))
    if #(sourceCoords - object.coords) < 4 then
        local obj = table["obj"]
        local Player = QBCore.Functions.GetPlayer(tonumber(src))
        objects[#objects+1] = {coords = object.coords, model = object.model}
        TriggerClientEvent("signrobbery:client:delete", -1, object)
        if obj[object.model] then
            Player.Functions.AddItem(obj[object.model][1], 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[obj[object.model][1]], "add")
        end
	end
end)




for i,v in pairs(table['Items']) do
    QBCore.Functions.CreateUseableItem(i, function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        TriggerClientEvent('qb-signrobbery:use:'..v, src, item)
    end)
end

-- QBCore.Functions.CreateUseableItem("yieldsign", function(source, item)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     TriggerClientEvent('qb-signrobbery:use:YieldSign', src, item)
-- end)

RegisterServerEvent("SignRobbery:TradeItems", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local randomItem = ""
	local amount = 0
	if data == 1 then
		if Player.Functions.GetItemByName('stopsign') ~= nil and Player.Functions.GetItemByName('stopsign').amount >= 1 then
			Player.Functions.RemoveItem("stopsign", 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["stopsign"], 'remove', 1)	
			Citizen.Wait(500)
			for i = 1, 5, math.random(1,2) do
				randomItem = Config.Items[math.random(1, #Config.Items)]
				amount = math.random(Config.min, Config.max)
				Player.Functions.AddItem(randomItem, amount, false, {["quality"] = nil})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', amount)
                Citizen.Wait(500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You Don't Have Enough Items")
		end
	elseif data == 2 then
		if Player.Functions.GetItemByName('walkingmansign') ~= nil and Player.Functions.GetItemByName('walkingmansign').amount >= 1 then
			Player.Functions.RemoveItem("walkingmansign", "1")
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["walkingmansign"], 'remove', 1)
			Citizen.Wait(500)
			for i = 1, 5, math.random(1,2) do
				randomItem = Config.Items[math.random(1, #Config.Items)]
				amount = math.random(Config.min, Config.max)
				Player.Functions.AddItem(randomItem, amount, false, {["quality"] = nil})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', amount)
				Citizen.Wait(500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You Do Not Have Enough Items")
		end
    elseif data == 3 then
		if Player.Functions.GetItemByName('dontblockintersectionsign') ~= nil and Player.Functions.GetItemByName('dontblockintersectionsign').amount >= 1 then
			Player.Functions.RemoveItem("dontblockintersectionsign", "1")
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["dontblockintersectionsign"], 'remove', 1)
			Citizen.Wait(500)
			for i = 1, 5, math.random(1,2) do
				randomItem = Config.Items[math.random(1, #Config.Items)]
				amount = math.random(Config.min, Config.max)
				Player.Functions.AddItem(randomItem, amount, false, {["quality"] = nil})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', amount)
				Citizen.Wait(500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You Do Not Have Enough Items")
		end
    elseif data == 4 then
		if Player.Functions.GetItemByName('uturnsign') ~= nil and Player.Functions.GetItemByName('uturnsign').amount >= 1 then
			Player.Functions.RemoveItem("uturnsign", "1")
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["uturnsign"], 'remove', 1)
			Citizen.Wait(500)
			for i = 1, 5, math.random(1,2) do
				randomItem = Config.Items[math.random(1, #Config.Items)]
				amount = math.random(Config.min, Config.max)
				Player.Functions.AddItem(randomItem, amount, false, {["quality"] = nil})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', amount)
				Citizen.Wait(500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You Do Not Have Enough Items")
		end
    elseif data == 5 then
		if Player.Functions.GetItemByName('noparkingsign') ~= nil and Player.Functions.GetItemByName('noparkingsign').amount >= 1 then
			Player.Functions.RemoveItem("noparkingsign", "1")
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["noparkingsign"], 'remove', 1)
			Citizen.Wait(500)
			for i = 1, 5, math.random(1,2) do
				randomItem = Config.Items[math.random(1, #Config.Items)]
				amount = math.random(Config.min, Config.max)
				Player.Functions.AddItem(randomItem, amount, false, {["quality"] = nil})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', amount)
				Citizen.Wait(500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You Do Not Have Enough Items")
		end
    elseif data == 6 then
		if Player.Functions.GetItemByName('leftturnsign') ~= nil and Player.Functions.GetItemByName('leftturnsign').amount >= 1 then
			Player.Functions.RemoveItem("leftturnsign", "1")
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["leftturnsign"], 'remove', 1)
			Citizen.Wait(500)
			for i = 1, 5, math.random(1,2) do
				randomItem = Config.Items[math.random(1, #Config.Items)]
				amount = math.random(Config.min, Config.max)
				Player.Functions.AddItem(randomItem, amount, false, {["quality"] = nil})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', amount)
				Citizen.Wait(500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You Do Not Have Enough Items")
		end
	elseif data == 7 then
		if Player.Functions.GetItemByName('rightturnsign') ~= nil and Player.Functions.GetItemByName('rightturnsign').amount >= 1 then
			Player.Functions.RemoveItem("rightturnsign", "1")
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["rightturnsign"], 'remove', 1)
			Citizen.Wait(500)
			for i = 1, 5, math.random(1,2) do
				randomItem = Config.Items[math.random(1, #Config.Items)]
				amount = math.random(Config.min, Config.max)
				Player.Functions.AddItem(randomItem, amount, false, {["quality"] = nil})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', amount)
				Citizen.Wait(500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You Do Not Have Enough Items")
		end
	elseif data == 8 then
		if Player.Functions.GetItemByName('notrespassingsign') ~= nil and Player.Functions.GetItemByName('notrespassingsign').amount >= 1 then
			Player.Functions.RemoveItem("notrespassingsign", "1")
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["notrespassingsign"], 'remove', 1)
			Citizen.Wait(500)
			for i = 1, 5, math.random(1,2) do
				randomItem = Config.Items[math.random(1, #Config.Items)]
				amount = math.random(Config.min, Config.max)
				Player.Functions.AddItem(randomItem, amount, false, {["quality"] = nil})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', amount)
				Citizen.Wait(500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You Do Not Have Enough Items")
		end
	elseif data == 9 then
		if Player.Functions.GetItemByName('yieldsign') ~= nil and Player.Functions.GetItemByName('yieldsign').amount >= 1 then
			Player.Functions.RemoveItem("yieldsign", "1")
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["yieldsign"], 'remove', 1)
			Citizen.Wait(500)
			for i = 1, 5, math.random(1,2) do
				randomItem = Config.Items[math.random(1, #Config.Items)]
				amount = math.random(Config.min, Config.max)
				Player.Functions.AddItem(randomItem, amount, false, {["quality"] = nil})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', amount)
				Citizen.Wait(500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "You Do Not Have Enough Items")
		end
    end
end)