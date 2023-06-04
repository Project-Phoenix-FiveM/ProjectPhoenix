local Translations = {
    error = {
        no_people_nearby = "Nessun cittadino nelle vicinanze",
        no_vehicle_found = "Nessun veicolo trovato",
        extra_deactivated = "Extra %{extra} è stato disattivato",
        extra_not_present = "Extra %{extra} non è presente su questo veicolo",
        not_driver = "Non sei il conducente del veicolo",
        vehicle_driving_fast = "Questo veicolo sta andando troppo veloce",
        seat_occupied = "Questo posto è occupato",
        race_harness_on = "Hai un'imbracatura da corsa, non puoi cambiare posto",
        obj_not_found = "Impossibile creare l'oggetto richiesto",
        not_near_ambulance = "Non sei vicino ad un'ambulanza",
        far_away = "Sei troppo lontano",
        stretcher_in_use = "Questa barella è già in uso",
        not_kidnapped = "Non hai rapito questa persona",
        trunk_closed = "Il bagagliaio è chiuso",
        cant_enter_trunk = "Non puoi entrare in questo bagagliaio",
        already_in_trunk = "Sei già nel bagagliaio",
        someone_in_trunk = "Qualcuno è già nel bagagliaio"
    },
    success = {
        extra_activated = "Extra %{extra} è stato attivato",
        entered_trunk = "Tu sei nel bagagliaio"
    },
    info = {
        no_variants = "Non sembrano esserci varianti per questo",
        wrong_ped = "Questo modello ped non consente questa opzione",
        nothing_to_remove = "Sembra che tu non abbia niente da rimuovere",
        already_wearing = "Lo stai già indossando",
        switched_seats = "Ora sei sul %{seat}"
    },
    general = {
        command_description = "Apri menu radiale",
        push_stretcher_button = "[E] - Spingi barella",
        stop_pushing_stretcher_button = "~g~E~w~ - Smetti di spingere",
        lay_stretcher_button = "[G] - Sdraiati sulla barella",
        push_position_drawtext = "Spingi qui",
        get_off_stretcher_button = "[G] - Scendi dalla barella",
        get_out_trunk_button = "[E] Esci dal bagagliaio",
        close_trunk_button = "[G] Chiudi il bagagliaio",
        open_trunk_button = "[G] Apri il bagagliaio",
        getintrunk_command_desc = "Entra nel bagagliaio",
        putintrunk_command_desc = "Metti cittadino nel bagagliaio"
    },
    options = {
        emergency_button = "Bottone di emergenza",
        driver_seat = "sedile del conducente",
        passenger_seat = "sedile del passeggero",
        other_seats = "sedile",
        rear_left_seat = "sedile posteriore sinistro",
        rear_right_seat = "sedile posteriore destro"
    },
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
