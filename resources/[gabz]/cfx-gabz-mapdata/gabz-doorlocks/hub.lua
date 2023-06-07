-- ## GABZ - NEW HUB
-- ## COORDINATES: -50.734, -1041.996, 28.163

-- Bennys Entry New location
table.insert(Config.DoorList, {
	objCoords = vector3(-44.1884, -1043.554, 27.8016),
	objHeading = 69.999923706054,
	objHash = -427498890, -- lr_prop_supermod_door_01
	maxDistance = 6.0,
	lockpick = false,
	garage = true,
	audioRemote = false,
	fixText = false,
	authorizedJobs = { ['mechanic']=0 },
	slides = 6.0,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Bennys Entry Old location
table.insert(Config.DoorList, {
	authorizedJobs = { ['mechanic']=0 },
	textCoords = vector3(-205.734,-1310.755,31.728),
	objCoords = vector3(-205.6828, -1310.682, 30.29572),
	objHeading = 0.0,
	objHash = -427498890, -- lr_prop_supermod_door_01
	maxDistance = 10.0,		
	slides = true,
	garage = true,
	lockpick = false,
	audioRemote = false,
	locked = true,
	setText = true,
	-- fixText = true,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

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

-- PDM main entry
table.insert(Config.DoorList, {
	audioRemote = false,
	garage = false,
	slides = false,
	objHeading = 249.99945068359,
	locked = true,
	lockpick = false,
	fixText = true,
	objHash = 1973010099, -- gabz_pdm_maindoor
	objCoords = vector3(-55.95074, -1088.065, 27.61301),
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM entry from parking
table.insert(Config.DoorList, {
	audioRemote = false,
	garage = false,
	slides = false,
	objHeading = 339.99945068359,
	locked = true,
	lockpick = false,
	fixText = true,
	objHash = 1973010099, -- gabz_pdm_maindoor
	objCoords = vector3(-48.1282, -1103.5, 27.61301),
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM office right
table.insert(Config.DoorList, {
	audioRemote = false,
	garage = false,
	slides = false,
	objHeading = 249.99945068359,
	locked = true,
	lockpick = false,
	fixText = false,
	objHash = 2089009131, -- sum_p_mp_yacht_door_02
	objCoords = vector3(-32.64267, -1108.559, 27.42459),
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM office left
table.insert(Config.DoorList, {
	audioRemote = false,
	garage = false,
	slides = false,
	objHeading = 69.999412536621,
	locked = true,
	lockpick = false,
	fixText = false,
	objHash = 2089009131, -- sum_p_mp_yacht_door_02
	objCoords = vector3(-30.42846, -1102.47, 27.42459),
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM garage (from inside)
table.insert(Config.DoorList, {
	audioRemote = false,
	garage = false,
	slides = false,
	objHeading = 249.99945068359,
	locked = true,
	lockpick = false,
	fixText = false,
	objHash = 2089009131, -- sum_p_mp_yacht_door_02
	objCoords = vector3(-27.62105, -1094.763, 27.42459),
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- PDM garage gate (from outside)
table.insert(Config.DoorList, {
	audioRemote = false,
	garage = true,
	slides = false,
	objHeading = 159.99942016602,
	locked = true,
	lockpick = false,
	fixText = true,
	objHash = 1010499530, -- gabz_pdm_garage_gate
	objCoords = vector3(-21.51159, -1089.399, 28.11345),
	authorizedJobs = { ['cardealer']=0 },
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})