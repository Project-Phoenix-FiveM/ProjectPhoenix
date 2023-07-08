SRPCore = exports['srp-core']:GetCoreObject()

SRPCore.Functions.CreateCallback("srp-multicharacter:server:GetUserCharacters", function(source, cb)
    local src = source

    --SRPCore.Functions.ExecuteSql(false, 'SELECT * FROM `players` WHERE `steam` = \'' .. GetPlayerIdentifier(src) ..'\'', function(result)
    exports.oxmysql:fetch('SELECT * FROM `players` WHERE `steam` = ?', {GetPlayerIdentifier(src)}, function(result)
        if result then
            for k, v in ipairs(result) do
                -- ToDo: Maybe remove from here the characters that is not in tier for the moment?
                if not v.created then
                    --SRPCore.Functions.ExecuteSql(false, "DELETE FROM `players` WHERE `citizenid` = '".. v.citizenid .."' AND `cid` = " .. v.cid, function(result) end)
                    exports.oxmysql:execute('DELETE FROM `players` WHERE `citizenid` = ? AND `cid` = ?', {v.citizenid, v.cid})
                    table.remove(result, k)
                end
            end

            cb(result)
        else
            cb(false)
        end
    end)
end)

--SRPCore.Functions.CreateCallback("srp-multicharacter:server:GetServerLogs", function(source, cb)
--    exports['ghmattimysql']:execute('SELECT * FROM server_logs', function(result)
--        cb(result)
--    end)
--end)

SRPCore.Functions.CreateCallback("test:yeet", function(source, cb)
    local steamId = GetPlayerIdentifiers(source)[1]
    local plyChars = {}
    
    --exports['ghmattimysql']:execute('SELECT * FROM players WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        local result = exports.oxmysql:fetchSync('SELECT * FROM `players` WHERE `steam` = @steam', {['@steam'] = steamId})
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)

            table.insert(plyChars, result[i])
        end

        cb(plyChars)
    --end)
end)

SRPCore.Functions.CreateCallback("srp-multicharacter:server:getSkin", function(source, cb, cid, inf)
    local src = source
    local info = inf
    --SRPCore.Functions.ExecuteSql(false, "SELECT * FROM `playerskins` WHERE `citizenid` = '"..cid.."'", function(result)
        local result = exports.oxmysql:fetchSync('SELECT * FROM `playerskins` WHERE `citizenid` = ?', {cid})

        if result[1] ~= nil then
            cb(result[1].model, result[1].skin, info)
        else
            cb(nil)
        end
    --end)
end)

--RegisterServerEvent('srp-multicharacter:server:disconnect')
--AddEventHandler('srp-multicharacter:server:disconnect', function()
--    local src = source
--    DropPlayer(src, "You are now disconnected from Story Roleplay")
--end)

SRPCore.Functions.CreateCallback("srp-multicharacter:server:getTaxiOn", function(source, cb)
    
    local amount = 0
	for k, v in pairs(SRPCore.Functions.GetPlayers()) do
        local Player = SRPCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "taxi") then
                amount = amount + 1
            end
        end
    end

    if amount ~= 0 then
        cb(true)
    else
        cb(false) 
    end

end)

RegisterServerEvent('srp-multicharacter:server:loadUserData')
AddEventHandler('srp-multicharacter:server:loadUserData', function(cData)
    local src = source
    if SRPCore.Player.Login(src, cData.dat[1]) then
        print('^2[srp-core]^7 '..GetPlayerName(src)..' (Citizen ID: '..cData.dat[1]..') has succesfully loaded!')
        SRPCore.Commands.Refresh(src)
        loadHouseData()

        TriggerEvent('srp-logs:server:createLog', GetCurrentResourceName(), 'srp-multicharacter:server:loadUserData', "Loaded citizenID " .. cData.dat[1] .. ".", src)
        --TriggerClientEvent('apartments:client:setupSpawnUI', src, cData)
        TriggerClientEvent('srp-multicharacter:client:setupSpawn', src, cData)
        TriggerEvent("srp-log:server:CreateLog", "joinleave", "Spawned", "orange", "**".. GetPlayerName(src) .. "** (#"..src..")("..GetPlayerIdentifiers(src)[1]..") spawned..")
        TriggerEvent("srp-log:server:CreateLog", "joinleaveadmins", "Spawned", "orange", "**".. GetPlayerName(src) .. "** (#"..src..") spawned..")
        --TriggerEvent("srp-log:server:sendLog", GetPlayerIdentifiers(src)[1], "spawned", {})

	end
end)

RegisterServerEvent('srp-multicharacter:server:createCharacter')
AddEventHandler('srp-multicharacter:server:createCharacter', function(data, cid)
    local src = source
    local newData = {}
    newData.charinfo = data
    newData.cid = cid
    if SRPCore.Player.Login(src, false, newData) then
        print('^2[srp-core]^7 '..GetPlayerName(src)..' has succesfully loaded!')
        SRPCore.Commands.Refresh(src)
        loadHouseData()

        TriggerEvent('srp-logs:server:createLog', GetCurrentResourceName(), 'srp-multicharacter:server:createCharacter', "Created new character.", src)

        TriggerClientEvent("srp-multicharacter:client:closeNUI", src)
        --TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
        TriggerClientEvent('srp-multicharacter:client:setupSpawn', src, newData)
        GiveStarterItems(src)
        TriggerEvent("srp-log:server:CreateLog", "joinleave", "New character", "orange", "**".. GetPlayerName(src) .. "** (#"..src..")("..GetPlayerIdentifiers(src)[1]..") spawned first time..")
        --TriggerEvent("srp-log:server:sendLog", GetPlayerIdentifiers(src)[1], "spawned first time", {})
	end
end)

RegisterServerEvent('srp-multicharacter:server:deleteCharacter')
AddEventHandler('srp-multicharacter:server:deleteCharacter', function(citizenid)
    local src = source
    SRPCore.Player.DeleteCharacter(src, citizenid)

    TriggerEvent('srp-logs:server:createLog', GetCurrentResourceName(), 'srp-multicharacter:server:createCharacter', "Deleted character.", src)
end)

function GiveStarterItems(source)
    local src = source
    local Player = SRPCore.Functions.GetPlayer(src)

    for k, v in pairs(SRPCore.Shared.StarterItems) do
        local info = {}
        if v.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        elseif v.item == "driver_license" then
            info.citizenid = Player.PlayerData.citizenid
			info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
			info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
            info.type = "A1-A2-A | AM-B | C1-C-CE"
        end
        Player.Functions.AddItem(v.item, 1, false, info)
    end
end

function loadHouseData()
    local HouseGarages = {}
    local Houses = {}

	--SRPCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
		local result = exports.oxmysql:fetchSync('SELECT * FROM houselocations', {})

		if result[1] ~= nil then
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
end

SRPCore.Commands.Add("char", "Get into Character Selection", {name="id", help="Player ID (optional)"}, true, function(source, args)
    local s = source
	if tonumber(args[1]) ~= nil then
		s = tonumber(args[1])
	end
	
	SRPCore.Player.Logout(s)
    TriggerClientEvent('srp-multicharacter:client:chooseChar', s)
    TriggerEvent('srp-logs:server:createLog', GetCurrentResourceName(), 'command char', "Used the command **char**", source)
end, "trialhelper")

SRPCore.Commands.Add("closeNUI", "Close NUI", {}, false, function(source, args)
    TriggerClientEvent('srp-multicharacter:client:closeNUI', source)
end)

---------------
SRPCore.Functions.CreateCallback('srp-multicharacter:server:checkCreated', function(source, cb, cid)
    if cid ~= nil then
        --SRPCore.Functions.ExecuteSql(false, "SELECT created FROM `players` WHERE `citizenid` = '"..cid.."' AND created = 1", function(result)
            local result = exports.oxmysql:fetchSync('SELECT `created` FROM `players` WHERE `citizenid` = ? AND created = 1', {cid})
            if result[1] ~= nil then 
                return cb(result[1])
            end
            return cb(nil)
        --end)
    else
        local src = source
        local Player = SRPCore.Functions.GetPlayer(src)
        --SRPCore.Functions.ExecuteSql(false, "SELECT created FROM `players` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND created = 1", function(result)
            local result = exports.oxmysql:fetchSync('SELECT `created` FROM `players` WHERE `citizenid` = ? AND created = 1', {Player.PlayerData.citizenid})
            if result[1] ~= nil then 
                return cb(result[1])
            end
            return cb(nil)
        --end)
    end
end)