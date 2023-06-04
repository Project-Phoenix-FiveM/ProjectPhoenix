Config = {}

Config.Debug = false         -- Set to true for debug mode (shows client/server tables in console)

Config.GKSPhone = false      -- Set to true if using gks phone, false for qb-phone

Config.LockOnFlag = true    -- Set to true to lock front plate reader on flagged status
Config.NotifDuration = 6000  -- Time until scan notification disappears (default = 6sec)
Config.OxTarget = true      -- Set True if using ox-target, false will use qb-target

--TODO: Change to new vehicles.
Config.AllowedVehicles = {
    [1] = {model = "nkbuffalos", label = 'Bravado Buffalo S'},
    [2] = {model = 'nkscout', label = 'Vapid Scout'},
    [3] = {model = 'nkcoquette', label = 'Invetero Coquette'},
    [4] = {model = 'nkcruiser', label = 'Vapid Stainer'},
    [5] = {model = 'nktorrence', label = 'Vapid Torrence'}
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