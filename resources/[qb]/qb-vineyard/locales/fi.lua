local Translations = {
    error = {
        ["invalid_job"] = "Et taida olla töissä täällä...",
        ["invalid_items"] = "Sinulla ei ole oikeita esineitä!",
        ["no_items"] = "Sinulla ei ole esineitä!",
    },
    progress = {
        ["pick_grapes"] = "Kerätään rypäleitä ..",
        ["process_grapes"] = "Prosessoidaan rypäleitä ..",
    },
    task = {
        ["start_task"] = "Paina [E] aloittaaksesi",
        ["load_ingrediants"] = "[E] Lastaa ainesosat",
        ["wine_process"] = "[E] Aloita viininteko",
        ["get_wine"] = "[E] Tee viiniä",
        ["make_grape_juice"] = "[E] Tee rypälemehua",
        ["countdown"] = "Aikaa jäljellä %{time}s",
        ['cancel_task'] = "Olet peruuttanut tehtävän!"
    }
}

if GetConvar('qb_locale', 'en') == 'fi' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
