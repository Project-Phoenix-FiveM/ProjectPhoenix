QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-communityservice:finishCommunityService')
AddEventHandler('qb-communityservice:finishCommunityService', function(key)
	local src = source 
	
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer then
			xPlayer.Functions.SetMetaData("communityservice", 0)
			TriggerClientEvent('qb-communityservice:finishCommunityService', xPlayer.PlayerData.source)
		end
	
end)

RegisterServerEvent('qb-communityservice:server:StartCommunityService')
AddEventHandler('qb-communityservice:server:StartCommunityService', function(targetSourceId, sentence, key)
	local src = source 
	local player = targetSourceId
	local count = sentence
		local tPlayer = QBCore.Functions.GetPlayer(player)
		TriggerClientEvent("qb-communityservice:inCommunityService", player, count)
		tPlayer.Functions.SetMetaData("communityservice", count)
end)

RegisterServerEvent('qb-communityservice:completeService')
AddEventHandler('qb-communityservice:completeService', function(key)
	local src = source
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer then
			xPlayer.Functions.SetMetaData("communityservice", xPlayer.PlayerData.metadata["communityservice"] - 1)
		end
end)

RegisterServerEvent('qb-communityservice:extendService') 
AddEventHandler('qb-communityservice:extendService', function()
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer then
		xPlayer.Functions.SetMetaData("communityservice", xPlayer.PlayerData.metadata["communityservice"] + Config.ServiceExtensionOnEscape)
	end
end)

RegisterServerEvent('sendserverdatass', function(data)
local player_id = data.id
local kamu = data.kamu
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.PlayerData.job.name == "police" then
		local tPlayer = QBCore.Functions.GetPlayer(tonumber(player_id))
		if tPlayer then
			local count = tonumber(kamu)
			TriggerClientEvent("qb-communityservice:inCommunityService", tPlayer.PlayerData.source, count)
			tPlayer.Functions.SetMetaData("communityservice", count)
			TriggerClientEvent("QBCore:Notify", src, "Player has been sentenced of community service.")
		else
			TriggerClientEvent("QBCore:Notify", source, "There Is No Such Player!", "error")
				end
	end
end)

QBCore.Commands.Add("endcomserv", "", {{name="id", help="Player ID"}}, true, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job.name == "police" then
		local tPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if tPlayer then
			tPlayer.Functions.SetMetaData("communityservice", 0)
			TriggerClientEvent('qb-communityservice:finishCommunityService', tPlayer.PlayerData.source)
		else
			TriggerClientEvent("QBCore:Notify", source, "There Is No Such Player!", "error")
		end
	end
end)