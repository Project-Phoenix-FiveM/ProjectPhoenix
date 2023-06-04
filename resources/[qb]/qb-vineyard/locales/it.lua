local Translations = {
    error = {
        ["invalid_job"] = "Non penso di lavorare qui...",
        ["invalid_items"] = "Non hai gli oggetti corretti!",
        ["no_items"] = "Non hai nessun oggetto!",
    },
    progress = {
        ["pick_grapes"] = "Raccogliendo l'uva ..",
        ["process_grapes"] = "Lavorando l'uva ..",
    },
    task = {
        ["start_task"] = "[E] Per Cominciare",
        ["load_ingrediants"] = "[E] Inserisci Ingredienti",
        ["wine_process"] = "[E] Avvia lavorazione vino",
        ["get_wine"] = "[E] Prendi il vino",
        ["make_grape_juice"] = "[E] Fai succo d'uva",
        ["countdown"] = "Tempo rimasto %{time}s",
        ['cancel_task'] = "Hai cancellato il compito"
    }
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
