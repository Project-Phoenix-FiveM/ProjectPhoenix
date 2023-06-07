-- ## GABZ - IMPORT GARAGE
-- ## COORDINATES: 946.637, -990.316, 39.228

-- entry (garage door)
table.insert(Config.DoorList, {
	objCoords = vector3(945.9344, -985.571, 41.1689),
	authorizedJobs = { ['mechanic']=0 },
	lockpick = false,
	objHash = -983965772, -- gabz_imp_garage_door
	maxDistance = 6.0,
	audioRemote = false,
	fixText = false,
	objHeading = 3.6506202220916,
	garage = true,
	slides = 6.0,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Staff front door
table.insert(Config.DoorList, {
	objCoords = vector3(948.5288, -965.352, 39.64354),
	authorizedJobs = { ['mechanic']=0 },
	lockpick = false,
	objHash = 1289778077, -- v_ilev_roc_door3
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objHeading = 93.65064239502,
	garage = false,
	slides = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Staff back door
table.insert(Config.DoorList, {
	objCoords = vector3(955.3582, -972.4452, 39.64792),
	authorizedJobs = { ['mechanic']=0 },
	lockpick = false,
	objHash = -626684119, -- v_ilev_roc_door2
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objHeading = 183.65063476562,
	garage = false,
	slides = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})