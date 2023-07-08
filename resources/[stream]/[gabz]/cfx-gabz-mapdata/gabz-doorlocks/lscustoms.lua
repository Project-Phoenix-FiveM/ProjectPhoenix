-- ## GABZ - LS Customs
-- ## COORDINATES: 716.214, -1088.703, 22.365

-- Entry (garage door)
table.insert(Config.DoorList, {
	slides = 6.0,
	objCoords = vector3(723.116, -1088.832, 23.232),
	authorizedJobs = { ['mechanic']=0 },
	lockpick = false,
	maxDistance = 6.0,
	garage = true,
	audioRemote = false,
	objHeading = 270.00003051758,
	fixText = true,
	objHash = 270330101, -- prop_id2_11_gdoor
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})