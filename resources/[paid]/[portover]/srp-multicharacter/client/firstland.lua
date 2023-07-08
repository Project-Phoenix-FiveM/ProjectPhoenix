local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

local disablecontrols = false
local play = false

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
		if disablecontrols == true then
		  DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		  DisableControlAction(0, 24,  true) -- Shoot
		  DisableControlAction(0, 92,  true) -- Shoot in car
		  DisableControlAction(0, 24,  true)
		  DisableControlAction(0, 25,  true)
		  DisableControlAction(0, 45,  true)
		  DisableControlAction(0, 76,  true)
		  DisableControlAction(0, 102,  true)
		  DisableControlAction(0, 278,  true)
		  DisableControlAction(0, 279,  true)
		  DisableControlAction(0, 280,  true)
		  DisableControlAction(0, 281,  true)
          DisableControlAction(0, 23,  true) -- F
          DisableControlAction(0, 75,  true) -- F
		  DisableControlAction(0, 140, true) -- Attack
		  DisableControlAction(0, 24, true) -- Attack
		  DisableControlAction(0, 25, true) -- Attack
		  DisableControlAction(2, 24, true) -- Attack
		  DisableControlAction(2, 257, true) -- Attack 2
		  DisableControlAction(2, 25, true) -- Aim
		  DisableControlAction(2, 263, true) -- Melee Attack 1
		  DisableControlAction(2, Keys['R'], true) -- Reload
		  DisableControlAction(2, Keys['LEFTALT'], true)
		  DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
		  DisableControlAction(2, Keys['Q'], true) -- Cover
		  DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
		  DisableControlAction(2, Keys['F1'], true) -- Disable phone
		  DisableControlAction(2, Keys['F2'], true) -- Inventory
		  DisableControlAction(2, Keys['F3'], true) -- Animations
		  DisableControlAction(2, Keys['F6'], true)
		  DisableControlAction(2, Keys['F7'], true)
		  DisableControlAction(2, Keys['F9'], true)
		  DisableControlAction(2, Keys['F10'], true)
		  DisableControlAction(2, Keys['Y'], true)
		  DisableControlAction(0, Keys['A'], true)
		  DisableControlAction(0, Keys['D'], true)
		  DisableControlAction(2, Keys["~"], true)
		  DisableControlAction(2, Keys["X"], true)
		  DisableControlAction(0, Keys["X"], true)
		  DisableControlAction(2, Keys["T"], true)
		  DisableControlAction(0, Keys["T"], true)
		  DisableControlAction(2, 49, true)
		  DisableControlAction(0, 49, true)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)

		if play and SRPCore then
			play = false

			Citizen.Wait(3000)

			while GetIsLoadingScreenActive() == true do
				Citizen.Wait(1)
			end

			local hash = 'shamal'
			while not HasModelLoaded(hash) do
				RequestModel(hash)
				Citizen.Wait(10)
			end
			if HasModelLoaded(hash) then
				vehicle = CreateVehicle(hash,Config.PlaneCoords.x,Config.PlaneCoords.y,Config.PlaneCoords.z, Config.PlaneCoords.a,false,false)

			--SRPCore.Functions.SpawnVehicle(GetHashKey('shamal'), function(vehicle)
				SetEntityInvincible(vehicle, true)
				--SetEntityCollision(vehicle,false,true)
				SetNetworkVehicleAsGhost(vehicle, true)
				SetModelAsNoLongerNeeded('shamal')
				--SetEntityVisible(vehicle, false,0)
				SetPedIntoVehicle(PlayerPedId(), vehicle, 2)
				RequestModel(GetHashKey('a_m_y_business_02'))

				while not HasModelLoaded(GetHashKey('a_m_y_business_02')) do
					Citizen.Wait(0)
				end

				DoScreenFadeIn(500)

				driverPed = CreatePedInsideVehicle(vehicle, 4, GetHashKey('a_m_y_business_02'), -1, true, true)
				--TaskPlaneMission(driverPed, vehicle, 0, 0,  -185.24, -1994.43, 379.57, 1, 1.0, 0, 2.4, 2313.3, 11.3)
				--TaskPlaneMission(driverPed, vehicle, 0, 0,  -2425.43, -2489.15, 279.57, 1, 1.0, 0, 2.4, 2313.3, 111.3) -- 309.24, -3504.31, 379.57 --
				TaskPlaneMission(driverPed, vehicle, 0, 0,  -2425.43, -2489.15, 179.57, 1, 1.0, 0, 2.4, 2313.3, 111.3) -- 309.24, -3504.31, 379.57 --
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(2000)
				SetVehicleForwardSpeed(vehicle, 72.2)
				Citizen.Wait(1000)
				SetVehicleForwardSpeed(vehicle, 62.2)
				Citizen.Wait(1000)
				SetVehicleForwardSpeed(vehicle, 50.2)
				Citizen.Wait(1000)
				SetVehicleForwardSpeed(vehicle, 42.2)
				Citizen.Wait(1000)
				SetVehicleForwardSpeed(vehicle, 35.2)
				Citizen.Wait(1000)

				--TaskPlaneLand(driverPed, vehicle, -950.55, -3359.43, 13.5, -1645.4, -2961.7, 13.5)
				--TaskPlaneLand(driverPed, vehicle, -1049.93, -3308.77, 13.95, -1645.4, -2961.7, 13.5)
				--TaskPlaneLand(driverPed, vehicle, -946.66, -3366.51, 13.94, -1647.47, -2964.06, 13.94)
				TaskPlaneLand(driverPed, vehicle, -946.66, -3366.51, 13.94, -1554.05, -3017.84, 13.95)

				while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -1601.09, -2990.63, 13.98, true) > 30 do
					Citizen.Wait(10)
				end

				DoScreenFadeOut(800)
				Citizen.Wait(2000)
				DeleteEntity(vehicle)
				DeleteEntity(driverPed)
				Citizen.Wait(2500)

				SetEntityCoords(GetPlayerPed(-1), Config.PlayerSpawnCoords)
				SetEntityHeading(GetPlayerPed(-1), 325.12)
				Citizen.Wait(1000)
				DoScreenFadeIn(2800)
				disablecontrols = false



				TriggerServerEvent('srp-multicharacter:server:finishCreateChar')
       			TriggerEvent('srp-clothes:client:setNo')
       			TriggerEvent('antirpquestion:checkTestPass')
				SRPCore.Functions.TriggerCallback('srp-multicharacter:server:getTaxiOn', function(taxis)

					local charinfo = SRPCore.Functions.GetPlayerData().charinfo
					local gender = 'Mr.'

					if charinfo.gender == 1 then
						gender = 'Mrs.'
					end

					if taxis then
						TriggerServerEvent('srp-phone:server:sendNewMail', {
							sender = "San Andreas Gov.",
							subject = "Welcome to Los Santos",
							message = "<strong>Dear " .. gender .. " " .. charinfo.lastname .. "</strong>,<br /><br />This is an important message from the <strong>government.</strong><br/><br/> To get the contacts and the information you need in this city, we would like to recommend you to call one of our <strong>taxi drivers</strong> from your phone app to give you a ride. <br/> <br/> They can help you to answer any questions and show you around our city. <br/><br/> <strong>Thank you for visiting our city. </strong> <br/> <br/> <strong>San Andreas Gov.</strong>"
						})
					else
						TriggerServerEvent('srp-phone:server:sendNewMail', {
							sender = "San Andreas Gov.",
							subject = "Welcome to Los Santos",
							message = "<strong>Dear " .. gender .. " " .. charinfo.lastname .. "</strong>,<br /><br />This is an important message from the <strong>government.</strong><br/><br/> To start your journey and explore our city, we recommend you rent a bike or a scooter from just outside the airport and visit the <strong>Job Center</strong> that was already marked on your phone GPS. <br/><br/> We hope you’ll enjoy your stay. <br/><br/> <strong>Thank you for visiting our city. </strong> <br/> <br/> <strong>San Andreas Gov.</strong>"
						})
						SetNewWaypoint(-233.49,-921.29)
					end

				end)	

        		SetEntityVisible(PlayerPedId(), true, 0)
        		SetLocalPlayerVisibleLocally(true)
			end
			--end, Config.PlaneCoords, false)
		end
	end
end)


RegisterNetEvent("srp-multicharacter:client:firstland")
AddEventHandler("srp-multicharacter:client:firstland", function()
	disablecontrols = true
	play = true
  SetEntityVisible(PlayerPedId(), true, 0)
end)
