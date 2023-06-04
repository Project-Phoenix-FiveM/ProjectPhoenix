local Translations = {
    info = {
        open_shop = "[E] Abrir Loja",
        sell_chips = "[E] Vender Fichas"
    },
    error = {
        dealer_decline = "O Vendedor recusou mostrar o armeiro",
        talk_cop = "Fala com um agente para obteres o porte de arma"
    },
    success = {
        dealer_verify = "O vendedor está a verificar a tua licença"
    },
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
