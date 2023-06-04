local Translations = {
    weather = {
        now_frozen = 'Vejret er sat på pause.',
        now_unfrozen = 'Vejret er nu normalt igen.',
        invalid_syntax = 'Ugyldig syntax, korrekt syntax er: /weather <vejrtype> ',
        invalid_syntaxc = 'Ugyldig syntax, brug /weather <vejrtype> istedet!',
        updated = 'Vejeret er blevet opdateret.',
        invalid = 'Ugyldig vejrtype, typer du kan bruge er: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        invalidc = 'Ugyldig vejrtype, typer du kan bruge er: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'Vejret vil ændre sig til: %{value}.',
        accessdenied = 'Adgangen til /weather er nægtet.',
    },

    dynamic_weather = {
        disabled = 'Dynamisk vejr er slået fra.',
        enabled = 'Dynamisk vejr er nu slået til.',
    },
    time = {
        frozenc = 'Tiden er sat på pause.',
        unfrozenc = 'Tiden er nu normal igen.',
        now_frozen = 'Tiden er nu sat på pause.',
        now_unfrozen = 'Tiden er ikke længere sat på pause.',
        console = 'For konsollen, brug \"/time <hh> <mm>\" command istedet!',
        morning = 'Tiden er sat til om morgenen.',
        noon = 'Tiden er sat til eftermiddag.',
        evening = 'Tiden er sat til aften.',
        night = 'Tiden er sat til nat.',
        change = 'Tiden er sat til %{value}:%{value2}.',
        changec = 'Tiden er ændret til: %{value}!',
        invalid = 'Ugyldig syntax, korrekt syntax er: time <time> <minut> !',
        invalidc = 'Ugyldig syntax. Brug /time <time> <minut> istedet!',
        access = 'Adgangen for command /time er nægtet.',
    },
    blackout = {
        enabled = 'Blackout er nu slået til.',
        enabledc = 'Blackout er nu slået til.',
        disabled = 'Blackout er nu slået fra.',
        disabledc = 'Blackout er nu slået fra.',
    },
    help = {
        weathercommand = 'Ændre vejr.',
        weathertype = 'vejrtype',
        availableweather = 'Mulige typer: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Ændre tiden.',
        timehname = 'timer',
        timemname = 'minutter',
        timeh = 'Et nummer mellem 0 - 23',
        timem = 'Et nummer mellem 0 - 59',
        freezecommand = 'Stop / kør tiden.',
        freezeweathercommand = 'Slå til/fra dynamiske vejr ændringer.',
        morningcommand = 'Sæt tiden til 09:00',
        nooncommand = 'Sæt tiden til 12:00',
        eveningcommand = 'Sæt tiden til 18:00',
        nightcommand = 'Sæt tiden til 23:00',
        blackoutcommand = 'Slå blackout til/fra .',
    },
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
