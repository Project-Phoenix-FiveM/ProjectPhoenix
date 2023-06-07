-- ## GABZ - PIZZERIA
-- ## COORDINATES: 789.087, -758.266, 26.728

-- front entry
table.insert(Config.DoorList, {
	doors = {
		{objHash = -49173194, objHeading = 270.00003051758, objCoords = vector3(794.2512, -759.4415, 27.02702)}, -- sm_pizzeria_mdoor_r
		{objHash = 95403626, objHeading = 270.00003051758, objCoords = vector3(794.2512, -757.0618, 27.02702)} -- sm_pizzeria_mdoor_l
 	},
	maxDistance = 2.5,
	locked = true,
	slides = false,
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- left entry
table.insert(Config.DoorList, {
	doors = {
		{objHash = -49173194, objHeading = 180.00001525879, objCoords = vector3(803.2782, -747.9282, 27.02702)}, -- sm_pizzeria_mdoor_r
		{objHash = 95403626, objHeading = 180.00001525879, objCoords = vector3(805.658, -747.9282, 27.02702)} -- sm_pizzeria_mdoor_l
 	},
	maxDistance = 2.5,
	locked = true,
	slides = false,
	lockpick = false,
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- back entry
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	objHeading = 89.999977111816,
	objCoords = vector3(814.5675, -762.8239, 27.04651), 
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	locked = true,
	garage = false,
	slides = false,
	fixText = false,
	audioRemote = false,
	objHash = -420112688, -- sm_pizzeria_back_door
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- WC Ladies
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	objHeading = 89.999961853027,
	objCoords = vector3(800.403, -765.0848, 26.93464),
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	locked = true,
	garage = false,
	slides = false,
	fixText = false,
	audioRemote = false,
	objHash = 1984391163, -- sm_pizzeria_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- WC Gents
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	objHeading = 270.00003051758,
	objCoords = vector3(800.4145, -763.9932, 26.93464),
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	locked = true,
	garage = false,
	slides = false,
	fixText = false,
	audioRemote = false, -- sm_pizzeria_wooden_door
	objHash = 1984391163,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Kitchen
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	objHeading = 0.0,
	objCoords = vector3(810.4092, -756.2733, 26.93464),
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	locked = true,
	garage = false,
	slides = false,
	fixText = false,
	audioRemote = false,
	objHash = 1984391163, -- sm_pizzeria_wooden_door
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
}) 

-- Fridge (sliding door)
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	objHeading = 90.0,
	objCoords = vector3(805.9268,-761.663,26.04281),
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	locked = true,
	garage = false,
	slides = true,
	fixText = false,
	setText = true,
	textCoords = vector3(805.832,-761.683,26.781),
	audioRemote = false,
	objHash = 2136811971, -- sm_pizzeria_fridge_door	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Freezer room (sliding door)
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	objHeading = 89.999977111816,
	objCoords = vector3(805.2613, -758.6738, 25.79361),
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	locked = true,
	garage = false,
	slides = false,
	fixText = false,
	setText = true,
	textCoords = vector3(805.152,-759.427,26.900),
	audioRemote = false,
	objHash = -357301147, -- sm_pizzeria_freezer_door	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cave
table.insert(Config.DoorList, {
	lockpick = false,
	garage = false,
	objHash = 1984391163, -- sm_pizzeria_wooden_door
	authorizedJobs = { ['unemployed']=0 },
	fixText = false,
	slides = false,
	objCoords = vector3(806.2781, -765.8099, 26.93464),
	objHeading = 179.99998474121,
	audioRemote = false,
	locked = true,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- stairs access
table.insert(Config.DoorList, {
	lockpick = false,
	garage = false,
	objHash = 1984391163, -- sm_pizzeria_wooden_door
	authorizedJobs = { ['unemployed']=0 },
	fixText = false,
	slides = false,
	objCoords = vector3(811.9174, -762.428, 26.93464),
	objHeading = 89.999961853027,
	audioRemote = false,
	locked = true,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- stairs access (upper floor)
table.insert(Config.DoorList, {
	lockpick = false,
	garage = false,
	objHash = 1984391163, -- sm_pizzeria_wooden_door
	authorizedJobs = { ['unemployed']=0 },
	fixText = false,
	slides = false,
	objCoords = vector3(804.4858, -767.6975, 31.41847),
	objHeading = 270.00003051758,
	audioRemote = false,
	locked = true,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- office (upper floor)
table.insert(Config.DoorList, {
	lockpick = false,
	garage = false,
	objHash = 1984391163, -- sm_pizzeria_wooden_door
	authorizedJobs = { ['unemployed']=0 },
	fixText = false,
	slides = false,
	objCoords = vector3(798.6847, -763.329, 31.41847),
	objHeading = 0.0,
	audioRemote = false,
	locked = true,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- CEO (upper floor)
table.insert(Config.DoorList, {
	lockpick = false,
	garage = false,
	objHash = 1984391163, -- sm_pizzeria_wooden_door
	authorizedJobs = { ['unemployed']=0 },
	fixText = false,
	slides = false,
	objCoords = vector3(797.4042, -758.2521, 31.41847),
	objHeading = 179.99998474121,
	audioRemote = false,
	locked = true,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Lockers (upper floor)
table.insert(Config.DoorList, {
	lockpick = false,
	garage = false,
	objHash = 1984391163, -- sm_pizzeria_wooden_door
	authorizedJobs = { ['unemployed']=0 },
	fixText = false,
	slides = false,
	objCoords = vector3(806.8858, -764.5674, 31.41847),
	objHeading = 270.00003051758,
	audioRemote = false,
	locked = true,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})