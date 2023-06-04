local Translations = {
    error = {
        ["missing_something"] = "Näyttää siltä että sinulta puuttuu jotain...",
        ["not_enough_police"] = "Ei tarpeaksi poliiseita..",
        ["door_open"] = "Tämä ovi on jo avattu..",
        ["process_cancelled"] = "Peruttu..",
        ["didnt_work"] = "Eipä toiminut..",
        ["emty_box"] = "The Box Is Empty..",
    },
    success = {
        ["worked"] = "Se toimi!",
    }
}

if GetConvar('qb_locale', 'en') == 'fi' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
