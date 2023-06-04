local Translations = {
    error = {
        ["already_mission"] = "Du gör redan ett NPC-uppdrag",
        ["not_in_taxi"] = "Du är inte i en taxi",
        ["missing_meter"] = "Det här fordonet har ingen taxameter",
        ["no_vehicle"] = "Du är inte i ett fordon",
        ["not_active_meter"] = "Taxametern är inte aktiv",
        ["no_meter_sight"] = "Ingen Taxameter i sikte",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "Passageraren släpptes av!",
        ["npc_on_gps"] = "NPC'n syns på din GPS",
        ["go_to_location"] = "Skjutsa NPC'n till den utsatta platsen",
        ["vehicle_parking"] = "[E] Fordonsparkering",
        ["job_vehicles"] = "[E] Arbetsfordon",
        ["drop_off_npc"] = "[E] Släpp av NPC",
        ["call_npc"] = "[E] Ropa på NPC",
        ["blip_name"] = "Taxi",
        ["taxi_label_1"] = "Standard-bil",
    },
    menu = {
        ["taxi_menu_header"] = "Taxibilar",
        ["close_menu"] = "⬅ Stäng meny",
    }
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
