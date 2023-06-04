local Translations = {
    ui = {
        last_location = "Última ubicación",
        confirm = "Confirmar",
        where_would_you_like_to_start = "¿Por dónde te gustaría empezar?",
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end