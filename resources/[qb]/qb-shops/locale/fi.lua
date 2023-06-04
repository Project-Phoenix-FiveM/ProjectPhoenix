local Translations = {
    info = {
        open_shop = "[E] Kauppa",
        sell_chips = "[E] Myy casino pelimerkkejä"
    },
    error = {
        dealer_decline = "Myyjä kieltäytyy näyttämästä sinulle aseita",
        talk_cop = "Pyydä poliisilta aselupaa."
    },
    success = {
        dealer_verify = "Myyjä tarkisti aselupasi"
    },
}

if GetConvar('qb_locale', 'en') == 'fi' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
