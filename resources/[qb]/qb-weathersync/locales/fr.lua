local Translations = {
    weather = {
        now_frozen = 'La météo est figée',
        now_unfrozen = "La météo n'es plus figé",
        invalid_syntax = 'Mauvaise syntaxe, la syntaxe correcte est : /weather <type de météo> ',
        invalid_syntaxc = 'Erreur : Mauvaise syntaxe, utiliser /weather <type de météo> à la place !',
        updated = 'La météo a été mise à jour',
        invalid = 'Type de météo invalide, les types de météo valides sont : \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        invalidc = 'Erreur : Type de météo invalide, les types de météo valides sont : \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'La météo vas changer à : %{value}.',
        accessdenied = 'Accès à la commande /weather refusée.',
    },
    dynamic_weather = {
        disabled = 'Changement dynamique de la météo désactiver',
        enabled = 'Changement dynamique de la météo activé',
    },
    time = {
        frozenc = 'Le temps est maintenant figé.',
        unfrozenc = "Le temps n'es plus figé",
        now_frozen = 'Le temps est maintenant figé ',
        now_unfrozen = "Le temps n'es plus figé",
        morning = 'Le temps a été mis au matin',
        noon = 'Le temps a été mis au midi',
        evening = "Le temps a été mis a l'après-midi",
        night = 'Le temps a été mis au soir',
        change = 'Le temps a été changé à %{value}:%{value2}.',
        changec = 'Le temps a été changé à : %{value} !',
        invalid = 'Mauvaise syntaxe, la syntaxe correcte est : time <heure> <minute> !',
        invalidc = 'Erreur : Mauvaise syntaxe. Utiliser /time <heure> <minute> à la place!',
        access = 'Accès pour la commande /time refusé.',
    },
    blackout = {
        enabled = 'Coupure électrique activée.',
        enabledc = 'Coupure électrique activée.',
        disabled = 'Coupure électrique désactivée.',
        disabledc = 'Coupure électrique désactivée.',
    },
    help = {
        weathercommand = 'Changer la météo.',
        weathertype = 'Types de météo',
        availableweather = 'Types de météo possible : extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Changer le temps.',
        timehname = 'heures',
        timemname = 'minutes',
        timeh = 'Un nombre entre 0 - 23',
        timem = 'Un nombre entre 0 - 59',
        freezecommand = 'gèle / dégèle le temps.',
        freezeweathercommand = 'Active/désactive le changement de temps dynamique.',
        morningcommand = 'Met le temps à 09:00',
        nooncommand = 'Met le temps à 12:00',
        eveningcommand = 'Met le temps à 18:00',
        nightcommand = 'Met le temps à 23:00',
        blackoutcommand = 'Active la coupure électrique',
    },
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
