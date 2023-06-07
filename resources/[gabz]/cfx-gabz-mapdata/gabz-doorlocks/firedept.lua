-- ## GABZ - FIRE STATION (2 LOCATIONS)
-- ## COORDINATES 1: 1197.553, -1454.430, 34.958
-- ## COORDINATES 2: 217.2, -1636.09, 30.44

-- Location 1 - large gate left
table.insert(Config.DoorList, {
	objCoords = vector3(1204.824, -1463.529, 35.8293),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 180.00001525879,
	maxDistance = 4.0,
	garage = true,
	lockpick = false,
	slides = 6.0,
	locked = true,
	fixText = true,
	objHash = 1934132135, -- gabz_firedept_garage_door
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - large gate middle
table.insert(Config.DoorList, {
	objCoords = vector3(1200.749, -1463.529, 35.8293),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 180.00001525879,
	maxDistance = 4.0,
	garage = true,
	lockpick = false,
	slides = 6.0,
	locked = true,
	fixText = true,
	objHash = 1934132135, -- gabz_firedept_garage_door	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - large gate middle
table.insert(Config.DoorList, {
	objCoords = vector3(1196.666, -1463.529, 35.8293),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 180.00001525879,
	maxDistance = 4.0,
	garage = true,
	lockpick = false,
	slides = 6.0,
	locked = true,
	fixText = true,
	objHash = 1934132135, -- gabz_firedept_garage_door	
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - reception entry
table.insert(Config.DoorList, {
	objCoords = vector3(1185.003, -1464.686, 34.07891),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 0.0,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1185.663,-1464.769,35.069),
	objHash = -585526495, -- gabz_firedept_reception_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - reception to garage
table.insert(Config.DoorList, {
	objCoords = vector3(1192.842, -1469.993, 33.85363),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 89.999977111816,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1192.834,-1469.417,34.857),
	objHash = -903733315, -- gabz_firedept_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - boss office
table.insert(Config.DoorList, {
	objCoords = vector3(1192.842, -1472.296, 33.85363),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 270.00003051758,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1192.745,-1472.911,34.857),
	objHash = -903733315, -- gabz_firedept_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - living room (glass double door)
table.insert(Config.DoorList, {
	doors = { 
		{objHash = -1056920428, objHeading = 0.0, objCoords = vector3(1201.766, -1477.167, 35.01291)}, -- gabz_firedept_glass_door
		{objHash = -1056920428, objHeading = 180.00001525879, objCoords = vector3(1199.698, -1477.167, 35.01291)} -- gabz_firedept_glass_door
 },
	lockpick = false,
	audioRemote = false,
	slides = false,
	authorizedJobs = { ['unemployed']=0 },
	locked = true,
	maxDistance = 2.5,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - living room to corridor
table.insert(Config.DoorList, {
	objCoords = vector3(1208.16, -1479.278, 33.85363),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 89.999977111816,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1208.282,-1478.661,34.857),
	objHash = -903733315, -- gabz_firedept_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - toilets
table.insert(Config.DoorList, {
	objCoords = vector3(1209.816, -1480.058, 33.85363),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 0.0,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1210.438,-1480.043,34.857),
	objHash = -903733315, -- gabz_firedept_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - showers
table.insert(Config.DoorList, {
	objCoords = vector3(1215.686, -1480.058, 33.85363),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 0.0,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1216.293,-1480.066,34.857),
	objHash = -903733315, -- gabz_firedept_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - lockers (from corridor)
table.insert(Config.DoorList, {
	objCoords = vector3(1211.135, -1477.167, 33.85363),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 179.99998474121,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1210.503,-1477.108,34.857),
	objHash = -903733315, -- gabz_firedept_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - bedroom (from corridor)
table.insert(Config.DoorList, {
	objCoords = vector3(1216.992, -1477.167, 33.85363),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 180.00001525879,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1216.374,-1477.107,34.857),
	objHash = -903733315, -- gabz_firedept_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - lockers (from garage)
table.insert(Config.DoorList, {
	objCoords = vector3(1208.659, -1473.365, 33.85363),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 269.99996948242,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1208.707,-1474.032,34.857),
	objHash = -903733315, -- gabz_firedept_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - kitchen (from garage)
table.insert(Config.DoorList, {
	objCoords = vector3(1208.659, -1470.001, 33.85363),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 90.0,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1208.696,-1469.369,34.857),
	objHash = -903733315, -- gabz_firedept_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 1 - bedroom (from kitchen)
table.insert(Config.DoorList, {
	objCoords = vector3(1216.992, -1471.455, 33.85363),
	audioRemote = false,
	authorizedJobs = { ['unemployed']=0 },
	objHeading = 180.00001525879,
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	slides = false,
	locked = true,
	fixText = true,
	setText = true,
	textCoords= vector3(1216.321,-1471.507,34.857),
	objHash = -903733315, -- gabz_firedept_wooden_door		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - large gate left
table.insert(Config.DoorList, {
	objHash = 1934132135, -- gabz_firedept_garage_door
	slides = 6.0,
	maxDistance = 4.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 140.00003051758,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(215.2195, -1646.341, 30.77299),
	garage = true,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - large gate middle
table.insert(Config.DoorList, {
	objHash = 1934132135, -- gabz_firedept_garage_door
	slides = 6.0,
	maxDistance = 4.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 140.00003051758,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(212.0979, -1643.722, 30.77299),
	garage = true,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - large gate right
table.insert(Config.DoorList, {
	objHash = 1934132135, -- gabz_firedept_garage_door
	slides = 6.0,
	maxDistance = 4.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 140.00003051758,
	audioRemote = false,
	fixText = false,
	objCoords = vector3(208.9706, -1641.098, 30.77299),
	garage = true,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - reception entry
table.insert(Config.DoorList, {
	objHash = -585526495, -- gabz_firedept_reception_door		
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 320.00003051758,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(199.752,-1634.915,30.017),
	objCoords = vector3(199.292, -1634.487, 29.0226),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - reception to garage
table.insert(Config.DoorList, {
	 objHash = -903733315, -- gabz_firedept_wooden_door
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 50.000003814697,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(202.356,-1643.083,29.836),
	objCoords = vector3(201.8855, -1643.591, 28.79733),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - boss office
table.insert(Config.DoorList, {
	 objHash = -903733315, -- gabz_firedept_wooden_door
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 230.00007629395,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(199.956,-1645.889,29.836),
	objCoords = vector3(200.4057, -1645.355, 28.79733),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - living room (glass double door)
table.insert(Config.DoorList, {
	lockpick = false,
	slides = false,
	audioRemote = false,
	doors = {
		{objHash = -1056920428, objHeading = 320.00003051758, objCoords = vector3(204.1111, -1654.823, 29.9566)},
		{objHash = -1056920428, objHeading = 140.00003051758, objCoords = vector3(202.5265, -1653.494, 29.9566)}
 },
	maxDistance = 2.5,
	locked = true,
	authorizedJobs = { ['unemployed']=0 },		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - living room to corridor
table.insert(Config.DoorList, {
	 objHash = -903733315, -- gabz_firedept_wooden_door
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 50.000003814697,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(208.106,-1660.047,29.836),
	objCoords = vector3(207.6519, -1660.55, 28.79733),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - toilets
table.insert(Config.DoorList, {
	 objHash = -903733315, -- gabz_firedept_wooden_door
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 320.00003051758,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(208.947,-1662.588,29.836),
	objCoords = vector3(208.4187, -1662.213, 28.79733),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - showers
table.insert(Config.DoorList, {
	 objHash = -903733315, -- gabz_firedept_wooden_door
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 320.00003051758,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(213.402,-1666.488,29.836),
	objCoords = vector3(212.9152, -1665.986, 28.79733),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - lockers (from corridor)
table.insert(Config.DoorList, {
	 objHash = -903733315, -- gabz_firedept_wooden_door
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 140.0,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(210.827,-1660.441,29.836),
	objCoords = vector3(211.2875, -1660.845, 28.79733),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - bedroom (from corridor)
table.insert(Config.DoorList, {
	 objHash = -903733315, -- gabz_firedept_wooden_door
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 140.00003051758,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(215.299,-1664.157,29.836),
	objCoords = vector3(215.7747, -1664.61, 28.79733),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - lockers (from garage)
table.insert(Config.DoorList, {
	 objHash = -903733315, -- gabz_firedept_wooden_door
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 230.00001525879,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(211.378,-1656.786,29.836),
	objCoords = vector3(211.8351, -1656.342, 28.79733),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - kitchen (from garage)
table.insert(Config.DoorList, {
	 objHash = -903733315, -- gabz_firedept_wooden_door
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 50.000030517578,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(214.422,-1653.266,29.836),
	objCoords = vector3(213.9973, -1653.764, 28.79733),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Location 2 - bedroom (from kitchen)
table.insert(Config.DoorList, {
	 objHash = -903733315, -- gabz_firedept_wooden_door
	slides = false,
	maxDistance = 2.0,
	authorizedJobs = { ['unemployed']=0 },
	lockpick = false,
	objHeading = 140.00003051758,
	audioRemote = false,
	fixText = false,
	setText = true,
	textCoords = vector3(218.920,-1659.850,29.836),
	objCoords = vector3(219.4466, -1660.235, 28.79733),
	garage = false,
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})