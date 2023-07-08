-- ## GABZ - EAST SIDE BALLAS LTD GASOLINE 
-- ## COORDINATES: -58.676 -1757.732 29.077

-- entry
table.insert(Config.DoorList, {
	authorizedJobs = { ['unemployed']=0 },		
	doors = {
		{objHash = 2065277225, objHeading = 319.98648071289, objCoords = vector3(-51.96669, -1757.387, 29.57094)}, -- v_ilev_gasdoor_r
		{objHash = -868672903, objHeading = 139.98645019531, objCoords = vector3(-53.96111, -1755.717, 29.57094)} -- v_ilev_gasdoor
	},
	maxDistance = 2.5,
	lockpick = false,
	locked = true,
	slides = false,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})