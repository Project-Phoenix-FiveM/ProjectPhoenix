local Translations = {
    weather = {
        now_frozen = 'Das Wetter ist jetzt eingefroren.',
        now_unfrozen = 'Das Wetter ist nicht mehr eingefroren.',
        invalid_syntax = 'Ungültige Syntax, die richtige Syntax ist: /weather <weathertype> ',
        invalid_syntaxc = 'Ungültige Syntax. Benutze stattdessen /weather <weatherType> !',
        updated = 'Wetter wurde aktualisiert.',
        invalid = 'Ungültiger Wettertyp, gültige Wettertypen sind: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        invalidc = 'Ungültiger Wettertyp, gültige Wettertypen sind: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'Das Wetter wechselt zu: %{value}.',
        accessdenied = 'Zugriff auf den Befehl /weather verweigert.',
    },
    dynamic_weather = {
        disabled = 'Dynamische Wetteränderungen sind nun deaktiviert.',
        enabled = 'Dynamische Wetteränderungen sind jetzt aktiviert.',
    },
    time = {
        frozenc = 'Die Zeit ist jetzt eingefroren.',
        unfrozenc = 'Die Zeit ist nicht mehr eingefroren.',
        now_frozen = 'Die Zeit ist jetzt eingefroren.',
        now_unfrozen = 'Die Zeit ist nicht mehr eingefroren.',
        morning = 'Zeit auf Morgen eingestellt.',
        noon = 'Zeit auf Mittag eingestellt.',
        evening = 'Zeit auf Abend eingestellt.',
        night = 'Zeit auf Nacht eingestellt.',
        change = 'Zeit auf %{value}:%{value2} eingestellt.',
        changec = 'Die Zeit wurde geändert auf: %{value} Uhr!',
        invalid = 'Ungültige Syntax, die richtige Syntax ist: time <hour> <minute> !',
        invalidc = 'Ungültige Syntax. Benutze stattdessen /time <hour> <minute> !',
        access = 'Zugriff auf den Befehl /time verweigert.',
    },
    blackout = {
        enabled = 'Blackout ist jetzt aktiviert.',
        enabledc = 'Blackout ist jetzt aktiviert.',
        disabled = 'Blackout ist jetzt deaktiviert.',
        disabledc = 'Blackout ist jetzt deaktiviert.',
    },
    help = {
        weathercommand = 'Das Wetter ändern.',
        weathertype = 'Wettertyp',
        availableweather = 'Gültige Wettertypen: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Uhrzeit ändern.',
        timehname = 'Stunden',
        timemname = 'Minuten',
        timeh = 'Eine Zahl zwischen 0 - 23',
        timem = 'Eine Zahl zwischen 0 - 59',
        freezecommand = 'Uhrzeit Einfrieren/Auftauen.',
        freezeweathercommand = 'Aktivieren/Deaktivieren der dynamischen Wetteränderungen.',
        morningcommand = 'Uhrzeit auf 09:00 Uhr einstellen',
        nooncommand = 'Uhrzeit auf 12:00 Uhr einstellen',
        eveningcommand = 'Uhrzeit auf 18:00 Uhr einstellen',
        nightcommand = 'Uhrzeit auf 23:00 Uhr einstellen',
        blackoutcommand = 'Blackoutmodus ein- und ausschalten.',
    },
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

