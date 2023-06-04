local Translations = {
    error = {
        process_canceled = "Process Canceled",
        plant_has_died = "The plant has died. Press ~r~ E ~w~ to remove plant.",
        cant_place_here = "Can't Place Here",
        not_safe_here = "It's Not Safe Here, try your house",
        not_need_nutrition = "The Plant Does Not Need Nutrition",
        this_plant_no_longer_exists = "This plant no longer exists?",
        house_not_found = "House Not Found",
        you_dont_have_enough_resealable_bags = "You Don't Have Enough Resealable Bags",
    },
    text = {
        sort = 'Sort:',
        harvest_plant = 'Press ~g~ E ~w~ to harvest plant.',
        nutrition = "Nutrition:",
        health = "Health:",
        harvesting_plant = "Harvesting Plant",
        planting = "Planting",
        feeding_plant = "Feeding Plant",
        the_plant_has_been_harvested = "The plant has been harvested",
        removing_the_plant = "Removing The Plant",
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
