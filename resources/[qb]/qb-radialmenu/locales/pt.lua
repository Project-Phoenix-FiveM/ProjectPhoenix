local Translations = {
    error = {
        no_people_nearby = "Não existem jogadores perto",
        no_vehicle_found = "Veículo não encontrado",
        extra_deactivated = "Extra %{extra} foi desativado",
        extra_not_present = "Extra %{extra} não está definido neste veículo",
        not_driver = "Não és o condutor deste veículo",
        vehicle_driving_fast = "Este veículo vai rápido demais",
        seat_occupied = "Este assento está ocupado",
        race_harness_on = "Tens um cinto de corrida posto, não podes mudar",
        obj_not_found = "Não foi possível criar o objeto pedido",
        not_near_ambulance = "Não estás perto de uma ambulância",
        far_away = "Estás demasiado longe",
        stretcher_in_use = "Esta maca já está em uso",
        not_kidnapped = "Não raptaste esta pessoa",
        trunk_closed = "A bagageira está trancada",
        cant_enter_trunk = "Não podes entrar nesta bagageira",
        already_in_trunk = "Já estás dentro da bagageira",
        someone_in_trunk = "Já existe alguém na bagageira"
    },
    success = {
        extra_activated = "Extra %{extra} ativado",
        entered_trunk = "Entraste na bagageira"
    },
    info = {
        no_variants = "Não parece haver nenhuma variante para isto",
        wrong_ped = "Este ped model não permite esta opção",
        nothing_to_remove = "Não parece haver nada para remover",
        already_wearing = "Já estás a usar isto",
        switched_seats = "Estás no %{seat}"
    },
    general = {
        command_description = "Abrir Radial Menu",
        push_stretcher_button = "[E] - Empurrar Maca",
        stop_pushing_stretcher_button = "~g~E~w~ - Parar De Empurrar",
        lay_stretcher_button = "[G] - Deitar Na Maca",
        push_position_drawtext = "Empurrar Aqui",
        get_off_stretcher_button = "[G] - Sair Da Maca",
        get_out_trunk_button = "[E] Sair Da Bagageira",
        close_trunk_button = "[G] Fechar Bagageira",
        open_trunk_button = "[G] Abrir Bagageira",
        getintrunk_command_desc = "Entrar Na Bagageira",
        putintrunk_command_desc = "Colocar Pessoa Na Bagageira"
    },
    options = {
        emergency_button = "Botão De Emergência",
        driver_seat = "Assento Condutor",
        passenger_seat = "Assento Passageiro",
        other_seats = "Assento Outro",
        rear_left_seat = "Assento Traseiro Esquerda",
        rear_right_seat = "Assento Traseiro Direita"
    },
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
