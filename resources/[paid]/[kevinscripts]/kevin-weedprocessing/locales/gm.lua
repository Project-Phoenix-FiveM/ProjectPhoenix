local Translations = {
    success = {
        dried_ready = 'Getrocknete Pflanzen zum Abholen bereit',
        watered = 'Pflanze bewässert',
        fertilized = 'Pflanze gedüngt',
    },
    blip = {
        dried_blip = 'Getrocknete Cannabispflanzen',
    },
    progressbar = {
        handing = 'Pflanzen übergeben',
        plants_drying = 'Pflanzen trocknen, Sie werden benachrichtigt, wenn sie fertig sind',
        reaping = 'Ernten',
        cleaning = 'Buds säubern',
        planting = 'Samen einpflanzen...',
        packing_cone = 'Cone verpacken',
        removing = 'Zerstören...',
        watering = 'Gießen...',
        fertilizing = 'Düngen...',
        refilling = 'Nachfüllen',
    },
    warning = {
        insufficentnuggets = 'Du hast nicht genügend Nuggets',
        no_cones = 'Du hast keine Cones',
        empty_jar = 'Glas ist leer?',
        empty_bucket = 'Eimer ist leer?',
        bottle_exceed = 'Du kannst nicht soviele reinstecken!',
        insufficentamount = 'Du besitzt diese Anzahl nicht',
        unselected = 'Du besitzt nicht die richtigen Items dafür',
        soil_unsuitable = 'Die Erde sieht nicht besonders gut aus zum einpflanzen',
        no_water = 'Du hast keine Wasserkanne dabei',
        no_food = 'Du hast kein Dünger dabei',
        can_empty = 'Die Dose sieht leer aus',
        not_inwater = 'Du bist nicht im Wasser',
        can_full = 'Die Dose scheint voll zu sein',
    },
    target = {
        dry_weed = 'Trockne Weed',
        collect_bucket = 'Eimer abholen',
        check = 'Checken',
        harvest = 'Pflanze ernten',
        water = 'Gießen',
        fertilize = 'Düngern',
        destroy = 'Zerstören',
        burn = 'Verbrenne Pflanze'
    },
    status = {
        dead = 'Tod',
        alive = 'Lebendig',
    },
    input = {
        select_plant = 'Wähle Pflanze aus',
        select_nugget = 'Wähle Nugget aus',
        item = 'Item',
        dry_amount = 'Menge',
        bottle_amount = 'Menge',
        max = ' (Max: %{maxamount})',
    },
    menu = {
        plant = 'Pflanze: %{seedname}',
        status = 'Status: %{status}',
        stage = 'Level: %{stage} ',
        health = 'Gesundheit: %{health}',
        food = 'Nährstoffe: %{food}',
        water = 'Wasser: %{water}',
        progress = 'Fortschritt: %{progress}',
    },
    cancel = {
        cancelled = 'Abgebrochen'
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})