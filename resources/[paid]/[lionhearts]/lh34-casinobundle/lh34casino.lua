-- casino-hotel-service created by Lionh34rt
Config.DoorList['casino-hotel-service'] = {
    authorizedJobs = { ['casino'] = 0 },
    doorType = 'double',
    distance = 2,
    locked = true,
    doors = {
        {objName = -192278810, objYaw = 58.156597137451, objCoords = vec3(900.544678, -65.384079, 21.150007)},
        {objName = -192278810, objYaw = 238.15664672852, objCoords = vec3(901.546753, -63.770603, 21.150007)}
    },
    doorRate = 1.0,
}

-- casino-hotel-service2 created by Lionh34rt
Config.DoorList['casino-hotel-service2'] = {
    authorizedJobs = { ['casino'] = 0 },
    doorType = 'double',
    distance = 2,
    locked = true,
    doors = {
        {objName = -170420121, objYaw = 238.15664672852, objCoords = vec3(883.776733, -50.523945, 21.149433)},
        {objName = 1090039464, objYaw = 58.156597137451, objCoords = vec3(882.774597, -52.137421, 21.149433)}
    },
    doorRate = 1.0,
}


-- down-entrance created by Lionh34rt
Config.DoorList['casino-down-entrance'] = {
    authorizedJobs = { ['casino'] = 0 },
    distance = 2,
    doors = {
        {objName = 21324050, objYaw = 328.15661621094, objCoords = vec3(958.141296, 33.978157, 72.404907)},
        {objName = 21324050, objYaw = 148.15661621094, objCoords = vec3(960.274231, 32.653469, 72.404907)}
    },
    doorRate = 1.0,
    locked = false,
    doorType = 'double',
}

-- shower-wall created by Lionh34rt
Config.DoorList['lh34casino-shower-wall'] = {
    doorType = 'door',
    objYaw = 58.156646728516,
    objName = -2603300,
    objCoords = vec3(935.566711, -52.710518, 21.796383),
    locked = true,
    distance = 1,
    fixText = false,
    doorRate = 1.0,
    hideLabel = true,
    autoLock = 5000,
    audioRemote = false,
    audioUnlock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.8},
}

-- generator1 created by Lionh34rt
Config.DoorList['lh34casino-generator1'] = {
    fixText = false,
    objCoords = vec3(1000.004333, 8.898457, 63.611694),
    objName = 217447762,
    objYaw = 58.156597137451,
    doorType = 'door',
    distance = 2,
    doorRate = 1.0,
    locked = true,
}

-- generator2 created by Lionh34rt
Config.DoorList['lh34casino-generator2'] = {
    fixText = false,
    objCoords = vec3(1008.124268, 16.299358, 63.611694),
    objName = 217447762,
    objYaw = 148.15661621094,
    doorType = 'door',
    distance = 2,
    doorRate = 1.0,
    locked = true,
}

-- generator3 created by Lionh34rt
Config.DoorList['lh34casino-generator3'] = {
    fixText = false,
    objCoords = vec3(1006.893860, 25.959684, 63.604462),
    doorType = 'door',
    distance = 2,
    objName = 217447762,
    locked = true,
    doorRate = 1.0,
    objYaw = 328.15661621094,
    hideLabel = true,
}

-- generator4 created by Lionh34rt
Config.DoorList['lh34casino-generator4'] = {
    doors = {
        {objName = -1240156945, objYaw = 327.95471191406, objCoords = vec3(1009.284241, 29.998472, 62.461468)},
        {objName = -1240156945, objYaw = 148.2368927002, objCoords = vec3(1010.557556, 29.205261, 62.461468)}
    },
    distance = 2,
    locked = true,
    doorRate = 1.0,
    doorType = 'double',
    hideLabel = true,
}

-- staff1 created by Lionh34rt
Config.DoorList['lh34casino-staff1'] = {
    objYaw = 238.03240966797,
    distance = 2,
    objCoords = vec3(991.747925, 25.033257, 71.614433),
    doorRate = 1.0,
    fixText = false,
    authorizedJobs = { ['casino'] = 0 },
    doorType = 'door',
    objName = 401003935,
    locked = false,
}

-- restricted1 created by Lionh34rt
Config.DoorList['lh34casino-restricted1'] = {
    objYaw = 328.15661621094,
    distance = 2,
    objCoords = vec3(994.513306, 25.085358, 71.611694),
    doorRate = 1.0,
    fixText = false,
    authorizedJobs = { ['casino'] = 2 },
    doorType = 'door',
    objName = 1278063852,
    locked = true,
}

-- elevator created by Lionh34rt
Config.DoorList['lh34casino-elevator'] = {
    doors = {
        {objName = -1240156945, objYaw = 327.83828735352, objCoords = vec3(1012.259888, 28.081015, 70.460556)},
        {objName = -1240156945, objYaw = 148.388671875, objCoords = vec3(1013.533813, 27.289812, 70.460556)}
    },
    distance = 2,
    doorType = 'double',
    doorRate = 1.0,
    locked = true,
    hideLabel = true,
}

-- keycardvault created by Lionh34rt
Config.DoorList['lh34casino-keycardvault'] = {
    distance = 2,
    fixText = false,
    doorRate = 1.0,
    objName = -2050208642,
    objYaw = 148.15661621094,
    objCoords = vec3(1006.631592, 7.444840, 71.711693),
    locked = true,
    hideLabel = true,
    doorType = 'door',
}

-- restrkeycard created by Lionh34rt
Config.DoorList['lh34casino-restrkeycard'] = {
    locked = true,
    doorRate = 1.0,
    doorType = 'double',
    doors = {
        {objName = -1747430008, objYaw = 148.15661621094, objCoords = vec3(1010.978821, 39.265533, 75.211693)},
        {objName = -1747430008, objYaw = 328.15661621094, objCoords = vec3(1009.279846, 40.320744, 75.211693)}
    },
    distance = 2,
}

-- elevatorshaft1 created by Lionh34rt
Config.DoorList['lh34casino-elevatorshaft1'] = {
    distance = 2,
    doors = {
        {objName = -1240156945, objYaw = 148.15661621094, objCoords = vec3(1015.239136, 30.034584, 74.060211)},
        {objName = -1240156945, objYaw = 328.15661621094, objCoords = vec3(1013.964478, 30.826216, 74.060211)}
    },
    locked = true,
    doorType = 'double',
    doorRate = 1.0,
    hideLabel = true,
}

-- elevatorshaft2 created by Lionh34rt
Config.DoorList['lh34casino-elevatorshaft2'] = {
    distance = 2,
    doors = {
        {objName = -1240156945, objYaw = 148.15661621094, objCoords = vec3(1012.011780, 32.040813, 74.061348)},
        {objName = -1240156945, objYaw = 328.15661621094, objCoords = vec3(1010.737610, 32.832161, 74.061348)}
    },
    locked = true,
    doorType = 'double',
    doorRate = 1.0,
    hideLabel = true,
}

-- elevator_hatch created by Lionh34rt
Config.DoorList['lh34casino-elevator_hatch'] = {
    objCoords = vec3(1014.560120, 29.901257, -7.026237),
    objYaw = 148.15661621094,
    locked = true,
    hideLabel = true,
    objName = 2087042309,
    distance = 2,
    doorRate = 1.0,
    doorType = 'sliding',
}

-- bottom_elevator created by Lionh34rt
Config.DoorList['lh34casino-bottom_elevator'] = {
    doorType = 'double',
    doorRate = 1.0,
    distance = 2,
    doors = {
        {objName = -1240156945, objYaw = 328.15661621094, objCoords = vec3(1012.480957, 27.987148, -9.541245)},
        {objName = -1240156945, objYaw = 148.15661621094, objCoords = vec3(1013.754211, 27.197426, -9.541245)}
    },
    locked = true,
    hideLabel = true
}

-- security-door1 created by Lionh34rt
Config.DoorList['lh34casino-security-door1'] = {
    objCoords = vec3(1021.192261, 20.666773, 71.611694),
    doorRate = 1.0,
    doorType = 'door',
    locked = true,
    authorizedJobs = { ['casino'] = 2 },
    fixText = false,
    objName = 1226684428,
    distance = 2,
    objYaw = 148.15661621094,
    autoLock = 5000,
}

-- security-door2 created by Lionh34rt
Config.DoorList['lh34casino-security-door2'] = {
    authorizedJobs = { ['casino'] = 2 },
    doorRate = 1.0,
    distance = 2,
    locked = true,
    doorType = 'double',
    autoLock = 5000,
    doors = {
        {objName = -267451115, objYaw = 328.15661621094, objCoords = vec3(1019.818542, -5.189483, 71.611694)},
        {objName = -267451115, objYaw = 148.15661621094, objCoords = vec3(1021.517395, -6.244555, 71.611694)}
    },
}

-- security-door3 created by Lionh34rt
Config.DoorList['lh34casino-security-door3'] = {
    objCoords = vec3(1018.884888, 2.029019, 71.611694),
    doorRate = 1.0,
    doorType = 'door',
    locked = true,
    authorizedJobs = { ['casino'] = 2 },
    fixText = false,
    objName = 1890811383,
    distance = 2,
    objYaw = 58.156597137451,
    autoLock = 5000,
}

-- security-door4 created by Lionh34rt
Config.DoorList['lh34casino-security-door4'] = {
    objCoords = vec3(1016.046204, 2.215143, 71.611694),
    doorRate = 1.0,
    doorType = 'door',
    locked = true,
    authorizedJobs = { ['casino'] = 2 },
    fixText = false,
    objName = 1890811383,
    distance = 2,
    objYaw = 328.15661621094,
    autoLock = 5000,
}

-- security-door5 created by Lionh34rt
Config.DoorList['lh34casino-security-door5'] = {
    objCoords = vec3(1019.510742, 13.083242, 71.611694),
    doorRate = 1.0,
    doorType = 'door',
    locked = true,
    authorizedJobs = { ['casino'] = 2 },
    fixText = false,
    objName = 1890811383,
    distance = 2,
    objYaw = 328.15661621094,
    autoLock = 5000,
}

-- security-door6 created by Lionh34rt
Config.DoorList['lh34casino-security-door6'] = {
    objCoords = vec3(1017.384766, 15.336731, 71.611694),
    doorRate = 1.0,
    doorType = 'door',
    locked = true,
    authorizedJobs = { ['casino'] = 2 },
    fixText = false,
    objName = 1890811383,
    distance = 2,
    objYaw = 148.15661621094,
    autoLock = 5000,
}

-- security-door7 created by Lionh34rt
Config.DoorList['lh34casino-security-door7'] = {
    objCoords = vec3(1013.197815, 16.051043, 71.611694),
    doorRate = 1.0,
    doorType = 'door',
    locked = true,
    authorizedJobs = { ['casino'] = 2 },
    fixText = false,
    objName = 1890811383,
    distance = 2,
    objYaw = 238.15664672852,
    autoLock = 5000,
}

-- security-door8 created by Lionh34rt
Config.DoorList['lh34casino-security-door8'] = {
    locked = true,
    doorRate = 1.0,
    authorizedJobs = { ['casino'] = 2 },
    doors = {
        {objName = -267451115, objYaw = 328.15661621094, objCoords = vec3(1011.449890, 0.008102, 71.611694)},
        {objName = -267451115, objYaw = 148.15661621094, objCoords = vec3(1013.148865, -1.047096, 71.611694)}
    },
    distance = 2,
    doorType = 'double',
    autoLock = 5000,
}