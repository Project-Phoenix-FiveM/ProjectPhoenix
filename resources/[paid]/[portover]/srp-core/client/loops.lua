local counter = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if NetworkIsSessionStarted() then
			Citizen.Wait(10)
			TriggerServerEvent('SRPCore:PlayerJoined')
			return
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if isLoggedIn then
			counter = counter + 1
			local data = {}
			if counter == 60 then -- Old 6
				counter = 0
				data.payment = true
			end
			--Citizen.Wait((1000 * 60) * 10)
			Citizen.Wait(30000) -- 30 sec
			TriggerEvent("SRPCore:Player:UpdatePlayerData",data)
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if isLoggedIn then
			Citizen.Wait(30000) -- 30 sec
			TriggerEvent("SRPCore:Player:UpdatePlayerPosition")
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(math.random(3000, 5000))
		if isLoggedIn then
			if SRPCore.Functions.GetPlayerData().metadata["hunger"] <= 0 or SRPCore.Functions.GetPlayerData().metadata["thirst"] <= 0 then
				--local ped = GetPlayerPed(-1)
				local currentHealth = GetEntityHealth(PlayerPedId())

				SetEntityHealth(PlayerPedId(), currentHealth - math.random(5, 10))
			end
		end
	end
end)