local Translations = {
    error = {
        already_driving_bus = 'Du fährst bereits einen Bus',
        not_in_bus = 'Du bist in keinem Bus',
        one_bus_active = 'Du kannst nur ein Bus nutzen',
        drop_off_passengers = 'Setz die Passagiere ab, bevor du mit der Arbeit aufhörst'
    },
    success = {
        dropped_off = 'Peson(en) wurde(n) abgesetzt',
    },
    info = {
        bus = 'Standart Bus',
        goto_busstop = 'Fahre zur Bushaltestelle',
        busstop_text = '[E] Bus stoppen',
        bus_plate = 'BUS', -- Can be 3 or 4 characters long (uses random 4 digits)
        bus_depot = 'Bus Depot',
        bus_stop_work = '[E] Arbeit beenden',
        bus_job_vehicles = '[E] Job Fahrzeuge'
    },
    menu = {
        bus_header = 'Bus Fahrzeuge',
        bus_close = '⬅ Menü schliessen'
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
