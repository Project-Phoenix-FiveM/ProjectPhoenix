local Translations = {
    error = {
        already_driving_bus = 'Vous conduisez déjà un bus',
        not_in_bus = 'Vous n\'êtes pas dans un bus',
        one_bus_active = 'Vous ne pouvez avoir qu\'un bus actif à la fois',
        drop_off_passengers = 'Déposez les passagers avant d\'arrêter le travail'
    },
    success = {
        dropped_off = 'Une personne a été déposée à l\'arrêt',
    },
    info = {
        bus = 'Bus Standard',
        goto_busstop = 'Allez a l\'arrêt de bus suivant',
        busstop_text = '[E] Arrêt de bus',
        bus_plate = 'BUS', -- Can be 3 or 4 characters long (uses random 4 digits)
        bus_depot = 'Dépôt de Bus',
        bus_stop_work = '[E] Finir sa tournée',
        bus_job_vehicles = '[E] Véhicules de service'
    },
    menu = {
        bus_header = 'Garage de bus',
        bus_close = '⬅ Fermer Menu'
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
