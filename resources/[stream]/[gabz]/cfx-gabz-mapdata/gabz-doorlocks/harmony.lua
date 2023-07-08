-- ## GABZ - HARMONY REPAIR
-- ## COORDINATES: 1178.985, 2653.985, 37.862

-- Garage right
table.insert(Config.DoorList, {
	garage = true,
	locked = true,
	authorizedJobs = { ['mechanic']=0 },
	maxDistance = 4.0,
	objCoords = vector3(1174.654, 2645.222, 38.63962),
	slides = 6.0,
	lockpick = false,
	audioRemote = false,
	objHash = -822900180, -- v_ilev_carmod3door 
	fixText = true,
	objHeading = 180.075881958,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage left
table.insert(Config.DoorList, {
	garage = true,
	locked = true,
	authorizedJobs = { ['mechanic']=0 },
	maxDistance = 4.0,
	objCoords = vector3(1182.306, 2645.232, 38.63962),
	slides = 6.0,
	lockpick = false,
	audioRemote = false,
	objHash = -822900180, -- v_ilev_carmod3door
	fixText = true,
	objHeading = 180.075881958,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Entry
table.insert(Config.DoorList, {
	garage = false,
	locked = true,
	authorizedJobs = { ['mechanic']=0 },
	maxDistance = 2.0,
	objCoords = vector3(1187.202, 2644.95, 38.55176),
	slides = false,
	lockpick = false,
	audioRemote = false,
	objHash = 1335311341, -- v_ilev_ss_door5_r
	fixText = false,
	objHeading = 180.075881958,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})