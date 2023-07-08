local Translations = {
    success = {
        dried_ready = 'Dried Plants ready to collect',
        watered = 'Plant watered.',
        fertilized = 'Plant fertilized.',
    },
    blip = {
        dried_blip = 'Dried weed plants',
    },
    progressbar = {
        handing = 'Handing Plants',
        plants_drying = 'Plants drying, will notify when ready.',
        reaping = 'Reaping crop',
        cleaning = 'Cleaning Buds',
        planting = 'Planting Seed...',
        packing_cone = 'Packing Cone',
        removing = 'Removing...',
        watering = 'Watering...',
        fertilizing = 'Fertilizing...',
        refilling = 'Refilling',
    },
    warning = {
        insufficentnuggets = 'You don\'t have enough nuggets..',
        no_cones = 'You don\'t have any cones',
        empty_jar = 'Jar is somehow empty?',
        empty_bucket = 'Bucket is somehow empty?',
        bottle_exceed = 'You can\'t bottle this many..',
        insufficentamount = 'You don\'t have this many',
        unselected = 'You dont have enough of what i need, Get more..',
        soil_unsuitable = 'The soil doesn\'t look good to plant..',
        no_water = 'You don\'t have any water source..',
        no_food = 'You don\'t have any fertilizer..',
        can_empty = 'Can looks empty',
        not_inwater = 'You are not in water',
        can_full = 'Can appears to be full',
    },
    target = {
        dry_weed = 'Dry Weed',
        collect_bucket = 'Collect Bucket',
        check = 'Check',
        harvest = 'Harvest Plant',
        water = 'Water Plant',
        fertilize = 'Fertilize Plant',
        destroy = 'Destroy Plant',
        burn = 'Burn Plant',
    },
    status = {
        dead = 'Dead',
        alive = 'Alive',
    },
    input = {
        select_plant = 'Select plant to be dried',
        select_nugget = 'Select nugget to bottle',
        item = 'Item',
        dry_amount = 'Amount to dry',
        bottle_amount = 'Amount to bottle',
        max = ' (Max: %{maxamount})',
    },
    menu = {
        plant = 'Plant : %{seedname}',
        status = 'Plant Status: %{status}',
        stage = 'Plant Stage: %{stage} ',
        health = 'Plant Health: %{health}',
        food = 'Plant Food: %{food}',
        water = 'Plant Water: %{water}',
        progress = 'Plant Progress: %{progress}',
    },
    cancel = {
        cancelled = 'Cancelled'
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})