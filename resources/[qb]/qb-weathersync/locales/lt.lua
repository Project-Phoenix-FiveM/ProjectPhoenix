local Translations = {
    weather = {
        now_frozen = 'Orai sustabdyti.',
        now_unfrozen = 'Orai nebe sustoj?.',
        invalid_syntax = 'Neteisinga sintaks?, teisinga sintaks? yra: /weather <or? tipas> ',
        invalid_syntaxc = 'Neteisinga sintaks?, naudokite /weather <or? tipas>!',
        updated = 'Orai buvo atnaujinti.',
        invalid = 'Neteisingas or? tipas, galimi or? tipai: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN',
        invalidc = 'Neteisingas or? tipas, galimi or? tipai: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN',
        willchangeto = 'Orai pasikeisti ?: %{value}.',
        accessdenied = 'Komandos /weather prieiga neleidžiama.',
    },
    dynamic_weather = {
        disabled = 'Dinamini? or? keitimasis išjungtas.',
        enabled = 'Dinamini? or? keitimasis ?jungtas.',
    },
    time = {
        frozenc = 'Laikas sustabdytas.',
        unfrozenc = 'Laikas nebe sustoj?s.',
        now_frozen = 'Laikas sustabdytas.',
        now_unfrozen = 'Laikas nebe sustoj?s.',
        morning = 'Nustatytas ryto laikas.',
        noon = 'Nustatytas piet? laikas.',
        evening = 'Nustatytas vakaro laikas.',
        night = 'Nustatytas nakties laikas.',
        change = 'Laikas nustatytas ? %{value}:%{value2}.',
        changec = 'Laikas nustatytas ?: %{value}!',
        invalid = 'Neteisinga sintaks?, teisinga sintaks?: time <valanda> <minut?>!',
        invalidc = 'Neteisinga sintaks?. Naudokite /time <valanda> <minut?>!',
        access = 'Komandos /time prieiga neleidžiama.',
    },
    blackout = {
        enabled = 'Užtemimas ?jungtas.',
        enabledc = 'Užtemimas ?jungtas.',
        disabled = 'Užtemimas išjungtas.',
        disabledc = 'Užtemimas išjungtas.',
    },
    help = {
        weathercommand = 'Or? nustatymas.',
        weathertype = 'or? tipas',
        availableweather = 'Galimi tipai: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas, halloween',
        timecommand = 'Laiko nustatymas.',
        timehname = 'valandos',
        timemname = 'minut?s',
        timeh = 'Skai?ius tarp 0 - 23',
        timem = 'Skai?ius tarp 0 - 59',
        freezecommand = 'Laiko sustabdymas.',
        freezeweathercommand = 'Or? keitimosi nustatymas.',
        morningcommand = 'Laikas nustatytas ? 09:00',
        nooncommand = 'Laikas nustatytas ? 12:00',
        eveningcommand = 'Laikas nustatytas ? 18:00',
        nightcommand = 'Laikas nustatytas ? 23:00',
        blackoutcommand = 'Užtemimo nustatymas.',
    },
}

if GetConvar('qb_locale', 'en') == 'lt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
