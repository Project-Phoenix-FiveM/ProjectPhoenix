Citizen.CreateThread( function()
	
	local resetcounter = 0
	local jumpDisabled = true
  	while true do 
    Citizen.Wait(1)
	local ped = PlayerPedId()
		if jumpDisabled and resetcounter > 0 and IsPedJumping(ped) then	
			SetPedToRagdoll(ped, 1000, 1000, 3, 0, 0, 0)
			resetcounter = 0
		end
		if not jumpDisabled and IsPedJumping(ped) then
			if math.random(2) == 2 then
				jumpDisabled = true
			end
			resetcounter = 1000
			Citizen.Wait(1200)
		end
		if resetcounter > 0 then
			resetcounter = resetcounter - 1
		else
			if jumpDisabled then
				resetcounter = 0
				jumpDisabled = false
			end
		end
	end
end) 

