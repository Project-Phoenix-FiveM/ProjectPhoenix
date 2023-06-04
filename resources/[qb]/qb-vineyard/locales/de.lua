local Translations = {
    error = {
        ["invalid_job"] = "Ich denke ich Arbeite hier nicht...",
        ["invalid_items"] = "Du hast nicht die korrekten Gegenstände!",
        ["no_items"] = "Du hast keine Gegenstände!",
    },
    progress = {
        ["pick_grapes"] = "Sammle Weintrauben ..",
        ["process_grapes"] = "Verarbeite Weintrauben ..",
    },
    task = {
        ["start_task"] = "[E] zum Starten",
        ["load_ingrediants"] = "[E] Zutaten Laden",
        ["wine_process"] = "[E] Starte den Wein Prozess",
        ["get_wine"] = "[E] Wein Holen",
        ["make_grape_juice"] = "[E] Mache Wein Saft",
        ["countdown"] = "Zeit übrig %{time}",
        ['cancel_task'] = "Du hast deine Aufgabe Abgebrochen"
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
