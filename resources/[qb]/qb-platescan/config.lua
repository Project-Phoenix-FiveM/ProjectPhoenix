Config = {}

Config.Debug = false         -- Set to true for debug mode (shows client/server tables in console)

Config.GKSPhone = false      -- Set to true if using gks phone, false for qb-phone

Config.LockOnFlag = true    -- Set to true to lock front plate reader on flagged status
Config.NotifDuration = 6000  -- Time until scan notification disappears (default = 6sec)
Config.OxTarget = true      -- Set True if using ox-target, false will use qb-target

Config.AllowedVehicles = {
    [1] = {model = "pd1", label = 'Ford Crown Victoria'},
    [2] = {model = 'mach1rb', label = 'Ford Mustang 2021'},
    [3] = {model = 'char', label = 'Dodge Charger 2018'},
    [4] = {model = 'poldemonrb', label = 'Demon'},
    [5] = {model = 'zr1rb', label = 'Corvette'}
}

Config.GTAVSounds = {        -- Frontend sounds from GTAV (https://wiki.gtanet.work/index.php?title=FrontEndSoundlist)
    good = {
        name = "5_Second_Timer",
        ref = "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS",
    },
    bad = {
        name = "Event_Message_Purple",
        ref = "GTAO_FM_Events_Soundset",
    },
}