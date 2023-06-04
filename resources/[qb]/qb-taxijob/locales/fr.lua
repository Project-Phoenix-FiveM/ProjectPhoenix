local Translations = {
    error = {
        ["already_mission"] = "Vous êtes déjà en mission",
        ["not_in_taxi"] = "Vous n\'êtes pas dans un taxi",
        ["missing_meter"] = "Ce véhicule n'a pas de taximètre",
        ["no_vehicle"] = "Vous n\'êtes pas dans un véhicule",
        ["not_active_meter"] = "Le taximètre n\'est pas activé",
        ["no_meter_sight"] = "Pas de taximètre en vue",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "La personne a été déposée!",
        ["npc_on_gps"] = "Le client est indiqué sur votre GPS!",
        ["go_to_location"] = "Amenez le client à la destination spécifiée",
        ["vehicle_parking"] = "[E] Parking",
        ["job_vehicles"] = "[E] Vehicules disponibles",
        ["drop_off_npc"] = "[E] Déposer le client",
        ["call_npc"] = "[E] Appeler le client",
        ["blip_name"] = "Downtown Cab Co.",
        ["taxi_label_1"] = "Taxi Standard",
        ["no_spawn_point"] = "Impossible de trouver un emplacement pour amener le taxi",
        ["taxi_returned"] = "Taxi Garé"
    },
    menu = {
        ["taxi_menu_header"] = "Taxi",
        ["close_menu"] = "⬅ Fermer le menu",
        ['boss_menu'] = "Menu Boss"
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
