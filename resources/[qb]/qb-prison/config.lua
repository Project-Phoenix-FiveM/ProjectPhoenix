Config = {}

-------------------
-- Debug Configs --
-------------------
Config.Debug = false -- Set to true for server/client prints
Config.DebugPoly = false -- Set to true to debug PolyZones
Config.Crafting = true -- Set to false to disable crafting or if you own qb-prisonjobs

-------------------------
--Extra Config Options --
-------------------------
Config.PrisonMap =  'gabz' -- Set to 'gabz' or 'qb'
Config.RemoveJobs = false -- Set to false if you don't want to remove player's job.

-- If you are using qb-prisonjobs by xThrasherrr#6666 then set this to true
-- https://thrasherrrdev.tebex.io/package/5226873
Config.QB_PrisonJobs = false

-- If Config.QB_PrisonJobs = false, these workout vales will be used
Config.Workout = {
    Cooldown = 20, -- Cooldown between workouts
    Chinup = {
        coords = vector3(1745.91, 2481.26, 45.74),
        time = math.random(10, 20) -- How long to do chinups (set in seconds)
    },
    Yoga = {
        Minigame = {
            circles = 5,
            time = math.random(25, 35)
        },
        time = math.random(10, 20), -- How long to do yoga (set in seconds)
        stress = 5 -- How much stress is removed from doing yoga
    }
}

----------------------
------- Lifers -------
----------------------
-- Add Citizen IDs here
-- Their time will not reduce
Config.Lifers = {
    'YOUR-CID-HERE'
}

----------------------
-- Dispatch Configs --
----------------------

Config.PSDispatch = true -- Set to true for using ps-dispatch
--[[

COMING SOON! - Make PR if you have it :)

Config.CoreDispatch = false -- Set to true for using Core_Dispatch
Config.CDDispatch = false -- Set to true for using cd-dispatch

]]--

--------------------
-- Outifts Config --
--------------------

Config.Outfits = { -- Set their prion outfits when they go to jail
    enabled = true, -- If false, outfits wont change
    male = {
        mask = { item = 0, texture = 0 },
        arms = { item = 4, texture = 0 },
        shirt = { item = 15, texture = 0 },
        jacket = { item = 139, texture = 0 },
        pants = { item = 125, texture = 3 },
        shoes = { item = 18, texture = 0 },
        accessories = { item = 0, texture = 0 },
    },
    female = {
        mask = { item = 0, texture = 0 },
        arms = { item = 4, texture = 0 },
        shirt = { item = 2, texture = 0 },
        jacket = { item = 229, texture = 0 },
        pants = { item = 3, texture = 15 },
        shoes = { item = 72, texture = 0 },
        accessories = { item = 0, texture = 0 },
    },
}

----------------------------------
------ Prison Break Configs ------
----------------------------------

Config.PrisonBreak = {
    Time = math.random(10, 20), -- If success, how long the progressbar takes to open the gate (set in seconds)
    Hack = { -- Enable one of these hacks
        PSVAR = {
            enable = true,
            blocks = 2,
            time = 20
        },
        PSThermite = {
            enable = true,
            time = 20,
            grid = 5,
            incorrect = 3
        },
        Items = {
            [1] = {
                item = 'trojan_usb',
                amount = 1
            },
            [2] = {
                item = 'electronickit',
                amount = 1
            },
        }
    }
}

------------------------------
------ Minigame Configs ------
------------------------------
-- Set one of these minigames enabled to TRUE
Config.SlushyMiniGame = {
    -- PS - UI MINIGAMES --
    PSThermite = {
        enabled = true,
        time = 20,
        grid = 5,
        incorrect = 5
    },
    PSCircle = {
        enabled = true,
        circles = 3,
        time = 15
    },

    -- QB MINIGAMES --
    QBSkillbar = {
        enabled = false,
        duration = math.random(3000, 5000), -- How long the skillbar runs for
        pos = math.random(10, 30), -- How far to the right the static box is
        width = math.random(5, 15), -- How wide the static box is
    },
    QBLock = {
        enabled = false,
        circles = 3,
        time = 15
    },
}

-- Set one of these minigames enabled to TRUE
Config.SodaMiniGame = {
    -- PS - UI MINIGAMES --
    PSThermite = {
        enabled = true,
        time = 20,
        grid = 5,
        incorrect = 5
    },
    PSCircle = {
        enabled = true,
        circles = 3,
        time = 15
    },

    -- QB MINIGAMES --
    QBSkillbar = {
        enabled = false,
        duration = math.random(3000, 5000), -- How long the skillbar runs for
        pos = math.random(10, 30), -- How far to the right the static box is
        width = math.random(5, 15), -- How wide the static box is
    },
    QBLock = {
        enabled = false,
        circles = 3,
        time = 15
    },
}

----------------------
-- Location Configs --
----------------------

Config.CheckTimeLocation = vector3(1827.3, 2587.72, 46.01)
Config.CraftingLocation = vector4(1669.21, 2566.56, 45.56, 270)

-- ONLY USED IF Config.Map = 'gabz'
Config.GabzLockers = {

    -- Cells 1 through 13

    { coords = vector4(1767.07, 2498.49, 45.74, 299.67), }, -- Cell 1
    { coords = vector4(1763.95, 2496.63, 45.74, 299.67), }, -- Cell 2
    { coords = vector4(1760.8, 2494.82, 45.74, 299.67), }, -- Cell 3
    { coords = vector4(1754.55, 2491.2, 45.74, 299.67), }, -- Cell 4
    { coords = vector4(1751.38, 2489.34, 45.74, 299.67), }, -- Cell 5
    { coords = vector4(1748.22, 2487.55, 45.74, 299.67), }, -- Cell 6
    { coords = vector4(1767.07, 2498.49, 49.69, 299.67), }, -- Cell 7
    { coords = vector4(1763.95, 2496.63, 49.69, 299.67), }, -- Cell 8
    { coords = vector4(1760.8, 2494.82, 49.69, 299.67), }, -- Cell 9
    { coords = vector4(1757.66, 2493.0, 49.69, 299.67), }, -- Cell 10
    { coords = vector4(1754.55, 2491.2, 49.69, 299.67), }, -- Cell 11
    { coords = vector4(1751.38, 2489.34, 49.69, 299.67), }, -- Cell 12
    { coords = vector4(1748.22, 2487.55, 49.69, 299.67), }, -- Cell 13

    -- Cells 14 through 27

    { coords = vector4(1758.76, 2474.95, 45.74, 119.67), }, -- Cell 14
    { coords = vector4(1761.95, 2476.74, 45.74, 119.67), }, -- Cell 15
    { coords = vector4(1765.09, 2478.56, 45.74, 119.67), }, -- Cell 16
    { coords = vector4(1768.21, 2480.42, 45.74, 119.67), }, -- Cell 17
    { coords = vector4(1771.38, 2482.2, 45.74, 119.67), }, -- Cell 18
    { coords = vector4(1774.54, 2483.99, 45.74, 119.67), }, -- Cell 19
    { coords = vector4(1777.72, 2485.75, 45.74, 119.67), }, -- Cell 20
    { coords = vector4(1758.76, 2474.95, 49.69, 119.67), }, -- Cell 21
    { coords = vector4(1761.95, 2476.74, 49.69, 119.67), }, -- Cell 22
    { coords = vector4(1765.09, 2478.56, 49.69, 119.67), }, -- Cell 23
    { coords = vector4(1768.21, 2480.42, 49.69, 119.67), }, -- Cell 24
    { coords = vector4(1771.38, 2482.2, 49.69, 119.67), }, -- Cell 25
    { coords = vector4(1774.54, 2483.99, 45.74, 119.67), }, -- Cell 26
    { coords = vector4(1777.72, 2485.75, 49.69, 119.67), }, -- Cell 27

}

-- ONLY USED IF Config.Map = 'qb'
Config.QBLockers = {

    -- Cells 1 through 13

    { coords = vector4(1767.07, 2498.49, 45.74, 299.67), }, -- Cell 1
    { coords = vector4(1763.95, 2496.63, 45.74, 299.67), }, -- Cell 2
    { coords = vector4(1760.8, 2494.82, 45.74, 299.67), }, -- Cell 3
    { coords = vector4(1754.55, 2491.2, 45.74, 299.67), }, -- Cell 4
    { coords = vector4(1751.38, 2489.34, 45.74, 299.67), }, -- Cell 5
    { coords = vector4(1748.22, 2487.55, 45.74, 299.67), }, -- Cell 6
    { coords = vector4(1767.07, 2498.49, 49.69, 299.67), }, -- Cell 7
    { coords = vector4(1763.95, 2496.63, 49.69, 299.67), }, -- Cell 8
    { coords = vector4(1760.8, 2494.82, 49.69, 299.67), }, -- Cell 9
    { coords = vector4(1757.66, 2493.0, 49.69, 299.67), }, -- Cell 10
    { coords = vector4(1754.55, 2491.2, 49.69, 299.67), }, -- Cell 11
    { coords = vector4(1751.38, 2489.34, 49.69, 299.67), }, -- Cell 12
    { coords = vector4(1748.22, 2487.55, 49.69, 299.67), }, -- Cell 13

    -- Cells 14 through 27

    { coords = vector4(1758.76, 2474.95, 45.74, 119.67), }, -- Cell 14
    { coords = vector4(1761.95, 2476.74, 45.74, 119.67), }, -- Cell 15
    { coords = vector4(1765.09, 2478.56, 45.74, 119.67), }, -- Cell 16
    { coords = vector4(1768.21, 2480.42, 45.74, 119.67), }, -- Cell 17
    { coords = vector4(1771.38, 2482.2, 45.74, 119.67), }, -- Cell 18
    { coords = vector4(1774.54, 2483.99, 45.74, 119.67), }, -- Cell 19
    { coords = vector4(1777.72, 2485.75, 45.74, 119.67), }, -- Cell 20
    { coords = vector4(1758.76, 2474.95, 49.69, 119.67), }, -- Cell 21
    { coords = vector4(1761.95, 2476.74, 49.69, 119.67), }, -- Cell 22
    { coords = vector4(1765.09, 2478.56, 49.69, 119.67), }, -- Cell 23
    { coords = vector4(1768.21, 2480.42, 49.69, 119.67), }, -- Cell 24
    { coords = vector4(1771.38, 2482.2, 49.69, 119.67), }, -- Cell 25
    { coords = vector4(1774.54, 2483.99, 45.74, 119.67), }, -- Cell 26
    { coords = vector4(1777.72, 2485.75, 49.69, 119.67), }, -- Cell 27

}

-----------------
-- Job Configs --
-----------------

Config.Jobs = {
    ["electrician"] = "Electrician",
    ["cook"] = "Cook",
    ["janitor"] = "Janitor",
}

Config.PrisonJobs = {
    [1] = {
        name = "electrician",
        label = "Prison Electrician",
    },
    [2] = {
        name = "cook",
        label = "Prison Cook",
    },
    [3] = {
        name = "janitor",
        label = "Prison Janitor",
    },
}

Config.PrisonWage = 10

----------------------------
-- Basic Location Configs --
----------------------------

Config.Locations = {
    jobs = {
        ["electrician"] = {
            [1] = {
                coords = vector4(1761.46, 2540.41, 45.56, 272.249)
            },
            [2] = {
                coords = vector4(1718.54, 2527.802, 45.56, 272.249)
            },
            [3] = {
                coords = vector4(1700.199, 2474.811, 45.56, 272.249)
            },
            [4] = {
                coords = vector4(1664.827, 2501.58, 45.56, 272.249)
            },
            [5] = {
                coords = vector4(1621.622, 2509.302, 45.56, 272.249)
            },
            [6] = {
                coords = vector4(1627.936, 2538.393, 45.56, 272.249)
            },
            [7] = {
                coords = vector4(1625.1, 2575.988, 45.56, 272.249)
            }
        },
        ["cook"] = {
            [1] = {
                coords = vector4(1780.85, 2564.29, 45.67, 4.85)
            },
            [2] = {
                coords = vector4(1777.57, 2561.91, 45.67, 92.91)
            },
            [3] = {
                coords = vector4(1784.56, 2564.17, 45.67, 355.81)
            },
            [4] = {
                coords = vector4(1786.54, 2564.33, 45.67, 356.82)
            },
            [5] = {
                coords = vector4(1780.19, 2560.78, 45.67, 180.96)
            },
        },
        ["janitor"] = {
            [1] = {
                coords = vector4(1758.37, 2566.15, 45.55, 102.74)
            },
            [2] = {
                coords = vector4(1756.89, 2514.18, 45.55, 128.11)
            },
            [3] = {
                coords = vector4(1622.82, 2563.98, 45.56, 33.26)
            },
            [4] = {
                coords = vector4(1683.65, 2565.2, 45.55, 220.94)
            },
            [5] = {
                coords = vector4(1635.25, 2502.33, 45.55, 314.76)
            },
            [6] = {
                coords = vector4(1655.69, 2527.02, 45.55, 325.87)
            },
            [7] = {
                coords = vector4(1689.13, 2517.97, 45.56, 278.94)
            },
        },
    },
    ["freedom"] = {
        coords = vector4(1827.3, 2587.72, 46.01, 91.44)
    },
    ["outside"] = {
        coords = vector4(1848.13, 2586.05, 45.67, 269.5)
    },
    ["yard"] = {
        coords = vector4(1765.67, 2565.91, 45.56, 1.5)
    },
    ["middle"] = {
        coords = vector4(1693.33, 2569.51, 45.55, 123.5)
    },
    ["shop"] = {
        coords = vector4(1786.19, 2557.77, 45.62, 0.5)
    },
    ["work"] = {
        coords = vector4(1828.83, 2580.21, 46.01, 0.5) --coords = vector3(1828.83, 2580.21, 46.01),
    },
    GabzSpawns = { -- ONLY USED IF Config.Map = 'gabz'
        [1] = { -- Cell 1
            animation = "lean3",
            coords = vector4(1768.61, 2501.28, 45.74, 120.24)
        },
        [2] = { -- Cell 2
            animation = "sitchair4",
            coords = vector4(1763.76, 2498.79, 45.74, 302.21)
        },
        [3] = { -- Cell 3
            animation = "cop2",
            coords = vector4(1760.31, 2498.47, 45.74, 211.6)
        },
        [4] = { -- Cell 4
            animation = "pushup",
            coords = vector4(1754.98, 2493.67, 45.74, 211.23)
        },
        [5] = { -- Cell 5
            animation = "finger2",
            coords = vector4(1751.64, 2491.95, 45.74, 206.71)
        },
        [6] = { -- Cell 6
            animation = "bringiton",
            coords = vector4(1748.6, 2489.97, 45.74, 212.25)
        },
        [7] = { -- Cell 7
            animation = "sitchair",
            coords = vector4(1766.99, 2500.5, 49.69, 302.02)
        },
        [8] = { -- Cell 8
            animation = "lean4",
            coords = vector4(1763.47, 2500.56, 49.69, 215.63)
        },
        [9] = { -- Cell 9
            animation = "impatient",
            coords = vector4(1762.5, 2495.82, 49.69, 209.08)
        },
        [10] = { -- Cell 10
            animation = "clown",
            coords = vector4(1758.24, 2495.23, 49.69, 215.26)
        },
        [11] = {-- Cell 11
            animation = "comeatmebro",
            coords = vector4(1755.04, 2493.39, 49.69, 214.06)
        },
        [12] = {-- Cell 12
            animation = "crossarms",
            coords = vector4(1751.68, 2491.84, 49.69, 212.38)
        },
        [13] = {-- Cell 13
            animation = "cutthroat",
            coords = vector4(1748.85, 2489.88, 49.69, 29.52)
        },
        [14] = {-- Cell 14
            animation = "situp",
            coords = vector4(1758.43, 2472.26, 45.74, 212.8)
        },
        [15] = {-- Cell 15
            animation = "damn",
            coords = vector4(1761.64, 2474.12, 45.74, 31.27)
        },
        [16] = {-- Cell 16
            animation = "damn2",
            coords = vector4(1764.61, 2476.1, 45.74, 32.23)
        },
        [17] = {-- Cell 17
            animation = "facepalm4",
            coords = vector4(1766.61, 2477.54, 45.74, 302.08)
        },
        [18] = {-- Cell 18
            animation = "fightme2",
            coords = vector4(1771.02, 2480.06, 45.74, 301.89)
        },
        [19] = {-- Cell 19
            animation = "fightme",
            coords = vector4(1773.61, 2481.45, 45.74, 122.67)
        },
        [20] = {-- Cell 20
            animation = "flex",
            coords = vector4(1777.21, 2483.37, 45.74, 30.68)
        },
        [21] = {-- Cell 21
            animation = "fallasleep",
            coords = vector4(1757.3, 2472.19, 49.69, 303.42)
        },
        [22] = {-- Cell 22
            animation = "flipoff",
            coords = vector4(1761.34, 2474.36, 49.69, 32.06)
        },
        [23] = {-- Cell 23
            animation = "gangsign",
            coords = vector4(1764.59, 2476.51, 49.69, 32.25)
        },
        [24] = {-- Cell 24
            animation = "gangsign2",
            coords = vector4(1767.49, 2478.6, 49.69, 33.47)
        },
        [25] = {-- Cell 25
            animation = "hammer",
            coords = vector4(1771.74, 2478.57, 49.69, 213.39)
        },
        [26] = {-- Cell 26
            animation = "knock",
            coords = vector4(1772.6, 2483.12, 49.69, 31.92)
        },
        [27] = {-- Cell 27
            animation = "knucklecrunch",
            coords = vector4(1777.3, 2483.17, 49.69, 32.5)
        },
        [28] = {-- Training Room
            animation = "chinup",
            coords = vector4(1746.61, 2481.72, 45.74, 120.24)
        },
        [29] = {-- Training Room
            animation = "yoga",
            coords = vector4(1744.93, 2477.94, 45.76, 300.99)
        },
        [30] = {-- Training Room
            animation = "yoga",
            coords = vector4(1744.31, 2479.47, 45.76, 301.23)
        },
        [31] = {-- Break Room
            animation = "sitchair4",
            coords = vector4(1752.54, 2474.74, 45.74, 247.44)
        },
    },
    -- QBCORE LOCATIONS -- ONLY USED IF Config.Map = 'qb'
    QBSpawns = {
        [1] = { -- Cell 1
            animation = "lean3",
            coords = vector4(1768.61, 2501.28, 45.74, 120.24)
        },
        [2] = { -- Cell 2
            animation = "sitchair4",
            coords = vector4(1763.76, 2498.79, 45.74, 302.21)
        },
        [3] = { -- Cell 3
            animation = "cop2",
            coords = vector4(1760.31, 2498.47, 45.74, 211.6)
        },
        [4] = { -- Cell 4
            animation = "pushup",
            coords = vector4(1754.98, 2493.67, 45.74, 211.23)
        },
        [5] = { -- Cell 5
            animation = "finger2",
            coords = vector4(1751.64, 2491.95, 45.74, 206.71)
        },
        [6] = { -- Cell 6
            animation = "bringiton",
            coords = vector4(1748.6, 2489.97, 45.74, 212.25)
        },
        [7] = { -- Cell 7
            animation = "sitchair",
            coords = vector4(1766.99, 2500.5, 49.69, 302.02)
        },
        [8] = { -- Cell 8
            animation = "lean4",
            coords = vector4(1763.47, 2500.56, 49.69, 215.63)
        },
        [9] = { -- Cell 9
            animation = "impatient",
            coords = vector4(1762.5, 2495.82, 49.69, 209.08)
        },
        [10] = { -- Cell 10
            animation = "clown",
            coords = vector4(1758.24, 2495.23, 49.69, 215.26)
        },
        [11] = {-- Cell 11
            animation = "comeatmebro",
            coords = vector4(1755.04, 2493.39, 49.69, 214.06)
        },
        [12] = {-- Cell 12
            animation = "crossarms",
            coords = vector4(1751.68, 2491.84, 49.69, 212.38)
        },
        [13] = {-- Cell 13
            animation = "cutthroat",
            coords = vector4(1748.85, 2489.88, 49.69, 29.52)
        },
        [14] = {-- Cell 14
            animation = "situp",
            coords = vector4(1758.43, 2472.26, 45.74, 212.8)
        },
        [15] = {-- Cell 15
            animation = "damn",
            coords = vector4(1761.64, 2474.12, 45.74, 31.27)
        },
        [16] = {-- Cell 16
            animation = "damn2",
            coords = vector4(1764.61, 2476.1, 45.74, 32.23)
        },
        [17] = {-- Cell 17
            animation = "facepalm4",
            coords = vector4(1766.61, 2477.54, 45.74, 302.08)
        },
        [18] = {-- Cell 18
            animation = "fightme2",
            coords = vector4(1771.02, 2480.06, 45.74, 301.89)
        },
        [19] = {-- Cell 19
            animation = "fightme",
            coords = vector4(1773.61, 2481.45, 45.74, 122.67)
        },
        [20] = {-- Cell 20
            animation = "flex",
            coords = vector4(1777.21, 2483.37, 45.74, 30.68)
        },
        [21] = {-- Cell 21
            animation = "fallasleep",
            coords = vector4(1757.3, 2472.19, 49.69, 303.42)
        },
        [22] = {-- Cell 22
            animation = "flipoff",
            coords = vector4(1761.34, 2474.36, 49.69, 32.06)
        },
        [23] = {-- Cell 23
            animation = "gangsign",
            coords = vector4(1764.59, 2476.51, 49.69, 32.25)
        },
        [24] = {-- Cell 24
            animation = "gangsign2",
            coords = vector4(1767.49, 2478.6, 49.69, 33.47)
        },
        [25] = {-- Cell 25
            animation = "hammer",
            coords = vector4(1771.74, 2478.57, 49.69, 213.39)
        },
        [26] = {-- Cell 26
            animation = "knock",
            coords = vector4(1772.6, 2483.12, 49.69, 31.92)
        },
        [27] = {-- Cell 27
            animation = "knucklecrunch",
            coords = vector4(1777.3, 2483.17, 49.69, 32.5)
        },
        [28] = {-- Training Room
            animation = "chinup",
            coords = vector4(1746.61, 2481.72, 45.74, 120.24)
        },
        [29] = {-- Training Room
            animation = "yoga",
            coords = vector4(1744.93, 2477.94, 45.76, 300.99)
        },
        [30] = {-- Training Room
            animation = "yoga",
            coords = vector4(1744.31, 2479.47, 45.76, 301.23)
        },
        [31] = {-- Break Room
            animation = "sitchair4",
            coords = vector4(1752.54, 2474.74, 45.74, 247.44)
        },
    },
    PrisonBreak = { -- Polyzones for prison break locations
        [1] = {
            coords = vector4(1817.47, 2602.68, 45.6, 0),
            length = 0.5,
            width = 0.5,
        },
        [2] = {
            coords = vector4(1819.49, 2604.7, 45.58, 0),
            length = 0.5,
            width = 0.5,
        },
        [3] = {
            coords = vector4(1846.01, 2604.7, 45.58, 0),
            length = 0.5,
            width = 0.5,
        },
        [4] = {
            coords = vector4(1843.97, 2602.67, 45.6, 0),
            length = 0.5,
            width = 0.5,
        },
        [5] = {
            coords = vector4(1804.78, 2616.29, 45.54, 0),
            length = 0.5,
            width = 0.5,
        },
        [6] = {
            coords = vector4(1804.79, 2617.49, 45.54, 0),
            length = 0.5,
            width = 0.5,
        },
    }
}

---------------------
-- Canteen Configs --
---------------------

Config.CanteenItems = {
    [1] = {
        name = "sandwich",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 1
    },
}

Config.SlushyItems = {
    [1] = {
        name = "slushy",
        price = 35,
        amount = 1,
        info = {},
        type = "item",
        slot = 1
    },
}

Config.SodaItems = {
    [1] = {
        name = "kurkakola",
        price = 35,
        amount = 1,
        info = {},
        type = "item",
        slot = 1
    },
        [2] = {
        name = "water_bottle",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 2
    }
}

Config.CoffeeItems = {
    [1] = {
        name = "coffee",
        price = 35,
        amount = 1,
        info = {},
        type = "item",
        slot = 1
    },
}

----------------------
-- Crafting Configs --
----------------------
-- Chance to receive crafting items
Config.CraftingItemChance = 25 -- 25% Chance to Receive Crafting Item when doing jobs

-- Randomly find these items when doing jobs
Config.JanitorItems = { -- Items found when cleaning
    [1] = { item = 'metalscrap', amount = math.random(1,3) },
    [2] = { item = 'rubber', amount = math.random(2,4) },
    [3] = { item = 'steel', amount = math.random(3,7) },
    [4] = { item = 'plastic', amount = math.random(1,2) },
}

Config.CookItems = { -- Items found when cooking
    [1] = { item = 'metalscrap', amount = math.random(1,3) },
    [2] = { item = 'rubber', amount = math.random(2,4) },
    [3] = { item = 'steel', amount = math.random(3,7) },
    [4] = { item = 'plastic', amount = math.random(1,2) },
}

Config.ElectricianItems = { -- Items found when fixing electrical
    [1] = { item = 'metalscrap', amount = math.random(1,3) },
    [2] = { item = 'rubber', amount = math.random(2,4) },
    [3] = { item = 'steel', amount = math.random(3,7) },
    [4] = { item = 'plastic', amount = math.random(1,2) },
}

-- Crafting Menu
Config.CraftingItems = {

    ----------------------------------------------------------

    -- THIS IS AN EXAMPLE, DO NOT REMOVE:
    -- You can add items to this menu

    -- ["Electronic Kit"] = {           -- Header of Menu
    --     materials = {                -- List Materials Required
    --         [1] = {
    --            item = "electronics",  -- Item Hash Name
    --            amount = 1            -- Item Amount
    --         },
    --         [2] = {
    --             item = "trojan_usb",
    --             amount = 1
    --         },
    --     },
    --     receive = "electronickit"     -- Received Item Hash Name
    -- },

    ----------------------------------------------------------

    [1] = {
        receive = "weapon_shiv",
        materials = {
            [1] = {
                item = "steel",
                amount = 20
            },
            [2] = {
                item = "rubber",
                amount = 20
            },
        },
    },

    [2] = {
        receive = "trojan_usb",
        materials = {
            [1] = {
                item = "steel", 
                amount = 10
            },
            [2] = {
                item = "plastic",
                amount = 15
            },
        },
    },

    [3] = {
        receive = "advancedlockpick",
        materials = {
            [1] = {
                item = "lockpick",
                amount = 1
            },
            [2] = {
                item = "metalscrap",
                amount = 10
            },
            [3] = {
                item = "plastic",
                amount = 15
            },
        },
    },

    [4] = {
        receive = "lockpick",
        materials = {
            [1] = {
                item = "metalscrap",
                amount = 15
            },
        },
    }
}
