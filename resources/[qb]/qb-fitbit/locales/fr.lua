local Translations = {
    success = {
        hunger_set = 'Fitbit: Alerte de faim fixée à %{hungervalue}%',
        thirst_set = 'Fitbit: Alerte de soif fixée à %{thirstvalue}%',
    },
    warning = {
        hunger_warning = 'Votre faim est %{hunger}%',
        thirst_warning = 'Votre soif est %{thirst}%'
    },
    info = {
        fitbit = 'FITBIT '
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang
    })
end
