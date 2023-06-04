local Translations = {
    error = {
        ["already_mission"] = "Du laver allerede en NPC Mission",
        ["not_in_taxi"] = "Du er ikke i en taxa",
        ["missing_meter"] = "Dette køretøj har intet taxameter",
        ["no_vehicle"] = "Du er ikke i et køretøj",
        ["not_active_meter"] = "Taxameteret er ikke aktivt",
        ["no_meter_sight"] = "Intet taxameter at se",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "Personen blev sat af!",
        ["npc_on_gps"] = "En NPC er markeret på din GPS",
        ["go_to_location"] = "Kør en NPC til lokationen",
        ["vehicle_parking"] = "[E] Køretøjs parkering",
        ["job_vehicles"] = "[E] Job køretøjer",
        ["drop_off_npc"] = "[E] Sæt NPC af",
        ["call_npc"] = "[E] Kald en NPC",
        ["blip_name"] = "Midtby taxa",
        ["taxi_label_1"] = "Standart taxa",
    },
    menu = {
        ["taxi_menu_header"] = "Taxa køretøjer",
        ["close_menu"] = "⬅ Luk menuen",
    }
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
