-- ## GABZ - HATERS SHOP
-- ## COORDINATES: -1115.524, -1439.953, 5.107

-- Entry
table.insert(Config.DoorList, {
	items = { 'keys_haters' },
	textCoords = vector3(-1118.905, -1440.189, 5.410148),
	objCoords = vector3(-1118.576, -1440.656, 4.285106),	
	objHeading = 125.18644714356,
	objHash = 932235872, -- gabz_haters_entrance_front
	maxDistance = 2.5,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	locked = true,		
	setText = true,
	-- fixText = true,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Back room
table.insert(Config.DoorList, {
	objHash = 396177650, -- gabz_haters_int_door
	textCoords = vector3(-1128.483,-1440.522,5.373),
	objCoords = vector3(-1128.95, -1439.986, 4.290968),
	slides = false,
	items = { 'keys_haters' },
	lockpick = false,
	objHeading = 305.18649291992,
	garage = false,
	maxDistance = 2.0,
	locked = true,
	audioRemote = false,		
	setText = true,
	fixText = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Back Door to outside
table.insert(Config.DoorList, {
	items = { 'keys_haters' },
	textCoords = vector3(-1126.510,-1446.825,5.405),
	objCoords = vector3(-1126.054, -1446.53, 4.344772),
	objHeading = 215.18649291992,
	objHash = 779130623, -- gabz_haters_entrance_back
	maxDistance = 2.0,
	garage = false,
	lockpick = false,
	audioRemote = false,
	slides = false,
	locked = true,		
	setText = true,
	-- fixText = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})