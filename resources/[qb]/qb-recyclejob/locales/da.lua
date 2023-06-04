local Translations = {
    success = {
        you_have_been_clocked_in = "Du er logget ind",
    },
    text = {
        point_enter_warehouse = "[E] Gå ind i lageret",
        enter_warehouse= "Gå ind i lageret",
        exit_warehouse= "Gå ud af lageret",
        point_exit_warehouse = "[E] Gå ud af lageret",
        clock_out = "[E] Log ind",
        clock_in = "[E] Log ud",
        hand_in_package = "Indlever pakke",
        point_hand_in_package = "[E] Indlever pakke",
        get_package = "Modtag pakke",
        point_get_package = "[E] Modtage pakke",
        picking_up_the_package = "Afhentning af pakken",
        unpacking_the_package = "Udpakning af pakken",
    },
    error = {
        you_have_clocked_out = "Du er logget ud"
    },
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
