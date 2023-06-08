local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem(Config.bodycamitem, function(source)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	for index, value in ipairs(Config.jobs) do
		if xPlayer.PlayerData.job.name == value then
		TriggerClientEvent('qb-bodycam:use', source , xPlayer.PlayerData.job.name, xPlayer.PlayerData.job.grade.name, xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname)
		break
		end
	end
end)

RegisterCommand(Config.command,function (source)
	if Config.command ~= "" then
		local xPlayer = QBCore.Functions.GetPlayer(source)
		for index, value in ipairs(Config.jobs) do
			if xPlayer.PlayerData.job.name == value then
				TriggerClientEvent('qb-bodycam:use', source , xPlayer.PlayerData.job.name, xPlayer.PlayerData.job.grade.name, xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname)
				break
			end
		end
	end
end)

RegisterServerEvent("SaveJsonData")
AddEventHandler("SaveJsonData",function (RecData)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local data = LoadResourceFile(GetCurrentResourceName(),"/RecordData.json")
	if data == nil then
		data = SaveResourceFile(GetCurrentResourceName(),"/RecordData.json", json.encode({}), -1)
	end
	data = json.decode(data)
	RecData.citizen = xPlayer.PlayerData.citizenid
	table.insert(data,RecData)
	SaveResourceFile(GetCurrentResourceName(),"/RecordData.json", json.encode(data), -1)
end)

RegisterServerEvent("GetRecordData")
AddEventHandler("GetRecordData",function()
	local userData = {}
	local data = LoadResourceFile(GetCurrentResourceName(),"/RecordData.json")
	if data == nil then
		data = SaveResourceFile(GetCurrentResourceName(),"/RecordData.json", json.encode({}), -1)
	end
	data = json.decode(data)
	for i,v in ipairs(data) do 
		if userData[v.citizen] == nil then
			userData[v.citizen] = v
		end
	end
	TriggerClientEvent("SetRecorData",source,userData)
end)

QBCore.Functions.CreateCallback('getUserRecords', function(source, cb, hex)
	local recData = {}
	local data = LoadResourceFile(GetCurrentResourceName(),"/RecordData.json")
	if data == nil then
		data = SaveResourceFile(GetCurrentResourceName(),"/RecordData.json", json.encode({}), -1)
	end
	data = json.decode(data)
	for i,v in ipairs(data) do 
		if v.citizen == hex then
			table.insert( recData, v )
		end
	end
	 cb(recData)
end)


QBCore.Functions.CreateCallback('deleteRecords', function(source, cb, key , cid)
	local recData = {}
	local islem = false
	local data = LoadResourceFile(GetCurrentResourceName(),"/RecordData.json")
	if data == nil then
		data = SaveResourceFile(GetCurrentResourceName(),"/RecordData.json", json.encode({}), -1)
	end
	data = json.decode(data)
	for i,v in ipairs(data) do 
		if v.key == key then
			table.remove(data,i)
			islem = true
			break
		end
	end
	for i,v in ipairs(data) do 
		if v.citizen == cid then
			table.insert( recData, v )
		end
	end
	cb(recData,islem)
	data = SaveResourceFile(GetCurrentResourceName(),"/RecordData.json", json.encode(data), -1)
end)