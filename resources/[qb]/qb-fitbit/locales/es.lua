local Translations = {
    success = {
        hunger_set = 'Fitbit: Alerta de hambre al %{hungervalue}%',
        thirst_set = 'Fitbit: Alerta de sed al %{thirstvalue}%',
    },
    warning = {
        hunger_warning = 'Nivel de hambre %{hunger}%',
        thirst_warning = 'Nivel de sed %{thirst}%'
    },
    info = {
        fitbit = 'FITBIT '
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
