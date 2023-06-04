local Translations = {
    error = {
        lockpick_fail = "Falhou",
        door_not_found = "Modelo hash da porta não foi registado. Se a porta for transparente, faz mira na moldura da porta",
        same_entity = "As portas não podem ter a mesma entidade",
        door_registered = "Esta porta já está registada",
        door_identifier_exists = "Já existe uma porta com este identificador. (%s)",
    },
    success = {
        lockpick_success = "Sucesso"
    },
    general = {
        locked = "Trancado",
        unlocked = "Destrancado",
        locked_button = "[E] - Trancado",
        unlocked_button = "[E] - Destrancado",
        keymapping_description = "Interagir com as fechaduras das portas",
        keymapping_remotetriggerdoor = "Interagir remotamente com porta",
        locked_menu = "Trancado",
        pickable_menu = "Permitir lockpick",
        cantunlock_menu = 'Sempre trancado',
        hidelabel_menu = 'Omitir interação',
        distance_menu = "Distância máxima",
        item_authorisation_menu = "Autorização com item",
        citizenid_authorisation_menu = "CitizenID autorizado",
        gang_authorisation_menu = "Gang autorizado",
        job_authorisation_menu = "Trabalho autorizado",
        doortype_title = "Tipo de porta",
        doortype_door = "Porta individual",
        doortype_double = "Porta dupla",
        doortype_sliding = "Porta de correr individual",
        doortype_doublesliding = "Porta de correr dupla",
        doortype_garage = "Garagem",
        dooridentifier_title = "Identificador único",
        doorlabel_title = "Etiqueta da porta",
        configfile_title = "Ficheiro de configuração",
        submit_text = "Submeter",
        newdoor_menu_title = "Adicionar nova porta",
        newdoor_command_description = "Adiciona uma nova porta ao sistema de fechaduras",
        doordebug_command_description = "Alternar modo debug",
        warning = "Aviso",
        created_by = "criado por",
        warn_no_permission_newdoor = "%{player} (%{license}) tentou criar uma nova porta sem permissão (source: %{source})",
        warn_no_authorisation = "%{player} (%{license}) tentou abrir uma porta sem autorização (Sent: %{doorID})",
        warn_wrong_doorid = "%{player} (%{license}) tentou atualizar uma porta inválida (Sent: %{doorID})",
        warn_wrong_state = "%{player} (%{license}) tentou atualizar para um estado inválido (Sent: %{state})",
        warn_wrong_doorid_type = "%{player} (%{license}) não enviou um ID de porta apropriado (Sent: %{doorID})",
        warn_admin_privilege_used = "%{player} (%{license}) abriu uma porta com privilégios de admin"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
