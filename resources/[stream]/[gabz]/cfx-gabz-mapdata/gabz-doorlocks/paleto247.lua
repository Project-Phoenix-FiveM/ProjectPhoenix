-- ## GABZ - PALETO 24/7
-- ## COORDINATES: 158.520 6632.474 31.659

-- entry
table.insert(Config.DoorList, {
	authorizedJobs = { ['unemployed']=0 },		
	doors = {
		{objHash = 997554217, objHeading = 315.0, objCoords = vector3(163.4141, 6636.093, 31.84888)}, -- v_ilev_247door_r
		{objHash = 1196685123, objHeading = 134.99998474121, objCoords = vector3(161.5749, 6637.933, 31.84888)} -- v_ilev_247door
	},
	maxDistance = 2.5,
	lockpick = false,
	locked = true,
	slides = false,
	audioRemote = false,
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})