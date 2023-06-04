local Translations = {
    error = {
        no_people_nearby = "No hay jugadores cerca",
        no_vehicle_found = "Ningún vehículo encontrado",
        extra_deactivated = "Extra %{extra} ha sido desactivado",
        extra_not_present = "Extra %{extra} No está presente en este vehículo.",
        not_driver = "No eres el conductor del vehículo.",
        vehicle_driving_fast = "Este vehículo va demasiado rápido.",
        seat_occupied = "Este asiento esta ocupado",
        race_harness_on = "Tienes un arnés de carrera, no puedes cambiar",
        obj_not_found = "No se pudo crear el objeto solicitado.",
        not_near_ambulance = "No estas cerca de una ambulancia",
        far_away = "Estas muy lejos",
        stretcher_in_use = "Esta camilla ya está en uso.",
        not_kidnapped = "Usted no secuestró a esta persona",
        trunk_closed = "El maletero esta cerrado",
        cant_enter_trunk = "No puedes entrar en este maletero",
        already_in_trunk = "Ya estas en el maletero",
        someone_in_trunk = "Alguien ya está en el maletero."
    },
    progress = {
        flipping_car = "Voltear el vehículo.."
    },
    success = {
        extra_activated = "Extra %{extra} Ha sido activado",
        entered_trunk = "entraste en el maletero"
    },
    info = {
        no_variants = "No parece haber ninguna variante para esto.",
        wrong_ped = "Este modelo de PED no permite esta opción.",
        nothing_to_remove = "No pareces tener nada que quitar",
        already_wearing = "Ya estas usando eso",
        switched_seats = "Estas ahora en el %{seat}"
    },
    general = {
        command_description = "Abrir Radial Menu",
        push_stretcher_button = "~g~E~w~ - empujar camilla",
        stop_pushing_stretcher_button = "~g~E~w~ - dejar de empujar",
        lay_stretcher_button = "[G] - Poner en camilla",
        push_position_drawtext = "Empuje aquí",
        get_off_stretcher_button = "[G] - Salir de la camilla",
        get_out_trunk_button = "[E] Salir del maletero",
        close_trunk_button = "[G] Cerrar el maletero",
        open_trunk_button = "[G] Abrir el maletero",
        getintrunk_command_desc = "Meterse en el maletero",
        putintrunk_command_desc = "Poner jugador en maletero"
    },
    options = {
        emergency_button = "Boton de emergencia",
        driver_seat = "Asiento del conductor",
        passenger_seat = "Asiento del pasajero",
        other_seats = "Otro asiento",
        rear_left_seat = "Asiento trasero izquierdo",
        rear_right_seat = "Asiento trasero derecho"
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
