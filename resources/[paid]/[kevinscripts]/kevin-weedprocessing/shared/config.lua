Config = Config or {}

Config.JobProperties = {
    ['jobneeded'] = false, -- if you want only players with a specific job able to pick the plants
    ['job'] = 'weedpicker', -- name of the job to pick the plants if above is set to true
}

Config.MinimumPolice = 0 -- not used yet
Config.WeedPed = { -- Starting ped to get the house location etc.
    hash = `player_two`, -- this is the trevor ped
    location = vector4(2201.08, 5603.9, 53.62, 262.73),
    scenario = 'WORLD_HUMAN_AA_SMOKE',
}

Config.PlantModels = { -- plant models that you target to pick
    `prop_weed_02`,
    `prop_weed_01`,
    `weed_plant1`,
    `weed_plant2`,
    `weed_plant3`,
    `weed_plant4`,
    `weed_plant5`,
    `weed_plant6`,
}

Config.DryWeedTimer = 3 -- 3 minutes (this timer is for how long it takes before you can collect the dried weed)
Config.WetWeedAmount = math.random(3, 6) -- amount of wet weed you get when harvested plants
Config.WeedBuffs = {
    name = 'luck', -- name of the buff the player needs to be on to get the rest below
    addamounts = false, -- this will add the amount below to the amount given as if the are not on any buffs
    addamount = math.random(10, 14), -- if the addamounts is set to false the amount of leaves given will be selected from this primarily 
}

-- ********* PLEASE DO NOT CHANGE ANYTHING BELOW HERE IN REGARDS TO NAMES OF ITEMS IF YOU GOT NO CLUE WHAT YOU ARE DOING ********* --

Config.WeedBucktItem = 'weed_bucket'
Config.ConeItem = 'weed_cone'
Config.ConePack = {
    ['weed_conepack'] = {
        coneamount = 12,
        coneitem = Config.ConeItem
    }
}

Config.WeedPlantSpawnProperties = {
    locations = {
        [1] = {
            spawn = true, -- if to spawn plants at this location
            showblip = true, -- if set to true it will show a blip for the location of the field
            blipsprite = 140, -- blip that is shown on the map  https://docs.fivem.net/docs/game-references/blips/
            blipcolor = 43, -- color of the blip 
            blipscale = 0.65, -- scale of the weed blip
            blipradius = 43.0, -- how big the radius of the blip is
            blipzoneopacity = 60,-- higher the number the less transparent the blip area is
            blipname = 'Weed Farm', -- name of the blip shown for the location
            radius = 10.0, -- radius the plants spawn withing the coords below
            coords = vector3(2602.87, 6174.08, 170.15), -- location of the plants area
            plant = `weed_plant1`, --name of the plant that spawns
            amount = 10, -- amount of plants that spawn in the area
            replaceamount = 3, -- 3 out of the 10 plants will be the plant model which is above (so out of 10 plants 3 of those will be weed_plant1)
        },
        [2] = {
            spawn = true,
            showblip = true,
            blipsprite = 140,
            blipcolor = 43,
            blipscale = 0.65,
            blipradius = 43.0,
            blipzoneopacity = 60,
            blipname = 'Weed Farm',
            radius = 5.0,
            coords = vector3(2295.08, 2562.27, 46.77),
            plant = `weed_plant2`,
            amount = 15,
            replaceamount = 3,
        },
        [3] = {
            spawn = true,
            showblip = true,
            blipsprite = 140,
            blipcolor = 43,
            blipscale = 0.65,
            blipradius = 43.0,
            blipzoneopacity = 60,
            blipname = 'Weed Farm',
            radius = 10.0,
            coords = vector3(-1991.89, 2585.2, 3.64),
            plant = `weed_plant3`,
            amount = 25,
            replaceamount = 3,
        },
        [4] = {
            spawn = true,
            showblip = true,
            blipsprite = 140,
            blipcolor = 43,
            blipscale = 0.65,
            blipradius = 43.0,
            blipzoneopacity = 60,
            blipname = 'Weed Farm',
            radius = 10.0,
            coords = vector3(-270.04, 5494.19, 176.62),
            plant = `weed_plant4`,
            amount = 30,
            replaceamount = 10,
        },
        [5] = {
            spawn = true,
            showblip = true,
            blipsprite = 140,
            blipcolor = 43,
            blipscale = 0.65,
            blipradius = 43.0,
            blipzoneopacity = 60,
            blipname = 'Weed Farm',
            radius = 10.0,
            coords = vector3(1887.32, -2578.92, 33.59),
            plant = `weed_plant5`,
            amount = 20,
            replaceamount = 7,
        },
        [6] = {
            spawn = true,
            showblip = true,
            blipsprite = 140,
            blipcolor = 43,
            blipscale = 0.65,
            blipradius = 43.0,
            blipzoneopacity = 60,
            blipname = 'Weed Farm',
            radius = 10.0,
            coords = vector3(3102.4, 1137.78, 16.06),
            plant = `weed_plant6`,
            amount = 30,
            replaceamount = 7,
        },
    },
}

Config.WeedBucketDrying = {
    ['weed_bucket'] = {
        items = {
            ['ak_47_plant'] = { -- obviously again the nugget items
                minamount = 10, -- minimum amount of plant needed to dry
                maxamount = 70, -- maximum amount of plant needed to dry
                buditemname = 'ak_47_bud' -- name of the bud item to give from weedbuckets
            },
            ['blue_dream_plant'] = {
                minamount = 10,
                maxamount = 70,
                buditemname = 'blue_dream_bud'
            },
            ['og_kush_plant'] = {
                minamount = 10,
                maxamount = 70,
                buditemname = 'og_kush_bud'
            },
            ['pineapple_express_plant'] = {
                minamount = 10,
                maxamount = 70,
                buditemname = 'pineapple_express_bud'
            },
            ['purple_haze_plant'] = { 
                minamount = 10,
                maxamount = 70,
                buditemname = 'purple_haze_bud'
            },
            ['weed_plant'] = { 
                minamount = 10,
                maxamount = 70,
                buditemname = 'weed_plant_bud'
            },
            ['white_widow_plant'] = { 
                minamount = 10,
                maxamount = 70,
                buditemname = 'white_widow_bud'
            },
        }
    }
}

Config.UseableBudItems = { -- made each have their own value just in case you want different amount based on the strains
    ['ak_47_bud'] = {
        useprogressbar = false, -- if to use a progressbar when breaking down the buds to nuggets
        removeamount = 2, -- amount of bud item need to give the nugget item
        nuggetgiveamount = 5, -- amount of nugget item to give after breaking down
        nuggetitemname = 'ak_47_nugget' -- nugget item to give after breaking down
    },
    ['blue_dream_bud'] = {
        useprogressbar = false,
        removeamount = 2,
        nuggetgiveamount = 5,
        nuggetitemname = 'blue_dream_nugget'
    },
    ['og_kush_bud'] = {
        useprogressbar = false,
        removeamount = 2,
        nuggetgiveamount = 5,
        nuggetitemname = 'og_kush_nugget'
    },
    ['pineapple_express_bud'] = {
        useprogressbar = false,
        removeamount = 2,
        nuggetgiveamount = 5,
        nuggetitemname = 'pineapple_express_nugget'
    },
    ['purple_haze_bud'] = {
        useprogressbar = false,
        removeamount = 2,
        nuggetgiveamount = 5,
        nuggetitemname = 'purple_haze_nugget'
    },
    ['white_widow_bud'] = {
        useprogressbar = false,
        removeamount = 2,
        nuggetgiveamount = 5,
        nuggetitemname = 'white_widow_nugget'
    },
    ['weed_plant_bud'] = {
        useprogressbar = false,
        removeamount = 2,
        nuggetgiveamount = 5,
        nuggetitemname = 'weed_nugget'
    },
}

Config.UseableNuggetItems = { -- made each have their own value just in case you want different amount based on the strains
    ['ak_47_nugget'] = {
        useprogressbar = false, -- if to use a progressbar when packing weed cones
        nuggetamount = 5, -- amount of nuggets needed to pack a weed cone for a joint
        jointitemname = 'ak_47_joint' -- joint item to give after putting nuggets in cone
    },
    ['blue_dream_nugget'] = {
        useprogressbar = false,
        nuggetamount = 5,
        jointitemname = 'blue_dream_joint'
    },
    ['og_kush_nugget'] = {
        useprogressbar = false,
        nuggetamount = 5,
        jointitemname = 'og_kush_joint'
    },
    ['pineapple_express_nugget'] = {
        useprogressbar = false,
        nuggetamount = 5,
        jointitemname = 'pineapple_express_joint'
    },
    ['purple_haze_nugget'] = {
        useprogressbar = false,
        nuggetamount = 5,
        jointitemname = 'purple_haze_joint'
    },
    ['white_widow_nugget'] = {
        useprogressbar = false,
        nuggetamount = 5,
        jointitemname = 'white_widow_joint'
    },
    ['weed_nugget'] = {
        useprogressbar = false,
        nuggetamount = 5,
        jointitemname = 'weed_joint'
    },
}

Config.UseableEmptyJar = { -- PS. If player does not have the amount it will not be showed on the menu when the jar is used 
    ['emptyweed_jar'] = { -- empty jar name obviously :)
        items = {
            ['ak_47_nugget'] = { -- obviously again the nugget items
                minamount = 10, -- minimum amount of nuggets needed to bottle
                maxamount = 70, -- maximum amount of nuggets needed to bottle
            },
            ['blue_dream_nugget'] = {
                minamount = 10,
                maxamount = 30,
            },
            ['og_kush_nugget'] = {
                minamount = 10,
                maxamount = 30,
            },
            ['pineapple_express_nugget'] = {
                minamount = 10,
                maxamount = 40,
            },
            ['purple_haze_nugget'] = {
                minamount = 10,
                maxamount = 35,
            },
            ['white_widow_nugget'] = {
                minamount = 10,
                maxamount = 20,
            },
            ['weed_nugget'] = {
                minamount = 10,
                maxamount = 60,
            },
        },
    }
}



-- Process with useable items --

-- weed plant = hand it to the trevor ped to dry once dried, you get a notification along with a blip on the map

-- weedbucket = this is how you get the buds after you collect the bucket from trevor ped

-- empty weedjar = brings up a menu where you would be able to see all the nuggets once you have them on you have have the right amount

-- weedjar = this just give the weed that was packed into the empty jar in the first place

-- all bud items = this is how you change the dried bud to the nugget form of that specific weed

-- conepack = this gives the weed cone to be able to make joints

-- all nuggets = once player has the weedcones they are able to make joints

-- 

-- All joints were made useable in the other resource linked in the readme kevin-buffconsumables