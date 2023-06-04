local QBCore = exports['qb-core']:GetCoreObject()
local Plates = {}

local function GenerateOwnerName()
	local first = Config.FakeNames.first[math.random(1, #Config.FakeNames.first)]
	local last = Config.FakeNames.last[math.random(1, #Config.FakeNames.last)]
	local fullname = first..' '..last
	return fullname
end

local function GetBoloStatus(plate, name)
    local result = MySQL.query.await("SELECT * FROM mdt_bolos WHERE plate = @plate OR owner = @owner OR individual = @person", {
		['@plate'] = plate,
		['@owner'] = name,
		['@person'] = name,
	})
	if result and result[1] then
		return true
	else
		return false
	end
end

local function GetStolenStatus(plate)
    local result = MySQL.query.await("SELECT * FROM mdt_vehicleinfo WHERE plate = @plate", {
        ['@plate'] = plate
    })
    if not result[1] then return false end
    if result[1].stolen then return true end
    return false
end

local function GetWarrantStatus(cid)
    local result = MySQL.query.await("SELECT * FROM mdt_convictions WHERE cid = @cid", {
        ['@cid'] = cid
    })
    if not result[1] then return false end
    if result[1].warrant == "1" then return true end
    return false
end

RegisterNetEvent("qb-platescan:server:AddStolenPlate", function(data)
	local veh, plate, name, class = data.veh, data.plate, data.name, data.class
	if type(plate) ~= "string" then return end
	local vehicle = MySQL.query.await("select pv.*, p.charinfo from player_vehicles pv LEFT JOIN players p ON pv.citizenid = p.citizenid WHERE pv.plate = :plate LIMIT 1", {
		plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
	})
	if not vehicle[1] then
		if not Plates[plate] then
			local person = GenerateOwnerName()
			Plates[plate] = {
				veh = veh,
				name = name,
				class = class,
				owner = person,
				bolo = false,
				stolen = true,
				warrant = false,
			}
		else
			Plates[plate].veh = veh
			Plates[plate].class = class
			Plates[plate].stolen = true
		end
		if Config.Debug then print(json.encode(Plates[plate])) end
	end
end)

RegisterNetEvent("qb-platescan:server:ScanPlate", function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local veh, plate, name, class, locked = data.veh, data.plate, data.name, data.class, data.locked
	local vehData
	print('something else')
	if plate ~= "" and plate ~= nil then
		local vehicle = MySQL.query.await("select pv.*, p.charinfo from player_vehicles pv LEFT JOIN players p ON pv.citizenid = p.citizenid WHERE pv.plate = :plate LIMIT 1", {
			plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
		})
		QBCore.Debug(vehicle)
		if vehicle and vehicle[1] then
			local owner = json.decode(vehicle[1].charinfo)
			local ownerName = owner['firstname'] .. " " .. owner['lastname']
			vehData = {
				veh = veh,
				name = name,
				class = class,
				plate = plate,
				stolen = GetStolenStatus(plate),
				bolo = GetBoloStatus(plate, tostring(ownerName)),
				warrant = GetWarrantStatus(vehicle[1].citizenid),
				owner = ownerName,
			}
		else
			if not Plates[plate] then
				local person = GenerateOwnerName()
				local bolo = GetBoloStatus(plate, tostring(person))
				Plates[plate] = {
					veh = veh,
					name = name,
					class = class,
					owner = person,
					bolo = bolo,
					stolen = false,
					warrant = false,
				}
				vehData = {
					veh = veh,
					name = name,
					class = class,
					plate = plate,
					owner = person,
					bolo = bolo,
					stolen = false,
					warrant = false,
				}
			else
				local owner = Plates[plate].owner
				local bolo = GetBoloStatus(plate, tostring(owner))
				if Plates[plate].bolo ~= bolo then
					Plates[plate].bolo = bolo
				end
				vehData = {
					veh = Plates[plate].veh,
					name = Plates[plate].name,
					class = Plates[plate].class,
					plate = plate,
					bolo = Plates[plate].bolo,
					stolen = Plates[plate].stolen,
					owner = owner,
					warrant = Plates[plate].warrant,
				}
			end
		end
		if Config.Debug then print(json.encode(vehData)) end
		TriggerClientEvent("qb-platescan:client:ScanPlate", src, vehData, locked)
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t('error.readerdisabled'), 'error')
	end
end)
