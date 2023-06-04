local Translations = {
    error = {
        ["missing_something"] = "Det verkar som att du saknar något...",
        ["not_enough_police"] = "Inte tillräckligt med poliser..",
        ["door_open"] = "Dörren är redan öppen..",
        ["process_cancelled"] = "Process avbruten..",
        ["didnt_work"] = "Det fungerade inte..",
        ["emty_box"] = "Lådan är tom..",
    },
    success = {
        ["worked"] = "Det fungerade!",
    }
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
