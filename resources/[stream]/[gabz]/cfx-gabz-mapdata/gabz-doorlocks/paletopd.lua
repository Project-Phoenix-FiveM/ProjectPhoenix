-- ## GABZ - PALETO POLICE DEPARTMENT
-- ## COORDINATES: -432.177, 6019.605, 31.490

-- main entrance
table.insert(Config.DoorList, {
	slides = false,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	doors = {
		{objHash = 965382714, objHeading = 314.99981689453, objCoords = vector3(-438.5865, 6014.362, 32.28851)}, -- gabz_paletopd_doors06
		{objHash = 733214349, objHeading = 134.99996948242, objCoords = vector3(-437.1717, 6012.947, 32.28851)} -- gabz_paletopd_doors05
	},
	maxDistance = 2.5,
	locked = true,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- back entrance
table.insert(Config.DoorList, {
	slides = false,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	doors = {
		{objHash = 965382714, objHeading = 134.99992370605, objCoords = vector3(-453.4868, 5996.637, 32.28851)}, -- gabz_paletopd_doors06
		{objHash = 733214349, objHeading = 314.99981689453, objCoords = vector3(-454.9017, 5998.052, 32.28851)} -- gabz_paletopd_doors05
	},
	maxDistance = 2.5,
	locked = true,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- main floor - reception
table.insert(Config.DoorList, {
	objHeading = 224.99992370605,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = true,
	slides = false,
	objHash = 1362051455, -- gabz_paletopd_doors01
	maxDistance = 2.0,
	garage = false,
	objCoords = vector3(-443.96, 6017.162, 32.28851),
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- main floor - hallway
table.insert(Config.DoorList, {
	slides = false,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	doors = {
		{objHash = 1857649811, objHeading = 314.99981689453, objCoords = vector3(-448.0713, 6004.868, 32.28851)}, -- gabz_paletopd_doors02
		{objHash = 1362051455, objHeading = 134.99996948242, objCoords = vector3(-446.6564, 6003.453, 32.28851)} -- gabz_paletopd_doors01
 },
	maxDistance = 2.5,
	locked = true,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- main floor - staircase access
table.insert(Config.DoorList, {
	slides = false,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	doors = {
		{objHash = 1857649811, objHeading = 224.99992370605, objCoords = vector3(-450.0098, 6004.835, 32.28851)}, -- gabz_paletopd_doors02
		{objHash = 1362051455, objHeading = 44.999935150146, objCoords = vector3(-451.4247, 6003.42, 32.28851)} -- gabz_paletopd_doors01
 },
	maxDistance = 2.5,
	locked = true,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- upper floor - staircase access
table.insert(Config.DoorList, {
	slides = false,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	doors = {
		{objHash = 1362051455, objHeading = 44.999923706055, objCoords = vector3(-451.4247, 6003.42, 36.99582)}, -- gabz_paletopd_doors01
		{objHash = 1857649811, objHeading = 224.99992370605, objCoords = vector3(-450.0098, 6004.835, 36.99582)} -- gabz_paletopd_doors02
 },
	maxDistance = 1.5,
	locked = true,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- upper floor - archive
table.insert(Config.DoorList, {
	objHeading = 134.99993896484,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = true,
	slides = false,
	objHash = 1362051455, -- gabz_paletopd_doors01
	maxDistance = 1.5,
	garage = false,
	objCoords = vector3(-449.6784, 5999.345, 36.99582),
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- upper floor - armory
table.insert(Config.DoorList, {
	objHeading = 44.999935150146,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = true,
	slides = false,
	objHash = 1362051455, -- gabz_paletopd_doors01
	maxDistance = 2.0,
	garage = false,
	objCoords = vector3(-447.4445, 6011.512, 36.99582),
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- upper floor - lockers
table.insert(Config.DoorList, {
	objHeading = 314.99984741211,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = true,
	slides = false,
	objHash = 1362051455, -- gabz_paletopd_doors01
	maxDistance = 2.0,
	garage = false,
	objCoords = vector3(-441.6726, 6009.144, 36.99582),
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- upper floor - office area left
table.insert(Config.DoorList, {
	slides = false,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	doors = {
		{objHash = 1127654798, objHeading = 224.99990844727, objCoords = vector3(-445.6457, 6002.511, 37.34019)}, -- gabz_paletopd_doors04
		{objHash = 899779172, objHeading = 224.99990844727, objCoords = vector3(-443.9523, 6004.205, 37.29659)} -- gabz_paletopd_doors03
 },
	maxDistance = 1.5,
	locked = true,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- upper floor - office area right
table.insert(Config.DoorList, {
	slides = false,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	doors = {
		{objHash = 1127654798, objHeading = 224.99992370605, objCoords = vector3(-448.6158, 5999.541, 37.34019)}, -- gabz_paletopd_doors04
		{objHash = 899779172, objHeading = 224.99990844727, objCoords = vector3(-446.9225, 6001.234, 37.29659)} -- gabz_paletopd_doors03
 },
	maxDistance = 1.5,
	locked = true,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- upper floor - captain office
table.insert(Config.DoorList, {
	objHeading = 314.99984741211,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = true,
	slides = false,
	objHash = 1362051455, -- gabz_paletopd_doors01
	maxDistance = 2.0,
	garage = false,
	objCoords = vector3(-437.1285, 6004.658, 36.99582),
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - staircase access
table.insert(Config.DoorList, {
	slides = false,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	doors = {
		{objHash = 1857649811, objHeading = 224.99992370605, objCoords = vector3(-450.0098, 6004.835, 27.58121)}, -- gabz_paletopd_doors02
		{objHash = 1362051455, objHeading = 44.999923706055, objCoords = vector3(-451.4247, 6003.42, 27.58121)} -- gabz_paletopd_doors01
 },
	maxDistance = 2.5,
	locked = true,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - mugshot
table.insert(Config.DoorList, {
	objHeading = 134.99996948242,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = true,
	slides = false,
	objHash = 1362051455, -- gabz_paletopd_doors01
	maxDistance = 1.5,
	garage = false,
	objCoords = vector3(-449.5088, 5999.468, 27.58121),
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - interrogation hallway
table.insert(Config.DoorList, {
	slides = false,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	doors = {
		{objHash = 1857649811, objHeading = 44.99987411499, objCoords = vector3(-447.9988, 5999.985, 27.58121)}, -- gabz_paletopd_doors02
		{objHash = 1362051455, objHeading = 224.99992370605, objCoords = vector3(-446.5839, 6001.4, 27.58121)} -- gabz_paletopd_doors01
 },
	maxDistance = 1.5,
	locked = true,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - interrogation right
table.insert(Config.DoorList, {
	objHeading = 314.99984741211,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = true,
	slides = false,
	objHash = 1362051455, -- gabz_paletopd_doors01
	maxDistance = 1.0,
	garage = false,
	objCoords = vector3(-445.3536, 5995.342, 27.58121),
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - observation right
table.insert(Config.DoorList, {
	objHeading = 134.99992370605,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = true,
	slides = false,
	objHash = 1362051455, -- gabz_paletopd_doors01
	maxDistance = 1.0,
	garage = false,
	objCoords = vector3(-446.4799, 5996.469, 27.58121),
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - observation left
table.insert(Config.DoorList, {
	objHeading = 134.99992370605,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = true,
	slides = false,
	objHash = 1362051455, -- gabz_paletopd_doors01
	maxDistance = 1.0,
	garage = false,
	objCoords = vector3(-443.0612, 5999.874, 27.58121),
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - interrogation left
table.insert(Config.DoorList, {
	objHeading = 314.99984741211,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = true,
	slides = false,
	objHash = 1362051455, -- gabz_paletopd_doors01
	maxDistance = 1.0,
	garage = false,
	objCoords = vector3(-441.9416, 5998.754, 27.58121),
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - cells area (1st gate)
table.insert(Config.DoorList, {
	objHeading = 314.99984741211,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	slides = false,
	objHash = -594854737, -- gabz_paletopd_cells_gate
	maxDistance = 2.0,
	garage = false,
	objCoords = vector3(-443.6405, 6006.973, 27.731),
	-- oldMethod = true,
	audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - cells area (2st gate)
table.insert(Config.DoorList, {
	objHeading = 44.999942779541,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	slides = false,
	objHash = -594854737, -- gabz_paletopd_cells_gate
	maxDistance = 2.0,
	garage = false,
	objCoords = vector3(-442.2433, 6012.62, 27.731),
	-- oldMethod = true,
	audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - cell 1 left
table.insert(Config.DoorList, {
	objHeading = 134.99992370605,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	slides = false,
	objHash = -594854737, -- gabz_paletopd_cells_gate
	maxDistance = 2.0,
	garage = false,
	objCoords = vector3(-445.9457, 6012.88, 27.731),
	-- oldMethod = true,
	audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - cell 2 left
table.insert(Config.DoorList, {
	objHeading = 134.99992370605,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	slides = false,
	objHash = -594854737, -- gabz_paletopd_cells_gate
	maxDistance = 2.0,
	garage = false,
	objCoords = vector3(-448.916, 6015.851, 27.731),
	-- oldMethod = true,
	audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - cell 1 right
table.insert(Config.DoorList, {
	objHeading = 134.99992370605,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	slides = false,
	objHash = -594854737, -- gabz_paletopd_cells_gate
	maxDistance = 2.0,
	garage = false,
	objCoords = vector3(-443.3901, 6015.436, 27.731),
	-- oldMethod = true,
	audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- basement - cell 2 right
table.insert(Config.DoorList, {
	objHeading = 134.99992370605,
	lockpick = false,
	locked = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	slides = false,
	objHash = -594854737, -- gabz_paletopd_cells_gate
	maxDistance = 2.0,
	garage = false,
	objCoords = vector3(-446.3604, 6018.407, 27.731),
	-- oldMethod = true,
	audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- paletopd_exterior - gatedoor
table.insert(Config.DoorList, {
	slides = false,
	objCoords = vector3(-449.6914, 6024.355, 32.15741),
	objHeading = 135.0,
	fixText = false,
	locked = true,
	authorizedJobs = { ['police']=0 },
	garage = false,
	maxDistance = 2.0,
	objHash = -1156020871,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Paletopd bollard - "gabz_paletopd_bollards1"
table.insert(Config.DoorList, {
	objHeading = 44.84627532959,
	garage = false,
	fixText = false,
	maxDistance = 2.0,
	locked = true,
	lockpick = false,
	audioRemote = false,
	objHash = -470936668,
	slides = false,
	authorizedJobs = { ['police']=0 },
	objCoords = vector3(-453.5876, 6028.265, 30.35073),		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})