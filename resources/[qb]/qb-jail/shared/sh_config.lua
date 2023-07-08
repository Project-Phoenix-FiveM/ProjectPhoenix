Config = Config or {}

--- QBCore Framework related settings
Config.Inventory            = 'exports' -- 'exports' for using qb-inventory exports or 'player' for using Player object functions
Config.Phone                = 'QBCore' -- 'This script supports standard QBCore, GKS Phone, options: (QBCore/GKS)'

--- Script related settings
Config.Debug                = false  -- Enables or disables extra console prints to the scripts
Config.AntiHelicopter       = true -- Enable or disable the guards that will shoot players if they enter prison with a helicopter to pick up someone
Config.JailBreakCops        = 2     -- Amount of cops on duty required to start a jailbreak
Config.JailBreakDuration    = 60    -- time in minutes that players have to comlete the jailbreak before breaking someone out is impossible
Config.BlipCoords           = vector3(1746.81, 2519.49, 45.57)          -- Bolingbroke Penitentiary blip location
Config.ReceptionPedCoords   = vector4(1840.35, 2577.71, 46.01, 358.01)  -- ped location for reception interaction
Config.BMXCoords            = vector4(1633.97, 2606.15, 44.56, 245.67)  -- ped location to grab BMX
Config.SpawnBMX             = vector3(1634.73, 2610.02, 44.56)          -- spawn location of BMX
Config.GardeningPed         = vector4(1694.98, 2541.10, 44.56, 324.13)  -- ped location for farming supplies
Config.InfirmaryPed         = vector4(1769.91, 2571.81, 45.73, 130.19)  -- ped location for infirmary
Config.SlushieSpoonChance   = 12    -- %Chance to receive a spoon after drinking a slushie
Config.KitchenRewardAmount  = 3     -- Amount that a player receives of a random item when doing kitchen jobs, chance per task is in kitchenTasks in sv_jobs
Config.CleaningTaskAmount   = 14    -- Amount of cleaning tasks that are generated per iteration, can't be higher than amount of objects in cleaningSetup (33)
Config.ScrapRewardAmount    = 1     -- Amount that a player receives of a random item when doing scrapyard jobs
Config.ScrapRewardChance    = 14    -- %Chance to receive an item when doing a scrapyard job
Config.FarmingLoopInterval  = 4     -- Minutes for the farming loop to increase growth and health based on water and nutrition
Config.FarmingHarvestAmount = 5     -- Amount of prisonfruit a player gets from harvesting a farming patch

Config.ReduceReward = { -- %Chance to reduce the jail sentence after completing a task; Amount of minutes to reduce the jail time with
    gardening   = { chance = 28,    amount = 5 },
    running     = { chance = 24,    amount = 3 },
    scrapyard   = { chance = 14,    amount = 1 },
    cleaning    = { chance = 14,    amount = 7 },
    workout     = { chance = 10,    amount = 3 },
    kitchen     = { chance = 14,    amount = 3 },
    electrical  = { chance = 14,    amount = 5 },
    lockup      = { chance = 0,     amount = 0 }
}

--- Economy
Config.CraftingCost = {
    [1] = {
        item = 'lockpick',
        header = 'Lockpick Set',
        amount = 1,
        duration = 5000,
        durationLabel = 'Short',
        items = {
            [1] = {
                item = 'rubber',
                amount = 7
            },
            [2] = {
                item = 'metalscrap',
                amount = 5
            },
            [3] = {
                item = 'aluminum',
                amount = 2
            }
        }
    },
    [2] = {
        item = 'prisonwine',
        header = 'Pruno',
        amount = 1,
        duration = 12000,
        durationLabel = 'Medium',
        items = {
            [1] = {
                item = 'prisonfruit',
                amount = 5
            },
            [2] = {
                item = 'prisonsugar',
                amount = 8
            },
            [3] = {
                item = 'prisonbag',
                amount = 1
            },
            [4] = {
                item = 'prisonslushie',
                amount = 3
            },
            [5] = {
                item = 'prisonjuice',
                amount = 3
            }
        }
    },
    [3] = {
        item = 'prisonmeth',
        header = 'Crank',
        amount = 3,
        duration = 24000,
        durationLabel = 'Long',
        items = {
            [1] = {
                item = 'prisonchemicals',
                amount = 5
            },
            [2] = {
                item = 'prisonbag',
                amount = 1
            },
            [3] = {
                item = 'prisonfarmnutrition',
                amount = 3
            }
        }
    },
    [4] = {
        item = 'weapon_knife',
        header = 'Knife',
        amount = 1,
        duration = 36000,
        durationLabel = 'Long',
        items = {
            [1] = {
                item = 'prisonspoon',
                amount = 1
            },
            [2] = {
                item = 'prisonrock',
                amount = 2
            }
        }
    }
}

Config.PrisonerPedShop = {
    [1] = {
        item = 'weapon_molotov',
        header = "Molotov",
        text = "This should get a nice riot started.",
        cost = {item = "prisonmeth", amount = 24}
    },
    [2] = {
        item = 'weapon_pistol',
        header = 'Pistol',
        text = "So you can defend yourself in here",
        cost = {item = "prisonmeth", amount = 34}
    },
    [3] = {
        item = 'pistol_ammo',
        header = 'Pistol Clip.',
        text = "In case you cannot get the job done with one clip.",
        cost = {item = "prisonwine", amount = 14}
    },
    [4] = {
        item = 'phone',
        header = 'Phone',
        text = "To make contact with the outside",
        cost = {item = "prisonspoon", amount = 3}
    }
}

--- Coordinates for teleportation
Config.Locations = {
    ['exit']        = vector4(1836.98, 2591.12, 45.01, 180.00),
    ['mugshot']     = vector4(1844.60, 2594.35, 45.01, 90.00),
    ['services']    = vector3(1828.70, 2580.17, 46.01),
    ['cells'] = { -- You don't really want to this these here
        [1]     = vector4(1768.10, 2500.25, 44.74, 210.00),
        [2]     = vector4(1764.64, 2498.91, 44.74, 210.00),
        [3]     = vector4(1761.20, 2497.47, 44.74, 210.00),
        [4]     = vector4(1755.07, 2493.48, 44.74, 210.00),
        [5]     = vector4(1751.99, 2491.72, 44.74, 210.00),
        [6]     = vector4(1748.81, 2489.95, 44.74, 210.00),
        [7]     = vector4(1767.85, 2500.76, 48.69, 210.00),
        [8]     = vector4(1764.67, 2498.97, 48.69, 210.00),
        [9]     = vector4(1761.25, 2497.09, 48.69, 210.00),
        [10]    = vector4(1758.30, 2495.28, 48.69, 210.00),
        [11]    = vector4(1755.10, 2493.63, 48.69, 210.00),
        [12]    = vector4(1751.97, 2491.73, 48.69, 210.00),
        [13]    = vector4(1748.70, 2489.80, 48.69, 210.00),
        [14]    = vector4(1758.42, 2472.79, 44.74, 30.00),
        [15]    = vector4(1761.44, 2474.73, 44.74, 30.00),
        [16]    = vector4(1764.50, 2476.30, 44.74, 30.00),
        [17]    = vector4(1767.75, 2478.51, 44.74, 30.00),
        [18]    = vector4(1770.54, 2480.31, 44.74, 30.00),
        [19]    = vector4(1774.19, 2481.78, 44.74, 30.00),
        [20]    = vector4(1777.28, 2483.62, 44.74, 30.00),
        [21]    = vector4(1758.13, 2473.03, 48.69, 30.00),
        [22]    = vector4(1761.51, 2474.30, 48.69, 30.00),
        [23]    = vector4(1764.71, 2476.23, 48.69, 30.00),
        [24]    = vector4(1767.61, 2478.39, 48.69, 30.00),
        [25]    = vector4(1770.74, 2480.02, 48.69, 30.00),
        [26]    = vector4(1774.03, 2481.64, 48.69, 30.00),
        [27]    = vector4(1777.12, 2483.52, 48.69, 30.00)
    },
}

Config.Electrical = { -- You don't really want to touch anything here, unless you want to add extra entries (Coords), completed changes dynamically during the script)
    [1] = { coords = vector4(1664.85, 2502.00, 46.00, 0.00),    completed = false },
    [2] = { coords = vector4(1761.52, 2540.80, 46.00, 0.00),    completed = false },
    [3] = { coords = vector4(1718.10, 2527.70, 46.00, 115.00),  completed = false },
    [4] = { coords = vector4(1627.94, 2538.80, 46.00, 0.00),    completed = false },
    [5] = { coords = vector4(1608.04, 2540.13, 45.56, 135.00),  completed = false },
    [6] = { coords = vector4(1652.60, 2564.60, 45.56, 0.00),    completed = false },
    [7] = { coords = vector4(1735.52, 2504.34, 45.56, 165.00),  completed = false },
    [8] = { coords = vector4(1677.74, 2480.77, 45.56, 135.00),  completed = false }
}

--- Prison break related states, these change dynamically during the script
Config.JailBreak = {
    PowerplantHit = false,
    JailBreakActive = false,
    Thermite = {
        [1] = { vector4(1846.73, 2571.49, 45.77, 90.00), vector3(1846.78, 2572.49, 45.67), 'jail-gate1', false },
        [2] = { vector4(1791.95, 2612.11, 45.67, 90.00), vector3(1791.98, 2613.11, 45.57), 'jail-gate3', false },
        [3] = { vector4(1761.14, 2517.25, 45.67, 255.0), vector3(1761.10, 2518.27, 45.57), 'jail-door5', false },
    },
    VARHack = false
}

--- Settings for the difficulty of the minigames
Config.Minigames = {
    ThermiteSettings = {
        correctBlocks = 1, -- correctBlocks = Number of correct blocks the player needs to click
        incorrectBlocks = 4, -- incorrectBlocks = number of incorrect blocks after which the game will fail
        timetoShow = 5, -- timetoShow = time in secs for which the right blocks will be shown
        timetoLose = 24 -- timetoLose = maximum time after timetoshow expires for player to select the right blocks
    },
    VarSettings = {
        varBlocks = 2, -- Amount of blocks displayed during the VAR Hack minigame
    }
}

--- Doc
Config.Armory = {
    label = "Police Armory",
    slots = 6,
    items = {
        [1] = {
            name = "weapon_stungun",
            price = 250,
            amount = 1,
            info = {
                serie = "",            
            },
            type = "weapon",
            slot = 1,
        },      
        [2] = {
            name = "weapon_nightstick",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 2
        },
        [3] = {
            name = "weapon_flashlight",
            price = 75,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 3
        },
        [4] = {
            name = "handcuffs",
            price = 25,
            amount = 1,
            info = {},
            type = "item",
            slot = 4
        },
        [5] = {
            name = "radio",
            price = 34,
            amount = 1,
            info = {},
            type = "item",
            slot = 5
        },
        [6] = {
            name = "bandage",
            price = 25,
            amount = 100,
            info = {},
            type = "item",
            slot = 6
        },
    }
}

Config.PrisonOutfit = {
    Enable = true,
    Outfits = {
        ['male'] = {
            outfitData = {
                ['t-shirt'] = { item = 15, texture = 0 },
                ['torso2']  = { item = 345, texture = 0 },
                ['arms']    = { item = 19, texture = 0 },
                ['pants']   = { item = 3, texture = 7 },
                ['shoes']   = { item = 1, texture = 0 },
            }
        },
        ['female'] = {
             outfitData = {
                ['t-shirt'] = { item = 14, texture = 0 },
                ['torso2']  = { item = 370, texture = 0 },
                ['arms']    = { item = 0, texture = 0 },
                ['pants']   = { item = 0, texture = 12 },
                ['shoes']   = { item = 1, texture = 0 },
             }
        }
    }
}