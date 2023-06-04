local Translations = {
    error = {
        ["already_mission"] = "Ya estás haciendo una misión con un NPC",
        ["not_in_taxi"] = "No estás en un taxi",
        ["missing_meter"] = "Este vehículo no tiene taxímetro",
        ["no_vehicle"] = "No estás en un vehículo",
        ["not_active_meter"] = "El taxímetro no está activo",
        ["no_meter_sight"] = "No hay taxímetro visible",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "La persona se bajó del taxi",
        ["npc_on_gps"] = "El NPC está indicado en tu GPS",
        ["go_to_location"] = "Trae el NPC a la ubicación específicada",
        ["vehicle_parking"] = "[E] Estacionamiento de vehículo",
        ["job_vehicles"] = "[E] Vehículos de trabajo",
        ["drop_off_npc"] = "[E] Bajar NPC",
        ["call_npc"] = "[E] Llamar NPC",
        ["blip_name"] = "Taxi del centro",
        ["taxi_label_1"] = "Taxi estándar",
        ["no_spawn_point"] = "No es posible encontrar una ubicación para traer el taxi",
        ["taxi_returned"] = "Taxi estacionado"
    },
    menu = {
        ["taxi_menu_header"] = "Vehículos para taxi",
        ["close_menu"] = "⬅ Cerrar menú",
        ['boss_menu'] = "Menú de jefe"
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
