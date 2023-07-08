

local isCurrentlyInAGame = false
local currentWeapon = "WEAPON_PLASMAP"

AddEventHandler('PlasmaLobby:CurrentGameDATA', function () -- Detection of start 
	print("Game launched")
	isCurrentlyInAGame = true
	currentWeapon = "WEAPON_PLASMAP"  --Set the default Weapon
end)

RegisterNetEvent('PlasmaLobby:CLILeaveTheGame')
AddEventHandler('PlasmaLobby:CLILeaveTheGame', function()
-- PlasmaLobby:CLILeaveTheGame
	isCurrentlyInAGame = false
	Wait(100)
	reEnableAction()
end)
RegisterNetEvent('PaintBallCTF:GoToFinMatchMSG')
AddEventHandler('PaintBallCTF:GoToFinMatchMSG', function() -- Detection of end 
	print("End Game CTF")
	isCurrentlyInAGame = false
	Wait(100)
	reEnableAction()
end)

RegisterNetEvent('PaintBall:GoToFinMatchMSG')
AddEventHandler('PaintBall:GoToFinMatchMSG', function() -- Detection of end
	print("End Game Classic")
	isCurrentlyInAGame = false
	Wait(100)
	reEnableAction()
end)

RegisterNetEvent('PlasmaRandom:GoToFinMatchMSG')
AddEventHandler('PlasmaRandom:GoToFinMatchMSG', function() -- Detection of end
	print("End Game Random")
	isCurrentlyInAGame = false
	Wait(100)
	reEnableAction()
end)


RegisterNetEvent('PlasmaLobby:CurrentWeapon')
AddEventHandler('PlasmaLobby:CurrentWeapon', function(wep) -- Detection of current Weapon (specific to random weap)
	currentWeapon = wep
end)

Citizen.CreateThread(function()
	while true do
		if isCurrentlyInAGame == true then
			print("Is in a game : "..tostring(isCurrentlyInAGame))
			GiveWeaponToPed(PlayerPedId(),GetHashKey(currentWeapon),250,false,true)
		else
			for k,v in pairs(LstGun) do
				RemoveWeaponFromPed(PlayerPedId(),GetHashKey(v))
			end
		end
		Wait(100)
	end
end)

-- RegisterCommand('ForceInGame', function(source, args, fullCommand)
	-- isCurrentlyInAGame = not isCurrentlyInAGame
-- end, false)




disabledControls = {
    30,     -- A and D (Character Movement)
    31,     -- W and S (Character Movement)
    21,     -- LEFT SHIFT
    36,     -- LEFT CTRL
    22,     -- SPACE
    44,     -- Q
    38,     -- E
    71,     -- W (Vehicle Movement)
    72,     -- S (Vehicle Movement)
    59,     -- A and D (Vehicle Movement)
    60,     -- LEFT SHIFT and LEFT CTRL (Vehicle Movement)
    85,     -- Q (Radio Wheel)
    86,     -- E (Vehicle Horn)
    15,     -- Mouse wheel up
    14,     -- Mouse wheel down
    37,     -- Controller R1 (PS) / RT (XBOX)
    80,     -- Controller O (PS) / B (XBOX)
    228,    -- 
    229,    -- 
    172,    -- 
    173,    -- 
    37,     -- 
    44,     -- 
    178,    -- 
    244    -- 
}
function reEnableAction()
	for k, v in pairs(disabledControls) do
		EnableControlAction(0, v, true)
	end
end