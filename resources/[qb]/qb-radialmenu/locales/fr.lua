local Translations = {
    error = {
        no_people_nearby = "Aucun joueur n'est à proximité.",
        no_vehicle_found = "Aucun véhicule n'a été retrouvé.",
        extra_deactivated = "%{extra} supplémentaires ont été désactivés.",
        extra_not_present = "%{extra} supplémentaires ne sont pas présents sur ce véhicule.",
        not_driver = "Tu n'es pas le conducteur de véhicule.",
        vehicle_driving_fast = "Ce véhicule va trop vite.",
        seat_occupied = "Ce siège est occupé.",
        race_harness_on = "Tu as un harnais de course. Tu ne peux pas changer.",
        obj_not_found = "Impossible de créer l'objet demandé.",
        not_near_ambulance = "Tu n'es pas près d'une ambulance.",
        far_away = "Tu es trop loin.",
        stretcher_in_use = "Cette civière est déjà utilisée.",
        not_kidnapped = "Tu n'as pas kidnappé cette personne.",
        trunk_closed = "Le coffre est fermé.",
        cant_enter_trunk = "Tu ne peux pas entrer dans ce coffre.",
        already_in_trunk = "Tu es déjà dans le coffre.",
        someone_in_trunk = "Quelqu'un est déjà dans le coffre."
    },
    success = {
        extra_activated = "%{extra} supplémentaires ont été activés.",
        entered_trunk = "Tu es dans le coffre."
    },
    info = {
        no_variants = "Il ne semble pas y avoir de variantes pour cela.",
        wrong_ped = "Ce modèle ped ne permet pas cette option.",
        nothing_to_remove = "Tu n'as rien à enlever.",
        already_wearing = "Tu le portes déjà.",
        switched_seats = "Tu es maintenant dans le %{seat}."
    },
    general = {
        command_description = "Ouvrer le Menu Radial",
        push_stretcher_button = "[E] - Pousser la Civière",
        stop_pushing_stretcher_button = "~g~E~w~ - Arrêter de Pousser",
        lay_stretcher_button = "[G] - Se Coucher sur la Civière",
        push_position_drawtext = "Poussez Ici",
        get_off_stretcher_button = "[G] - Descendre de la Civière",
        get_out_trunk_button = "[E] Sortir du Coffre",
        close_trunk_button = "[G] Fermer le Coffre",
        open_trunk_button = "[G] Ouvrir le Coffre",
        getintrunk_command_desc = "Entrer dans le Coffre",
        putintrunk_command_desc = "Mettre le Joueur dans le Coffre"
    },
    options = {
        emergency_button = "Le Bouton d'Urgence",
        driver_seat = "Le Siège du Conducteur",
        passenger_seat = "Le Siège Passager",
        other_seats = "L'Autre Siège",
        rear_left_seat = "Le Siège Arrière Gauche",
        rear_right_seat = "Le Siège Arrière Droit"
    },
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
