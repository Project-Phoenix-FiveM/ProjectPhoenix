local Translations = {
    error = {
        ["already_mission"] = "Já te encontrar a efectuar uma missão NPC",
        ["not_in_taxi"] = "Não estás num Taxi",
        ["missing_meter"] = "Este veículo não possui um taxímetro",
        ["no_vehicle"] = "Não estás num veículo",
        ["not_active_meter"] = "O taxímetro não se encontra activo",
        ["no_meter_sight"] = "Nenhum taxímetro à vista",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "O passageiro foi entregue!",
        ["npc_on_gps"] = "O NPC encontra-se indicado no teu GPS",
        ["go_to_location"] = "Transporta o NPC para a localização assinalada",
        ["vehicle_parking"] = "[E] Estacionamento de Veículo",
        ["job_vehicles"] = "[E] Veículos de Trabalho",
        ["drop_off_npc"] = "[E] Entregar NPC",
        ["call_npc"] = "[E] Chamar NPC",
        ["blip_name"] = "Taxis da Baixa",
        ["taxi_label_1"] = "Taxi",
    },
    menu = {
        ["taxi_menu_header"] = "Veículos de Taxi",
        ["close_menu"] = "⬅ Fechar Menu",
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
