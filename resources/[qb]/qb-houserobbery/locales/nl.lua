local Translations = {
    error = {
        ["missing_something"] = "Het lijkt erop dat je iets mist...",
        ["not_enough_police"] = "Niet genoeg politie..",
        ["door_open"] = "De deur is al open..",
        ["process_cancelled"] = "Proces geannuleerd..",
        ["didnt_work"] = "Het is niet gelukt..",
        ["emty_box"] = "De doos is leeg..",
    },
    success = {
        ["worked"] = "Het is gelukt!",
    }
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
