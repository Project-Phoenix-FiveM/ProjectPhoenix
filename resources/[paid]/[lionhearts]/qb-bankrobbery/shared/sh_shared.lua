Shared = {}

Shared.Debug = false

--- Laptop Settings
Shared.LaptopMoneyType = 'crypto' -- Any QBCore moneytype: cash/bank/crypto
Shared.LaptopUses = 3
Shared.Laptop = {
    green = {
        coords = vector4(2892.58, 4371.02, 50.31, 270.88),
        price = 15,
        pedModel = 'hc_hacker',
        usb = 'usb_green',
        reward = 'laptop_green'
    },
    blue = {
        coords = vector4(-90.95, -2577.8, 6.0, 102.77),
        price = 25,
        pedModel = 'g_f_y_vagos_01',
        usb = 'usb_blue',
        reward = 'laptop_blue'
    },
    red = {
        coords = vector4(2574.85, 1283.87, 44.54, 302.55),
        price = 35,
        pedModel = 'ig_talcc',
        usb = 'usb_red',
        reward = 'laptop_red'
    }
}

--- Minigame Settings
Shared.MinigameSettings = {
    laptop = {
        ['fleeca'] = { time = 10, blocks = 3, amount = 3 },
        ['maze'] = { time = 11, blocks = 4, amount = 4 },
        ['paleto'] = { time = 12, blocks = 5, amount = 4 },
        ['pacific'] = { time = 12, blocks = 6, amount = 4 }
    },
    simonSays = { buttonGrid = 5, length = 3 }, -- Used in Fleeca bank
    lightsOut = { grid = 4, maxClicks = 50 }, -- Used for every locker (drilling)
    varHack = { blocks = 4 }, -- Used for Paleto hacks
    mazeHack = { time = 17 }, -- Used for Paleto security hacks
    thermite = { correctBlocks = 1, incorrectBlocks = 4, timetoShow = 6, timetoLose = 20 }, -- Used in Maze and Pacific
    hackingdevice = { timer = 25, characters = 'alphanumeric' }, -- Used in Pacific
}

--- Bank Settings
Shared.BankSettings = {
    VaultUnlockTime = 6, -- Time in seconds for when the vault door opens after laptop hack
    PaletoInputTime = 1500, -- Time in milliseconds where all 3 inputs must be entered
    PacificInputTime = 1500 -- Time in milliseconds where both inputs must be entered
}

Shared.MinCops = {
    fleeca = 0,
    maze = 0,
    paleto = 0,
    pacific = 0
}

Shared.Cooldown = { -- These cooldowns start the second the bank is successfully hacked, time in minutes
    fleeca = 45,
    maze = 45,
    paleto = 60,
    pacific = 120
}

--- Banks
Shared.Banks = { -- This is mainly for storing variables that are used and/or change dynamically during the script
    ['PinkCage'] = {
        label = 'Pink Cage Motels',
        type = 'fleeca',
        coords = vector3(311.15, -284.49, 54.16),
        size = 15,
        keycardTaken = false,
        door = { id = 'lh34banksgabz-pinkcage_door2', coords = vector3(308.69, -281.55, 54.33) },
        innerDoor = { id = 'lh34banksgabz-pinkcage_door3', hacked = false },
        hacked = false,
        policeClose = false,
        vaultDoor = { object = `v_ilev_gb_vauldr`, closed = 250.0, open = 150.0 },
        camId = 21,
        laptop = vector4(311.14, -284.03, 53.974, 160.00),
        lockers = {
            [1] = { busy = false, taken = false, coords = vector4(315.03, -288.31, 54.14, 249.50) },
            [2] = { busy = false, taken = false, coords = vector4(315.92, -285.14, 54.14, 249.50) },
            [3] = { busy = false, taken = false, coords = vector4(312.47, -289.45, 54.16, 159.50) },
            [4] = { busy = false, taken = false, coords = vector4(310.79, -286.92, 54.16, 249.50) },
            [5] = { busy = false, taken = false, coords = vector4(314.13, -283.07, 54.16, 159.50) },
        },
        trolly = {
            [1] = { type = 'money', busy = false, taken = false, coords = vector4(313.47702, -289.2542, 54.1431, 320.27249) },
            [2] = { type = 'money', busy = false, taken = false, coords = vector4(311.61235, -287.6962, 54.143051, 305.18524) }
        }
    },
    ['Legion'] = {
        label = 'Legion Square',
        type = 'fleeca',
        coords = vector3(146.92, -1046.11, 29.36),
        size = 15,
        keycardTaken = false,
        door = { id = 'lh34banksgabz-legion_door2', coords = vector3(144.36, -1043.19, 29.53) },
        innerDoor = { id = 'lh34banksgabz-legion_door3', hacked = false },
        hacked = false,
        policeClose = false,
        vaultDoor = { object = `v_ilev_gb_vauldr`, closed = 250.0, open = 150.0 },
        camId = 22,
        laptop = vector4(147.60, -1046.86, 30.008, 160.00),
        lockers = {
            [1] = { busy = false, taken = false, coords = vector4(151.54, -1046.71, 29.35, 250.00) },
            [2] = { busy = false, taken = false, coords = vector4(150.81, -1050.10, 29.35, 250.00) },
            [3] = { busy = false, taken = false, coords = vector4(148.12, -1051.03, 29.35, 160.00) },
            [4] = { busy = false, taken = false, coords = vector4(146.58, -1048.51, 29.35, 250.00) },
            [5] = { busy = false, taken = false, coords = vector4(149.84, -1044.7, 29.35, 160.00) },
        },
        trolly = {
            [1] = { type = 'money', busy = false, taken = false, coords = vector4(147.13935, -1049.607, 29.34633, 311.47201) },
            [2] = { type = 'money', busy = false, taken = false, coords = vector4(149.51391, -1050.767, 29.346384, 291.46362) }
        }
    },
    ['Hawick'] = {
        label = 'Hawick Ave',
        type = 'fleeca',
        coords = vector3(-353.82, -55.37, 49.03),
        size = 15,
        keycardTaken = false,
        door = { id = 'lh34banksgabz-hawick_door2', coords = vector3(-356.42, -52.46, 49.20) },
        innerDoor = { id = 'lh34banksgabz-hawick_door3', hacked = false },
        hacked = false,
        policeClose = false,
        vaultDoor = { object = `v_ilev_gb_vauldr`, closed = 250.0, open = 150.0 },
        camId = 23,
        laptop = vector4(-354.55, -55.26, 49.86, 160.00),
        lockers = {
            [1] = { busy = false, taken = false, coords = vector4(-349.16, -55.93, 49.01, 250.00) },
            [2] = { busy = false, taken = false, coords = vector4(-349.98, -59.1, 49.01, 250.00) },
            [3] = { busy = false, taken = false, coords = vector4(-352.70, -60.14, 49.01, 160.00) },
            [4] = { busy = false, taken = false, coords = vector4(-354.07, -57.75, 49.01, 250.00) },
            [5] = { busy = false, taken = false, coords = vector4(-350.95, -53.85, 49.01, 160.00) },
        },
        trolly = {
            [1] = { type = 'money', busy = false, taken = false, coords = vector4(-353.644, -59.04, 49.0148, 309.626) },
            [2] = { type = 'money', busy = false, taken = false, coords = vector4(-351.6271, -59.91, 49.0148, 296.23211) }
        }
    },
    ['DelPerro'] = {
        label = 'Del Perro Blvd',
        type = 'fleeca',
        coords = vector3(-1210.77, -336.57, 37.78),
        size = 15,
        keycardTaken = false,
        door = { id = 'lh34banksgabz-delperro_door2', coords = vector3(-1214.62, -336.44, 37.94) },
        innerDoor = { id = 'lh34banksgabz-delperro_door3', hacked = false },
        hacked = false,
        policeClose = false,
        vaultDoor = { object = `v_ilev_gb_vauldr`, closed = 296.863, open = 196.863 },
        camId = 24,
        laptop = vector4(-1210.53, -336.78, 37.381, 206.00),
        lockers = { 
            [1] = { busy = false, taken = false, coords = vector4(-1207.14, -333.59, 37.76, 297.0) },
            [2] = { busy = false, taken = false, coords = vector4(-1205.28, -336.56, 37.76, 297.0) },
            [3] = { busy = false, taken = false, coords = vector4(-1209.7, -333.31, 37.76, 207.0) },
            [4] = { busy = false, taken = false, coords = vector4(-1206.52, -339.17, 37.76, 207.0) },
            [5] = { busy = false, taken = false, coords = vector4(-1209.34, -338.3, 37.76, 297.0) },
        },
        trolly = {
            [1] = { type = 'money', busy = false, taken = false, coords = vector4(-1207.97, -338.9731, 37.759284, 353.9089) },
            [2] = { type = 'money', busy = false, taken = false, coords = vector4(-1205.895, -338.0665, 37.759326, 340.50067) }
        }
    },
    ['GreatOcean'] = {
        label = 'Great Ocean Hwy',
        type = 'fleeca',
        coords = vector3(-2956.55, 481.74, 15.69),
        size = 15,
        keycardTaken = false,
        door = { id = 'lh34banksgabz-greatocean_door2', coords = vector3(-2958.54, 478.42, 15.86) },
        innerDoor = { id = 'lh34banksgabz-greatocean_door3', hacked = false },
        hacked = false,
        policeClose = false,
        vaultDoor = { object = `v_ilev_gb_vauldr`, closed = 357.542, open = 257.542 },
        camId = 25,
        laptop = vector4(-2956.07, 481.64, 15.297, 268.00),
        lockers = {
            [1] = { busy = false, taken = false, coords = vector4(-2958.77, 484.18, 15.68, 268.0) },
            [2] = { busy = false, taken = false, coords = vector4(-2957.33, 486.25, 15.68, 358.0) },
            [3] = { busy = false, taken = false, coords = vector4(-2954.02, 486.69, 15.68, 358.0) },
            [4] = { busy = false, taken = false, coords = vector4(-2952.23, 484.32, 15.68, 268.0) },
            [5] = { busy = false, taken = false, coords = vector4(-2954.27, 482.06, 15.68, 358.0) },
        },
        trolly = {
            [1] = { type = 'money', busy = false, taken = false, coords = vector4(-2953.083, 482.7803, 15.675336, 49.137405) },
            [2] = { type = 'money', busy = false, taken = false, coords = vector4(-2952.881, 485.22781, 15.675389, 37.428142) }
        }
    },
    ['Sandy'] = {
        label = 'Sandy Shores',
        type = 'fleeca',
        coords = vector3(1175.28, 2712.72, 38.08),
        size = 15,
        keycardTaken = false,
        door = { id = 'lh34banksgabz-sandy_door2', coords = vector3(1179.39, 2711.02, 38.25) },
        innerDoor = { id = 'lh34banksgabz-sandy_door3', hacked = false },
        hacked = false,
        policeClose = false,
        vaultDoor = { object = `v_ilev_gb_vauldr`, closed = 90.00, open = -10.00 },
        camId = 99,
        laptop = vector4(1175.81, 2713.26, 39.35, 359.96),
        lockers = {
            [1] = { busy = false, taken = false, coords = vector4(1171.43, 2711.87, 38.07, 91.2) },
            [2] = { busy = false, taken = false, coords = vector4(1170.89, 2715.25, 38.07, 91.2) },
            [3] = { busy = false, taken = false, coords = vector4(1173.29, 2717.18, 38.09, 1.2) },
            [4] = { busy = false, taken = false, coords = vector4(1173.65, 2710.27, 38.07, 181.2) },
            [5] = { busy = false, taken = false, coords = vector4(1175.75, 2715.18, 38.07, 91.2) },
        },
        trolly = {
            [1] = { type = 'money', busy = false, taken = false, coords = vector4(1174.6406, 2716.2036, 38.066295, 141.10868) },
            [2] = { type = 'money', busy = false, taken = false, coords = vector4(1171.6578, 2716.2761, 38.066303, 231.91242) }
        }
    },
    ['Maze'] = {
        label = 'Maze Bank',
        type = 'maze',
        coords = vector3(-1306.05, -816.82, 17.3),
        size = 15,
        hacked = false,
        policeClose = false,
        vaultDoor = { object = `v_ilev_bk_vaultdoor`, closed = 37.0, open = -133.0 },
        camId = 99,
        laptop = vector4(-1304.17, -816.56, 18.05, 311.46),
        lockers = {
            [1] = { busy = false, taken = false, coords = vector4(-1307.53, -810.4, 17.15, 307.00) },
            [2] = { busy = false, taken = false, coords = vector4(-1311.2, -813.01, 17.15, 126.65) },
            [3] = { busy = false, taken = false, coords = vector4(-1310.35, -810.21, 17.15, 36.57) },
        },
        trolly = {
            [1] = { type = 'money', taken = false, coords = vector4(-1310.97, -811.23, 17.15, 221.28) },
            [2] = { type = 'gold', taken = false, coords = vector4(-1308.99, -809.94, 17.15, 187.48) },
        },
        thermite = {
            [1] = { coords = vector4(-1305.3, -819.80, 17.20, 38.56), ptfx = vector3(-1305.40, -818.70, 17.20), doorId = 'lh34banksgabz-mazethermite1', hit = false },
            [2] = { coords = vector4(-1308.46, -814.2, 17.20, 38.56), ptfx = vector3(-1308.57, -813.1, 17.20), doorId = 'lh34banksgabz-mazethermite2', hit = false },
        }
    },
    ['Paleto'] = {
        label = 'Paleto Bay',
        type = 'paleto',
        coords = vector3(-105.41, 6468.69, 31.64),
        size = 15,
        hacked = false,
        policeClose = false,
        vaultDoor = { object = -2050208642, closed = 225.07, open = 90.0 },
        securityEntrance = { id = 'lh34banksgabz-paleto-security-back', hacked = false },
        sideEntrance = { id = 'lh34banksgabz-paleto-side-back', hacked = false },
        sideHack = { id = 'lh34banksgabz-paleto-security-room', hacked = false },
        officeHacks = {
            [1] = { label = 'Office 1', id = 'lh34banksgabz-paleto-office-left', hacked = false },
            [2] = { label = 'Office 2', id = 'lh34banksgabz-paleto-office-right', hacked = false },
            [3] = { label = 'Administration', id = 'lh34banksgabz-paleto-office-admin', hacked = false }
        },
        camId = 99,
        laptop = vector4(-102.05, 6463.24, 31.20, 188.71),
        lockers = {
            [1] = { busy = false, taken = false, coords = vector4(-96.52, 6459.74, 31.63, 225.0) },
            [2] = { busy = false, taken = false, coords = vector4(-100.35, 6459.81, 31.63, 135.0) },
            [3] = { busy = false, taken = false, coords = vector4(-96.95, 6463.51, 31.63, 135.0) },
        },
        trolly = {
            [1] = { type = 'money', busy = false, taken = false, coords = vector4(-98.24, 6459.19, 31.63, 6.37) },
            [2] = { type = 'money', busy = false, taken = false, coords = vector4(-96.22, 6461.65, 31.63, 91.8) },
            [3] = { type = 'gold', busy = false, taken = false, coords = vector4(-98.98, 6461.86, 31.63, 90.55) },
        }
    },
    ['Pacific'] = {
        label = 'Pacific Standard Bank',
        type = 'pacific',
        coords = vector3(239.24, 228.07, 97.12),
        size = 40,
        hacked = false,
        lockdown = false,
        laserPanel = false,
        policeClose = false,
        vaultDoor = { object = `v_ilev_bk_vaultdoor`, closed = 70.0, open = -45.0 },
        camId = 26,
        laptop = vector4(237.09, 231.32, 97.0, 70.0),
        sideEntrance = { id = 'lh34banksgabz-pacific-side', hacked = false },
        computers = {
            ['main'] = { coords = vector3(278.78, 213.07, 110.17), hacked = false },
            ['office1'] = { coords = vector3(260.54, 205.56, 110.17), hacked = false, key = 'pacific_key1' },
            ['office2'] = { coords = vector3(252.04, 208.66, 110.17), hacked = false, key = 'pacific_key2' },
            ['office3'] = { coords = vector3(270.14, 231.59, 110.17), hacked = false, key = 'pacific_key3' },
            ['office4'] = { coords = vector3(261.65, 234.7, 110.17), hacked = false, key = 'pacific_key4' }
        },
        searchDrawers = {
            [1] = { coords = vector4(257.23, 204.99, 110.17, 70.0), usb = false },
            [2] = { coords = vector4(254.91, 207.69, 110.17, 250.0), usb = false },
            [3] = { coords = vector4(264.27, 233.28, 110.17, 250.0), usb = false },
            [4] = { coords = vector4(267.79, 234.14, 110.17, 70.0), usb = false },
            [5] = { coords = vector4(278.59, 209.42, 110.17, 160.0), usb = false },
            [6] = { coords = vector4(279.36, 206.79, 106.28, 250.0), usb = false },
            [7] = { coords = vector4(267.93, 209.16, 106.28, 160.0), usb = false },
            [8] = { coords = vector4(259.12, 212.27, 106.28, 160.0), usb = false },
            [9] = { coords = vector4(257.18, 204.98, 106.28, 70.0), usb = false },
            [10] = { coords = vector4(254.38, 206.24, 106.28, 250.0), usb = false },
            [11] = { coords = vector4(264.48, 227.54, 106.28, 160.0), usb = false },
            [12] = { coords = vector4(264.98, 235.36, 106.28, 250.0), usb = false },
            [13] = { coords = vector4(267.85, 234.04, 106.28, 70.0), usb = false },
            [14] = { coords = vector4(273.98, 223.91, 106.28, 160.0), usb = false },
            [15] = { coords = vector4(277.5, 220.43, 106.28, 160.0), usb = false },
            [16] = { coords = vector4(273.04, 209.52, 106.28, 160.0), usb = false },
        },
        sideVaults = {
            [1] = { id = 'lh34banksgabz-vault-door6', laptop = vector4(242.35, 218.52, 97.0, 160.0), hacked = false },
            [2] = { id = 'lh34banksgabz-vault-door7', laptop = vector4(247.47, 233.38, 97.0, 340.0), hacked = false }
        },
        thermite = {
            [1] = { coords = vector4(272.75, 215.98, 110.25, 250.0), ptfx = vector3(272.70, 217.0, 110.25), doorId = 'lh34banksgabz-pacific-office-main', hit = false },
            [2] = { coords = vector4(252.15, 217.33, 97.22, 70.0), ptfx = vector3(252.15, 218.33, 97.22), doorId = 'lh34banksgabz-vault-door3', hit = false },
            [3] = { coords = vector4(256.10, 228.26, 97.22, 70.0), ptfx = vector3(256.07, 229.26, 97.22), doorId = 'lh34banksgabz-vault-door4', hit = false },
            [4] = { coords = vector4(265.36, 224.86, 97.22, 250.0), ptfx = vector3(265.30, 225.86, 97.22), doorId = 'lh34banksgabz-vault-door5', hit = false },
        },
        lockers = {
            [1] = { busy = false, taken = false, coords = vector4(252.49, 240.94, 97.12, 340.0) },
            [2] = { busy = false, taken = false, coords = vector4(253.64, 236.53, 97.12, 250.0) },
            [3] = { busy = false, taken = false, coords = vector4(249.04, 237.75, 97.12, 70.0) },
            [4] = { busy = false, taken = false, coords = vector4(241.49, 209.88, 97.12, 160.0) },
            [5] = { busy = false, taken = false, coords = vector4(240.33, 214.13, 97.12, 70.0) },
            [6] = { busy = false, taken = false, coords = vector4(244.77, 212.73, 97.12, 250.0) },
            [7] = { busy = false, taken = false, coords = vector4(225.74, 230.85, 97.12, 70.0) },
            [8] = { busy = false, taken = false, coords = vector4(227.12, 234.62, 97.12, 70.0) },
            
        },
        trolly = {
            [1] = { type = 'money', busy = false, taken = false, coords = vector4(252.72, 238.42, 97.12, 110.95) },
            [2] = { type = 'money', busy = false, taken = false, coords = vector4(249.64, 235.98, 97.12, 298.49) },
            [3] = { type = 'money', busy = false, taken = false, coords = vector4(240.68, 211.68, 97.12, 295.56) },
            [4] = { type = 'money', busy = false, taken = false, coords = vector4(244.3, 214.81, 97.12, 117.34) },
            [5] = { type = 'money', busy = false, taken = false, coords = vector4(228.43, 234.95, 97.12, 206.52) },
            [6] = { type = 'money', busy = false, taken = false, coords = vector4(231.5, 233.37, 97.12, 116.47) },
            [7] = { type = 'money', busy = false, taken = false, coords = vector4(228.52, 225.38, 97.12, 340.0) },
            [8] = { type = 'money', busy = false, taken = false, coords = vector4(225.48, 226.35, 97.12, 340.0) },
        }
    }
}
