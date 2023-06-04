local Translations = {
    error = {
        already_driving_bus = 'Du kører allerede en bus',
        not_in_bus = 'Du er ikke i en bus',
        one_bus_active = 'Du kan kun have én aktiv bus ad gangen',
        drop_off_passengers = 'Smid passagererne af, før du holder op med at arbejde'
    },
    success = {
        dropped_off = 'Person blev sat af',
    },
    info = {
        bus = 'Standard Bus',
        goto_busstop = 'Gå til busstoppestedet',
        busstop_text = '[E] Busstoppested',
        bus_plate = 'BUS', -- Kan være 3 eller 4 tegn lang (bruger tilfældige 4 cifre)
        bus_depot = 'Busdepot',
        bus_stop_work = '[E] Stop med at arbejde',
        bus_job_vehicles = '[E] Jobbiler'
    },
    menu = {
        bus_header = 'Buskøretøjer',
        bus_close = '⬅ Luk menu'
    }
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
