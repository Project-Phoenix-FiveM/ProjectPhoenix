local Translations = {
    afk = {
        will_kick = "Estás AFK e vais ser kickado em",
        time_seconds = " segundos!",
        time_minutes = " minutos!",
        kick_message = "Foste Kickado Por Estares AFK",
    },
    error = {
        ["car_wash_canceled"] = "Lavagem cancelada...",
        ["car_wash_notdirty"] = "O veículo não está sujo",
        ["cruise_deactivated"] = "Cruise control desativado",
        ["cruise_unavailable"] = "Cruise control indisponível",
        ["not_in_car"] = "Não estás dentro de um carro.",
        ["dont_have_enough_money"] = "Não tens dinheiro suficiente...",
        ["global_canceled"] = "Cancelado...",
    },
    info = {
        ["cruise_activated_mp"] = "Cruise Ativado: %{speed} MP/H",
        ["cruise_activated_km"] = "Cruise Ativado: %{speed} KM/H",
    },
    progress = {
        ["car_wash_progress"] = "O veículo está a ser lavado...",
        ["placing_firework"] = "A preparar fogo de artifício...",
        ["attach_race_harness"] = "A colocar Arnês de Corrida",
        ["remove_race_harness"] = "A remover Arnês de Corrida",
    },
    text = {
        ["car_wash_text"] = "~g~E~w~ - Lavar Veículo (%{price}€)",
        ["car_wash_not_available"] = "A estação de lavagem não está disponível...",
        ["time_until_firework"] = "Fogo de Artifício em ~r~%{time}",
        ["push_vehicle"] = "[~g~SHIFT~w~] + [~g~E~w~] para empurrar veículo",
    },
    editor = {
        ["record"] = "Gravação Iniciada!",
        ["save"] = "Gravação Guardada!",
        ["delete_clip"] = "Gravação Apagada!",
        ["editor"] = "Later aligator!",
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
