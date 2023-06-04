local Translations = {
    error = {
        ["missing_something"] = "Il semble qu'il te manque quelque chose...",
        ["not_enough_police"] = "Pas assez de policiers..",
        ["door_open"] = "La porte est déjà ouverte..",
        ["process_cancelled"] = "Processus annulé..",
        ["didnt_work"] = "Cela n'a pas fonctionné..",
        ["emty_box"] = "La boîte est vide..",
    },
    success = {
        ["worked"] = "Ça a marché!",
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
