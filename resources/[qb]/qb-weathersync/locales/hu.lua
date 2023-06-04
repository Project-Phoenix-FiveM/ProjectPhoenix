local Translations = {
    weather = {
        now_frozen = 'Az id? leállítva.',
        now_unfrozen = 'Az id? elindítva.',
        invalid_syntax = 'Rossz szintaktika, használd ezt: /weather <weathertype> ',
        invalid_syntaxc = 'Rossz szintaktika, használd ezt: /weather <weatherType> ',
        updated = 'Weather has been updated.',
        invalid = 'Helytelen id?járás típus. Használd ezeket: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        invalidc = 'Helytelen id?járás típus. Használd ezeket: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'Az id?járás megváltozott: %{value}.',
        accessdenied = 'Nincs Jogosultságod a /weather parancs használatához.',
    },
    dynamic_weather = {
        disabled = 'Dinamikus id?járás változások kikapcsolva.',
        enabled = 'Dinamikus id?járás változások kikapcsolva.',
    },
    time = {
        frozenc = 'Id? leállítva.',
        unfrozenc = 'Id? elindítva',
        now_frozen = 'Id? leállítva.',
        now_unfrozen = 'Id? elindítva',
        morning = 'Id? reggelre állítva.',
        noon = 'Id? délre állítva.',
        evening = 'Id? estére állítva.',
        night = 'Id? éjszakára állítva.',
        change = 'Az id? megváltozott: %{value}:%{value2}.',
        changec = 'Id? megváltoztatva: %{value}!',
        invalid = 'Rossz szintaktika, használd ezt: time <hour> <minute> !',
        invalidc = 'Rossz szintaktika, használd ezt: /time <hour> <minute> !',
        access = 'Nincs jogosultságod a /time parancshasználatához.',
    },
    blackout = {
        enabled = 'Áramszünet bekapcsolva.',
        enabledc = 'Áramszünet bekapcsolva.',
        disabled = 'Áramszünet kikapcsolva.',
        disabledc = 'Áramszünet kikapcsolva.',
    },
    help = {
        weathercommand = 'Id?járás megváltoztatása.',
        weathertype = 'id?járás típus.',
        availableweather = 'Id?járás típusok: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Id? megváltoztatása.',
        timehname = 'óra',
        timemname = 'perc',
        timeh = 'Egy szám 0 - 23 között',
        timem = 'Egy szám 0 - 59 között',
        freezecommand = 'Id? leállít/elindít.',
        freezeweathercommand = 'Be/Kikapcsolása a Dinamikus id?járás változásoknak',
        morningcommand = 'Id? megváltoztatva: 09:00',
        nooncommand = 'Id? megváltoztatva: 12:00',
        eveningcommand = 'Id? megváltoztatva: 18:00',
        nightcommand = 'Id? megváltoztatva: 23:00',
        blackoutcommand = 'Áramszünet mód ki/be kapcsolása.',
    },
}

if GetConvar('qb_locale', 'en') == 'hu' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
