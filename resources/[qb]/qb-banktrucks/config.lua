Config = Config or {}

Config.Dispatch = 'ps-dispatch'  -- ps-dispatch / cd-dispatch  (type of dispatch you use)

---Thermite Minigame for lester Computer
Config.Blocks = "6" -- Number of correct blocks the player needs to click
Config.Attempts = "3" -- Number of incorrect blocks after which the game will fail
Config.Show = "5" -- Time in secs for which the right blocks will be shown
Config.Time = "45" -- Maximum time after timetoshow expires for player to select the right blocks
---

---Thermite Minigame for bank truck
Config.Blocks2 = "8" -- Number of correct blocks the player needs to click
Config.Attempts2 = "4" -- Number of incorrect blocks after which the game will fail
Config.Show2 = "6" -- Time in secs for which the right blocks will be shown
Config.Time2 = "40" -- Maximum time after timetoshow expires for player to select the right blocks
---

Config.CoolDown = 600 * 1000 --- Cooldown until can start next job default is 10 minutes you can use this link too get a better understanding of the time to change if you like http://convertwizard.com/600000-milliseconds-to-minutes

Config.SecurityPed = "s_m_m_armoured_02"

Config.Timer = 180 * 1000 -- Timer till the truck opens up and the guards come out (default is 3 minutes)

-- Convoy Rewards
Config.MinReward = 7 -- Minimum amount of the item you recieve
Config.MaxReward = 9 -- Maximum amount of the item you recieve
Config.MinPayout = 10000 -- Minimum Payout of the item
Config.MaxPayout = 20000 -- Maximum Payout of the item
Config.Reward = "markedbills" -- Reward you get when finished looting the truck
Config.RareItem = "usb_green" -- Change to whatever item you want the rare item to get is
Config.RareItemAmt = "1" -- Amount of the rare item you want to be given
-- End of Convoy Rewards

-- Delivery Rewards (Default same as convoy rewards, can change if you want one paying out more or differently than the other)
Config.DeliveryMinReward = 5 -- Minimum amount of the item you recieve
Config.DeliveryMaxReward = 8 -- Maximum amount of the item you recieve
Config.DeliveryMinPayout = 10000 -- Minimum Payout of the item
Config.DeliveryMaxPayout = 20000 -- Maximum Payout of the item
Config.DeliveryReward = "markedbills" -- Reward you get when finished looting the truck
Config.DeliveryRareItem = "security_card_02" -- Change to whatever item you want the rare item to get is
Config.DeliveryRareItemAmt = "2" -- Amount of the rare item you want to be given
-- End of Delivery Rewards

Config.PedLocations = {
    vector3(454.8, -2191.15, 5.92),
    vector3(-1336.55, -1164.09, 4.54),
    vector3(815.79, -492.8, 30.55),
    vector3(-389.64, -454.55, 30.94),
    vector3(-910.66, 156.39, 63.33),
    vector3(-1698.7, -272.61, 51.88),
    vector3(-1607.59, -1048.69, 6.02)
}

Config.Locations = {
    vector3(-1254.59, -860.8, 12.35),
    vector3(1208.85, 2710.62, 38.01),
    vector3(140.46, 6351.8, 31.34),
    vector3(-2940.26, 489.59, 15.25),
    vector3(2579.24, 425.47, 108.46),
    vector3(970.88, -72.83, 75.19),
    vector3(-160.54, -162.81, 43.62),
    vector3(1247.0718994141, -344.65634155273, 69.08),
    vector3(798.18426513672, -1799.8173828125, 29.33),
    vector3(-1327.479736328, -86.045326232910, 49.31),
    vector3(-2075.888183593, -233.73908996580, 21.10),
    vector3(-972.1781616210, -1530.9045410150, 4.890),
}
-----------------------------------------------------------

--- START OF DELIVERY SIDE
Config.GpsTimer = 180 * 1000 -- 3 minutes till you get a gps location to delivery the truck

Config.DeliverTruckLocations = {-- where truck spawns add as many coords as you like
    vector4(-1318.02, -591.91, 28.35, 305.08),
    vector4(306.95, 364.92, 104.87, 249.48),
    vector4(1034.76, -142.68, 73.8, 313.86)
}

Config.RandomDropLocation = { -- where delivery locations are, add as many as you like
    vector4(-2170.1, 4276.49, 48.57, 329.47),
    vector4(572.97, 2797.41, 42.05, 193.96),
    vector4(1263.14, -2564.7, 42.77, 117.85),
    vector4(1140.87, -2018.12, 31.02, 358.93)
}

Config.JobsList = {
    [1] = {
        bank = true,
        Header = "Bank Truck Delivery",
        icon = "fas fa-truck-moving",
        busyicon = "fas fa-xmark",
        event = "qb-banktrucks:client:StartDelivery",
        minCops = 2,--- Amount of cops to do the delivery
    },
    [2] = {
        bank = true,
        Header = "Bank Truck Convoy",
        icon = "fas fa-truck-moving",
        busyicon = "fas fa-xmark",
        event = "qb-banktrucks:client:GotAccess",
        minCops = 2,
    },
}

--- Guards that spawn from the back
Config.GuardsHealth = 500
Config.GuardArmor = 300
Config.GuardWeapon = `WEAPON_SMG`
Config.GuardAccuracy = 90
--