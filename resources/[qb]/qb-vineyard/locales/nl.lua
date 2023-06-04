local Translations = {
    error = {
        ["invalid_job"] = "Ik denk niet dat ik hier werk...",
        ["invalid_items"] = "Je hebt niet de juiste items!",
        ["no_items"] = "Je hebt geen items!",
    },
    progress = {
        ["pick_grapes"] = "Druiven plukken ..",
        ["process_grapes"] = "Druiven Verwerken ..",
    },
    task = {
        ["start_task"] = "[E] Beginnen",
        ["load_ingrediants"] = "[E] Ingrediënten laden",
        ["wine_process"] = "[E] Wijnproces Starten",
        ["get_wine"] = "[E] Pak Wijn",
        ["make_grape_juice"] = "[E] Druivensap maken",
        ["countdown"] = "Resterende tijd %{time}s",
        ['cancel_task'] = "Je hebt de taak geannuleerd"
    },
    text = {
        ["start_shift"] = "Je bent begonnen met je dienst in de wijngaard!",
        ["end_shift"] = "Je dienst bij de wijngaard zit erop!",
        ["valid_zone"] = "Geldige Zone!",
        ["invalid_zone"] = "Ongeldige Zone!",
        ["zone_entered"] = "%{zone} Zone Ingelopen",
        ["zone_exited"] = "%{zone} Zone Verlaten",
    }
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
