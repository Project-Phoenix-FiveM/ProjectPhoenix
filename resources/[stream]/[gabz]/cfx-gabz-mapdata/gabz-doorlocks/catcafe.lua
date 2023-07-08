-- ## GABZ - UWU CAFE
-- ## COORDINATES: -580.862, -1079.083, 22.330

-- main entry
table.insert(Config.DoorList, {
	maxDistance = 2.5,
	authorizedJobs = { ['unemployed']=0 },
	locked = true,
	slides = false,
	audioRemote = false,
	doors = {
		{objHash = -69331849, objHeading = 0.0, objCoords = vector3(-580.3611, -1069.627, 22.48975)}, -- denis3d_catcafe_maindoors_r
		{objHash = 526179188, objHeading = 0.0, objCoords = vector3(-581.6678, -1069.627, 22.48975)} -- denis3d_catcafe_maindoors_l
 },
	lockpick = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- employees access
table.insert(Config.DoorList, {
	objHeading = 89.999977111816,
	locked = true,
	slides = false,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 2.0,
	fixText = false,
	audioRemote = false,
	objCoords = vector3(-587.34, -1051.899, 22.41301),
	objHash = -1283712428, -- denis3d_catcafe_doorsB
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- kitchen
table.insert(Config.DoorList, {
	objHeading = 179.99998474121,
	locked = true,
	slides = false,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 2.0,
	fixText = false,
	audioRemote = false,
	objCoords = vector3(-590.1828, -1054.148, 22.41301),
	objHash = -60871655, -- denis3d_catcafe_doorsA		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- garage (from kitchen, sliding door)
table.insert(Config.DoorList, {
	objHeading = 270.00003051758,
	locked = true,
	slides = true,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 6.0,
	fixText = false,
	audioRemote = false,
	objCoords = vector3(-591.7699, -1066.974, 22.53749),
	objHash = -562476388, -- denis3d_catcafe_fridgedoors
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- employees office
table.insert(Config.DoorList, {
	fixText = false,
	garage = false,
	slides = false,
	objHeading = 89.999977111816,
	locked = true,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	audioRemote = false,
	maxDistance = 2.0,
	objHash = 2089009131, -- sum_p_mp_yacht_door_02
	objCoords = vector3(-594.4123, -1049.769, 22.49713),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- garage (from inside)
table.insert(Config.DoorList, {
	objHeading = 0.0,
	locked = true,
	slides = false,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 2.0,
	fixText = false,
	audioRemote = false,
	objCoords = vector3(-592.4738, -1056.091, 22.41301),
	objHash = -60871655, -- denis3d_catcafe_doorsA		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- garage exit (from inside)
table.insert(Config.DoorList, {
	objHeading = 89.999977111816,
	locked = true,
	slides = false,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 2.0,
	fixText = false,
	audioRemote = false,
	objCoords = vector3(-600.9008, -1055.124, 22.61267),
	objHash = -1283712428, -- denis3d_catcafe_doorsB			
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- garage exit (large gate from inside)
table.insert(Config.DoorList, {
	objHeading = 270.00003051758,
	locked = true,
	slides = false,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 2.0,
	fixText = true,
	setText = true,
	textCoords = vector3(-600.940,-1059.249,23.049),
	audioRemote = false,
	objCoords = vector3(-600.9106, -1059.218, 21.72143),
	objHash = 522844070, -- denis3d_catcafe_garagedoors
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- toilet left
table.insert(Config.DoorList, {
	objHeading = 270.00003051758,
	locked = true,
	slides = false,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 2.0,
	fixText = false,
	audioRemote = false,
	objCoords = vector3(-570.6216, -1053.211, 22.41301),
	objHash = 1717323416, -- denis3d_catcafe_doors
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- toilet right
table.insert(Config.DoorList, {
	objHeading = 89.999977111816,
	locked = true,
	slides = false,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 2.0,
	fixText = false,
	audioRemote = false,
	objCoords = vector3(-570.6236, -1055.216, 22.41301),
	objHash = 1717323416, -- denis3d_catcafe_doors		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- entry (upper floor)
table.insert(Config.DoorList, {
	objHeading = 0.0,
	locked = true,
	slides = false,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 2.0,
	fixText = false,
	audioRemote = false,
	objCoords = vector3(-571.7927, -1057.388, 26.76797),
	objHash = 2089009131, -- sum_p_mp_yacht_door_02
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- office 1 (upper floor)
table.insert(Config.DoorList, {
	objHeading = 270.00003051758,
	locked = true,
	slides = false,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 2.0,
	fixText = false,
	audioRemote = false,
	objCoords = vector3(-575.0109, -1062.381, 26.76797),
	objHash = 2089009131, -- sum_p_mp_yacht_door_02
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- office 2 (upper floor)
table.insert(Config.DoorList, {
	objHeading = 89.999977111816,
	locked = true,
	slides = false,
	garage = false,
	lockpick = false,
	authorizedJobs = { ['unemployed']=0 },
	maxDistance = 2.0,
	fixText = false,
	audioRemote = false,
	objCoords = vector3(-575.0128, -1063.783, 26.76797),
	objHash = 2089009131, -- sum_p_mp_yacht_door_02
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})