local Translations = {
    error = {
        already_driving_bus = 'Ya estás manejando un autobús',
        not_in_bus = 'No estás en un autobús',
        one_bus_active = 'Solo puedes tener un autobús activo a la vez',
        drop_off_passengers = 'Lleva a tus pasajeros antes de salir del trabajo'
    },
    success = {
        dropped_off = 'Una persona se bajó'
    },
    info = {
        bus = 'Autobús estándar',
        goto_busstop = 'Ir a la siguiente parada de autobús',
        busstop_text = '[E] Parada de autobús',
        bus_plate = 'BUS', -- Can be 3 or 4 characters long (uses random 4 digits)
        bus_depot = 'Estación de autobuses',
        bus_stop_work = '[E] Salir del trabajo',
        bus_job_vehicles = '[E] Vehículos de trabajo'
    },
    menu = {
        bus_header = 'Autobuses',
        bus_close = '⬅ Cerrar menú'
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
