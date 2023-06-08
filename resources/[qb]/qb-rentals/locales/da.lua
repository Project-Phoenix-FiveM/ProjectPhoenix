local Translations = {
    info = {
        ["air_veh"] = "Fly Udlejning!",
        ["land_veh"] = "Bil Udlejning!",
        ["sea_veh"] = "Båd Udlejning!",
    },
    error = {
        ["not_enough_space"] = "%{vehicle} er i vejen!",
        ["not_enough_money"] = "Du har ikke nok Penge!",
        ["no_vehicle"] = "Intet køretøj til returnering"
    },
    task = {
        ["return_veh"] = "Giv køretøjet tilbage!",
        ['veh_returned'] = 'Køretøj returneret!'
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
