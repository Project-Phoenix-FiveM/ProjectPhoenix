local Translations = {
    error = {
        ["invalid_job"] = "Jag tror inte att du jobbar här...",
        ["invalid_items"] = "Du har inte rätt prylar!",
        ["no_items"] = "Du har inga prylar!",
    },
    progress = {
        ["pick_grapes"] = "Plockar vindruvor..",
        ["process_grapes"] = "Proccesserar vindruvor..",
    },
    task = {
        ["start_task"] = "[E] För att starta",
        ["load_ingrediants"] = "[E] Blanda i ingredienser",
        ["wine_process"] = "[E] Starta jäsningsprocessen",
        ["get_wine"] = "[E] Ta vinet",
        ["make_grape_juice"] = "[E] Göra druvjuice",
        ["countdown"] = "Tid kvar: %{time}s",
        ['cancel_task'] = "Du avbröt en uppgift"
    }
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
