SRPCore.Functions = {}

SRPCore.Functions.ExecuteSql = function(wait, query, cb)
	local rtndata = {}
	local waiting = true
	exports['oxmysql']:execute(query, {}, function(data)
		if cb ~= nil and wait == false then
			cb(data)
		end
		rtndata = data
		waiting = false
	end)
	if wait then
		while waiting do
			Citizen.Wait(5)
		end
		if cb ~= nil and wait == true then
			cb(rtndata)
		end
	end
	return rtndata
end


SRPCore.Functions.GetCoords = function(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)

    return vector4(coords.x, coords.y, coords.z, heading)
end

SRPCore.Functions.GetIdentifier = function(source, idtype)
    local src = source
	local idtype = idtype ~=nil and idtype or SRPConfig.IdentifierType

	for _, identifier in pairs(GetPlayerIdentifiers(src)) do
		if string.find(identifier, idtype) then
			return identifier
		end
	end

	return nil
end

SRPCore.Functions.GetSource = function(identifier)
	for src, player in pairs(SRPCore.Players) do
		local idens = GetPlayerIdentifiers(src)

		for _, id in pairs(idens) do
			if identifier == id then
				return src
			end
		end
	end

	return 0
end

SRPCore.Functions.GetPlayer = function(source)
    local src = source

	if type(src) == "number" then
		return SRPCore.Players[src]
	else
		return SRPCore.Players[SRPCore.Functions.GetSource(src)]
	end
end

SRPCore.Functions.GetPlayerByCitizenId = function(citizenid)
	for src, player in pairs(SRPCore.Players) do
		local cid = citizenid

		if SRPCore.Players[src].PlayerData.citizenid == cid then
			return SRPCore.Players[src]
		end
	end

	return nil
end

SRPCore.Functions.GetPlayerByPhone = function(number)
	for src, player in pairs(SRPCore.Players) do
		local cid = citizenid

		if SRPCore.Players[src].PlayerData.charinfo.phone == number then
			return SRPCore.Players[src]
		end
	end

	return nil
end

-- Will return an array of SRP Player class instances
-- unlike the GetPlayers() wrapper which only returns IDs
function SRPCore.Functions.GetSRPPlayers()
    return SRPCore.Players
end

SRPCore.Functions.GetPlayers = function()
	local sources = {}

	for k, v in pairs(SRPCore.Players) do
		table.insert(sources, k)
	end

	return sources
end

SRPCore.Functions.CreateCallback = function(name, cb)
	SRPCore.ServerCallbacks[name] = cb
end

SRPCore.Functions.TriggerCallback = function(name, source, cb, ...)
    local src = source

	if SRPCore.ServerCallbacks[name] then
		SRPCore.ServerCallbacks[name](src, cb, ...)
	end
end

SRPCore.Functions.CreateUseableItem = function(item, cb)
	SRPCore.UseableItems[item] = cb
end

SRPCore.Functions.CanUseItem = function(item)
	return SRPCore.UseableItems[item] ~= nil
end

SRPCore.Functions.UseItem = function(source, item)
    local src = source

	SRPCore.UseableItems[item.name](src, item)
end

SRPCore.Functions.Kick = function(source, reason, setKickReason, deferrals)
	local src = source
	reason = "\n"..reason.."\n🔸 Check out our discord for more information: "..SRPCore.Config.Server.discord

	if(setKickReason ~=nil) then
		setKickReason(reason)
	end

	Citizen.CreateThread(function()
		if deferrals then
			deferrals.update(reason)
			Citizen.Wait(2500)
		end

		if src then
			DropPlayer(src, reason)
		end

		local i = 0

		while (i <= 4) do
			i = i + 1

			while true do
				if src then
					if(GetPlayerPing(src) >= 0) then
						break
					end

					Citizen.Wait(100)

					Citizen.CreateThread(function() 
						DropPlayer(src, reason)
					end)
				end
			end

			Citizen.Wait(5000)
		end
	end)
end

SRPCore.Functions.IsWhitelisted = function(source)
    local src = source
	local identifiers = GetPlayerIdentifiers(src)
	local rtn = false

	if SRPCore.Config.Server.whitelist then
		--SRPCore.Functions.ExecuteSql(true, "SELECT * FROM `whitelist` WHERE `"..SRPCore.Config.IdentifierType.."` = '".. SRPCore.Functions.GetIdentifier(src).."'", function(result)
		--	local data = result[1]
		    print('CHECK IsWhitelisted') -- ToDo: Remove
		    local result = exports.oxmysql:fetchSync('SELECT * FROM `whitelist` WHERE ? = ?', { SRPCore.Config.IdentifierType, SRPCore.Functions.GetIdentifier(src) })
			if result[1] then
				for _, id in pairs(identifiers) do
					if data.steam == id or data.license == id then
						rtn = true
					end
				end
			end
		--end)
	else
		rtn = true
	end

	return rtn
end

SRPCore.Functions.AddPermission = function(source, permission)
    local src = source
	local Player = SRPCore.Functions.GetPlayer(src)
	if Player then
		SRPCore.Config.Server.PermissionList[GetPlayerIdentifiers(src)[1]] = {
			steam = GetPlayerIdentifiers(src)[1],
			license = GetPlayerIdentifiers(src)[2],
			permission = permission:lower(),
		}

		--SRPCore.Functions.ExecuteSql(true, "DELETE FROM `permissions` WHERE `steam` = '"..GetPlayerIdentifiers(src)[1].."'")
		--SRPCore.Functions.ExecuteSql(true, "INSERT INTO `permissions` (`name`, `steam`, `license`, `permission`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..permission:lower().."')")
		exports.oxmysql:executeSync('DELETE FROM `permissions` WHERE `steam` = ?', { GetPlayerIdentifiers(src)[1] })
		exports.oxmysql:insertSync('INSERT INTO `permissions` (`name`, `steam`, `license`, `permission`) VALUES (?, ?, ?, ?)', {
            GetPlayerName(src),
            GetPlayerIdentifiers(src)[1],
            GetPlayerIdentifiers(src)[2],
            permission:lower()
        })

		Player.Functions.UpdatePlayerData()
		TriggerClientEvent('SRPCore:Client:OnPermissionUpdate', src, permission)
	end
end

SRPCore.Functions.RemovePermission = function(source)
    local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	if Player then
		SRPCore.Config.Server.PermissionList[GetPlayerIdentifiers(src)[1]] = nil
		--SRPCore.Functions.ExecuteSql(true, "DELETE FROM `permissions` WHERE `steam` = '"..GetPlayerIdentifiers(src)[1].."'")
		exports.oxmysql:executeSync('DELETE FROM `permissions` WHERE `steam` = ?', { GetPlayerIdentifiers(src)[1] })
		Player.Functions.UpdatePlayerData()
	end
end

SRPCore.Functions.HasPermission = function(source, permission)
    local src = source
	local retval = false
	local steamid = GetPlayerIdentifiers(src)[1]
	local licenseid = GetPlayerIdentifiers(src)[2]
	local permission = tostring(permission:lower())

	if permission == "user" then
		retval = true
	else
		if SRPCore.Config.Server.PermissionList[steamid] then
			if SRPCore.Config.Server.PermissionList[steamid].steam == steamid and SRPCore.Config.Server.PermissionList[steamid].license == licenseid then
				if SRPConfig.Server.PermissionLevels[SRPCore.Config.Server.PermissionList[steamid].permission].power >= SRPConfig.Server.PermissionLevels[permission].power then
					retval = true
				end
			end
		end
	end

	return retval
end

SRPCore.Functions.GetPermission = function(source)
    local src = source
	local retval = "user"
	Player = SRPCore.Functions.GetPlayer(src)
	local steamid = GetPlayerIdentifiers(src)[1]
	local licenseid = GetPlayerIdentifiers(src)[2]

	if Player then
		if SRPCore.Config.Server.PermissionList[Player.PlayerData.steam] then
			if SRPCore.Config.Server.PermissionList[Player.PlayerData.steam].steam == steamid and SRPCore.Config.Server.PermissionList[Player.PlayerData.steam].license == licenseid then
				retval = SRPCore.Config.Server.PermissionList[Player.PlayerData.steam].permission
			end
		end
	end

	return retval
end

SRPCore.Functions.IsOptin = function(source)
    local src = source
	local retval = false
	local steamid = GetPlayerIdentifiers(src)[1]

	if SRPCore.Config.Server.PermissionList[steamid] and SRPConfig.Server.PermissionLevels[SRPCore.Config.Server.PermissionList[steamid].permission].power >= SRPConfig.Server.PermissionLevels["trialhelper"].power then
		retval = SRPCore.Config.Server.PermissionList[steamid].optin
	end

	return retval
end

SRPCore.Functions.ToggleOptin = function(source)
    local src = source
	local steamid = GetPlayerIdentifiers(src)[1]

	if SRPCore.Config.Server.PermissionList[steamid] and SRPConfig.Server.PermissionLevels[SRPCore.Config.Server.PermissionList[steamid].permission].power >= SRPConfig.Server.PermissionLevels["trialhelper"].power then
		SRPCore.Config.Server.PermissionList[steamid].optin = not SRPCore.Config.Server.PermissionList[steamid].optin
	end
end

SRPCore.Functions.IsPlayerBanned = function (source)
    local src = source
	local retval = false
	local message = ""

    -- ToDo: Remove dupa test
	--SRPCore.Functions.ExecuteSql(true, "SELECT * FROM `bans` WHERE `steam` = '"..GetPlayerIdentifiers(src)[1].."' OR `license` = '"..GetPlayerIdentifiers(src)[2].."' OR `ip` = '"..GetPlayerIdentifiers(src)[3].."'", function(result)
	    local result = exports.oxmysql:fetchSync('SELECT * FROM bans WHERE steam = ? OR `license` = ? OR `ip` = ?', {
	        GetPlayerIdentifiers(src)[1],
	        GetPlayerIdentifiers(src)[2],
	        GetPlayerIdentifiers(src)[3]
	    })
		if result[1] then
			if os.time() < result[1].expire then
				retval = true
				local timeTable = os.date("*t", tonumber(result[1].expire))
				message = "You have been banned from the server:\n"..result[1].reason.."\nExpires: "..timeTable.day.. "/" .. timeTable.month .. "/" .. timeTable.year .. " " .. timeTable.hour.. ":" .. timeTable.min .. "\n"
			else
				--SRPCore.Functions.ExecuteSql(true, "DELETE FROM `bans` WHERE `id` = "..result[1].id)
				exports.oxmysql:executeSync('DELETE FROM `bans` WHERE `id` = ?', {result[1].id})
			end
		end
	--end)

	return retval, message
end

-- Check for duplicate license -- ToDo: De folosit
function SRPCore.Functions.IsLicenseInUse(license)
    local players = GetPlayers()

    for _, player in pairs(players) do
        local identifiers = GetPlayerIdentifiers(player)

        for _, id in pairs(identifiers) do
            if string.find(id, 'steam') then
                local playerLicense = id

                if playerLicense == license then
                    return true
                end
            end
        end
    end

    return false
end

SRPCore.Functions.BanInjection = function(source, script)
    local src = source
	local reason = "[Story RP] You have been banned by the ANTICHEAT!"
	local banTime = 2147483647
	local timeTable = os.date("*t", banTime)

	TriggerClientEvent('chatMessage', -1, "BANHAMMER", "error", GetPlayerName(src).." has been banned for: "..reason.."")
	
	TriggerEvent("srp-log:server:CreateLog", "bans", "Player Banned", "orange", "Player: "..GetPlayerName(src).." has been banned from using ServerTriggerEvents through an external program (Resource: "..script..")")

	--SRPCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', "..banTime..")")
	exports.oxmysql:insert('INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(src),
        GetPlayerIdentifiers(src)[1],
        GetPlayerIdentifiers(src)[2],
        GetPlayerIdentifiers(src)[3],
        GetPlayerIdentifiers(src)[4],
        reason,
        banTime
    })

	DropPlayer(src, "Hey sucker, you've been banned from the server:\n"..reason.."\n\nExpires: "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"] .. "\n🔸 Check out our discord for more information")
end