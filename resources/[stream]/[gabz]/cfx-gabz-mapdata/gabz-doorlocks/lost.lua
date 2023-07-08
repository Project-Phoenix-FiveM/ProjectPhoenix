-- ## GABZ - LOST MC
-- ## COORDINATES: 957.232, -143.250, 74.496

-- Street entry (Sliding fence)
table.insert(Config.DoorList, {
	objCoords = vector3(956.4542, -137.8408, 73.5749),
	maxDistance = 6.0,
	slides = true,
	garage = false,
	fixText = false,
	objHash = -930593859, -- lost_mc_gate
	audioRemote = false,
	authorizedJobs = { ['lost']=0 },
	objHeading = 148.1940612793,
	locked = true,
	lockpick = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- main_building_entry
table.insert(Config.DoorList, {
	objCoords = vector3(981.1506, -103.2552, 74.99358),
	maxDistance = 2.0,
	slides = false,
	garage = false,
	fixText = true,
	objHash = 190770132, -- v_ilev_lostdoor
	audioRemote = false,
	authorizedJobs = { ['lost']=0 },
	objHeading = 42.65185546875,
	locked = true,
	lockpick = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage left entry (normal door)
table.insert(Config.DoorList, {
	slides = false,
	maxDistance = 2.0,
	lockpick = false,
	fixText = false,
	audioRemote = false,
	objHeading = 43.01594543457,
	authorizedJobs = { ['lost']=0 },
	garage = false,
	objCoords = vector3(959.3824, -120.4512, 75.16158),
	locked = true,
	objHash = 1335311341, -- v_ilev_ss_door5_r	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage left 1 (garage door)
table.insert(Config.DoorList, {
	objCoords = vector3(963.1594, -117.3218, 75.24942),
	maxDistance = 6.0,
	slides = 6.0,
	garage = true,
	fixText = false,
	objHash = -822900180, -- v_ilev_carmod3door
	audioRemote = false,
	authorizedJobs = { ['lost']=0 },
	objHeading = 43.01594543457,
	locked = true,
	lockpick = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage left 2 (garage door)
table.insert(Config.DoorList, {
	objCoords = vector3(968.7536, -112.1022, 75.24942),
	maxDistance = 6.0,
	slides = 6.0,
	garage = true,
	fixText = true,
	objHash = -822900180, -- v_ilev_carmod3door
	audioRemote = false,
	authorizedJobs = { ['lost']=0 },
	objHeading = 43.01594543457,
	locked = true,
	lockpick = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage right (same as biker DLC)
table.insert(Config.DoorList, {
	objCoords = vector3(982.3874, -125.371, 74.99314),
	maxDistance = 6.0,
	slides = 6.0,
	garage = true,
	fixText = false,
	objHash = -197537718, -- lost_mc_door_01 
	audioRemote = false,
	authorizedJobs = { ['lost']=0 },
	objHeading = 239.42889404296,
	locked = true,
	lockpick = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})