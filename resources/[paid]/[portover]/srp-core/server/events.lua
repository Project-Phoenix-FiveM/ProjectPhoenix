--------------
--  CONFIG  --
--------------
local ownerEmail = 'bobby@inwide.com'             -- Owner Email (Required) - No account needed (Used Incase of Issues)
local kickThreshold = 0.99        					-- Anything equal to or higher than this value will be kicked. (0.99 Recommended as Lowest)
local kickReason = 'We see that you are using a VPN or a cloud gaming service, go to the StoryRP Discord for a VPNBlock whitelist.'
local flags = 'm'				  					-- Quickest and most accurate check. Checks IP blacklist.
local printFailed = true


------- DO NOT EDIT BELOW THIS LINE -------
function splitString(inputstr, sep)
	local t= {}; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

--Een quickfix, later naar config of db zetten--
local vpnWhitelist = {
	[1]="steam:110000109847c72",
	[2]="steam:11000010a0551c8",
	[3]="steam:1100001024047d4",
	[4]="steam:110000141b86e7d", -- KiraJay
	[5]="steam:110000136f1c471", -- Phluphpie
	[6]="steam:1100001032f5f9f", -- DaddyTunes -- ituneyoudrive
}

-- Citizen.CreateThread(function()
-- 	SRPCore.Functions.ExecuteSql(true, "SELECT * FROM `vpnwhitelist`", function(result)
-- 		vpnWhitelist = result[1]
-- 	end)
-- end)

-- Player joined
RegisterServerEvent("SRPCore:PlayerJoined")
AddEventHandler('SRPCore:PlayerJoined', function()
	local src = source
end)

AddEventHandler('playerDropped', function(reason) 
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	print("Dropped: "..GetPlayerName(src))

	if Player then
        local coords = Player.PlayerData.position

    	TriggerEvent("srp-log:server:CreateLog", "joinleave", "Dropped", "red", "**".. GetPlayerName(src) .. "** (#"..src..")("..GetPlayerIdentifiers(src)[1]..") left.. (" .. reason .. ") (Coords: " .. coords.x .. " " .. coords.y .. " " .. coords.z)
	    TriggerEvent("srp-log:server:CreateLog", "joinleaveadmins", "Dropped", "red", "**".. GetPlayerName(src) .. "** (#"..src..") left.. (" .. reason .. ") (Coords: " .. coords.x .. " " .. coords.y .. " " .. coords.z)
	    --TriggerEvent("srp-log:server:sendLog", GetPlayerIdentifiers(src)[1], "joined", {})
	else
	    TriggerEvent("srp-log:server:CreateLog", "joinleave", "Dropped", "red", "**".. GetPlayerName(src) .. "** (#"..src..")("..GetPlayerIdentifiers(src)[1]..") left.. (" .. reason .. ")")
    	TriggerEvent("srp-log:server:CreateLog", "joinleaveadmins", "Dropped", "red", "**".. GetPlayerName(src) .. "** (#"..src..") left.. (" .. reason .. ")")
	end

	if reason ~= "Reconnecting" and src > 60000 then return false end
	if(src==nil or (SRPCore.Players[src] == nil)) then return false end
	SRPCore.Players[src].Functions.Save()
	SRPCore.Players[src] = nil
end)

-- Checking everything before joining
AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
	local src = source
	id = GetPlayerIdentifiers(src)[1]
	isWhitelisted = false

	for i, v in ipairs(vpnWhitelist) do
		if(v == id) then
			print("found one: "..id)
			isWhitelisted = true
		end
	end

	if GetNumPlayerIndices() < GetConvarInt('sv_maxclients', 64)  then
		deferrals.defer()
		deferrals.update("Checking Player Information. Please Wait.")
		playerIP = GetPlayerEP(src)

		if string.match(playerIP, ":") then
			playerIP = splitString(playerIP, ":")[1]
		end
		if IsPlayerAceAllowed(src, "blockVPN.bypass") or isWhitelisted == true then
			--deferrals.done()
		else 
			PerformHttpRequest('http://check.getipintel.net/check.php?ip=' .. playerIP .. '&contact=' .. ownerEmail .. '&flags=' .. flags, function(statusCode, response, headers)
				if response then
					if tonumber(response) == -5 then
						print('[BlockVPN][ERROR] GetIPIntel seems to have blocked the connection with error code 5 (Either incorrect email, blocked email, or blocked IP. Try changing the contact email)')
					elseif tonumber(response) == -6 then
						print('[BlockVPN][ERROR] A valid contact email is required!')
					elseif tonumber(response) == -4 then
						print('[BlockVPN][ERROR] Unable to reach database. Most likely being updated.')
					else
						if tonumber(response) >= kickThreshold then
							deferrals.done(kickReason)
							if printFailed then
								print('[BlockVPN][BLOCKED] ' .. playerName .. ' has been blocked from joining with a value of ' .. tonumber(response))
							end
						else 
							--deferrals.done()
						end
					end
				end
			end)
		end
	end
	
	deferrals.defer()
	deferrals.update("\nChecking name...")
	local name = GetPlayerName(src)
	if name == nil then 
		SRPCore.Functions.Kick(src, 'Please do not use an empty steam name.', setKickReason, deferrals)
        CancelEvent()
        return false
	end
	if(string.match(name, "[*%%'=`\"]")) then
        SRPCore.Functions.Kick(src, 'You have a sign in your name('..string.match(name, "[*%%'=`\"]")..') that is not allowed.\nPlease remove this from your steam name.', setKickReason, deferrals)
        CancelEvent()
        return false
	end
	if (string.match(name, "drop") or string.match(name, "table") or string.match(name, "database")) then
        SRPCore.Functions.Kick(src, 'You have a word (drop/table/database) in your name which is not allowed.\nPlease change your steam name.', setKickReason, deferrals)
        CancelEvent()
        return false
	end
	deferrals.update("\nChecking identifiers...")
    local identifiers = GetPlayerIdentifiers(src)
	local steamid = identifiers[1]
	local license = identifiers[2]
    if (SRPConfig.IdentifierType == "steam" and (steamid:sub(1,6) == "steam:") == false) then
        SRPCore.Functions.Kick(src, 'You must have steam on to play.', setKickReason, deferrals)
        CancelEvent()
		return false
	elseif (SRPConfig.IdentifierType == "license" and (steamid:sub(1,6) == "license:") == false) then
		SRPCore.Functions.Kick(src, 'No social club license found.', setKickReason, deferrals)
        CancelEvent()
		return false
    end
	deferrals.update("\nChecking ban status...")
    local isBanned, Reason = SRPCore.Functions.IsPlayerBanned(src)
    if(isBanned) then
        SRPCore.Functions.Kick(src, Reason, setKickReason, deferrals)
        CancelEvent()
        return false
    end
	deferrals.update("\nChecking whitelist status...")
    if(not SRPCore.Functions.IsWhitelisted(src)) then
        SRPCore.Functions.Kick(src, 'Unfortunately you are not whitelisted or the server is under maintenance...', setKickReason, deferrals)
        CancelEvent()
        return false
    end
	deferrals.update("\nChecking server status...")
    if(SRPCore.Config.Server.closed and not IsPlayerAceAllowed(src, "rsadmin.join")) then
		SRPCore.Functions.Kick(src, 'The server is closed:\n'..SRPCore.Config.Server.closedReason, setKickReason, deferrals)
        CancelEvent()
        return false
	end
	TriggerEvent("srp-log:server:CreateLog", "joinleave", "Queue", "orange", "**"..name .. "** ("..json.encode(GetPlayerIdentifiers(src))..") in queue..")
	--TriggerEvent("srp-log:server:sendLog", GetPlayerIdentifiers(src)[1], "left", {})
	TriggerEvent("connectqueue:playerConnect", src, setKickReason, deferrals)
end)

RegisterServerEvent("SRPCore:server:CloseServer")
AddEventHandler('SRPCore:server:CloseServer', function(reason)
    local src = source
    local Player = SRPCore.Functions.GetPlayer(src)

    if SRPCore.Functions.HasPermission(src, "admin") or SRPCore.Functions.HasPermission(src, "god") then
        local reason = reason ~= nil and reason or "No reason given..."
        SRPCore.Config.Server.closed = true
        SRPCore.Config.Server.closedReason = reason
        TriggerClientEvent("rsadmin:client:SetServerStatus", -1, true)
	else
		SRPCore.Functions.Kick(src, "You don't have permission for loser here..", nil, nil)
    end
end)

RegisterServerEvent("SRPCore:server:OpenServer")
AddEventHandler('SRPCore:server:OpenServer', function()
    local src = source
    local Player = SRPCore.Functions.GetPlayer(src)

    if SRPCore.Functions.HasPermission(src, "admin") or SRPCore.Functions.HasPermission(src, "god") then
        SRPCore.Config.Server.closed = false
        TriggerClientEvent("rsadmin:client:SetServerStatus", -1, false)
    else
        SRPCore.Functions.Kick(src, "You don't have permission for loser here..", nil, nil)
    end
end)

RegisterServerEvent("SRPCore:UpdatePlayer")
AddEventHandler('SRPCore:UpdatePlayer', function(data)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	if Player then
		Player.PlayerData.position = data.position

		local newHunger = Player.PlayerData.metadata["hunger"] - 0.21 --4.2
		local newThirst = Player.PlayerData.metadata["thirst"] - 0.19 --3.8
		if newHunger <= 0 then newHunger = 0 end
		if newThirst <= 0 then newThirst = 0 end
		Player.Functions.SetMetaData("thirst", newThirst)
		Player.Functions.SetMetaData("hunger", newHunger)
		
		if data.payment then
			Player.Functions.AddMoney("bank", Player.PlayerData.job.payment)
			TriggerClientEvent('SRPCore:Notify', src, "You received your salary [$"..Player.PlayerData.job.payment.."]")
		end
		
		TriggerClientEvent("hud:client:UpdateNeeds", src, newHunger, newThirst)

		Player.Functions.Save()
	end
end)

RegisterServerEvent("SRPCore:UpdatePlayerPosition")
AddEventHandler("SRPCore:UpdatePlayerPosition", function(position)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	if Player then
		Player.PlayerData.position = position
	end
end)

RegisterServerEvent("SRPCore:Server:TriggerCallback")
AddEventHandler('SRPCore:Server:TriggerCallback', function(name, ...)
	local src = source

	SRPCore.Functions.TriggerCallback(name, src, function(...)
		TriggerClientEvent("SRPCore:Client:TriggerCallback", src, name, ...)
	end, ...)
end)

RegisterServerEvent("SRPCore:Server:UseItem")
AddEventHandler('SRPCore:Server:UseItem', function(item)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	if item and item.amount > 0 then
		if SRPCore.Functions.CanUseItem(item.name) then
			SRPCore.Functions.UseItem(src, item)
		end
	end
end)

RegisterServerEvent("SRPCore:Server:RemoveItem")
AddEventHandler('SRPCore:Server:RemoveItem', function(itemName, amount, slot)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	Player.Functions.RemoveItem(itemName, amount, slot)
end)

RegisterServerEvent('SRPCore:Server:AddItem')
AddEventHandler('SRPCore:Server:AddItem', function()
    local src = source

	SRPCore.Functions.BanInjection(source, "srp-core")
end)

SRPCore.Functions.CreateCallback('SRPCore:AddItem', function(source, cb, itemName, amount, slot, info)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	Player.Functions.AddItem(itemName, amount, slot, info)
end)

RegisterServerEvent('SRPCore:Server:SetMetaData')
AddEventHandler('SRPCore:Server:SetMetaData', function(meta, data)
    local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	if meta == "hunger" or meta == "thirst" then
		if data > 100 then
			data = 100
		end
	end

	if Player then
		Player.Functions.SetMetaData(meta, data)
		TriggerClientEvent("hud:client:UpdateNeeds", src, Player.PlayerData.metadata["hunger"], Player.PlayerData.metadata["thirst"])
	end	
end)

AddEventHandler('chatMessage', function(source, n, message)
	if string.sub(message, 1, 1) == "/" then
	    local src = source
		local args = SRPCore.Shared.SplitStr(message, " ")
		local command = string.gsub(args[1]:lower(), "/", "")

		CancelEvent()

		if SRPCore.Commands.List[command] then
			local Player = SRPCore.Functions.GetPlayer(src)
			if Player then
				table.remove(args, 1)

				if (SRPCore.Functions.HasPermission(src, "god") or SRPCore.Functions.HasPermission(src, SRPCore.Commands.List[command].permission)) then
					if (SRPCore.Commands.List[command].argsrequired and #SRPCore.Commands.List[command].arguments ~= 0 and args[#SRPCore.Commands.List[command].arguments] == nil) then
					    local agus = ""

					    TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "All arguments must be filled in!")

					    for name, help in pairs(SRPCore.Commands.List[command].arguments) do
					    	agus = agus .. " ["..help.name.."]"
					    end

				        TriggerClientEvent('chatMessage', src, "/"..command, false, agus)
					else
						SRPCore.Commands.List[command].callback(src, args)
					end
				else
					TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "No access to this command!")
				end
			end
		end
	end
end)

RegisterServerEvent('SRPCore:CallCommand')
AddEventHandler('SRPCore:CallCommand', function(command, args)
	if SRPCore.Commands.List[command] then
	    local src = source
		local Player = SRPCore.Functions.GetPlayer(tonumber(src))

		if Player then
			if (SRPCore.Functions.HasPermission(src, "god")) or (SRPCore.Functions.HasPermission(src, SRPCore.Commands.List[command].permission)) or (SRPCore.Commands.List[command].permission == Player.PlayerData.job.name) then
				if (SRPCore.Commands.List[command].argsrequired and #SRPCore.Commands.List[command].arguments ~= 0 and args[#SRPCore.Commands.List[command].arguments] == nil) then
					TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "All arguments must be filled in!")
					local agus = ""
					for name, help in pairs(SRPCore.Commands.List[command].arguments) do
						agus = agus .. " ["..help.name.."]"
					end
					TriggerClientEvent('chatMessage', src, "/"..command, false, agus)
				else
					SRPCore.Commands.List[command].callback(src, args)
				end
			else
				TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "No access to this command!")
			end
		end
	end
end)

RegisterServerEvent("SRPCore:AddCommand")
AddEventHandler('SRPCore:AddCommand', function(name, help, arguments, argsrequired, callback, persmission)
	SRPCore.Commands.Add(name, help, arguments, argsrequired, callback, persmission)
end)

RegisterServerEvent("SRPCore:ToggleDuty")
AddEventHandler('SRPCore:ToggleDuty', function()
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	if Player.PlayerData.job.onduty then
		Player.Functions.SetJobDuty(false)
		TriggerClientEvent('SRPCore:Notify', src, "You are now off duty!")
	else
		Player.Functions.SetJobDuty(true)
		TriggerClientEvent('SRPCore:Notify', src, "You are now on duty!")
	end

	TriggerClientEvent("SRPCore:Client:SetDuty", src, Player.PlayerData.job.onduty)
end)

SRPCore.Functions.CreateCallback('SRPCore:HasItem', function(source, cb, itemName)
	local src = source
	local retval = false
	local Player = SRPCore.Functions.GetPlayer(src)

	if Player then
		if Player.Functions.GetItemByName(itemName) then
			retval = true
		end
	end
	
	cb(retval)
end)

SRPCore.Functions.CreateCallback('SRPCore:HasItemAmount', function(source, cb, itemName, amount)
	local src = source
	local retval = false
	local Player = SRPCore.Functions.GetPlayer(src)

	if Player then
		if Player.Functions.GetItemByName(itemName) then
			local theItem = Player.Functions.GetItemByName(itemName)
			if theItem.amount >= amount then
				retval = true
			end
		end
	end
	
	cb(retval)
end)

RegisterServerEvent('SRPCore:Command:CheckOwnedVehicle')
AddEventHandler('SRPCore:Command:CheckOwnedVehicle', function(VehiclePlate)
	if VehiclePlate then
		exports.oxmysql:execute("SELECT * FROM `player_vehicles` WHERE `plate` = ?", {VehiclePlate}, function(result)
			if result[1] then
				exports.oxmysql:execute("UPDATE `player_vehicles` SET `state` = '1' WHERE `citizenid` = ?", {result[1].citizenid})
				TriggerEvent('srp-garages:server:RemoveVehicle', result[1].citizenid, VehiclePlate)
			end
		end)
	end
end)