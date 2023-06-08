local Translations = {
    info = {
        ["air_veh"] = "Aircraft Rentals",
        ["land_veh"] = "Vehicle Rentals",
        ["sea_veh"] = "Boat Rentals",
    },
    error = {
        ["not_enough_space"] = "%{vehicle} is in the way!",
        ["not_enough_money"] = "You do not have enough money!",
        ["no_vehicle"] = "No vehicle to return!",
        ["no_driver_license"] = "You do not have a driver license!",
        ["no_pilot_license"] = "You do not have a pilot license!"
    },
    task = {
        ["return_veh"] = "Return your rented vehicle.",
        ['veh_returned'] = 'Vehicle Returned!'
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})