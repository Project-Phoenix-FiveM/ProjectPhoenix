local Translations = {
    error = {
        ["missing_something"] = "Il vous manque quelque chose...",
        ["not_enough_police"] = "Pas assez de policiers..",
        ["door_open"] = "La porte est déjà ouverte..",
        ["cancelled"] = "Annulé..",
        ["didnt_work"] = "Ca n'a pas marché..",
        ["emty_box"] = "La boite est vide..",
        ["injail"] = "Vous êtes en prison pour %{Time} mois..",
        ["item_missing"] = "Il vous manque un objet..",
        ["escaped"] = "Vous-vous êtes échappé... Courrez !",
        ["do_some_work"] = "Travaillez pour réduire votre peine, Travail actuel: %{currentjob} ",
        ["security_activated"] = "Le niveau de sécurité le plus élevé est actif, restez dans les blocs de cellules!"
    },
    success = {
        ["found_phone"] = "Vous avez trouvé un téléphone..",
        ["time_cut"] = "Vous avez reçu une réduction de peine.",
        ["free_"] = "Vous êtes libre! Profitez-en! :)",
        ["timesup"] = "Votre peine a été purgée! Rendez-vous au centre des visites !",
    },
    info = {
        ["timeleft"] = "Il vous reste encore... %{JAILTIME} mois",
        ["lost_job"] = "Vous êtes au chômage",
        ["job_interaction"] = "[E] Travailler sur l'électricité",
        ["job_interaction_target"] = "Travailler : %{job}",
        ["received_property"] = "Vous avez récupéré vos affaires personnelles..",
        ["seized_property"] = "Vos affaires ont été saisies, vous récupérerez tout lorsque votre peine sera écoulée..",
        ["cells_blip"] = "Cellules",
        ["freedom_blip"] = "Réception de la prison",
        ["canteen_blip"] = "Cantine",
        ["work_blip"] = "Travail pénitentiaire",
        ["target_freedom_option"] = "Vérifier temps restant",
        ["target_canteen_option"] = "Obtenir de la nourriture",
        ["police_alert_title"] = "Nouvel appel",
        ["police_alert_description"] = "Evasion de Prison",
        ["connecting_device"] = "Connecter l'appareil",
        ["working_electricity"] = "Connecter les fils"
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
