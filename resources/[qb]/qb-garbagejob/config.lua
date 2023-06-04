Config = {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Jobname = 'garbage'
-- Price taken and given back when delivered a truck
Config.TruckPrice = 250

-- Want to give out a cryptostick per stop?
Config.GiveCryptoStick = true

-- Has to roll this number or higher to receive a cryptostick
Config.CryptoStickChance = 75

-- How many stops minimum should the job roll?
Config.MinStops = 5

-- Upper worth per bag
Config.BagUpperWorth = 100

-- Lower worth per bag
Config.BagLowerWorth = 50

-- Minimum bags per stop
Config.MinBagsPerStop = 2

-- Maximum bags per stop
Config.MaxBagsPerStop = 5

-- WIP: Do not use
-- If you want to use custom routes instead of random amount of stops stops set to true
Config.UsePreconfiguredRoutes = false

Config.Peds = {
    {
        model = 's_m_y_garbage',
        coords = vector4(-322.24, -1546.02, 30.02, 294.97),
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0
        }
    }
}

Config.Locations = {
    ["main"] = {
        label = "Garbage Depot",
        coords = vector3(-313.84, -1522.82, 27.56),
    },
    ["vehicle"] = {
        label = "Garbage Truck Storage",
        coords = { -- parking spot locations to spawn garbage
            [1] = vector4(-333.84, -1527.28, 27.28, 1.97),
            [2] = vector4(-327.55, -1527.69, 27.25, 359.43),
        },
    },
    ["paycheck"] = {
        label = "Payslip Collection",
        coords = vector3(-321.45, -1545.86, 31.02),
    },
    ["trashcan"] ={
        [1] = {
            name = "forumdrive",
            coords = vector4(-168.07, -1662.8, 33.31, 137.5),
        },
        [2] = {
            name = "grovestreet",
            coords = vector4(118.06, -1943.96, 20.43, 179.5),
        },
        [3] = {
            name = "jamestownstreet",
            coords = vector4(297.94, -2018.26, 20.49, 119.5),
        },
        [4] = {
            name = "davisave",
            coords = vector4(424.98, -1523.57, 29.28, 120.08),
        },
        [5] = {
            name = "littlebighornavenue",
            coords = vector4(488.49, -1284.1, 29.24, 138.5),
        },
        [6] = {
            name = "vespucciblvd",
            coords = vector4(307.47, -1033.6, 29.03, 46.5),
        },
        [7] = {
            name = "elginavenue",
            coords = vector4(239.19, -681.5, 37.15, 178.5),
        },
        [8] = {
            name = "elginavenue2",
            coords = vector4(543.51, -204.41, 54.16, 199.5),
        },
        [9] = {
            name = "powerstreet",
            coords = vector4(268.72, -25.92, 73.36, 90.5),
        },
        [10] = {
            name = "altastreet",
            coords = vector4(267.03, 276.01, 105.54, 332.5),
        },
        [11] = {
            name = "didiondrive",
            coords = vector4(21.65, 375.44, 112.67, 323.5),
        },
        [12] = {
            name = "miltonroad",
            coords = vector4(-546.9, 286.57, 82.85, 127.5),
        },
        [13] = {
            name = "eastbourneway",
            coords = vector4(-683.23, -169.62, 37.74, 267.5),
        },
        [14] = {
            name = "eastbourneway2",
            coords = vector4(-771.02, -218.06, 37.05, 277.5),
        },
        [15] = {
            name = "industrypassage",
            coords = vector4(-1057.06, -515.45, 35.83, 61.5),
        },
        [16] = {
            name = "boulevarddelperro",
            coords = vector4(-1558.64, -478.22, 35.18, 179.5),
        },
        [17] = {
            name = "sandcastleway",
            coords = vector4(-1350.0, -895.64, 13.36, 17.5),
        },
        [18] = {
            name = "magellanavenue",
            coords = vector4(-1243.73, -1359.72, 3.93, 287.5),
        },
        [19] = {
            name = "palominoavenue",
            coords = vector4(-845.87, -1113.07, 6.91, 253.5),
        },
        [20] = {
            name = "southrockforddrive",
            coords = vector4(-635.21, -1226.45, 11.8, 143.5),
        },
        [21] = {
            name = "southarsenalstreet",
            coords = vector4(-587.74, -1739.13, 22.47, 339.5),
        },
    },
    ["routes"] = { -- Custom routes (WIP Do not use)
        [1] = {7, 6, 5, 15, 10},
        [2] = {11, 18, 7, 8, 15},
        [3] = {1, 7, 8, 17, 18},
        [4] = {16, 17, 4, 8, 21},
        [5] = {8, 2, 6, 17, 19},
        [6] = {3, 19, 1, 8, 11},
        [7] = {8, 19, 9, 6, 14},
        [8] = {14, 12, 20, 9, 11},
        [9] = {9, 18, 3, 6, 20},
        [10] = {9, 13, 7, 17, 16}
    }
}

Config.Vehicle = 'trash2' -- vehicle name used to spawn