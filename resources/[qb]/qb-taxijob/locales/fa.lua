local Translations = {
    error = {
        ["already_mission"] = "Shoma Ham Aknun Dar Mamuriyat NPC Hastid",
        ["not_in_taxi"] = "Shoma Dar Taxi Nistid",
        ["missing_meter"] = "Dar In Vasile Nagliye Taxi Meter Mojud Nist",
        ["no_vehicle"] = "Shoma Dar Vasile Nagliye Nist",
        ["not_active_meter"] = "Taxi Meter Faal Nist",
        ["no_meter_sight"] = "Taxi Meter Dar Maraze Did Nist",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "Mosafer Piyade Shod!",
        ["npc_on_gps"] = "NPC Dar GPS Shoma Neshan Dade Shode Ast",
        ["go_to_location"] = "NPC ra be Mogeiyat Moshakhs Shode Bebarid",
        ["vehicle_parking"] = "[E] Park Kardan Vasile Nagliye",
        ["job_vehicles"] = "[E] Vasayele Nagliye Shoghl",
        ["drop_off_npc"] = "[E] Piyade Kardane NPC",
        ["call_npc"] = "[E] Darkhast NPC",
        ["blip_name"] = "Downtown Cab",
        ["taxi_label_1"] = "Taxi Mamuli",
    },
    menu = {
        ["taxi_menu_header"] = "List Mashin heye Taxi",
        ["close_menu"] = "⬅ Bastan Menu",
    }
}

if GetConvar('qb_locale', 'en') == 'fa' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
