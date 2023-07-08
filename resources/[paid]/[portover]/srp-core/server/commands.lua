SRPCore.Commands = {}
SRPCore.Commands.List = {}

SRPCore.Commands.Add = function(name, help, arguments, argsrequired, callback, permission) -- [name] = command name (ex. /givemoney), [help] = help text, [arguments] = arguments that need to be passed (ex. {{name="id", help="ID of a player"}, {name="amount", help="amount of money"}}), [argsrequired] = set arguments required (true or false), [callback] = function(source, args) callback, [permission] = rank or job of a player
	SRPCore.Commands.List[name:lower()] = {
		name = name:lower(),
		permission = permission ~= nil and permission:lower() or "user",
		help = help,
		arguments = arguments,
		argsrequired = argsrequired,
		callback = callback,
	}
end

SRPCore.Commands.Refresh = function(source)
    local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	if Player then
		for command, info in pairs(SRPCore.Commands.List) do
			if SRPCore.Functions.HasPermission(src, "god") or SRPCore.Functions.HasPermission(src, SRPCore.Commands.List[command].permission) then
				TriggerClientEvent('chat:addSuggestion', src, "/"..command, info.help, info.arguments)
			end
		end
	end
end

SRPCore.Commands.Add("tp", "Teleport to a player or location", {{name="id/x", help="ID of a player or X position"}, {name="y", help="Y position"}, {name="z", help="Z position"}}, false, function(source, args)
    local src = source

	if args[1] and not args[2] and not args[3] then
		local target = GetPlayerPed(tonumber(args[1]))

		if target ~= 0 then
		    local coords = GetEntityCoords(target)

            TriggerClientEvent('SRPCore:Command:TeleportToPlayer', src, coords)
		else
			TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
		end
	else
		-- tp to location
		if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
			local x = tonumber(args[1])
			local y = tonumber(args[2])
			local z = tonumber(args[3])
			TriggerClientEvent('SRPCore:Command:TeleportToCoords', src, x, y, z)
		else
			TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Not every argument is filled in (x, y, z)")
		end
	end
end, "trialhelper")

SRPCore.Commands.Add("markto", "Set Waypoint to a coordonate", {{name="x", help="X position"}, {name="y", help="Y position"}}, false, function(source, args)
    local src = source

	if args[1] and args[2] then
		local x = tonumber(args[1])
		local y = tonumber(args[2])
		TriggerClientEvent('SRPCore:Command:SetNewWaypoint', src, x, y)
	else
		TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Not every argument is filled in (x, y)")
	end
end, "helper")

SRPCore.Commands.Add("addpermission", "Give permission to someone (god/admin)", {{name="id", help="Player ID"}, {name="permission", help="Permission level"}}, true, function(source, args)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(tonumber(args[1]))
	local AdminPlayer = SRPCore.Functions.GetPlayer(src)
	local permission = tostring(args[2]):lower()

	if Player then
		SRPCore.Functions.AddPermission(Player.PlayerData.source, permission)
        TriggerEvent("srp-log:server:CreateLog", "admins", "AddPermission", "green", "**"..GetPlayerName(src).."** (CitizenID: "..AdminPlayer.PlayerData.citizenid.." | ID: "..src..") **Permission:** " .. permission .. " **CitizenID:** " .. Player.PlayerData.citizenid, false)
	else
		TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
	end
end, "admin")

SRPCore.Commands.Add("removepermission", "Take permission away from somebody", {{name="id", help="Player ID"}}, true, function(source, args)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(tonumber(args[1]))
	local AdminPlayer = SRPCore.Functions.GetPlayer(src)

	if Player then
		SRPCore.Functions.RemovePermission(Player.PlayerData.source)
		TriggerEvent("srp-log:server:CreateLog", "admins", "RemovePermission", "green", "**"..GetPlayerName(src).."** (CitizenID: "..AdminPlayer.PlayerData.citizenid.." | ID: "..src..") **CitizenID:** " .. Player.PlayerData.citizenid, false)
	else
		TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
	end
end, "admin")

SRPCore.Commands.Add("sv", "Spawn a Vehicle", {{name="model", help="Model name of the vehicle"}}, true, function(source, args)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	TriggerClientEvent('SRPCore:Command:SpawnVehicle', src, args[1])
	TriggerEvent("srp-log:server:CreateLog", "admins", "GetVehicle", "green", "**"..GetPlayerName(src).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..src..") **Spawn vehicle:** " .. args[1], false)
end, "helper")

SRPCore.Commands.Add("debug", "Turn debug mode on/off", {}, false, function(source, args)
    local src = source

	TriggerClientEvent('koil-debug:toggle', src)
end, "moderator")

SRPCore.Commands.Add("dv", "Delete spawned vehicle", {}, false, function(source, args)
    local src = source

	TriggerClientEvent('SRPCore:Command:DeleteVehicle', src)
end, "dv")

SRPCore.Commands.Add("adv", "Advanced delete spawned vehicle", {}, false, function(source, args)
    local src = source

	TriggerClientEvent('SRPCore:Command:AdvancedDeleteVehicle', src)
end, "dv")

SRPCore.Commands.Add("tpm", "Teleport to marker", {}, false, function(src, args)
	TriggerClientEvent('SRPCore:Command:GoToMarker', src)
end, "trialhelper")

SRPCore.Commands.Add("givecash", "Give money to player", {{name="id", help="Player ID"}, {name="amount", help="Amount of money"}}, true, function(source, args)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)
	local xPlayer = SRPCore.Functions.GetPlayer(tonumber(args[1]))

	if xPlayer and tonumber(args[2]) > 0 then
		local cash = Player.PlayerData.money['cash']
		if cash >= tonumber(args[2]) then		
			Player.Functions.RemoveMoney('cash', tonumber(args[2]))
			xPlayer.Functions.AddMoney('cash', tonumber(args[2]))
		end
	else
		TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
	end
end)


SRPCore.Commands.Add("givemoney", "Give money to player", {{name="id", help="Player ID"},{name="moneytype", help="Type money (cash, bank, crypto)"}, {name="amount", help="Amount of money"}}, true, function(source, args)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(tonumber(args[1]))
	local AdminPlayer = SRPCore.Functions.GetPlayer(src)

	if Player then
		Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
		TriggerEvent("srp-log:server:CreateLog", "admins", "GiveMoney", "green", "**"..GetPlayerName(src).."** (CitizenID: "..AdminPlayer.PlayerData.citizenid.." | ID: "..src..") **Type:** " .. tostring(args[2]) .. " **Amount:** " .. tostring(args[3]) .. " **CitizenID:** " .. Player.PlayerData.citizenid, false)
	else
		TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
	end
end, "moderator")

SRPCore.Commands.Add("setmoney", "Give a job to a player", {{name="id", help="Player ID"},{name="moneytype", help="Type money (cash, bank, crypto)"}, {name="amount", help="Amount of money"}}, true, function(source, args)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(tonumber(args[1]))
	local AdminPlayer = SRPCore.Functions.GetPlayer(src)

	if Player then
		Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
		TriggerEvent("srp-log:server:CreateLog", "admins", "SetMoney", "green", "**"..GetPlayerName(src).."** (CitizenID: "..AdminPlayer.PlayerData.citizenid.." | ID: "..src..") **Type:** " .. tostring(args[2]) .. " **Amount:** " .. tostring(args[3]) .. " **CitizenID:** " .. Player.PlayerData.citizenid, false)
	else
		TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
	end
end, "junioradmin")

SRPCore.Commands.Add("setjob", "Give a job to a player", {{name="id", help="Player ID"}, {name="job", help="Name of a job"}, {name="grade", help="level"}}, true, function(source, args)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(tonumber(args[1]))
	local AdminPlayer = SRPCore.Functions.GetPlayer(src)

	if Player then
		if not Player.Functions.SetJob(tostring(args[2]), tonumber(args[3])) then
			TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Invalid job or job grade!")
		else
		    TriggerEvent("srp-log:server:CreateLog", "admins", "SetJob", "green", "**"..GetPlayerName(src).."** (CitizenID: "..AdminPlayer.PlayerData.citizenid.." | ID: "..src..") **SetJob:** " .. args[2] .. " **Rank:** " .. args[3] .. " **CitizenID:** " .. Player.PlayerData.citizenid, false)
		end
	else
		TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
	end
end, "moderator")

SRPCore.Commands.Add("job", "Look what your job is", {}, false, function(source, args)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	TriggerClientEvent('chatMessage', src, "SYSTEM", "warning", "Job: "..Player.PlayerData.job.label.." - "..Player.PlayerData.job.gradelabel)
end)

SRPCore.Commands.Add("setgang", "Makea player a gang member.", {{name="id", help="Player ID"}, {name="gang", help="Name of a gang"}, {name="level", help= "Grade in Gang"}}, true, function(source, args)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(tonumber(args[1]))
	local AdminPlayer = SRPCore.Functions.GetPlayer(src)
	local name = tostring(args[2])
	local level = tonumber(args[3])

	if Player then
		if level then
			if level <= SRPCore.Shared.Gangs[name].maxLevel and level >= 0 then
				Player.Functions.SetGang(name, level)
                TriggerEvent("srp-log:server:CreateLog", "admins", "SetGang", "green", "**"..GetPlayerName(src).."** (CitizenID: "..AdminPlayer.PlayerData.citizenid.." | ID: "..src..") **SetGang:** " .. name .. " **Rank:** " .. level .. " **CitizenID:** " .. Player.PlayerData.citizenid, false)
			else
				TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Invalid Level. Gang's max level (grade) is " ..SRPCore.Shared.Gangs[name].maxLevel.."")
			end
		else
			TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Invalid Level. Gang's max level (grade) is " ..SRPCore.Shared.Gangs[name].maxLevel.."")
		end
	else
		TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
	end
end, "moderator")

SRPCore.Commands.Add("gang", "Look what your gang is", {}, false, function(source, args)
	local src = source
	local Player = SRPCore.Functions.GetPlayer(src)

	if Player.PlayerData.gang.name ~= "nogang" then
		TriggerClientEvent('chatMessage', src, "SYSTEM", "warning", "Gang: "..Player.PlayerData.gang.label)
	else
		TriggerClientEvent('SRPCore:Notify', src, "You're not in a gang!", "error")
	end
end)

SRPCore.Commands.Add("testnotify", "test notify", {{name="text", help="Just a test"}}, true, function(source, args)
    local src = source

	TriggerClientEvent('SRPCore:Notify', src, table.concat(args, " "), "success")
end, "moderator")

SRPCore.Commands.Add("clearinv", "Clear players inventory.", {{name="id", help="Player ID"}}, false, function(source, args)
	local src = source
	local playerId = args[1] ~= nil and args[1] or src
	local Player = SRPCore.Functions.GetPlayer(tonumber(playerId))
	local AdminPlayer = SRPCore.Functions.GetPlayer(src)

	if Player then
		Player.Functions.ClearInventory()
        TriggerEvent("srp-log:server:CreateLog", "admins", "ClearInventory", "green", "**"..GetPlayerName(src).."** (CitizenID: "..AdminPlayer.PlayerData.citizenid.." | ID: "..src..") **CitizenID:** " .. Player.PlayerData.citizenid, false)
	else
		TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
	end
end, "admin")

-- SRPCore.Commands.Add("ooc", "Out Of Character chat message (use only when needed)", {}, false, function(source, args)
-- 	local src = source
-- 	local message = table.concat(args, " ")
--     local Player = SRPCore.Functions.GetPlayer(src)
--
-- 	TriggerClientEvent("SRPCore:Client:LocalOutOfCharacter", -1, src, GetPlayerName(src), message)
--     TriggerEvent("srp-log:server:CreateLog", "ooc", "OOC", "white", "**"..GetPlayerName(src).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..src..") **Message:** " ..message, false)
-- end)

SRPCore.Commands.Add('ooc', 'Out Of Character chat message (use only when needed)', {}, false, function(source, args)
    local src = source
    local message = table.concat(args, ' ')
    local Players = SRPCore.Functions.GetPlayers()
    local Player = SRPCore.Functions.GetPlayer(src)
    local playerName = GetPlayerName(src)

    for k, v in pairs(Players) do
        if v == src then
            TriggerClientEvent("chatMessage", v, "OOC " .. playerName, "normal", message)
        elseif #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(v))) < 20.0 then
            TriggerClientEvent("chatMessage", v, "OOC " .. playerName, "normal", message)
        elseif SRPCore.Functions.HasPermission(v, 'trialhelper') then
            if SRPCore.Functions.IsOptin(v) then
                TriggerClientEvent("chatMessage", v, 'Proxmity OOC | '.. playerName, "normal", message)
                TriggerEvent("srp-log:server:CreateLog", "ooc", "OOC", "white", "**"..GetPlayerName(src).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..src..") **Message:** " ..message, false)
            end
        end
    end
end, 'user')

SRPCore.Commands.Add('me', 'Show local message', {name = 'message', help = 'Message to respond with'}, false, function(source, args)
    local src = source
    local ped = GetPlayerPed(src)
    local pCoords = GetEntityCoords(ped)
    local Player = SRPCore.Functions.GetPlayer(src)
    local playerName = "** [" .. source .. "]"
    local msg = table.concat(args, ' ')
    if msg == '' then return end
    msg = "* " .. msg .. " *"

    for k,v in pairs(SRPCore.Functions.GetPlayers()) do
        local target = GetPlayerPed(v)
        local tCoords = GetEntityCoords(target)
        if #(pCoords - tCoords) < 20 then
            TriggerClientEvent('SRPCore:Command:ShowMe3D', v, src, msg)

            if v == src then
                TriggerClientEvent("chatMessage", v, playerName, "warning", msg .. " **")
            elseif #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(v))) < 20.0 then
                TriggerClientEvent("chatMessage", v, playerName, "warning", msg .. " **")
            elseif SRPCore.Functions.HasPermission(v, 'trialhelper') then
                if SRPCore.Functions.IsOptin(v) then
                    TriggerClientEvent("chatMessage", v, 'Proxmity ME | '.. GetPlayerName(src), "warning", msg .. " **")
                end
            end

            TriggerEvent("srp-log:server:CreateLog", "me", "Me", "white", "**"..GetPlayerName(src).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..src..")** " ..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.. " **" ..msg, false)
        end
    end
end, 'user')

-- SRPCore.Commands.Add("toggleme", "Toggle if you want or not to see the local /me's", {}, false, function(source, args)
--     local src = source
--
-- 	TriggerClientEvent('SRPCore:Client:LocalMeSet', src)
-- end)

SRPCore.Commands.Add("adminkey", "Spawn vehicle keys", {}, false, function(source, args, plate)
    local src = source
    local group = SRPCore.Functions.GetPermission(src)
    local Player = SRPCore.Functions.GetPlayer(src)

    TriggerClientEvent('vehiclekeys:client:SetOwner', src, plate)
    TriggerClientEvent('vehiclekeys:client:ToggleEngine', src)
    TriggerEvent("srp-log:server:CreateLog", "admins", "GetVehicleKeys", "green", "**"..GetPlayerName(src).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..src..") **Spawn vehicle keys:** ", false)
end, "helper")