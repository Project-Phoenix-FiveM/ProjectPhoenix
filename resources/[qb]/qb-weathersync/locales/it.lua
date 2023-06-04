local Translations = {
    weather = {
        now_frozen = 'Il tempo è congelato.',
        now_unfrozen = 'Il tempo non è più congelato.',
        invalid_syntax = 'Sintassi non valida, la sintassi corretta è: /weather <weathertype> ',
        invalid_syntaxc = 'Sintassi non valida, usa /weather <weatherType> invece!',
        updated = 'Il tempo è stato aggiornato.',
        invalid = 'Tipo di tempo non valido, tipi di tempo validi: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        invalidc = 'Tipo di tempo non valido, tipi di tempo validi: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'Il tempo cambierà in: %{value}.',
        accessdenied = 'Accesso per il comando /weather rifiutato.',
    },

    dynamic_weather = {
        disabled = 'I cambiamenti climatici dinamici sono disabilitati.',
        enabled = 'I cambiamenti climatici dinamici sono ora abilitati.',
    },
    time = {
        frozenc = 'Il tempo è congelato.',
        unfrozenc = 'Il tempo non è più congelato.',
        now_frozen = 'Il tempo è congelato.',
        now_unfrozen = 'Il tempo non è più congelato.',
        console = 'Per la console, utilizza il comando \"/time <hh> <mm>\" invece!',
        morning = 'Ora cambiata in mattino.',
        noon = 'Ora cambiata in mezzogiorno.',
        evening = 'Ora cambiata in sera.',
        night = 'Ora cambiata in notte',
        change = 'Il tempo è cambiato in %{value}:%{value2}.',
        changec = 'Il tempo è stato cambiato in: %{value}!',
        invalid = 'Sintassi non valida, la sintassi corretta è: time <ore> <minuti> !',
        invalidc = 'Sintassi non valida. Usa /time <ore> <minuti> invece!',
        access = 'Access for command /time denied.',
    },
    blackout = {
        enabled = 'Il blackout è ora abilitato.',
        enabledc = 'Il blackout è ora abilitato.',
        disabled = 'Il blackout è disattivato.',
        disabledc = 'Il blackout è disattivato.',
    },
    help = {
        weathercommand = 'Cambia il tempo.',
        weathertype = 'tipotempo',
        availableweather = 'Tipi disponibili: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Cambia il tempo.',
        timehname = 'ore',
        timemname = 'minuti',
        timeh = 'Un numero tra 0 - 23',
        timem = 'Un numero tra 0 - 59',
        freezecommand = 'Congela / scongela tempo.',
        freezeweathercommand = 'Abilita/disabilita le modifiche meteo dinamiche.',
        morningcommand = 'Imposta l\'ora a 09:00',
        nooncommand = 'Imposta l\'ora a  12:00',
        eveningcommand = 'Imposta l\'ora a  18:00',
        nightcommand = 'Imposta l\'ora a  23:00',
        blackoutcommand = 'Attiva/disattiva la modalità blackout.',
    },
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

