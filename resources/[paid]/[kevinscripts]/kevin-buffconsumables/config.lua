Config = Config or {}
-- IF EMOTES DO NOT PLAY EVEN WITH IT BEING IN RPEMOTES, IN RPEMOTES CONFIG BE SURE THAT 'FRAMEWORK' IS SET TO 'Framework = 'qb-core',' by default it is   Framework = false,

-- Buffs are default found in ps-buffs unless you have your own custom buffs
Config.BuffItems = {
    ['coffee'] = { -- used for sanitation job https://kevin-scripts.tebex.io/package/5516125
        type = 'drink', -- drink / eat / both
        metadata = math.random(20, 50), -- amount of thirst/ hunger gets applied to player stats this goes with the type set above
        animation = 'coffee',
        useprogbar = false, -- if to use progress bar or not
        movement = false, -- only applicable when using progress bar
        carmovement = true, -- only applicable when using progress bar
        mouse = false, -- only applicable when using progress bar
        combat = true, -- only applicable when using progress bar
        progbarlabel = 'Drinking', -- only applicable when using progress bar
        progbartime = 5000, -- only applicable when using progress bar
        bufftime = 3, -- buff will be applied for 3 minutes
        buffname = 'luck', -- default buff for ps-buffs
    },
    ['ak_47_joint'] = {
        type = 'eat',
        metadata = math.random(-20 ,-10), -- amount of thirst/ hunger gets applied to player stats
        animation = 'smoke3',
        useprogbar = false, -- if to use progress bar or not
        movement = false, -- only applicable when using progress bar
        carmovement = true, -- only applicable when using progress bar
        mouse = false, -- only applicable when using progress bar
        combat = true, -- only applicable when using progress bar
        progbarlabel = 'Smoking Joint', -- only applicable when using progress bar
        progbartime = 5000, -- only applicable when using progress bar
        bufftime = 3, -- buff will be applied for 3 minutes
        buffname = 'super-stress', -- default buff for ps-buffs
    },
    ['blue_dream_joint'] = { 
        type = 'eat',
        metadata = math.random(-20 ,-10), -- amount of thirst/ hunger gets applied to player stats
        animation = 'smoke3',
        useprogbar = false, -- if to use progress bar or not
        movement = false, -- only applicable when using progress bar
        carmovement = true, -- only applicable when using progress bar
        mouse = false, -- only applicable when using progress bar
        combat = true, -- only applicable when using progress bar
        progbarlabel = 'Smoking Joint', -- only applicable when using progress bar
        progbartime = 5000, -- only applicable when using progress bar
        bufftime = 3, -- buff will be applied for 3 minutes
        buffname = 'super-armor', -- default buff for ps-buffs
    },
    ['og_kush_joint'] = {
        type = 'eat',
        metadata = math.random(-20 ,-10), -- amount of thirst/ hunger gets applied to player stats
        animation = 'smoke3',
        useprogbar = false, -- if to use progress bar or not
        movement = false, -- only applicable when using progress bar
        carmovement = true, -- only applicable when using progress bar
        mouse = false, -- only applicable when using progress bar
        combat = true, -- only applicable when using progress bar
        progbarlabel = 'Smoking Joint', -- only applicable when using progress bar
        progbartime = 5000, -- only applicable when using progress bar
        bufftime = 3, -- buff will be applied for 3 minutes
        buffname = 'strength', -- default buff for ps-buffs
    },
    ['pineapple_express_joint'] = {
        type = 'eat',
        metadata = math.random(-20 ,-10), -- amount of thirst/ hunger gets applied to player stats
        animation = 'smoke3',
        useprogbar = false, -- if to use progress bar or not
        movement = false, -- only applicable when using progress bar
        carmovement = true, -- only applicable when using progress bar
        mouse = false, -- only applicable when using progress bar
        combat = true, -- only applicable when using progress bar
        progbarlabel = 'Smoking Joint', -- only applicable when using progress bar
        progbartime = 5000, -- only applicable when using progress bar
        bufftime = 3, -- buff will be applied for 3 minutes
        buffname = 'hacking', -- default buff for ps-buffs
    },
    ['purple_haze_joint'] = {
        type = 'eat',
        metadata = math.random(50, 70), -- amount of thirst/ hunger gets applied to player stats
        animation = 'smoke3',
        useprogbar = false, -- if to use progress bar or not
        movement = false, -- only applicable when using progress bar
        carmovement = true, -- only applicable when using progress bar
        mouse = false, -- only applicable when using progress bar
        combat = true, -- only applicable when using progress bar
        progbarlabel = 'Smoking Joint', -- only applicable when using progress bar
        progbartime = 5000, -- only applicable when using progress bar
        bufftime = 3, -- buff will be applied for 3 minutes
        buffname = 'super-hunger', -- default buff for ps-buffs
    },
    ['white_widow_joint'] = {
        type = 'drink',
        metadata = math.random(-20 ,-10), -- amount of thirst/ hunger gets applied to player stats
        animation = 'smoke3',
        useprogbar = false, -- if to use progress bar or not
        movement = false, -- only applicable when using progress bar
        carmovement = true, -- only applicable when using progress bar
        mouse = false, -- only applicable when using progress bar
        combat = true, -- only applicable when using progress bar
        progbarlabel = 'Smoking Joint', -- only applicable when using progress bar
        progbartime = 5000, -- only applicable when using progress bar
        bufftime = 3, -- buff will be applied for 3 minutes
        buffname = 'super-health', -- default buff for ps-buffs
    },
    ['weed_joint'] = {
        type = 'eat',
        metadata = math.random(-20 ,-10), -- amount of thirst/ hunger gets applied to player stats
        animation = 'smoke3',
        useprogbar = false, -- if to use progress bar or not
        movement = false, -- only applicable when using progress bar
        carmovement = true, -- only applicable when using progress bar
        mouse = false, -- only applicable when using progress bar
        combat = true, -- only applicable when using progress bar
        progbarlabel = 'Smoking Joint', -- only applicable when using progress bar
        progbartime = 10000, -- only applicable when using progress bar
        bufftime = 1, -- buff will be applied for 3 minutes
        buffname = 'super-hunger', -- default buff for ps-buffs
    },
}