-- ## GABZ - PALETO ROBS & LIQUOR
-- ## COORDINATES: -154.363 6329.432 31.565

-- entry
table.insert(Config.DoorList, {
	authorizedJobs = { ['unemployed']=0 },		
	objCoords = vector3(-156.9465, 6327.188, 31.73091),
	objHash = -1212951353, -- v_ilev_ml_door1
	objHeading = 135.0,
	maxDistance = 2.0,
	audioRemote = false,
	garage = false,
	lockpick = false,
	fixText = false,
	slides = false,
	locked = true,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- backdoor
table.insert(Config.DoorList, {
	authorizedJobs = { ['unemployed']=0 },		
	objCoords = vector3(-164.6524, 6318.269, 31.73678),
	objHash = 1173348778, -- v_ilev_ss_door04
	objHeading = 314.99987792969,
	maxDistance = 2.0,
	audioRemote = false,
	garage = false,
	lockpick = false,
	fixText = false,
	slides = false,
	locked = true,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})