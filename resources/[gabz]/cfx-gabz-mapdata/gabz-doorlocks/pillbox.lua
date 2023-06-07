-- ## GABZ - PILLBOX V2
-- ## COORDINATES: 286.562, -570.565, 43.168


-- Reception (top) - Main entry
table.insert(Config.DoorList, {
	objHeading = 249.98275756836,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(313.48, -595.4584, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Reception (top) - Staff only
table.insert(Config.DoorList, {
	objHeading = 160.00003051758,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(309.1338, -597.7514, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward A - Laboratory
table.insert(Config.DoorList, {
	objHeading = 340.00003051758,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(307.1182, -569.569, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward A - Surgery 1
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	slides = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(312.0052, -571.3412, 43.43392)}, -- gabz_pillbox_doubledoor_r
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(314.4242, -572.2216, 43.43392)} -- gabz_pillbox_doubledoor_l
 	},		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward A - Surgery 2
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	slides = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(317.8426, -573.4658, 43.43392)}, -- gabz_pillbox_doubledoor_r
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(320.2616, -574.3464, 43.43392)} -- gabz_pillbox_doubledoor_l
 	},		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward A - Surgery 3
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	slides = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = -434783486, objHeading = 340.00003051758, objCoords = vector3(323.2376, -575.4294, 43.43392)}, -- gabz_pillbox_doubledoor_r
		{objHash = -1700911976, objHeading = 340.00003051758, objCoords = vector3(325.6566, -576.31, 43.43392)} -- gabz_pillbox_doubledoor_l
 	},		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward A - Intense care (usually respawn room)
table.insert(Config.DoorList, {
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	slides = false,
	maxDistance = 2.5,
	audioRemote = false,
	doors = {
		{objHash = -434783486, objHeading = 160.00003051758, objCoords = vector3(318.4846, -579.2282, 43.43392)}, -- gabz_pillbox_doubledoor_r
		{objHash = -1700911976, objHeading = 160.00003051758, objCoords = vector3(316.0658, -578.3478, 43.43392)} -- gabz_pillbox_doubledoor_l
 	},		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

---------------------------------------------------------------------------------------------------

-- Ward B - MRI
table.insert(Config.DoorList, {
	objHeading = 340.00003051758,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(336.1628, -580.1404, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward B - Diagnostics
table.insert(Config.DoorList, {
	objHeading = 340.00003051758,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(340.7818, -581.8214, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward B - X-Ray
table.insert(Config.DoorList, {
	objHeading = 340.00003051758,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(346.774, -584.0024, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward B - Director office
table.insert(Config.DoorList, {
	objHeading = 340.00003051758,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(336.8664, -592.5788, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward C - Private room 369
table.insert(Config.DoorList, {
	objHeading = 249.98275756836,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(357.4908, -579.6106, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward C - Private room 370
table.insert(Config.DoorList, {
	objHeading = 249.98275756836,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(356.1252, -583.3624, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward C - Patient room 371
table.insert(Config.DoorList, {
	objHeading = 340.00003051758,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(360.5034, -588.9996, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward C - Dr. office 372
table.insert(Config.DoorList, {
	objHeading = 340.00003051758,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(358.7266, -593.8814, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward C - Dr. office 373
table.insert(Config.DoorList, {
	objHeading = 249.98275756836,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(352.1996, -594.1478, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward C - Private room 374
table.insert(Config.DoorList, {
	objHeading = 249.98275756836,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(350.834, -597.8998, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ward C - Treatment
table.insert(Config.DoorList, {
	objHeading = 70.01732635498,
	lockpick = false,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	garage = false,
	maxDistance = 2.0,
	audioRemote = false,
	fixText = true,
	objCoords = vector3(346.8854, -593.6, 43.43392),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- DOWNSTAIRS -------------------------------------------------------------------------------------



-- Reception
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	maxDistance = 2.0,
	slides = false,
	objHash = 854291622, -- gabz_pillbox_singledoor
	garage = false,
	objHeading = 250.00610351562,
	authorizedJobs = { ['ambulance']=0 },
	audioRemote = false,
	fixText = true,
	objCoords = vector3(348.5466, -585.1584, 28.9471),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ambulance garage - Wooden double door from hallway
table.insert(Config.DoorList, {
	doors = {
		{objHash = -434783486, objHeading = 70.006050109864, objCoords = vector3(338.4466, -590.053, 28.9471)}, -- gabz_pillbox_doubledoor_r
		{objHash = -1700911976, objHeading = 70.006050109864, objCoords = vector3(339.3266, -587.6346, 28.9471)} -- gabz_pillbox_doubledoor_l
 },
	lockpick = false,
	locked = true,
	maxDistance = 2.5,
	slides = false,
	audioRemote = false,
	authorizedJobs = { ['ambulance']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ambulance garage - Elevator right (from garage)
table.insert(Config.DoorList, {
	doors = {
		{objHash = 1674289593, objHeading = 70.006050109864, objCoords = vector3(340.7712, -583.942, 27.79682)}, -- gabz_pillbox_elevdoor_l
		{objHash = -1048421071, objHeading = 70.006050109864, objCoords = vector3(340.1254, -585.717, 27.79682)} -- gabz_pillbox_elevdoor_l
 	},
	lockpick = false,
	locked = true,
	maxDistance = 2.0,
	slides = true,
	audioRemote = false,
	authorizedJobs = { ['ambulance']=0 },	
	textCoords = vector3(340.366,-584.852,29.0),
	setText = true,	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Ambulance garage - Elevator left (from garage)
table.insert(Config.DoorList, {
	doors = {
		{objHash = 1674289593, objHeading = 70.006050109864, objCoords = vector3(342.1202, -580.2346, 27.79682)}, -- gabz_pillbox_elevdoor_l
		{objHash = -1048421071, objHeading = 70.006050109864, objCoords = vector3(341.4744, -582.0096, 27.79682)} -- gabz_pillbox_elevdoor_l
	},
	lockpick = false,
	locked = true,
	maxDistance = 2.0,
	slides = true,
	audioRemote = false,
	authorizedJobs = { ['ambulance']=0 },	
	textCoords = vector3(341.906,-581.182,29.0),
	setText = true,	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage - White garage door from outside
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	maxDistance = 6.0,
	slides = 6.0,
	objHash = -820650556, -- gabz_pillbox_dlc_gate
	garage = true,
	objHeading = 160.00607299804,
	authorizedJobs = { ['ambulance']=0 },
	audioRemote = false,
	fixText = true,
	objCoords = vector3(337.2776, -564.432, 29.7753),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage - White right garage door from outside
table.insert(Config.DoorList, {
	lockpick = false,
	locked = true,
	maxDistance = 6.0,
	slides = 6.0,
	objHash = -820650556, -- gabz_pillbox_dlc_gate
	garage = true,
	objHeading = 160.00605773926,
	authorizedJobs = { ['ambulance']=0 },
	audioRemote = false,
	fixText = true,
	objCoords = vector3(330.135, -561.8332, 29.7753),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Garage - Double door besides garage doors
table.insert(Config.DoorList, {
	doors = {
		{objHash = -1421582160, objHeading = 25.005989074708, objCoords = vector3(321.0148, -559.9128, 28.94724)}, -- v_ilev_ct_doorr
		{objHash = 1248599813, objHeading = 205.0061340332, objCoords = vector3(318.6656, -561.0086, 28.94724)} -- v_ilev_ct_doorl
 },
	lockpick = false,
	locked = true,
	maxDistance = 2.5,
	slides = false,
	audioRemote = false,
	authorizedJobs = { ['ambulance']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})