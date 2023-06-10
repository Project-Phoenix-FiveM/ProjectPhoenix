-- DISCORD CONFIG IS INSIDE SERVER/FRAMEWORK/_DISCORD.LUA
-- DISCORD CONFIG IS INSIDE SERVER/FRAMEWORK/_DISCORD.LUA
-- DISCORD CONFIG IS INSIDE SERVER/FRAMEWORK/_DISCORD.LUA

Config = {}
Config.Framework = "QBCore" -- QBCore or ESX
Config.DebugCommand = "boosting:debug" -- Debug vehicle list and verify if all models exists in game (run this command if you update the vehicle list to verify the model names)
Config.Admin = "god" -- Permission needed to access CreateContract command
Config.CreateContract = "boosting:contract" -- Command used to create and give contracts to specific players
Config.TargetSystem = "qb-target" -- qb-target or qtarget ... if using ox_target put qtarget and it will automatically convert it
Config.VehicleTable = "player_vehicles" -- "player_vehicles" for QBcore, "owned_vehicles" for ESX
Config.MaxVinVehicles = 3 -- Max vinscratched vehicles a player can own, set false to ignore this limit
Config.CrackerItem = "transponder" -- Used to open vehicles, don't use your current lockpick item
Config.DongleName = "dongle" -- Item used to register your username/photo in laptop app 
Config.TrackerItem = "hacking_device" -- Item used to disable GPS from vehicles
Config.MaxUsernameCharacters = 20 -- Max characters an username can have
Config.RenewUserWithSameDongle = false -- True if you want players be able to use the same dongle to change their username, false means 1 dongle = 1 username
Config.DefaultPicture = "https://i.imgur.com/a86BdrW.png"
Config.CryptoAccount = "gne" -- Crypto used for APP
Config.PoliceJobName = "police" -- Police job name
Config.PoliceRadiusCheck = 25.0 -- Distance check for cops around you
Config.MaxContractsPerPlayer = 4 -- Max contracts a player can own at the same time
Config.QueueTime = 15 -- Every 5 minutes send contracts to random players in queue
Config.HackingCooldown = 10 -- In milliseconds (10 seconds), is the cooldown after using the hack device (police won't receive veh blip during cooldown)
Config.DeliveryBlip = {
    sprite = 225,
    color = 2,
    scale = 0.8
}
Config.MinSpeedHack = 30 -- Min speed needed to start hacking the vehicle (in miles)
Config.MaxSContracts = 5 -- Max S contracts per server restart (for all users)
Config.MaxSPlusContracts = 2 -- Max S+ contracts per server restart (for all users)
Config.GuardModels = {`g_m_importexport_01`, `g_m_m_chicold_01`, `g_m_y_armgoon_02`, `s_m_y_dealer_01`, `s_m_y_robber_01`}
Config.GuardSpawn = {-15,15} -- Distance for guards spawn, -15 mts behind - 15 mts in front of player ped, the guard will spawn inside that range
Config.Classes = {
    ["D"] = {
        ["Prices"] = {normal = {min = 1, max = 2}, vinscratch = {min = 20, max = 30}, payout = 10},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 0,
            ['vin'] = 2,
        },
        ["EXP"] = {driver = {min = 5, max = 10}, hacker = {min = 5, max = 10}},
        ['ContractTime'] = 2,
        ["Hacks"] = false,
        ["NextClass"] = "C",
        ["Guards"] = {min = 1, max = 2},
        ["Weapons"] = {"WEAPON_BAT", "WEAPON_KNUCKLE"}
    },
    ["C"] = {
        ["Prices"] = {normal = {min = 2, max = 4}, vinscratch = {min = 30, max = 40}, payout = 20},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 2,
            ['vin'] = 2,
        },
        ["EXP"] = {driver = {min = 5, max = 10}, hacker = {min = 5, max = 10}},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 1, max = 2},
        ["NextClass"] = "B",
        ["Guards"] = {min = 2, max = 3},
        ["Weapons"] = {"WEAPON_BAT", "WEAPON_CROWBAR"}
    },
    ["B"] = {
        ["Prices"] = {normal = {min = 3, max = 5}, vinscratch = {min = 40, max = 60}, payout = 30},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 2,
            ['vin'] = 2,
        },
        ["EXP"] = {driver = {min = 5, max = 10}, hacker = {min = 5, max = 10}},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 2, max = 3},
        ["NextClass"] = "A",
        ["Guards"] = {min = 2, max = 3},
        ["Weapons"] = {"WEAPON_MACHETE", "WEAPON_BATTLEAXE"}
    },
    ["A"] = {
        ["Prices"] = {normal = {min = 5, max = 8}, vinscratch = {min = 60, max = 80}, payout = 40},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 0,
            ['vin'] = 2,
        },
        ["EXP"] = {driver = {min = 10, max = 20}, hacker = {min = 10, max = 15}},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 3, max = 5},
        ["NextClass"] = "A+",
        ["Guards"] = {min = 3, max = 4},
        ["Weapons"] = {"WEAPON_PISTOL", "WEAPON_SAWNOFFSHOTGUN"}
    },
    ["A+"] = {
        ["Prices"] = {normal = {min = 10, max = 20}, vinscratch = {min = 80, max = 100}, payout = 50},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 2,
            ['vin'] = 2,
        },
        ["EXP"] = {driver = {min = 15, max = 25}, hacker = {min = 10, max = 20}},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 5, max = 7},
        ["NextClass"] = "S",
        ["Guards"] = {min = 3, max = 4},
        ["Weapons"] = {"WEAPON_SAWNOFFSHOTGUN", "WEAPON_PISTOL50"}
    },
    ["S"] = {
        ["Prices"] = {normal = {min = 15, max = 30}, vinscratch = {min = 100, max = 120}, payout = 60},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 2,
            ['vin'] = 2,
        },
        ["EXP"] = {driver = {min = 20, max = 30}, hacker = {min = 10, max = 25}},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 8, max = 10},
        ["NextClass"] = "S+",
        ["Guards"] = {min = 4, max = 5},
        ["Weapons"] = {"WEAPON_MICROSMG", "WEAPON_COMBATPDW", "WEAPON_MINISMG", "WEAPON_COMPACTRIFLE"}
    },
    ["S+"] = {
        ["Prices"] = {normal = {min = 40, max = 50}, vinscratch = {min = 120, max = 150}, payout = 70},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 0,
            ['vin'] = 2,
        },
        ["EXP"] = {driver = {min = 25, max = 40}, hacker = {min = 15, max = 30}},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 10, max = 12},
        ["NextClass"] = "Max",
        ["Guards"] = {min = 4, max = 5},
        ["Weapons"] = {"WEAPON_COMPACTRIFLE", "WEAPON_ASSAULTRIFLE", "WEAPON_ADVANCEDRIFLE"}
    },
}