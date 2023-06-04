local Translations = {
    error = {
        ["already_mission"] = "Du bist bereits in einer NPC-Mission",
        ["not_in_taxi"] = "Sie sind nicht in einem Taxi",
        ["missing_meter"] = "Dieses Fahrzeug hat keine Taxameter",
        ["no_vehicle"] = "Sie sind nicht in einem Fahrzeug",
        ["not_active_meter"] = "Das Taxameter ist nicht aktiv",
        ["no_meter_sight"] = "Kein Taxameter in Sicht",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "Person wurde abgesetzt!",
        ["npc_on_gps"] = "Der NPC wird auf Ihrem GPS angezeigt",
        ["go_to_location"] = "Den NPC an den angegebenen Ort bringen",
        ["vehicle_parking"] = "[E] Fahrzeug parken",
        ["job_vehicles"] = "[E] Arbeitsfahrzeug",
        ["drop_off_npc"] = "[E] NPC absetzen",
        ["call_npc"] = "[E] NPC anrufen",
        ["blip_name"] = "Taxigesellschaft",
        ["taxi_label_1"] = "Standard Taxi",
        ["no_spawn_point"] = "Unfähig, einen Ort zu finden, an den das Taxi gebracht werden kann",
        ["taxi_returned"] = "Taxi einparken"
    },
    menu = {
        ["taxi_menu_header"] = "Taxifahrzeuge",
        ["close_menu"] = "⬅ Schließe Menü",
        ['boss_menu'] = "Boss Menu"
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
