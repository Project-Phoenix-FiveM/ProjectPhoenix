-- ## GABZ - PDM
-- ## COORDINATES: -70.46, -1103.06, 26.46

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