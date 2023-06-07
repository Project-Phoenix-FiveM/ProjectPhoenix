-- ## GABZ - IMPOUND
-- ## COORDINATES: -191.51, -1153.89, 23.58

-- Impound office room
table.insert(Config.DoorList, {
	lockpick = false,
	objHash = -952356348, -- v_ilev_cf_officedoor
	authorizedJobs = { ['mechanic']=0 },
	maxDistance = 2.0,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-187.0614, -1162.348, 23.82124),
	garage = false,
	objHeading = 89.999961853028,
	locked = true,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Impound back door
table.insert(Config.DoorList, {
	lockpick = false,
	objHash = 97297972, -- v_ilev_gc_door04
	authorizedJobs = { ['mechanic']=0 },
	maxDistance = 2.0,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-189.636, -1167.884, 23.82124),
	garage = false,
	objHeading = 179.99998474122,
	locked = true,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Impound Enter Gate
table.insert(Config.DoorList, {
	lockpick = false,
	objHash = 1286535678, -- prop_facgate_07b
	authorizedJobs = { ['mechanic']=0 },
	maxDistance = 9.0,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(-164.1268, -1160.678, 22.63864),
	garage = false,
	objHeading = 180.00093078614,
	locked = true,
	slides = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Impound Exit Gate
table.insert(Config.DoorList, {
	slides = true,
	objHeading = 180.00001525878,
	authorizedJobs = { ['mechanic']=0 },
	garage = false,
	maxDistance = 9.0,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(-225.0742, -1158.824, 22.09534),
	objHash = 1286535678, -- prop_facgate_07b
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})
