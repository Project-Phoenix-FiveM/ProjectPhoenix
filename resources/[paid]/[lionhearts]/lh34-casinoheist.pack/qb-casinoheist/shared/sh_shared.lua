Shared = Shared or {}

Shared.MinCops = 0 -- Minimum amount of cops on-duty and online

--[[

    This is not a config file.
    You don't really want to change anything in here, this is a shared file to cache heist progress states.

    Below are teleport coordinates that you can use with the /tp command.

    Room 503: 931.17 -47.44 21.0
    Tunnel: 980.6 13.64 51.25
    Thermite: 1011.27 18.61 54.46
    Generator: 997.39 14.9 63.46
    Elevator Shaft: 1010.99 30.37 -12.9
    Vault: 1005.44 15.6 -8.55
    Roof Magnets: 937.16 -1.58 111.3
    Security Room: 1013.29 10.52 71.47

]]

Shared.PowerplantHit = false
Shared.TunnelHit = false
Shared.SetLadder = false

Shared.MagnetsEnabled = false
Shared.USBSpawned = false
Shared.KeycardTaken = false

Shared.VaultLogin = false
Shared.VaultOpen = false
Shared.VaultStage = 0

Shared.Thermite = {
    [1] = {
        busy = false,
        hit = false,
        coords = vector3(1010.18, 21.88, 54.46),
        thermiteAnimation = vector4(1010.03, 22.03, 54.56, 61.58),
        thermitePtfx = vector3(1010.03, 23.03, 54.46)
    },
    [2] = {
        busy = false,
        hit = false,
        coords = vector3(1013.01, 20.94, 54.46),
        thermiteAnimation = vector4(1013.01, 21.27, 54.56, 324.46),
        thermitePtfx = vector3(1013.01, 22.32, 54.46)
    },
    [3] = {
        busy = false,
        hit = false,
        coords = vector3(1012.35, 17.82, 54.46),
        thermiteAnimation = vector4(1012.55, 17.67, 54.56, 238.33),
        thermitePtfx = vector3(1012.53, 18.67, 54.46)
    }
}

Shared.Generators = {
    [1] = {
        currentAttempt = 0,
        maxAttempt = 3,
        busy = false,
        hit = false,
        coords = vector3(994.77, 18.69, 63.46)
    },
    [2] = {
        currentAttempt = 0,
        maxAttempt = 3,
        busy = false,
        hit = false,
        coords = vector3(996.57, 21.52, 63.46)
    },
    [3] = {
        currentAttempt = 0,
        maxAttempt = 3,
        busy = false,
        hit = false,
        coords = vector3(1001.46, 26.72, 63.46)
    },
    [4] = {
        currentAttempt = 0,
        maxAttempt = 3,
        busy = false,
        hit = false,
        coords = vector3(1004.47, 24.82, 63.46)
    }
}

Shared.Magnets = {
    [1] = {
        coords = vector3(984.72, 74.84, 111.28),
        label = "N1",
        animation = vector4(984.65, 75.6, 111.33, 60.91),
        busy = false
    },
    [2] = {
        coords = vector3(992.1, 69.02, 111.28),
        label = "E1",
        animation = vector4(992.5, 69.35, 111.33, 326.32),
        busy = false
    },
    [3] = {
        coords = vector3(987.21, 61.25, 111.28),
        label = "E2",
        animation = vector4(987.71, 61.30, 111.33, 329.96),
        busy = false
    },
    [4] = {
        coords = vector3(984.4, 56.58, 111.28),
        label = "E3",
        animation = vector4(984.65, 56.82, 111.33, 327.57),
        busy = false
    },
    [5] = {
        coords = vector3(978.11, 46.43, 111.28),
        label = "E4",
        animation = vector4(978.22, 46.83, 111.33, 333.9),
        busy = false
    },
    [6] = {
        coords = vector3(963.03, 22.26, 111.28),
        label = "E5",
        animation = vector4(963.13, 22.56, 111.33, 336.69),
        busy = false
    },
    [7] = {
        coords = vector3(952.98, 6.09, 111.28),
        label = "E6",
        animation = vector4(953.19, 6.29, 111.33, 335.48),
        busy = false
    },
    [8] = {
        coords = vector3(940.78, -0.38, 111.28),
        label = "S1",
        animation = vector4(941.04, -0.48, 111.33, 236.09),
        busy = false
    }
}

Shared.Bags = {
    vector4(982.23, 5.017, -8.63, 45.00),
    vector4(987.99, -17.875, -8.63, 45.00),
    vector4(990.027, -0.291, -8.63, 135.00),
    vector4(990.172, 0.929, -8.63, 45.00),
    vector4(1000.198, -3.275, -8.63, 45.00),
    vector4(1000.079, -4.511, -8.63, 135.00)
}

Shared.Lockers = {
    [1] = { -- 1 1 4
        coords = vector3(1012.98, -0.87, -8.55),
        hit = false
    },
    [2] = { -- 1 1 5
        coords = vector3(1013.22, -3.46, -8.55),
        hit = false
    },
    [3] = { -- 1 2 8
        coords = vector3(1011.94, -11.11, -8.55),
        hit = false
    },
    [4] = { -- 1 2 10
        coords = vector3(1009.51, -15.68, -8.55),
        hit = false
    },
    [5] = { -- 2 3 16
        coords = vector3(996.35, -23.85, -8.55),
        hit = false
    },
    [6] = { -- 2 3 17
        coords = vector3(993.83, -24.08, -8.55),
        hit = false
    },
    [7] = { -- 2 4 19
        coords = vector3(988.58, -23.57, -8.55),
        hit = false
    },
    [8] = { -- 2 4 22
        coords = vector3(981.49, -20.45, -8.55),
        hit = true
    },
    [9] = { -- 2 5 25
        coords = vector3(976.17, -14.72, -8.55),
        hit = false
    },
    [10] = { -- 2 5 27
        coords = vector3(974.0, -9.91, -8.55),
        hit = false
    },
    [11] = { -- 2 5 29
        coords = vector3(973.07, -4.57, -8.55),
        hit = false
    },
    [12] = { -- 2 5 30
        coords = vector3(973.2, -2.0, -8.55),
        hit = false
    },
    [13] = { -- 3 6 31
        coords = vector3(973.61, 0.58, -8.55),
        hit = false
    },
    [14] = { -- 3 6 36
        coords = vector3(980.53, 11.52, -8.55),
        hit = false
    },
    [15] = { -- 3 7 38
        coords = vector3(984.94, 14.24, -8.55),
        hit = false
    },
    [16] = { -- 3 7 40
        coords = vector3(989.96, 15.85, -8.55),
        hit = false
    },
    [17] = { -- 3 7 42
        coords = vector3(995.2, 15.98, -8.55),
        hit = false
    }
}