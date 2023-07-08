-- Variables
local SRPCore = exports['srp-core']:GetCoreObject()
local frozen = false
local permissions = {
    ['kill'] = 'helper',
    ['ban'] = 'moderator',
    ['noclip'] = 'trialhelper',
    ['kickall'] = 'god',
    ['jail'] = 'trialhelper',
    ['kick'] = 'trialhelper',
    ['clearArea'] = 'trialhelper',
    ['fixcar'] = 'helper',
}
local onCharacterLoadEvent = 'srp-multicharacter:server:loadUserData'


CreateThread(function()
    exports.oxmysql:executeSync('CREATE TABLE IF NOT EXISTS `adminJail` ('..
                                    '`id` int(11) NOT NULL AUTO_INCREMENT, '..
                                    '`steam` varchar(255) DEFAULT NULL, '..
                                    '`name` varchar(255) DEFAULT NULL, '..
                                    '`releasetime` integer DEFAULT NULL, '..
                                    '`reason` varchar(255) DEFAULT NULL, '..
                                    '`unjailed` bool DEFAULT false, '..
                                    'PRIMARY KEY (`id`) '..
                                    ') ENGINE=InnoDB DEFAULT CHARSET=latin1; '
                                    ,{})
end)


-- Get Dealers
SRPCore.Functions.CreateCallback('test:getdealers', function(source, cb)
    cb(exports['srp-drugs']:GetDealers())
end)

-- Get Players
SRPCore.Functions.CreateCallback('test:getplayers', function(source, cb) -- WORKS
    local players = {}

    for k, v in pairs(SRPCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = SRPCore.Functions.GetPlayer(v)
        local result = exports.oxmysql:executeSync('SELECT * FROM permissions WHERE steam = ? LIMIT 1', { ped.PlayerData.steam })
        local levl = ""
        if result and result[1] then
            levl = result[1]["permission"]
        end
        local hoursLabel = -1
        if ped.PlayerData.playtime then
            hoursLabel = math.floor((tonumber(ped.PlayerData.playtime) / 3600)+0.5)
        end

        table.insert(players, {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. '  (' .. GetPlayerName(v) .. ')',
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source,
            hours =  hoursLabel,
            level = levl,
            tier = ped.PlayerData.tier
        })
    end

    cb(players)
end)

SRPCore.Functions.CreateCallback('srp-admin:server:getrank', function(source, cb)
    local src = source

    if SRPCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
        cb(true)
    else
        cb(false)
    end
end)

SRPCore.Functions.CreateCallback('srp-admin:server:GetHandcuffStatus', function(source, cb, playerId)
	local CuffedPlayer = SRPCore.Functions.GetPlayer(playerId)
    local status = 0

    if CuffedPlayer then
        status = CuffedPlayer.PlayerData.metadata["ishandcuffed"]
    end

	cb(status)
end)

-- Functions

local function tablelength(table)
    local count = 0

    for _ in pairs(table) do
        count = count + 1
    end

    return count
end

-- Events

RegisterNetEvent('srp-admin:server:GetPlayersForBlips', function()
    local src = source					                        
    local players = {}

    for k, v in pairs(SRPCore.Functions.GetPlayers()) do         
        local targetped = GetPlayerPed(v)                       
        local ped = SRPCore.Functions.GetPlayer(v)

        table.insert(players, {                             
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | ' .. GetPlayerName(v),
            id = v,                                      
            coords = GetEntityCoords(targetped),             
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,            
            sources = GetPlayerPed(ped.PlayerData.source),    
            sourceplayer= ped.PlayerData.source              
        })                                                  
    end

    TriggerClientEvent('srp-admin:client:Show', src, players)  
end)

RegisterNetEvent('srp-admin:server:kill', function(player)
    TriggerClientEvent('hospital:client:KillPlayer', player.id)
end)

RegisterNetEvent('srp-admin:server:revive', function(player)
    local src = source
    local AdminPlayer = SRPCore.Functions.GetPlayer(src)

    TriggerClientEvent('hospital:client:Revive', player.id)
    TriggerEvent("srp-log:server:CreateLog", "admins", "[Menu] Revive player", "green", "**"..GetPlayerName(src).."** (CitizenID: "..AdminPlayer.PlayerData.citizenid.." | ID: "..src..") **Revive:** " ..player.id, false)
end)

RegisterNetEvent('srp-admin:server:kick', function(player, reason)
    local src = source
    local adminPermission = SRPCore.Functions.GetPermission(src, permissions['kick'])
    local userPermission = SRPCore.Functions.GetPermission(player.id, permissions['kick'])

    if SRPCore.Config.Server.PermissionLevels[adminPermission].power <= SRPCore.Config.Server.PermissionLevels[userPermission].power then
        TriggerClientEvent('SRPCore:Notify', src, 'You cannot kick a rank equal or higher than you', 'error', 5000)
    elseif SRPCore.Functions.HasPermission(src, permissions['kick']) or IsPlayerAceAllowed(src, 'command')  then
        TriggerEvent('srp-log:server:CreateLog', 'bans', 'Player Kicked', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
        DropPlayer(player.id, 'You have been kicked from the server:\n' .. reason .. '\n\n🔸 Check our Discord for more information: ' .. SRPCore.Config.Server.discord)
    end
end)

RegisterNetEvent('srp-admin:server:ban', function(player, time, reason)
    local src = source
    local adminPermission = SRPCore.Functions.GetPermission(src, permissions['ban'])
    local userPermission = SRPCore.Functions.GetPermission(player.id, permissions['ban'])

    if SRPCore.Config.Server.PermissionLevels[adminPermission].power <= SRPCore.Config.Server.PermissionLevels[userPermission].power then
        TriggerClientEvent('SRPCore:Notify', src, 'You cannot kick a rank equal or higher than you', 'error', 5000)
    elseif SRPCore.Functions.HasPermission(src, permissions['ban']) or IsPlayerAceAllowed(src, 'command') then
        local time = tonumber(time)
        local banTime = tonumber(os.time() + time)

        if banTime > 2147483647 then
            banTime = 2147483647
        end

        local timeTable = os.date('*t', banTime)

        exports.oxmysql:insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            GetPlayerName(player.id),
            SRPCore.Functions.GetIdentifier(player.id, 'license'),
            SRPCore.Functions.GetIdentifier(player.id, 'discord'),
            SRPCore.Functions.GetIdentifier(player.id, 'ip'),
            reason,
            banTime,
            GetPlayerName(src)
        })

        TriggerClientEvent('chat:addMessage', -1, {
            template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been banned:</strong> {1}</div>",
            args = {GetPlayerName(player.id), reason}
        })

        TriggerEvent('srp-log:server:CreateLog', 'bans', '[Menu] Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)

        if banTime >= 2147483647 then
            DropPlayer(player.id, 'You have been banned:\n' .. reason .. '\n\nYour ban is permanent.\n🔸 Check our Discord for more information: ' .. SRPCore.Config.Server.discord)
        else
            DropPlayer(player.id, 'You have been banned:\n' .. reason .. '\n\nBan expires: ' .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discord for more information: ' .. SRPCore.Config.Server.discord)
        end
    end
end)

RegisterNetEvent('srp-admin:server:jail', function(playerID, time, reason)
    local src = source
    local adminPermission = SRPCore.Functions.GetPermission(src, permissions['jail'])
    local userPermission = SRPCore.Functions.GetPermission(playerID, permissions['jail'])
    local Player = SRPCore.Functions.GetPlayer(src)

    if SRPCore.Config.Server.PermissionLevels[adminPermission].power <= SRPCore.Config.Server.PermissionLevels[userPermission].power then
        TriggerClientEvent('SRPCore:Notify', src, 'You cannot jail a rank equal or higher than you', 'error', 5000)
    elseif SRPCore.Functions.HasPermission(src, permissions['jail']) or IsPlayerAceAllowed(src, 'command') then
        adminJail(src, playerID, time, reason, Player.name)
        -- TriggerClientEvent('chat:addMessage', -1, {
        --     template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been admin jailed:</strong> {1}</div>",
        --     args = {GetPlayerName(playerID), reason}
        -- })
        --TriggerEvent('srp-log:server:CreateLog', 'jails', '[Menu] Player Jail', 'red', string.format('%s was jail by %s for %s', GetPlayerName(playerID), GetPlayerName(src), reason), true)
    end
end)


function adminJail (source, playerID, timesecounds, reason)
        local timesecounds = tonumber(timesecounds)
        local jailTime = tonumber(os.time() + (timesecounds*10000))
        local currentTime = tonumber(os.time())
        local tojailPalyer = SRPCore.Functions.GetPlayer(playerID)
        local player = SRPCore.Functions.GetPlayer(src)

        if tojailPalyer then
            exports.oxmysql:insert('INSERT INTO adminJail (steam, name, releasetime, reason) VALUES (?, ?, ?, ?)', {
                tojailPalyer.PlayerData.steam,
                tojailPalyer.PlayerData.name,
                jailTime,
                reason
            })
            
            TriggerClientEvent('srp-admin:client:jail', playerID, jailTime, currentTime)
            TriggerClientEvent('srp-admin:Client:notify', source, "You have jail "..playerID.." for "..timesecounds.." secound.", 'error')
        else   
            TriggerClientEvent('srp-admin:Client:notify', source, "ID "..playerID.."is not online.", 'error')
        end

end

RegisterNetEvent('srp-admin:server:spectate')
AddEventHandler('srp-admin:server:spectate', function(player)
    local src = source
    local targetped = GetPlayerPed(player.id)
    local coords = GetEntityCoords(targetped)

    TriggerClientEvent('srp-admin:client:spectate', src, player.id, coords)
end)

RegisterNetEvent('srp-admin:server:freeze')
AddEventHandler('srp-admin:server:freeze', function(player)
    local target = GetPlayerPed(player.id)

    if not frozen then
        frozen = true
        FreezeEntityPosition(target, true)
    else
        frozen = false
        FreezeEntityPosition(target, false)
    end
end)

RegisterNetEvent('srp-admin:server:goto', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(GetPlayerPed(player.id))

    SetEntityCoords(admin, coords)
end)

RegisterNetEvent('srp-admin:server:intovehicle', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    -- local coords = GetEntityCoords(GetPlayerPed(player.id))
    local targetPed = GetPlayerPed(player.id)
    local vehicle = GetVehiclePedIsIn(targetPed,false)
    local seat = -1

    if vehicle ~= 0 then
        for i=0,8,1 do
            if GetPedInVehicleSeat(vehicle,i) == 0 then
                seat = i
                break
            end
        end

        if seat ~= -1 then
            SetPedIntoVehicle(admin,vehicle,seat)
            TriggerClientEvent('SRPCore:Notify', src, 'Entered vehicle', 'success', 5000)
        else
            TriggerClientEvent('SRPCore:Notify', src, 'The vehicle has no free seats!', 'danger', 5000)
        end
    end
end)


RegisterNetEvent('srp-admin:server:bring', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(player.id)

    SetEntityCoords(target, coords)
end)

RegisterNetEvent('srp-admin:server:inventory', function(player)
    local src = source

    TriggerClientEvent('srp-admin:client:inventory', src, player.id)
end)

RegisterNetEvent('srp-admin:server:cloth', function(player)
    TriggerClientEvent('srp-clothing:client:openMenu', player.id)
end)

RegisterNetEvent('srp-admin:server:setPermissions', function(targetId, group)
    local src = source
    local Player = SRPCore.Functions.GetPlayer(targetId)
    local AdminPlayer = SRPCore.Functions.GetPlayer(src)

    if SRPCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        SRPCore.Functions.AddPermission(targetId, group[1].rank)
        TriggerClientEvent('SRPCore:Notify', targetId, 'Your Permission Level Is Now '..group[1].label)
        TriggerEvent("srp-log:server:CreateLog", "admins", "[Menu] SetPermission", "green", "**"..GetPlayerName(src).."** (CitizenID: "..AdminPlayer.PlayerData.citizenid.." | ID: "..src..") **Permission:** " .. group[1].label .. " **CitizenID:** " .. Player.PlayerData.citizenid, false)
    end
end)

RegisterNetEvent('srp-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source

    if SRPCore.Functions.HasPermission(src, 'trialhelper')or IsPlayerAceAllowed(src, 'command') then
        if SRPCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, 'REPORT - '..name..' ('..targetSrc..')', 'report', msg)
        end
    end
end)

RegisterNetEvent('srp-admin:server:StaffChatMessage', function(name, msg)
    local src = source

    if SRPCore.Functions.HasPermission(src, 'trialhelper') or IsPlayerAceAllowed(src, 'command') then
        if SRPCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, 'STAFFCHAT - '..name, 'error', msg)
        end
    end
end)

RegisterNetEvent('srp-admin:server:SaveCar', function(mods, vehicle, hash, plate)
    local src = source
    local Player = SRPCore.Functions.GetPlayer(src)
    local result = exports.oxmysql:executeSync('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })

    if not result[1] then
        exports.oxmysql:insert('INSERT INTO player_vehicles (steam, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.steam,
            Player.PlayerData.citizenid,
            vehicle.model,
            vehicle.hash,
            json.encode(mods),
            plate,
            0
        })
        TriggerClientEvent('SRPCore:Notify', src, 'The vehicle is now yours!', 'success', 5000)
    else
        TriggerClientEvent('SRPCore:Notify', src, 'This vehicle is already yours..', 'error', 3000)
    end
end)

-- Commands

SRPCore.Commands.Add('blips', 'Show blips for players (Admin Only)', {}, false, function(source, args)
    TriggerClientEvent('srp-admin:client:toggleBlips', source)
end, 'admin')

SRPCore.Commands.Add('names', 'Show player name overhead (Admin Only)', {}, false, function(source, args)
    TriggerClientEvent('srp-admin:client:toggleNames', source)
end, 'admin')

SRPCore.Commands.Add('coords', 'Enable coord display for development stuff (Admin Only)', {}, false, function(source, args)
    TriggerClientEvent('srp-admin:client:ToggleCoords', source)
end, 'admin')

SRPCore.Commands.Add('admincar', 'Save Vehicle To Your Garage (Admin Only)', {}, false, function(source, args)
    local ply = SRPCore.Functions.GetPlayer(source)

    TriggerClientEvent('srp-admin:client:SaveCar', source)
end, 'admin')

SRPCore.Commands.Add('announce', 'Make An Announcement (Admin Only)', {}, false, function(source, args)
    local msg = table.concat(args, ' ')

    for i = 1, 3, 1 do
        TriggerClientEvent('chatMessage', -1, 'ANNOUNCEMENT', 'error', msg)
    end
end, 'helper')

SRPCore.Commands.Add('admin', 'Open Admin Menu (Admin Only)', {}, false, function(source, args)
    TriggerClientEvent('srp-admin:client:openMenu', source, SRPCore.Functions.GetPermission(source))
end, 'trialhelper')

SRPCore.Commands.Add('report', 'Admin Report', {{name='message', help='Message'}}, true, function(source, args)
    local msg = table.concat(args, ' ')
    local Player = SRPCore.Functions.GetPlayer(source)

    TriggerClientEvent('srp-admin:client:SendReport', -1, GetPlayerName(source), source, msg)
    TriggerClientEvent('chatMessage', source, 'Report sent', 'normal', msg)
    TriggerEvent('srp-log:server:CreateLog', 'report', 'Report', 'green', '**'..GetPlayerName(source)..'** (CitizenID: '..Player.PlayerData.citizenid..' | ID: '..source..') **Report:** ' ..msg, false)
end)

SRPCore.Commands.Add('achat', 'Send A Message To All Staff (Admin Only)', {{name='message', help='Message'}}, true, function(source, args)
    local msg = table.concat(args, ' ')

    TriggerClientEvent('srp-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, 'trialhelper')

SRPCore.Commands.Add('givenuifocus', 'Give A Player NUI Focus (Admin Only)', {{name='id', help='Player id'}, {name='focus', help='Set focus on/off'}, {name='mouse', help='Set mouse on/off'}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]

    TriggerClientEvent('srp-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, 'admin')

SRPCore.Commands.Add('warn', 'Warn A Player (Admin Only)', {{name='ID', help='Player'}, {name='Reason', help='Mention a reason'}}, true, function(source, args)
    local targetPlayer = SRPCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = SRPCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local myName = senderPlayer.PlayerData.name
    local warnId = 'WARN-'..math.random(1111, 9999)

    if targetPlayer then
        TriggerClientEvent('chatMessage', targetPlayer.PlayerData.source, "SYSTEM", "error", "You have been warned by: "..GetPlayerName(source)..", Reason: "..msg)
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "You have warned "..GetPlayerName(targetPlayer.PlayerData.source).." for :  "..msg)

        exports.oxmysql:insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
            senderPlayer.PlayerData.steam,
            targetPlayer.PlayerData.steam,
            msg,
            warnId
        })
    else
        TriggerClientEvent('SRPCore:Notify', source, 'This player is not online', 'error')
    end
end, 'helper')

SRPCore.Commands.Add('checkwarns', 'Check Player Warnings (Admin Only)', {{name='ID', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, false, function(source, args)
    if not args[2] then
        local targetPlayer = SRPCore.Functions.GetPlayer(tonumber(args[1]))
        local result = exports.oxmysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.steam })

        TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." has "..tablelength(result).." warnings!")
    else
        local targetPlayer = SRPCore.Functions.GetPlayer(tonumber(args[1]))
        local warnings = exports.oxmysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.steam })
        local selectedWarning = tonumber(args[2])

        if warnings[selectedWarning] then
            local sender = SRPCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
            TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." has been warned by "..sender.PlayerData.name..", Reason: "..warnings[selectedWarning].reason)
        end
    end
end, 'trialhelper')

SRPCore.Commands.Add('delwarn', 'Delete Players Warnings (Admin Only)', {{name='ID', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, true, function(source, args)
    local targetPlayer = SRPCore.Functions.GetPlayer(tonumber(args[1]))
    local warnings = exports.oxmysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.steam })
    local selectedWarning = tonumber(args[2])

    if warnings[selectedWarning] then
        local sender = SRPCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
        TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", "You have warning ("..selectedWarning..") removed, Reason: "..warnings[selectedWarning].reason)

        exports.oxmysql:execute('DELETE FROM player_warns WHERE warnId = ?', { warnings[selectedWarning].warnId })
    end
end, 'admin')

SRPCore.Commands.Add('reportr', 'Reply To A Report (Admin Only)', {}, false, function(source, args)
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local OtherPlayer = SRPCore.Functions.GetPlayer(playerId)
    local Player = SRPCore.Functions.GetPlayer(source)

    if OtherPlayer then
        TriggerClientEvent('chatMessage', playerId, 'ADMIN - '..GetPlayerName(source), 'warning', msg)
        TriggerClientEvent('SRPCore:Notify', source, 'Sent reply')

        for _, v in pairs(SRPCore.Functions.GetPlayers()) do
			local checkPlayer = SRPCore.Functions.GetPlayer(v)

			if checkPlayer then
				if SRPCore.Functions.HasPermission(v, 'trialhelper') or IsPlayerAceAllowed(source, 'command') then
					if SRPCore.Functions.IsOptin(v) then
						TriggerClientEvent('chatMessage', v, "ReportReply("..source..") - "..GetPlayerName(source), "warning", msg)
						TriggerEvent('srp-log:server:CreateLog', 'report', 'Report Reply', 'red', '**'..GetPlayerName(source)..'** replied on: **'..OtherPlayer.PlayerData.name.. ' **(ID: '..OtherPlayer.PlayerData.source..') **Message:** ' ..msg, false)
					end
				end
            end
        end
    else
        TriggerClientEvent('SRPCore:Notify', source, 'Player is not online', 'error')
    end
end, 'trialhelper')

SRPCore.Commands.Add('setmodel', 'Change Ped Model (Admin Only)', {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])

    if model ~= nil or model ~= '' then
        if not target then
            TriggerClientEvent('srp-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = SRPCore.Functions.GetPlayer(target)

            if Trgt then
                TriggerClientEvent('srp-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('SRPCore:Notify', source, 'This person is not online..', 'error')
            end
        end
    else
        TriggerClientEvent('SRPCore:Notify', source, 'You did not set a model..', 'error')
    end
end, 'admin')

SRPCore.Commands.Add('setspeed', 'Set Player Foot Speed (Admin Only)', {}, false, function(source, args)
    local speed = args[1]

    if speed ~= nil then
        TriggerClientEvent('srp-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('SRPCore:Notify', source, 'You did not set a speed.. (`fast` for super-run, `normal` for normal)', 'error')
    end
end, 'admin')

SRPCore.Commands.Add('reporttoggle', 'Toggle Incoming Reports (Admin Only)', {}, false, function(source, args)
    SRPCore.Functions.ToggleOptin(source)

    if SRPCore.Functions.IsOptin(source) then
        TriggerClientEvent('SRPCore:Notify', source, 'You are receiving reports', 'success')
    else
        TriggerClientEvent('SRPCore:Notify', source, 'You are not receiving reports', 'error')
    end
end, 'trialhelper')


SRPCore.Commands.Add("aunjail", "Take a person out of Admin Jail", {{name="id", help="Player ID"}}, true, function(source, args)

    local src = source
    local playerId = tonumber(args[1])
    local Player = SRPCore.Functions.GetPlayer(src)
    local adminPermission = SRPCore.Functions.GetPermission(src, permissions['jail'])
    local userPermission = SRPCore.Functions.GetPermission(playerId, permissions['jail'])
    local tojailPalyer = SRPCore.Functions.GetPlayer(playerId)

    if SRPCore.Config.Server.PermissionLevels[adminPermission].power <= SRPCore.Config.Server.PermissionLevels[userPermission].power then
        TriggerClientEvent('srp-admin:Client:notify', src, 'You cannot use this command', 'error')
    elseif SRPCore.Functions.HasPermission(src, permissions['jail']) or IsPlayerAceAllowed(src, 'command') then
        local result = exports.oxmysql:executeSync('SELECT * FROM adminJail WHERE steam = ? and unjailed = false LIMIT 1', {tojailPalyer.PlayerData.steam})
        if result and result[1] then
            exports.oxmysql:executeSync('UPDATE adminjail SET unjailed = true where steam = ? and unjailed = false', { tojailPalyer.PlayerData.steam, tonumber(os.time()) })
        end
        TriggerClientEvent('srp-admin:client:unjail', playerId)
        TriggerClientEvent('srp-admin:Client:notify', src, 'You have admin unjail ID: '..playerId, 'success')
        TriggerEvent("srp-log:server:CreateLog", "admins", "Un Admin Jail ", "green", "**"..GetPlayerName(src).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..src..") Jail ID: "..tostring(playerId), false)
    end
end)


SRPCore.Commands.Add("ajail", "Admin Jail a player", {{name="id", help="Player ID"}, {name="Minutes", help="How may minutes"}, {name="Reason", help="Reason for the jail"}}, true, function(source, args)

    local src = source
    local Player = SRPCore.Functions.GetPlayer(src)
    local playerId = tonumber(args[1])
    local secounds = tonumber(args[2])*60
    local adminPermission = SRPCore.Functions.GetPermission(src, permissions['jail'])
    local userPermission = SRPCore.Functions.GetPermission(playerId, permissions['jail'])

    if SRPCore.Config.Server.PermissionLevels[adminPermission].power <= SRPCore.Config.Server.PermissionLevels[userPermission].power then
        TriggerClientEvent('srp-admin:Client:notify', src, 'You cannot use this command', 'error')
    elseif SRPCore.Functions.HasPermission(src, permissions['jail']) or IsPlayerAceAllowed(src, 'command') then
        adminJail(src, playerId, secounds, tostring(args[3]))
        TriggerEvent("srp-log:server:CreateLog", "admins", "Admin Jail", "green", "**"..GetPlayerName(src).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..src..") UnJail ID: "..tostring(playerId), false)
        -- TriggerClientEvent('chat:addMessage', -1, {
        --     template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been admin jailed:</strong> {1}</div>",
        --     args = {GetPlayerName(playerId), tostring(args[3])}
        -- })
    end
    
end)

SRPCore.Commands.Add("ajailtime", "Gets my Jail Time", {}, true, function(source, args)
    local src = source
    TriggerClientEvent('srp-admin:client:jailtime', src)
end)


RegisterServerEvent("srp-admin:server:checkAdmin")
AddEventHandler("srp-admin:server:checkAdmin", function()
    local src = source
	local Player = SRPCore.Functions.GetPlayer(src)
    local currentTime = tonumber(os.time())
    if Player then
            local result = exports.oxmysql:executeSync('SELECT * FROM adminJail WHERE steam = ? and releasetime > ? and unjailed = false ORDER BY id DESC LIMIT 1', { Player.PlayerData.steam, currentTime })
            if result and result[1] and currentTime < tonumber(result[1]["releasetime"]) then
                TriggerClientEvent('srp-admin:client:jail', src, result[1]["releasetime"], currentTime )
            end
    else
        print('Error: Unable to get a player')
    end
end)


RegisterCommand('kickall', function(source, args, rawCommand)
    local src = source
    if src > 0 then
        local reason = table.concat(args, ' ')
        local Player = SRPCore.Functions.GetPlayer(src)

        if SRPCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
            if args[1] ~= nil then
                for k, v in pairs(SRPCore.Functions.GetPlayers()) do
                    local Player = SRPCore.Functions.GetPlayer(v)
                    if Player ~= nil then
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('chatMessage', src, 'SYSTEM', 'error', 'Mention a reason..')
            end
        else
            TriggerClientEvent('chatMessage', src, 'SYSTEM', 'error', 'You can\'t do this..')
        end
    else
        for k, v in pairs(SRPCore.Functions.GetPlayers()) do
            local Player = SRPCore.Functions.GetPlayer(v)

            if Player then
                DropPlayer(Player.PlayerData.source, 'Server restart, check our Discord for more information: ' .. SRPCore.Config.Server.discord)
            end
        end
    end
end, false)

RegisterServerEvent("srp-admin:Server:ClearArea")
AddEventHandler("srp-admin:Server:ClearArea", function()
    local src = source
	local Player = SRPCore.Functions.GetPlayer(src)
    TriggerClientEvent('srp-admin:Client:ClearArea', -1, src, GetEntityCoords(GetPlayerPed(src)))    
    TriggerEvent("srp-log:server:CreateLog", "admins", "ClearArea", "green", "**"..GetPlayerName(src).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..src..")", false)
end)

SRPCore.Commands.Add("clearArea", "Clears the Area of EVERYTHING", {}, true, function(source, args) 
    TriggerClientEvent('srp-admin:Client:ClearArea', -1, source, GetEntityCoords(GetPlayerPed(source)))    
end, 'trialhelper')
SRPCore.Commands.Add('noclip', "Toggles NoClip", {}, true, function(source, args) 
    TriggerClientEvent('srp-admin:Client:toggleNoClicp', source)
end,'trialhelper')

SRPCore.Commands.Add('setammo', 'Set Your Ammo Amount (Admin Only)', {{name='amount', help='Amount of bullets, for example: 20'}, {name='weapon', help='Name of the weapen, for example: WEAPON_VINTAGEPISTOL'}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon then
        TriggerClientEvent('srp-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('srp-weapons:client:SetWeaponAmmoManual', src, 'current', amount)
    end
end, 'admin')


SRPCore.Commands.Add('fixfull', 'fix the vehicle fully', {}, false, function(source, args)
    local src = source
    TriggerClientEvent('srp-admin:Client:fixfull', src)
end, 'helper')

RegisterServerEvent("srp-admin:server:fixfull")
AddEventHandler("srp-admin:server:fixfull", function(plate)
    local src = source
	fixVehicle(src, plate)
end)

function fixVehicle(src,vehPlate)
    local adminPermission = SRPCore.Functions.GetPermission(src)
    local Player = SRPCore.Functions.GetPlayer(src)
    if SRPCore.Config.Server.PermissionLevels[adminPermission].power < SRPCore.Config.Server.PermissionLevels["trialhelper"].power then
        TriggerEvent('srp-admin:Client:notify', src, 'You cannot use this command', 'error')
    elseif SRPCore.Functions.HasPermission(src, permissions['fixcar']) or IsPlayerAceAllowed(src, 'command') then
        TriggerEvent('SRPCore:CallCommand', "fix", {})
        if vehPlate then
            exports.oxmysql:executeSync('UPDATE player_vehicles SET engine = 1000, body = 1000, '..
            'player_vehicles.condition = \'{"windows":{"1":1,"2":false,"3":false,"4":false,"5":false,"6":false,"7":false,"8":false,"9":false,"10":false,"11":false,"12":false,"13":false,"0":1},"dirt":0.0,"doors":{"1":true,"2":true,"3":true,"4":true,"5":true,"0":true},"tyres":{"1":2,"2":2,"3":2,"4":2,"5":2,"6":2,"7":2,"0":2}}\', '.. 
            'health = \'[{"value":100,"part":"electronics"},{"value":100,"part":"fuelinjector"},{"value":100,"part":"brakes"},{"value":100,"part":"radiator"},{"value":100,"part":"driveshaft"},{"value":100,"part":"transmission"},{"value":100,"part":"clutch"}]\' '..
            'WHERE plate = ?', {vehPlate})
            TriggerClientEvent('srp-admin:Client:notify', src, 'You have fixed '..tostring(vehPlate), 'success')
            TriggerEvent("srp-log:server:CreateLog", "admins", "fixVehicle", "green", "**"..GetPlayerName(src).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..src..")", false)
        end        
    end
end

SRPCore.Commands.Add('fuelfill', 'Fuels the vehicle at it fullest', {}, false, function(source, args)
    local src = source
    TriggerClientEvent('srp-admin:Client:fuelfill', src)
end, 'trialhelper')

RegisterServerEvent("srp-admin:server:fuelfill")
AddEventHandler("srp-admin:server:fuelfill", function(plate)
    local src = source
	fuelVehicle(src, plate)
end)

function fuelVehicle(src, vehPlate)
    local adminPermission = SRPCore.Functions.GetPermission(src)
    local Player = SRPCore.Functions.GetPlayer(src)
    if SRPCore.Config.Server.PermissionLevels[adminPermission].power < SRPCore.Config.Server.PermissionLevels["trialhelper"].power then
        TriggerEvent('srp-admin:Client:notify', src, 'You cannot use this command', 'error')
    elseif SRPCore.Functions.HasPermission(src, permissions['fixcar']) or IsPlayerAceAllowed(src, 'command') then
        if vehPlate then
            exports.oxmysql:executeSync('UPDATE player_vehicles SET fuel = 100 WHERE plate = ?', {vehPlate})
            TriggerClientEvent('srp-admin:Client:notify', src, 'You have fulled '..tostring(vehPlate), 'success')
            TriggerEvent("srp-log:server:CreateLog", "admins", "fuelVehicle", "green", "**"..GetPlayerName(src).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..src..")", false)
        end        
    end
end