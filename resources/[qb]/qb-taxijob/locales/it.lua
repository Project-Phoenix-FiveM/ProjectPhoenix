local Translations = {
    error = {
        ["already_mission"] = "Stai già facendo una missione di un NPC",
        ["not_in_taxi"] = "Non sei in un taxi",
        ["missing_meter"] = "Questo veicolo non ha un tassametro",
        ["no_vehicle"] = "Non sei in un veicolo",
        ["not_active_meter"] = "Il tassametro non è acceso",
        ["no_meter_sight"] = "Nessun tassametro visibile",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "La persona è stata lasciata! ",
        ["npc_on_gps"] = "L'NPC è stato segnato sul GPS",
        ["go_to_location"] = "Porta l'NPC nella posizione specificata",
        ["vehicle_parking"] = "[E] Parcheggio Veicoli",
        ["job_vehicles"] = "[E] Veicoli Lavorativi",
        ["drop_off_npc"] = "[E] Lascia NPC",
        ["call_npc"] = "[E] Chiama NPC",
        ["blip_name"] = "Taxi",
        ["taxi_label_1"] = "Standard Cab",
    },
    menu = {
        ["taxi_menu_header"] = "Veicoli Taxi",
        ["close_menu"] = "⬅ Chiudi Menu",
    }
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
