local shot = false
local check = false
local check2 = false
local count = 0

Citizen.CreateThread(function()
	while true do
		SetBlackout(false)
		Citizen.Wait( 1 )
		if IsPlayerFreeAiming(PlayerId()) then
		    if GetFollowVehicleCamViewMode() == 4 and check == false then
			    check = false
			else
			    SetFollowVehicleCamViewMode(4)
			    check = true
			end
		else
		    if check == true then
		        SetFollowVehicleCamViewMode(0)
				check = false
			end
		end
	end
end )



Citizen.CreateThread(function()
	while true do
		SetBlackout(false)
		Citizen.Wait(1)
		
		if IsPedShooting(PlayerPedId()) and shot == false and GetFollowVehicleCamViewMode() ~= 4 then
			check2 = true
			shot = true
			SetFollowVehicleCamViewMode(4)
		end
		
		if IsPedShooting(PlayerPedId()) and shot == true and GetFollowVehicleCamViewMode() == 4 then
			count = 0
		end
		
		if not IsPedShooting(PlayerPedId()) and shot == true then
		    count = count + 1
		end

        if not IsPedShooting(PlayerPedId()) and shot == true then
			if not IsPedShooting(PlayerPedId()) and shot == true and count > 20 then
		        if check2 == true then
				    check2 = false
					shot = false
					SetFollowVehicleCamViewMode(1)
				end
			end
		end	    
	end
end )