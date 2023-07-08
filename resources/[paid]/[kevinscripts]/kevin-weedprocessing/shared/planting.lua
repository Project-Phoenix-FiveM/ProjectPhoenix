Planting = {}
--
--
--
--
Planting.PoliceJobs = { -- list of police jobs that can burn the weed plants (PS burning is the same as destrying difference just being there is fire for one as a little immersion for police officers)
    'police',
    'bcso',
    'lapd',
}
Planting.WaterCanUses = 30
Planting.MaleSeedChance = 45 -- 45% chance to get male seed when harvesting playergrown plants
Planting.LocalMaleSeedChance = 30 -- 30% chance to get male seed when harvesting local plants 
Planting.SeedChance = 30 -- 30% chance to get a seed from harvesting local plants
Planting.SeedAmount = math.random(1, 3) -- amount of seeds given when harvesting plants (local and playergrown)
Planting.Quality = 100 -- something to separate player grown plants from local
Planting.LocalQuality = math.random(30, 65)
Planting.WaterCanItem = 'water_can'
Planting.FertilizerItem = 'weed_fertilizer'
Planting.FemalePlantChance = 45 -- 45% chance the plant would be a female plant
Planting.WaterAmount = 90 -- only when the plant is below this amount would you get the option to water plant
Planting.FoodAmount = 90 -- only when the plant is below this amount would you get the option to fertilize plant
Planting.HarvestWaterFoodAmount = 80 -- this amount is checked when harvesting the plants once the plant is not dead and is harvestable.
-- If the plant is not dead and is harvestable but the food and water is under this amount the option to harvest would not show until it is equal to or above the amount

-- 
-- Times are in minutes
Planting.GrowthRefreshTime = 10 --(minutes) time till the plant progress / stage is updated
Planting.FoodWaterRefreshTime = 4 --(minutes) time till the food and water gets updated
-- 
-- 
Planting.Colors = { --this is the progressbar colors on the menu can change to whatever color to match your hud or whatever you like https://mantine.dev/theming/colors/#default-colors
    health = '#F03E3E',
    food = '#FD7E14',
    water = '#228BE6',
    progress = '#51CF66',
}

-- 
-- AVOID MAKES CHANGES IN HERE IF YOU HAVE NO IDEA WHAT YOU ARE DOING.
Planting.Plants = {
    ['ak_47_seed'] = {
        label = 'AK 47',
        stage = {
            stage_a = 'bkr_prop_weed_bud_01b', -- stages for the plant props
            stage_b = 'bkr_prop_weed_bud_02b',
            stage_c = 'prop_weed_02',
            stage_d = 'weed_plant3',
        }
    },
    ['blue_dream_seed'] = {
        label = 'BlueDream',
        stage = {
            stage_a = 'bkr_prop_weed_bud_01b',
            stage_b = 'bkr_prop_weed_bud_02b',
            stage_c = 'prop_weed_02',
            stage_d = 'weed_plant2',
        }
    },
    ['og_kush_seed'] = {
        label = 'Og Kush',
        stage = {
            stage_a = 'bkr_prop_weed_bud_01b',
            stage_b = 'bkr_prop_weed_bud_02b',
            stage_c = 'prop_weed_02',
            stage_d = 'weed_plant1',
        }
    },
    ['pineapple_express_seed'] = {
        label = 'Pineapple Express',
        stage = {
            stage_a = 'bkr_prop_weed_bud_01b',
            stage_b = 'bkr_prop_weed_bud_02b',
            stage_c = 'prop_weed_02',
            stage_d = 'weed_plant4',
        }
    },
    ['purple_haze_seed'] = {
        label = 'Purple Haze',
        stage = {
            stage_a = 'bkr_prop_weed_bud_01b',
            stage_b = 'bkr_prop_weed_bud_02b',
            stage_c = 'prop_weed_02',
            stage_d = 'weed_plant5',
        }
    },
    ['white_widow_seed'] = {
        label = 'White Widow',
        stage = {
            stage_a = 'bkr_prop_weed_bud_01b',
            stage_b = 'bkr_prop_weed_bud_02b',
            stage_c = 'prop_weed_02',
            stage_d = 'weed_plant6',
        }
    },
    ['weed_seed'] = {
        label = 'Weed',
        stage = {
            stage_a = 'bkr_prop_weed_bud_01b',
            stage_b = 'bkr_prop_weed_bud_02b',
            stage_c = 'prop_weed_02',
            stage_d = 'prop_weed_01',
        }
    },
}

Planting.GroundHashes = { --types of ground hashes the number after is the amount that would be added to the plants progress to increase
    [2409420175]    = 1,
    [951832588]     = 1,
    [3008270349]    = 1,
    [3833216577]    = 1,
    [223086562]     = 1,
    [1333033863]    = 1,
    [4170197704]    = 1,
    [3594309083]    = 1,
    [2461440131]    = 1,
    [1109728704]    = 1,
    [2352068586]    = 1,
    [1144315879]    = 1,
    [581794674]     = 1,
    [2128369009]    = 1,
    [-461750719]    = 1,
    [-1286696947]   = 1,
}