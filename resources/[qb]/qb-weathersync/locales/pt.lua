local Translations = {
    weather = {
        now_frozen = 'Clima congelado.',
        now_unfrozen = 'Clima descongelado.',
        invalid_syntax = 'Sintaxe inválida, a sintaxe correta é: /weather <weathertype> ',
        invalid_syntaxc = 'Sintaxe inválida. Usa /weather <weatherType>!',
        updated = 'Clima atualizado.',
        invalid = 'Tipo de clima inválido, os tipos de clima válidos são: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        invalidc = 'Tipo de clima inválido, os tipos de clima válidos são: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'Clima alterado para: %{value}.',
        accessdenied = 'Acesso do comando /weather negado.',
    },

    dynamic_weather = {
        disabled = 'Alterações de clima dinâmico desativado.',
        enabled = 'Alterações de clima dinâmico ativado.',
    },
    time = {
        frozenc = 'Tempo congelado.',
        unfrozenc = 'Tempo descongelado.',
        now_frozen = 'Tempo congelado.',
        now_unfrozen = 'Tempo descongelado.',
        console = 'Para consola do servidor, usa o comando \"/time <hh> <mm>\"!',
        morning = 'Tempo definido para manhã.',
        noon = 'Tempo definido para meio-dia.',
        evening = 'Tempo definido para tarde.',
        night = 'Tempo definido para noite.',
        change = 'Tempo mudado para %{value}:%{value2}.',
        changec = 'Tempo mudado para: %{value}!',
        invalid = 'Sintaxe inválida, a sintaxe correta é: time <hora> <minuto>!',
        invalidc = 'Sintaxe inválida. Usa /time <hora> <minuto>!',
        access = 'Acesso do comando /time negado.',
    },
    blackout = {
        enabled = 'Apagão está agora activado.',
        enabledc = 'Apagão está agora activado.',
        disabled = 'Apagão está agora desativado.',
        disabledc = 'Apagão está agora desativado.',
    },
    help = {
        weathercommand = 'Alterar o clima.',
        weathertype = 'weathertype',
        availableweather = 'Climas disponíveis: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Alterar o tempo.',
        timehname = 'horas',
        timemname = 'minutos',
        timeh = 'Um número entre 0 - 23',
        timem = 'Um número entre 0 - 59',
        freezecommand = 'Congelar / Descongelar o tempo.',
        freezeweathercommand = 'Ativar/Desativar as alterações dinâmicas de clima.',
        morningcommand = 'Definir o tempo para 09:00',
        nooncommand = 'Definir o tempo para 12:00',
        eveningcommand = 'Definir o tempo para 18:00',
        nightcommand = 'Definir o tempo para 23:00',
        blackoutcommand = 'Ativar/Desativar apagão.',
    },
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
