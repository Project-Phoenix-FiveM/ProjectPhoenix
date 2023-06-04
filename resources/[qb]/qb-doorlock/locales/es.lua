local Translations = {
    error = {
        lockpick_fail = "Falló",
        door_not_found = "No recibí el hash del modelo, si la puerta es transparente, asegurate de apuntar al marco de la puerta",
        same_entity = "Ambas puertas no pueden ser la misma entidad",
        door_registered = "Esta puerta ya está registrada",
        door_identifier_exists = "Una puerta con este identificador ya existe en la configuración. (%s)"
    },
    success = {
        lockpick_success = "Éxito"
    },
    general = {
        locked = "Cerrada",
        unlocked = "Abierta",
        locked_button = "[E] - Cerrada",
        unlocked_button = "[E] - Abierta",
        keymapping_description = "Interactúa con las cerraduras de las puertas",
        keymapping_remotetriggerdoor = "Remotamente cierra/abre una puerta",
        locked_menu = "Con llave",
        pickable_menu = "Intentar abrir",
        cantunlock_menu = 'No se puede abrir',
        hidelabel_menu = 'Esconder etiqueta de puerta',
        distance_menu = "Distancia máxima",
        item_authorisation_menu = "Autorización de objeto",
        citizenid_authorisation_menu = "Autorización de CitizenID",
        gang_authorisation_menu = "Autorización de banda",
        job_authorisation_menu = "Autorización de trabajo",
        doortype_title = "Tipo de puerta",
        doortype_door = "Puerta individual",
        doortype_double = "Puerta doble",
        doortype_sliding = "Puerta deslizante individual",
        doortype_doublesliding = "Puerta deslizante doble",
        doortype_garage = "Garaje",
        dooridentifier_title = "Identificado único",
        doorlabel_title = "Etiqueta de puerta",
        configfile_title = "Nombre de archivo de configuración",
        submit_text = "Enviar",
        newdoor_menu_title = "Agregar nueva puerta",
        newdoor_command_description = "Agregar una nueva puerta al sistema de cerraduras",
        doordebug_command_description = "Activar/desactivar modo debug",
        warning = "Advertencia",
        created_by = "creado por",
        warn_no_permission_newdoor = "%{player} (%{license}) trató de agregar una nueva puerta sin permiso (fuente: %{source})",
        warn_no_authorisation = "%{player} (%{license}) trató de abrir una puerta sin autorización (Enviado: %{doorID})",
        warn_wrong_doorid = "%{player} (%{license}) intentó actualizar una puerta inválida (Enviado: %{doorID})",
        warn_wrong_state = "%{player} (%{license}) intentó actualizar a un estado inválido (Enviado: %{state})",
        warn_wrong_doorid_type = "%{player} (%{license}) no envió la doorID apropiada (Enviado: %{doorID})",
        warn_admin_privilege_used = "%{player} (%{license}) abrió una puerta usando privilegios de admin"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
