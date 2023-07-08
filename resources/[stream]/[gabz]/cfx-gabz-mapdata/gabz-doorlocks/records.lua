-- ## GABZ - TRIAD RECORDS
-- ## COORDINATES: -832.578, -698.627, 27.280

-- Entry right
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.5,
	doors = {
		{objHash = 2001816392, objHeading = 270.00003051758, objCoords = vector3(-826.4025, -700.9301, 28.49083)}, -- wuchang_entrance_door
		{objHash = 2001816392, objHeading = 89.999977111816, objCoords = vector3(-826.4025, -698.7478, 28.49083)} -- wuchang_entrance_door
 },
	lockpick = false,
	audioRemote = false,
	slides = false,
	authorizedJobs = { ['records']=0 },
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Entry left
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.5,
	doors = {
		{objHash = 2001816392, objHeading = 270.00003051758, objCoords = vector3(-826.4025, -697.9944, 28.49083)}, -- wuchang_entrance_door
		{objHash = 2001816392, objHeading = 89.999977111816, objCoords = vector3(-826.4025, -695.8148, 28.49083)} -- wuchang_entrance_door
 },
	lockpick = false,
	audioRemote = false,
	slides = false,
	authorizedJobs = { ['records']=0 },
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Hallway entry
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.5,
	lockpick = false,
	doors = {
		{objHash = 75593271, objHeading = 0.0, objCoords = vector3(-822.3143, -703.1263, 28.2056)}, -- denis3d_wuchang_doubledoors_r
		{objHash = 1403720845, objHeading = 0.0, objCoords = vector3(-820.3126, -703.1263, 28.2056)} -- denis3d_wuchang_doubledoors_l
 },
	audioRemote = false,
	authorizedJobs = { ['records']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Reception staff right
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	objHash = 693644064, -- denis3d_wuchang_singledoor 
	fixText = true,
	objCoords = vector3(-816.6038, -702.3438, 28.2056),
	authorizedJobs = { ['records']=0 },
	objHeading = 89.999977111816,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Reception staff left
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	objHash = 693644064, -- denis3d_wuchang_singledoor
	fixText = true,
	objCoords = vector3(-816.6038, -694.3998, 28.2056),
	authorizedJobs = { ['records']=0 },
	objHeading = 270.00003051758,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Hallway 2
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.5,
	lockpick = false,
	doors = {
		{objHash = 75593271, objHeading = 0.0, objCoords = vector3(-822.3143, -715.694, 28.2056)}, -- denis3d_wuchang_doubledoors_r
		{objHash = 1403720845, objHeading = 0.0, objCoords = vector3(-820.3126, -715.694, 28.2056)} -- denis3d_wuchang_doubledoors_l
 },
	audioRemote = false,
	authorizedJobs = { ['records']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Cloakroom
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	objHash = 693644064, -- denis3d_wuchang_singledoor
	fixText = true,
	objCoords = vector3(-819.4991, -719.3163, 28.2056),
	authorizedJobs = { ['records']=0 },
	objHeading = 89.999977111816,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Restroom
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	objHash = 693644064, -- denis3d_wuchang_singledoor
	fixText = true,
	objCoords = vector3(-819.4991, -728.5467, 28.2056),
	authorizedJobs = { ['records']=0 },
	objHeading = 89.999977111816,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Staircase
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	objHash = 693644064, -- denis3d_wuchang_singledoor
	fixText = true,
	objCoords = vector3(-819.4991, -711.9124, 28.2056),
	authorizedJobs = { ['records']=0 },
	objHeading = 270.00003051758,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Upper floor - Staircase
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	objHash = 693644064, -- denis3d_wuchang_singledoor
	fixText = true,
	objCoords = vector3(-819.4991, -711.9124, 32.48665),
	authorizedJobs = { ['records']=0 },
	objHeading = 270.00003051758,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Upper floor - CEO Office
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	objHash = 693644064, -- denis3d_wuchang_singledoor
	fixText = true,
	objCoords = vector3(-822.0345, -703.1276, 32.48665),
	authorizedJobs = { ['records']=0 },
	objHeading = 0.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Upper floor - Meeting Room
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.5,
	lockpick = false,
	doors = {
		{objHash = 1403720845, objHeading = 89.999977111816, objCoords = vector3(-823.145, -708.4457, 32.4866)}, -- denis3d_wuchang_doubledoors_l
		{objHash = 75593271, objHeading = 89.999977111816, objCoords = vector3(-823.145, -710.4473, 32.4866)} -- denis3d_wuchang_doubledoors_r
 },
	audioRemote = false,
	authorizedJobs = { ['records']=0 },
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Upper floor - Studio Entry
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	objHash = 693644064, -- denis3d_wuchang_singledoor
	fixText = true,
	objCoords = vector3(-822.0345, -715.6934, 32.48665),
	authorizedJobs = { ['records']=0 },
	objHeading = 0.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Upper floor - Studio Inside
table.insert(Config.DoorList, {
	locked = true,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	objHash = 390840000, -- ba_prop_door_club_edgy_generic
	fixText = true,
	objCoords = vector3(-818.7371, -724.0592, 32.52227),
	authorizedJobs = { ['records']=0 },
	objHeading = 89.999977111816,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Down stairs - Starcase
table.insert(Config.DoorList, {
	lockpick = false,
	objCoords = vector3(-819.4991, -711.9124, 23.92465),
	slides = false,
	objHash = 693644064, -- denis3d_wuchang_singledoor
	garage = false,
	authorizedJobs = { ['records']=0 },
	maxDistance = 2.0,
	objHeading = 270.00003051758,
	fixText = true,
	audioRemote = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Down stairs - Storage
table.insert(Config.DoorList, {
	lockpick = false,
	objCoords = vector3(-823.1431, -711.9124, 23.92465),
	slides = false,
	objHash = -2023754432, -- v_ilev_rc_door2 
	garage = false,
	authorizedJobs = { ['records']=0 },
	maxDistance = 2.0,
	objHeading = 270.00003051758,
	fixText = true,
	audioRemote = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Down stairs - Garage access (from interior)
table.insert(Config.DoorList, {
	lockpick = false,
	objCoords = vector3(-820.6585, -715.6949, 23.93994),
	slides = false,
	objHash = -2023754432, -- v_ilev_rc_door2
	garage = false,
	authorizedJobs = { ['records']=0 },
	maxDistance = 2.0,
	objHeading = 179.99998474121,
	fixText = true,
	audioRemote = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Down stairs - Garage door (from outside)
table.insert(Config.DoorList, {
	lockpick = false,
	objCoords = vector3(-816.2236, -740.1627, 24.16524),
	slides = 6.0,
	objHash = -700626879, -- denis3d_wuchang_records_warehousegate
	garage = true,
	authorizedJobs = { ['records']=0 },
	maxDistance = 6.0,
	objHeading = 0.0,
	fixText = false,
	audioRemote = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Down stairs - Garage employees room
table.insert(Config.DoorList, {
	lockpick = false,
	objCoords = vector3(-819.0727, -721.4122, 23.93994),
	slides = false,
	objHash = -2023754432, -- v_ilev_rc_door2
	garage = false,
	authorizedJobs = { ['records']=0 },
	maxDistance = 2.0,
	objHeading = 89.999977111816,
	fixText = true,
	audioRemote = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})