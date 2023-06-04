local Translations = {
    info = {
        open_shop = "[E] Butik",
        sell_chips = "[E] Sell Chips"
    },
    error = {
        dealer_decline = "Forhandleren nægter at vise dig våbene",
        talk_cop = "Snak med politiet for at få en våben licens"
    },
    success = {
        dealer_verify = "Forhandleren bekræfter din licens"
    },
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
