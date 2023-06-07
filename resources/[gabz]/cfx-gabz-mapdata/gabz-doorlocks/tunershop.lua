-- ## GABZ - TUNERS SHOP
-- ## COORDINATES: 166.715, -3014.122, 5.888

-- Entry (normal door)
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(154.9345, -3017.323, 7.190679),
	objHeading = 270.00003051758,		
	objHash = -2023754432, -- v_ilev_rc_door2
	maxDistance = 2.0,
	audioRemote = false,
	garage = false,
	locked = true,
	lockpick = false,
	slides = false,
	fixText = true,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage door right (from outside)
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(154.8095, -3023.889, 8.503336),
	objHeading = 89.999961853027,
	objHash = -456733639, -- denis3d_ts_gate
	maxDistance = 10.0,
	audioRemote = false,
	garage = true,
	locked = true,
	lockpick = false,
	slides = 6.0,
	fixText = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage door left (from outside)
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(154.8095, -3034.051, 8.503336),
	objHeading = 89.999961853027,		
	objHash = -456733639, -- denis3d_ts_gate
	maxDistance = 10.0,
	audioRemote = false,
	garage = true,
	locked = true,
	lockpick = false,
	slides = 6.0,
	fixText = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Employees room
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(151.4668, -3011.705, 7.258367),
	objHeading = 89.999977111816,
	objHash = -1229046235, -- denis3d_ts_container_doors
	maxDistance = 2.0,
	audioRemote = false,
	garage = false,		
	locked = true,
	lockpick = false,
	slides = false,
	fixText = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})