local Translations = {
    error = {
        ["invalid_job"] = "I dont think I work here...",
        ["invalid_items"] = "You do not have the correct items!",
        ["no_items"] = "You do not have any items!",
    },
    progress = {
        ["pick_grapes"] = "Picking Grapes ..",
        ["process_grapes"] = "Processing Grapes ..",
    },
    task = {
        ["start_task"] = "[E] To Start",
        ["load_ingrediants"] = "[E] Load Ingredients",
        ["wine_process"] = "[E] Start WineProcess",
        ["get_wine"] = "[E] Get Wine",
        ["make_grape_juice"] = "[E] Make Grape Juice",
        ["countdown"] = "Time Remaining %{time}s",
        ['cancel_task'] = "You have cancelled the task"
    },
    text = {
        ["start_shift"] = "You have started your shift at the vineyard!",
        ["end_shift"] = "Your shift at the vineyard has ended!",
        ["valid_zone"] = "Valid Zone!",
        ["invalid_zone"] = "Invalid Zone!",
        ["zone_entered"] = "%{zone} Zone Entered",
        ["zone_exited"] = "%{zone} Zone Exited",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
