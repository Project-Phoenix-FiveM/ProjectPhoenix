Citizen.CreateThread(function()
	local Houses = {}
	local HouseGarages = {}

	--SRPCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
	    local result = exports.oxmysql:fetchSync('SELECT * FROM `houselocations`', {})

		if result[1] then
			for k, v in pairs(result) do
				local owned = false
				if tonumber(v.owned) == 1 then
					owned = true
				end
				local garage = v.garage ~= nil and json.decode(v.garage) or {}
				
				Houses[v.name] = {
					coords = json.decode(v.coords),
					owned = v.owned,
					price = v.price,
					locked = true,
					adress = v.label, 
					tier = v.tier,
					garage = garage,
					decorations = {},
				}
				HouseGarages[v.name] = {
					label = v.label,
					takeVehicle = garage,
				}
			end
		end

		TriggerClientEvent("srp-garages:client:houseGarageConfig", -1, HouseGarages)
		TriggerClientEvent("srp-houses:client:setHouseConfig", -1, Houses)
	--end)
end)

SRPCore.Functions.CreateCallback('srp-multicharacter:server:getOwnedHouses', function(source, cb, cid)
	if cid then
		--SRPCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_houses` WHERE `citizenid` = "'..cid..'"', function(ownedHouses)
		    local ownedHouses = exports.oxmysql:fetchSync('SELECT * FROM `player_houses` WHERE `citizenid` = ?', {cid})

			if ownedHouses[1] ~= nil then
				cb(ownedHouses)
			else
				cb(nil)
			end
		--end)
	else
		cb(nil)
	end
end)

RegisterServerEvent('srp-multicharacter:server:finishCreateChar')
AddEventHandler('srp-multicharacter:server:finishCreateChar', function()
    local src = source
    local Player = SRPCore.Functions.GetPlayer(src)
	
    --SRPCore.Functions.ExecuteSql(false, "UPDATE `players` SET created = 1 WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'")
    exports.oxmysql:execute('UPDATE `players` SET `created` = 1 WHERE `citizenid` = ?', {Player.PlayerData.citizenid})
end)