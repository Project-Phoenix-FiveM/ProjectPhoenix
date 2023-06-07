-- ## GABZ - HAYES AUTO
-- ## COORDINATES: -1434.173, -441.539, 35.624

-- Entry (normal door)
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(-1434.156, -448.586, 36.05924),
	slides = false,
	maxDistance = 3.0,
	lockpick = false,
	fixText = true,
	audioRemote = false,
	objHeading = 31.999956130982,
	garage = false,
	locked = true,
	objHash = -634936098, -- denis3d_hayes_auto_maindoors	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Entry 1 (garage door)
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=0 },
	textCoords = vector3(-1414.868, -436.3676, 34.77352),
	objCoords = vector3(-1414.868, -436.3676, 34.77352),
	objHeading = 31.990060806274,
	objHash = 1715394473, -- denis3d_hayes_auto_shuttergate 		
	maxDistance = 5.5,
	slides = true,
	lockpick = false,
	audioRemote = false,
	garage = false,
	locked = true,
	setText = true,
	-- fixText = true,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Entry 2 (garage door)
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=0 },
	textCoords = vector3(-1421.118, -440.272, 34.77352),
	objCoords = vector3(-1421.118, -440.272, 34.77352),
	objHeading = 31.999959945678,
	objHash = 1715394473, -- denis3d_hayes_auto_shuttergate		
	maxDistance = 5.5,
	slides = true,
	lockpick = false,
	setText = true,
	audioRemote = false,
	garage = false,
	locked = true,
	-- fixText = true,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Entry 3 (garage door)
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=0 },
	textCoords = vector3(-1427.326, -444.1516, 34.77352),
	objCoords = vector3(-1427.326, -444.1516, 34.77352),
	objHeading = 32.01089477539,
	objHash = 1715394473, -- denis3d_hayes_auto_shuttergate		
	maxDistance = 5.5,
	slides = true,
	lockpick = false,
	setText = true,
	audioRemote = false,
	garage = false,
	locked = true,
	-- fixText = true,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Staff
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=0 },
	objCoords = vector3(-1427.526, -455.6804, 36.05956),
	objHeading = 302.0,
	maxDistance = 2.0,
	slides = false,
	lockpick = false,
	audioRemote = false,
	garage = false,
	locked = true,
	objHash = 1289778077, -- v_ilev_roc_door3
	fixText = true,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})