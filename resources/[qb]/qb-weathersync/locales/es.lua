local Translations = {
    weather = {
        now_frozen = 'El clima ahora está congelado.',
        now_unfrozen = 'El clima ya no está congelado.',
        invalid_syntax = 'Sintaxis no válida, la sintaxis correcta es: /weather <weathertype> ',
        invalid_syntaxc = 'Sintaxis no válida, utilice /weather <weatherType> ',
        updated = 'El clima ha sido actualizado.',
        invalid = 'Tipo de tiempo inválido, los tipos de tiempo válidos son: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        invalidc = 'Tipo de tiempo inválido, los tipos de tiempo válidos son: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'El tiempo cambiará a: %{value}.',
        accessdenied = 'Acceso para comando /weather denegado.',
    },
    dynamic_weather = {
        disabled = 'Los cambios climáticos dinámicos ahora están deshabilitados.',
        enabled = 'Los cambios climáticos dinámicos ahora están habilitados.',
    },
    time = {
        frozenc = 'El tiempo ahora está congelado.',
        unfrozenc = 'el tiempo ya no esta congelado.',
        now_frozen = 'El tiempo ahora está congelado.',
        now_unfrozen = 'El tiempo ya no se congela.',
        morning = 'El tiempo se ha establecido por la mañana.',
        noon = 'El tiempo se ha establecido por el mediodía.',
        evening = 'El tiempo se ha establecido por la tarde.',
        night = 'El tiempo se ha establecido por la noche.',
        change = 'El tiempo ha cambiado a %{value}:%{value2}.',
        changec = 'El tiempo fue cambiado a: %{value}!',
        invalid = 'Sintaxis no válida, la sintaxis correcta es: time <hour> <minute> !',
        invalidc = 'Sintaxis inválida. usar /time <hora> <minuto> en cambio!',
        access = 'Acceso para comando /time denegador.',
    },
    blackout = {
        enabled = 'El apagón está ahora habilitado.',
        enabledc = 'El apagón está ahora habilitado.',
        disabled = 'El apagón ahora está deshabilitado.',
        disabledc = 'El apagón ahora está deshabilitado.',
    },
    help = {
        weathercommand = 'Change the weather.',
        weathertype = 'weathertype',
        availableweather = 'Tipos disponibles: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Cambiar el tiempo.',
        timehname = 'Hora',
        timemname = 'Minutos',
        timeh = 'un numero entre 0 - 23',
        timem = 'un numero entre 0 - 59',
        freezecommand = 'usa Freeze / unfreeze para detener el tiempo.',
        freezeweathercommand = 'usa Enable/disable cambios dinámicos del tiempo.',
        morningcommand = 'Establezca el tiempo para las 09:00',
        nooncommand = 'Establezca el tiempo para las 12:00',
        eveningcommand = 'Establezca el tiempo para las 18:00',
        nightcommand = 'Establezca el tiempo para las 23:00',
        blackoutcommand = 'Cambiar el modo de apagón.',
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
