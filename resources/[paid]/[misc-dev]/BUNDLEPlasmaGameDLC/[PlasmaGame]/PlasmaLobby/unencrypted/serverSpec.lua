
--You can add here any restriction to create a game (Job / Vip or what ever)
RegisterServerEvent('PlasmaLobby:AskForCreateAGame')
AddEventHandler('PlasmaLobby:AskForCreateAGame', function(data)
	local player = source
	print("---creatorname : "..tostring(data.creatorname))
	for k,v in pairs(data) do
		print(tostring(k).." : "..tostring(v))
	end
	print("---")
	
	local curIDX = #allPlasmaSession + 1 
	if data.mode == "Team DeathMatch" then
		allPlasmaSession[curIDX] = {}
		allPlasmaSession[curIDX].lobbyname = "Game-"..tostring(IDX)
		TriggerEvent("PaintBall:NewSession",data,curIDX,player)
	elseif data.mode == "Capture The Orbs" then
		allPlasmaSession[curIDX] = {}
		allPlasmaSession[curIDX].lobbyname = "Game-"..tostring(IDX)
		TriggerEvent("PaintBall:NewCTFSession",data,curIDX,player)
	elseif data.mode == "Burning Mode" then
		allPlasmaSession[curIDX] = {}
		allPlasmaSession[curIDX].lobbyname = "Game-"..tostring(IDX)
		TriggerEvent("PlasmaBurning:NewSession",data,curIDX,player)
	elseif data.mode == "Random Weapon" then
		allPlasmaSession[curIDX] = {}
		allPlasmaSession[curIDX].lobbyname = "Game-"..tostring(IDX)
		TriggerEvent("PlasmaRandom:NewSession",data,curIDX,player)
	end
end)

--You can add here any restriction to create a game (ticket / Vip or what ever)
RegisterServerEvent('PlasmaLobby:TryToJoinAGame')
AddEventHandler('PlasmaLobby:TryToJoinAGame', function(IDX,side)
	-- print("RWM Lobby Status received")
	-- Wait(30)
	local player = source
	local gameDetails = {}
	local isOwner = false
	-- if RequestAllLobby() then
		-- concatAllLobby()
	print("k,v in pairs(allPlasmaSession)")
	print("Lobby With Exclusion == "..tostring(IsPlayerAlreadyInALobby(player,IDX)))
	print("Lobby Without Exclusion == "..tostring(IsPlayerAlreadyInALobby(player)))
	
	if not IsPlayerAlreadyInALobby(player,IDX) then
		for k,v in pairs(allPlasmaSession) do
			for k1,v1 in pairs(v) do
			print("^1k,v:"..tostring(k1)..","..tostring(v1).."^7")
			end
			if tostring(v.idx) == tostring(IDX) then
			
				if v.CurStat == "WaitingPeople" then
					if v.modes == "Team DeathMatch" then
					print("status : "..tostring(v.CurStat))
						
						if side =="blue" then
							TriggerEvent("PaintBall:JoinBlue",IDX,player,GetSpecificPlayerName(player))
						elseif side =="red" then
							TriggerEvent("PaintBall:JoinRed",IDX,player,GetSpecificPlayerName(player))
						end
						
						
					elseif v.modes == "Capture The Orbs" then
						if side =="blue" then
							TriggerEvent("PaintBallCTF:JoinBlue",IDX,player,GetSpecificPlayerName(player))
						elseif side =="red" then
							TriggerEvent("PaintBallCTF:JoinRed",IDX,player,GetSpecificPlayerName(player))
						end
					elseif v.modes == "Random Weapon" then
						if side =="blue" then
							TriggerEvent("PlasmaRandom:JoinBlue",IDX,player,GetSpecificPlayerName(player))
						elseif side =="red" then
							TriggerEvent("PlasmaRandom:JoinRed",IDX,player,GetSpecificPlayerName(player))
						end
					
					
					elseif v.modes == "Burning Mode" then
						if side =="blue" then
							TriggerEvent("PlasmaBurn:JoinBlue",IDX,player,GetSpecificPlayerName(player))
						elseif side =="red" then
							TriggerEvent("PlasmaBurn:JoinRed",IDX,player,GetSpecificPlayerName(player))
						end
					end
				else
					TriggerClientEvent("PlasmaLobby:Notif",player,trad[lang]["AlreadyInALobby"],"error")
				end
				break; --Break car game found
			end
		end
	else
		TriggerClientEvent("PlasmaLobby:Notif",player,trad[lang]["AlreadyInALobby"],"error")
	end
	-- else
		-- print("error on getting lobby")
	-- end
end)