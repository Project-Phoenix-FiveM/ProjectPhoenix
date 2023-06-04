local Translations = {
    weather = {
        now_frozen = 'Weer is bevroren.',
        now_unfrozen = 'Weer is niet langer bevroren.',
        invalid_syntax = 'Ongeldige commando, correcte commando is: /weather <weertype> ',
        invalid_syntaxc = 'Ongeldige commando, gebruik /weather <weertype> !',
        updated = 'Het weer is bijgewerkt.',
        invalid = 'Ongeldig weertype, geldige weertypes zijn: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        invalidc = 'Ongeldig weertype, geldige weertypes zijn: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'Het weer verandert in: %{value}.',
        accessdenied = 'Toegang voor commando /weather geweigerd.',
    },
    dynamic_weather = {
        disabled = 'Dynamische weersveranderingen zijn nu uitgeschakeld.',
        enabled = 'Dynamische weersveranderingen zijn nu ingeschakeld.',
    },
    time = {
        frozenc = 'De tijd is bevroren.',
        unfrozenc = 'De tijd is niet langer bevroren.',
        now_frozen = 'De tijd is bevroren.',
        now_unfrozen = 'De tijd is niet langer bevroren.',
        morning = 'Tijd ingesteld op ochtend.',
        noon = 'Tijd ingesteld op middag.',
        evening = 'Tijd ingesteld op avond.',
        night = 'Tijd ingesteld op nacht.',
        change = 'De tijd is veranderd in %{value}:%{value2}.',
        changec = 'De tijd is veranderd in: %{value}!',
        invalid = 'Ongeldige commando, correcte commando is: time <hour> <minute> !',
        invalidc = 'Ongeldige commando. gebruik /time <uur> <minuut> !',
        access = 'Toegang voor commando /time geweigerd.',
    },
    blackout = {
        enabled = 'Black-out is ingeschakeld.',
        enabledc = 'Black-out is ingeschakeld.',
        disabled = 'Black-out is uitgeschakeld.',
        disabledc = 'Black-out is uitgeschakeld.',
    },
    help = {
        weathercommand = 'Verander het weer.',
        weathertype = 'weertype',
        availableweather = 'Beschikbare typen: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Verander de tijd.',
        timehname = 'uren',
        timemname = 'minuten',
        timeh = 'Een getal tussen 0 - 23',
        timem = 'Een getal tussen 0 - 59',
        freezecommand = 'Tijd bevriezen / ontdooien.',
        freezeweathercommand = 'Dynamische weersveranderingen in-/uitschakelen.',
        morningcommand = 'Zet de tijd op 09:00',
        nooncommand = 'Zet de tijd op 12:00',
        eveningcommand = 'Zet de tijd op 18:00',
        nightcommand = 'Zet de tijd op 23:00',
        blackoutcommand = 'Schakel de black-outmodus.',
    },
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
