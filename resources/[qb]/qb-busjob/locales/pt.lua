local Translations = {
    error = {
        already_driving_bus = 'Já estás a conduzir um autocarro',
        not_in_bus = 'Não estás num autocarro',
        one_bus_active = 'Só podes ter um autocarro ativo ao mesmo tempo',
        drop_off_passengers = 'Deixa os passageiros antes de parares de trabalhar'
    },
    success = {
        dropped_off = 'Deixaste o passageiro',
    },
    info = {
        bus = 'Autocarro normal',
        goto_busstop = 'Vai para a paragem de autocarro',
        busstop_text = '[E] Paragem de Autocarro',
        bus_plate = 'BUS', -- Can be 3 or 4 characters long (uses random 4 digits)
        bus_depot = 'Central de Autocarros',
        bus_stop_work = '[E] Parar de Trabalhar',
        bus_job_vehicles = '[E] Veículos'
    },
    menu = {
        bus_header = 'Autocarros',
        bus_close = '⬅ Fechar Menu'
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
