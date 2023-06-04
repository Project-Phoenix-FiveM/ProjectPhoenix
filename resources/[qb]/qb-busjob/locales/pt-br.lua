local Translations = {
    error = {
        already_driving_bus = 'Você já está dirigindo um ônibus',
        not_in_bus = 'Você não está em um ônibus',
        one_bus_active = 'Você só pode ter um ônibus ativo por vez',
        drop_off_passengers = 'Deixe os passageiros antes de parar de trabalhar'
    },
    success = {
        dropped_off = 'A pessoa foi deixada',
    },
    info = {
        bus = 'Ônibus padrão',
        goto_busstop = 'Vá até o ponto de ônibus',
        busstop_text = '[E] Ponto de ônibus',
        bus_plate = 'BUS', -- Can be 3 or 4 characters long (uses random 4 digits)
        bus_depot = 'Rodoviária',
        bus_stop_work = '[E] Parar de trabalhar',
        bus_job_vehicles = '[E] Veículos de trabalho'
    },
    menu = {
        bus_header = 'Ônibus',
        bus_close = '⬅ Fechar Menu'
    }
}

if GetConvar('qb_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
