Config = {}

Config.cardTypes = { "visa", "mastercard"}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Zones = {
        [1] = {
        position = vector3(149.05, -1041.3, 29.37),
        length = 6.2, width = 2.0, heading = 250,
        minZ = 27.17, maxZ = 31.17
    },
    [2] = {
        position = vector3(313.32, -280.03, 54.17),
        length = 6.6, width = 2.0, heading = 250,
        minZ = 51.97, maxZ = 55.97
    },
    [3] = {
        position = vector3(-351.94, -50.72, 49.04),
        length = 6.4, width = 2.0, heading = 71,
        minZ = 46.84, maxZ = 50.84
    },
    [4] = {
        position = vector3(-1212.68, -331.83, 37.78),
        length = 6.4, width = 2.0, heading = 297,
        minZ = 35.58, maxZ = 39.58
    },
    [5] = {
        position = vector3(-2961.67, 482.31, 15.7),
        length = 6.6, width = 2.0, heading = 358,
        minZ = 13.7, maxZ = 17.7
    },
    [6] = {
        position = vector3(1175.64, 2707.71, 38.09),
        length = 6.6, width = 2.0, heading = 90,
        minZ = 35.89, maxZ = 39.89
    },
    [7] = {
        position = vector3(247.65, 223.87, 106.29),
        length = 15.8, width = 2.0, heading = 250,
        minZ = 104.49, maxZ = 108.49
    },
    [8] = {
        position = vector3(-111.98, 6470.56, 31.63),
        length = 6.6, width = 2.0, heading = 45,
        minZ = 29.43, maxZ = 33.43
    }
}

Config.Blip = {
    blipName = Lang:t('info.bank_blip'),
    blipType = 108,
    blipColor = 2,
    blipScale = 0.55
}

Config.ATMModels = {
    "prop_atm_01",
    "prop_atm_02",
    "prop_atm_03",
    "prop_fleeca_atm"
}

Config.BankLocations = {
    vector3(149.9, -1040.46, 29.37),
    vector3(314.23, -278.83, 54.17),
    vector3(-350.8, -49.57, 49.04),
    vector3(-1213.0, -330.39, 37.79),
    vector3(-2962.71, 483.0, 15.7),
    vector3(1175.07, 2706.41, 38.09),
    vector3(246.64, 223.20, 106.29),
    vector3(-113.22, 6470.03, 31.63)
}
