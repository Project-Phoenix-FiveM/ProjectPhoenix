local Translations = {
    error = {
        ["failed_notification"] = "Failed!",
        ["not_near_veh"] = "You are not near a vehicle!",
        ["out_range_veh"] = "You are too far from the vehicle!",
        ["inside_veh"] = "You cannot repair a vehicle engine from the inside!",
        ["healthy_veh"] = "Vehicle is too healthy and needs better tools!",
        ["inside_veh_req"] = "You must be in a vehicle to repair it!",
        ["roadside_avail"] = "There is roadside assistance available call that via your phone!",
        ["no_permission"] = "You don't have permission to repair vehicles",
        ["fix_message"] = "%{message}, and now go to a garage!",
        ["veh_damaged"] = "Your vehicle is too damaged!",
        ["nofix_message_1"] = "You looked at your oil level, and this looked normal",
        ["nofix_message_2"] = "You looked at your bike, and nothing seems wrong",
        ["nofix_message_3"] = "You looked at the duck tape on your oil hose and seemed fine",
        ["nofix_message_4"] = "You turned the radio up. The weird engine noise is now gone",
        ["nofix_message_5"] = "The rust remover you used had no effect",
        ["nofix_message_6"] = "Never try to make something that isn't broken, but you didn't listen",
    },
    success = {
        ["cleaned_veh"] = "Vehicle cleaned!",
        ["repaired_veh"] = "Vehicle repaired!",
        ["fix_message_1"] = "You checked the oil level",
        ["fix_message_2"] = "You closed the oil spill with chewing gum",
        ["fix_message_3"] = "You made the oil hose with tape",
        ["fix_message_4"] = "You have temporarily stopped the oil leak",
        ["fix_message_5"] = "You kicked the bike and it works again",
        ["fix_message_6"] = "You removed some rust",
        ["fix_message_7"] = "You yelled at your car, and it works again",
    },
    progress = {
        ["clean_veh"] = "Cleaning the car...",
        ["repair_veh"] = "Repairing vehicle..",

    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
