local Translations = {
    error = {
        ["missing_something"] = "Det verkar som att du saknar något...",
        ["not_enough_police"] = "Inte tillräckligt med poliser..",
        ["door_open"] = "Dörren är redan öppen..",
        ["cancelled"] = "Avbrutet..",
        ["didnt_work"] = "Det fungerade inte..",
        ["emty_box"] = "Lådan är tom..",
        ["injail"] = "Ditt straff är %{Time} månader..",
        ["item_missing"] = "Du saknar ett objekt..",
        ["escaped"] = "Du rymde... Stick nu för fan!",
        ["do_some_work"] = "Arbeta lite för att redusera straffet, snabbjobb: %{currentjob} ",
    },
    success = {
        ["found_phone"] = "Du hittade en telefon..",
        ["time_cut"] = "Du förkortade ditt straff lite genom att arbeta.",
        ["free_"] = "Du är fri! Njut! 🙂",
        ["timesup"] = "Tiden är ute! Du kan checka ut dig själv vid besökscentret",
    },
    info = {
        ["timeleft"] = "Du måste fortfarande... %{JAILTIME} månader",
        ["lost_job"] = "Du är arbetslös",
    }
}
Lang = Locale:new({
phrases = Translations,
warnOnMissing = true})
