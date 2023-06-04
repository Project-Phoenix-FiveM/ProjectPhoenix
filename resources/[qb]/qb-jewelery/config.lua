Config = Config or {}

-- Set to true or false or GetConvar('UseTarget', 'false') == 'true' to use global option or script specific
-- These have to be a string thanks to how Convars are returned.
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.Timeout = 30 * (60 * 2000)
Config.RequiredCops = 2
Config.JewelleryLocation = {
    ["coords"] = vector3(-630.5, -237.13, 38.08),
}

Config.WhitelistedWeapons = {
    [`weapon_assaultrifle`] = {
        ["timeOut"] = 10000
    },
    [`weapon_carbinerifle`] = {
        ["timeOut"] = 10000
    },
    [`weapon_pumpshotgun`] = {
        ["timeOut"] = 10000
    },
    [`weapon_sawnoffshotgun`] = {
        ["timeOut"] = 10000
    },
    [`weapon_compactrifle`] = {
        ["timeOut"] = 10000
    },
    [`weapon_microsmg`] = {
        ["timeOut"] = 10000
    },
    [`weapon_autoshotgun`] = {
        ["timeOut"] = 10000
    },
    [`weapon_pistol`] = {
        ["timeOut"] = 10000
    },
    [`weapon_pistol_mk2`] = {
        ["timeOut"] = 10000
    },
    [`weapon_combatpistol`] = {
        ["timeOut"] = 10000
    },
    [`weapon_appistol`] = {
        ["timeOut"] = 10000
    },
    [`weapon_pistol50`] = {
        ["timeOut"] = 10000
    },
}

Config.VitrineRewards = {
    [1] = {
        ["item"] = "rolex",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
    [2] = {
        ["item"] = "diamond_ring",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
    [3] = {
        ["item"] = "goldchain",
        ["amount"] = {
            ["min"] = 1,
            ["max"] = 4
        },
    },
}

Config.Locations = {
    [1] = {
        ["coords"] = vector3(-626.83, -235.35, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [2] = {
        ["coords"] = vector3(-625.81, -234.7, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [3] = {
        ["coords"] = vector3(-626.95, -233.14, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [4] = {
        ["coords"] = vector3(-628.0, -233.86, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [5] = {
        ["coords"] = vector3(-625.7, -237.8, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [6] = {
        ["coords"] = vector3(-626.7, -238.58, 38.05),
      ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [7] = {
        ["coords"] = vector3(-624.55, -231.06, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [8] = {
        ["coords"] = vector3(-623.13, -232.94, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [9] = {
        ["coords"] = vector3(-620.29, -234.44, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [10] = {
        ["coords"] = vector3(-619.15, -233.66, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [11] = {
        ["coords"] = vector3(-620.19, -233.44, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [12] = {
        ["coords"] = vector3(-617.63, -230.58, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [13] = {
        ["coords"] = vector3(-618.33, -229.55, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [14] = {
        ["coords"] = vector3(-619.7, -230.33, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [15] = {
        ["coords"] = vector3(-620.95, -228.6, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [16] = {
        ["coords"] = vector3(-619.79, -227.6, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [17] = {
        ["coords"] = vector3(-620.42, -226.6, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [18] = {
        ["coords"] = vector3(-623.94, -227.18, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [19] = {
        ["coords"] = vector3(-624.91, -227.87, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    },
    [20] = {
        ["coords"] = vector3(-623.94, -228.05, 38.05),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }
}

Config.MaleNoGloves = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true,
}

Config.FemaleNoGloves = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true,
}
