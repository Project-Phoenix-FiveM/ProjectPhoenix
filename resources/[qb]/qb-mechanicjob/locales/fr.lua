local Translations = {
    labels = {
        engine = "Moteur",
        bodsy = "Carrosserie",
        radiator = "Radiateur",
        axle = "Arbre d'entraînement",
        brakes = "Freins",
        clutch = "Embrayage",
        fuel = "Réservoir de carburant",
        sign_in = "Prise de service",
        sign_off = "Fin de service",
        o_stash = "[E] - Ouvrir Coffre",
        h_vehicle = "[E] - Cacher Véhicule",
        g_vehicle = "[E] - Obtenir Véhicule",
        o_menu = "[E] - Ouvrir Menu",
        work_v = "[E] - Travailler sur le véhicule",
        progress_bar = "Réparation...",
        veh_status = "Statut du véhicule:",
        job_blip = "Mécanicien Automobile"
    },

    lift_menu = {
        header_menu = "Options du véhicule",
        header_vehdc = "Débrancher le véhicule",
        desc_vehdc = "Détacher le véhicule du monte-charge",
        header_stats = "Vérifier le statut",
        desc_stats = "Vérifier le statut du véhicule",
        header_parts = "Pièces du véhicules",
        desc_parts = "Réparation de pièces du véhicules",
        c_menu = "⬅ Close Menu"
    },

    parts_menu = {
        status = "Statut: ",
        menu_header = "Menu des pièces",
        repair_op = "Réparer:",
        b_menu = "⬅ Retour",
        d_menu = "Retour aux pièces",
        c_menu = "⬅ Fermer"
    },

    nodamage_menu = {
        header = "Non endommagé",
        bh_menu = "Retour",
        bd_menu = "Cette pièce est en parfait état.",
        c_menu = "⬅ Fermer"
    },

    notifications = {
        not_enough = "Vous n'avez pas assez",
        not_have = "Vous n'avez pas",
        not_materials = "Il n'y a pas assez de matériaux dans le coffre",
        rep_canceled = "Réparation annulée",
        repaired = "a été réparé !",
        uknown = "Statut inconnu",
        not_valid = "Véhicule non valide",
        not_close = "Vous n'êtes pas assez près du véhicule",
        veh_first = "Vous devez d'abord être dans le véhicule",
        outside = "Vous devez être à l'extérieur du véhicule",
        wrong_seat = "Vous n'êtes pas le conducteur ou dans un véhicule",
        not_vehicle = "Vous n'êtes pas dans un véhiculee",
        progress_bar = "Réparation du véhicule...",
        process_canceled = "Processus annulé",
        not_part = "Pas une pièce valable",
        partrep ="La %{value} est réparée !"
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
