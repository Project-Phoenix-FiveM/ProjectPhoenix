-- ## GABZ - BOLINGBROKE PENITENTIARY
-- ## COORDINATES: 1855.556 2586.384 45.673


-- ## RECEPTION - COORDINATES: 1855.556 2586.384 45.673
-- entrance (big gates)
table.insert(Config.DoorList, {
	objHash = 741314661, -- prop_gate_prison_01
	objCoords = vector3(1844.9, 2604.8, 44.6),
	textCoords = vector3(1845.28, 2608.5, 48.0),
	authorizedJobs = { ['police'] = 0 },
	locked = true,
	maxDistance = 12,
	fixText = true,
	size = 2,
	slides = true,
	lockpick = true,
})

table.insert(Config.DoorList, {
	objHash = 741314661, -- prop_gate_prison_01
	objCoords = vector3(1818.5, 2604.8, 44.6),
	textCoords = vector3(1818.5, 2608.4, 48.0),
	authorizedJobs = { ['police'] = 0 },
	locked = true,
	maxDistance = 12,
	fixText = true,
	size = 2,
	slides = true,
	lockpick = true,
})

-- main entry
table.insert(Config.DoorList, {
	objHash = 1373390714, -- prop_gate_prison_01
	objHeading = 89.999977111816,
	maxDistance = 2.0,
	audioRemote = false,
	objCoords = vector3(1845.336, 2585.348, 46.0855),
	authorizedJobs = { ['police'] = 0 },
	lockpick = false,
	fixText = true,
	locked = true,
	garage = false,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- reception staff entry
table.insert(Config.DoorList, {
	objHash = 2024969025, -- sanhje_prison_recep_door01 
	slides = false,
	maxDistance = 2.0,
	objHeading = 0.0,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(1844.404, 2576.997, 46.0356),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cloakroom reception
table.insert(Config.DoorList, {
	objHash = 2024969025, -- sanhje_prison_recep_door01
	slides = false,
	maxDistance = 2.0,
	objHeading = 0.0,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(1837.634, 2576.992, 46.0386),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- restroom reception
table.insert(Config.DoorList, {
	objHash = -2051651622, -- v_ilev_fib_door1
	slides = false,
	maxDistance = 2.0,
	objHeading = 89.999977111816,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(1838.09, 2572.297, 46.15969),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- visitors access
table.insert(Config.DoorList, {
	objHash = -684929024, -- sanhje_prison_recep_door02
	slides = false,
	maxDistance = 2.0,
	objHeading = 89.999977111816,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(1835.528, 2587.44, 46.03712),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- prison access reception
table.insert(Config.DoorList, {
	objHash = -684929024, -- sanhje_prison_recep_door02
	slides = false,
	maxDistance = 2.0,
	objHeading = 0.0,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(1837.742, 2592.162, 46.03957),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- prison access 2 reception
table.insert(Config.DoorList, {
	objHash = -684929024, -- sanhje_prison_recep_door02
	slides = false,
	maxDistance = 2.0,
	objHeading = 89.999961853027,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(1831.34, 2594.992, 46.03791),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- photography room door
table.insert(Config.DoorList, {
	objHash = -684929024, -- sanhje_prison_recep_door02
	slides = false,
	maxDistance = 2.0,
	objHeading = 270.00003051758,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(1838.617, 2593.705, 46.03636),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- prisoners visits access
table.insert(Config.DoorList, {
	objHash = -684929024, -- sanhje_prison_recep_door02
	slides = false,
	maxDistance = 2.0,
	objHeading = 179.99998474121,
	lockpick = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	locked = true,
	audioRemote = false,
	objCoords = vector3(1827.981, 2592.157, 46.03718),
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- reception entry
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	objCoords = vector3(1835.902, 2584.903, 45.0169),
	audioRemote = false,
	garage = false,
	authorizedJobs = { ['police']=0 },
	fixText = false,
	lockpick = false,
	objHash = 673826957, -- prop_pris_door_03
	locked = true,
	objHeading = 89.999977111816,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- reception back door (to outside)
table.insert(Config.DoorList, {
	garage = false,
	authorizedJobs = { ['police']=0 },
	objHeading = 270.00003051758,
	maxDistance = 2.0,
	locked = true,
	slides = false,
	lockpick = false,
	audioRemote = false,
	objCoords = vector3(1819.073, 2594.873, 46.08695),
	fixText = true,
	objHash = 1373390714, -- prop_gate_prison_01		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- ## CELL BLOCK - Coordinates: 1751.387 2505.984 45.565
-- cellblock entry (outside)
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 1373390714, -- prop_gate_prison_01
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = true,
	objCoords = vector3(1754.796, 2501.568, 45.80966),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cellblock entry 2 (inside)
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 241550507, -- sanhje_prison_block_door -- sanhje_prison_block_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1758.652, 2492.659, 45.88988),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 1
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1768.548, 2498.411, 45.88988),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 2
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1765.401, 2496.594, 45.88988),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 3
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1762.255, 2494.778, 45.88988),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 4
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1755.963, 2491.146, 45.88988),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 5
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1752.817, 2489.33, 45.88988),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 6
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1749.671, 2487.514, 45.88988),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 7
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1768.547, 2498.412, 49.84591),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 8
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1765.401, 2496.595, 49.84591),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 9
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1762.255, 2494.779, 49.84591),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 10
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1759.109, 2492.963, 49.84591),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 11
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1755.963, 2491.146, 49.84591),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 12
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1752.817, 2489.329, 49.84591),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 13
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1749.671, 2487.513, 49.84591),
	objHeading = 210.00001525879,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 14
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1758.078, 2475.393, 45.88988),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 15
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1761.225, 2477.21, 45.88988),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 16
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1764.369, 2479.026, 45.88988),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 17
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1767.515, 2480.843, 45.88988),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 18
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1770.661, 2482.659, 45.88988),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 19
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1773.807, 2484.476, 45.88988),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 20
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1776.952, 2486.292, 45.88988),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 21
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1758.078, 2475.391, 49.84636),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 22
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1761.225, 2477.209, 49.84636),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 23
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1764.369, 2479.025, 49.84636),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 24
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1767.515, 2480.843, 49.84636),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 25
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1770.66, 2482.659, 49.84636),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 26
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1773.807, 2484.477, 49.84636),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- cell 27
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 913760512, -- sanhje_prison_block_cell_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1776.951, 2486.293, 49.84636),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- gym
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 241550507, -- sanhje_prison_block_door 
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1751.147, 2481.178, 45.88988),
	objHeading = 300.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- recreational room
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 241550507, -- sanhje_prison_block_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1752.281, 2479.248, 45.88988),
	objHeading = 119.99996948242,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- security left
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 241550507, -- sanhje_prison_block_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1772.939, 2495.313, 49.84006),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- security right
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	objHash = 241550507, -- sanhje_prison_block_door
	maxDistance = 2.0,
	locked = true,
	slides = false,
	garage = false,
	audioRemote = false,
	lockpick = false,
	fixText = false,
	objCoords = vector3(1775.414, 2491.025, 49.84006),
	objHeading = 29.999996185303,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- ## INFIRMARY - Coordinates: 1765.756 2561.949 45.565
-- infirmary entry (outdoor)
table.insert(Config.DoorList, {
	objCoords = vector3(1765.118, 2566.524, 45.80285),
	authorizedJobs = { ['police']=0 },
	locked = true,
	audioRemote = false,
	slides = false,
	lockpick = false,
	fixText = true,
	objHeading = 3.8476657209685e-05,
	objHash = 1373390714, -- prop_gate_prison_01
	garage = false,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- infirmary reception
table.insert(Config.DoorList, {
	objCoords = vector3(1772.813, 2570.296, 45.74467),
	authorizedJobs = { ['police']=0 },
	locked = true,
	audioRemote = false,
	slides = false,
	lockpick = false,
	fixText = false,
	objHeading = 4.8494574002689e-05,
	objHash = 2074175368, -- sanhje_prison_infirmary_door3 
	garage = false,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- hallway entry
table.insert(Config.DoorList, {
	lockpick = false,
	doors = {
		{objHash = -1624297821, objHeading = 4.8494574002689e-05, objCoords = vector3(1766.325, 2574.698, 45.75301)}, -- sanhje_prison_infirmary_door1
		{objHash = -1624297821, objHeading = 180.00001525879, objCoords = vector3(1764.025, 2574.698, 45.75301)} -- sanhje_prison_infirmary_door1
 },
	slides = false,
	audioRemote = false,
	maxDistance = 2.5,
	authorizedJobs = { ['police']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- laboratory
table.insert(Config.DoorList, {
	objCoords = vector3(1767.323, 2580.832, 45.74783),
	garage = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = -1392981450, -- sanhje_prison_infirmary_door2
	fixText = false,
	objHeading = 90.000007629395,
	audioRemote = false,
	slides = false,
	authorizedJobs = { ['police']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- surgery
table.insert(Config.DoorList, {
	lockpick = false,
	doors = {
		{objHash = -1624297821, objHeading = 270.0, objCoords = vector3(1767.321, 2582.308, 45.75345)}, -- sanhje_prison_infirmary_door1
		{objHash = -1624297821, objHeading = 90.000007629395, objCoords = vector3(1767.321, 2584.607, 45.75345)} -- sanhje_prison_infirmary_door1
 },
	slides = false,
	audioRemote = false,
	maxDistance = 2.5,
	authorizedJobs = { ['police']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- intensive care
table.insert(Config.DoorList, {
	lockpick = false,
	doors = {
		{objHash = -1624297821, objHeading = 3.8476657209685e-05, objCoords = vector3(1766.325, 2589.564, 45.75309)}, -- sanhje_prison_infirmary_door1
		{objHash = -1624297821, objHeading = 180.00006103516, objCoords = vector3(1764.026, 2589.564, 45.75309)} -- sanhje_prison_infirmary_door1
 },
	slides = false,
	audioRemote = false,
	maxDistance = 2.5,
	authorizedJobs = { ['police']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})


-- ## CAFETERIA - Coordinates: 1772.354 2551.826 45.565
-- entry 1 (from recreational area)
table.insert(Config.DoorList, {
	objCoords = vector3(1776.195, 2552.563, 45.74741),
	garage = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = 1373390714, -- prop_gate_prison_01
	fixText = false,
	objHeading = 270.00003051758,
	audioRemote = false,
	slides = false,
	authorizedJobs = { ['police']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- entry 2
table.insert(Config.DoorList, {
	objCoords = vector3(1791.595, 2551.462, 45.7532),
	garage = false,
	maxDistance = 2.0,
	lockpick = false,
	objHash = 1373390714, -- prop_gate_prison_01
	fixText = false,
	objHeading = 89.999977111816,
	audioRemote = false,
	slides = false,
	authorizedJobs = { ['police']=0 },
	locked = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})