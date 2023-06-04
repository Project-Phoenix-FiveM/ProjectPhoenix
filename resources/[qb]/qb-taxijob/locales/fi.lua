local Translations = {
    error = {
        ["already_mission"] = "Olet jo tekemässä NPC keikkaa!",
        ["not_in_taxi"] = "Et ole taksissa!",
        ["missing_meter"] = "Ajoneuvossa ei ole taksimittaria",
        ["no_vehicle"] = "Et ole ajoneuvossa!",
        ["not_active_meter"] = "Taksimittari ei ole aktiivinen",
        ["no_meter_sight"] = "Ei taksimittaria nähtävissä",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "Jätit matkustajan pois!",
        ["npc_on_gps"] = "Matkustajan sijainti näkyy GPS:ssäsi",
        ["go_to_location"] = "Vie matkustaja määränpäähän",
        ["vehicle_parking"] = "[E] Talleta ajoneuvo",
        ["job_vehicles"] = "[E] Ajoneuvot",
        ["drop_off_npc"] = "[E] Jätä matkustaja",
        ["call_npc"] = "[E] Soita NPC:lle",
        ["blip_name"] = "Taksi",
        ["taxi_label_1"] = "Taksi",
    },
    menu = {
        ["taxi_menu_header"] = "Taksit",
        ["close_menu"] = "⬅ Sulje valikko",
    }
}

if GetConvar('qb_locale', 'en') == 'fi' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
