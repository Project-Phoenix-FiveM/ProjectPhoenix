Config = Config or {}

Config.Timeout = 60 * (60 * 1000)
Config.DoorLock = 'qb' -- use 'qb' for qb-doorlock events
Config.DoorId = 'jewelery' -- name of the door in your doorlock config
Config.RequiredCops = 0
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
        ["coords"] = vector4(-626.06, -234.19, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [2] = {
        ["coords"] = vector4(-626.58, -233.47, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [3] = {
        ["coords"] = vector4(-625.4, -238.3, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [4] = {
        ["coords"] = vector4(-626.46, -239.02, 39.24, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [5] = {
        ["coords"] = vector4(-627.59, -234.26, 38.97, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [6] = {
        ["coords"] = vector4(-627.13, -234.79, 38.86, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [7] = {
        ["coords"] = vector4(-624.25, -226.71, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [8] = {
        ["coords"] = vector4(-625.2, -227.32, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [9] = {
        ["coords"] = vector4(-623.72, -228.68, 39.24, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [10] = {
        ["coords"] = vector4(-623.96, -230.76, 39.22, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [11] = {
        ["coords"] = vector4(-621.4, -228.77, 39.22, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [12] = {
        ["coords"] = vector4(-619.25, -227.31, 39.24, 310.89),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [13] = {
        ["coords"] = vector4(-620.02, -226.36, 39.22, 304),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [14] = {
        ["coords"] = vector4(-617.86, -229.26, 39.22, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [15] = {
        ["coords"] = vector4(-617.14, -230.28, 39.24, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [16] = {
        ["coords"] = vector4(-620.09, -230.63, 39.22, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [17] = {
        ["coords"] = vector4(-620.46, -232.87, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [18] = {
        ["coords"] = vector4(-622.62, -232.63, 39.22, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [19] = {
        ["coords"] = vector4(-618.9, -234.17, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [20] = {
        ["coords"] = vector4(-619.93, -234.85, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }
}

Config.MaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true,
}

Config.FemaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true,
}
