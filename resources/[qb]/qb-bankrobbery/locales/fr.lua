local Translations = {
    success = {
        success_message = "Succès",
        fuses_are_blown = "Les fusibles ont sauté",
        door_has_opened = "La porte a été ouverte"
    },
    error = {
        cancel_message = "Annulé",
        safe_too_strong = "Il semble que le verrou de la banque soit trop fort...",
        missing_item = "Il vous manque un objet...",
        bank_already_open = "La banque est déjà ouverte...",
        minimum_police_required = "Il faut au moins %{police} policiers pour ouvrir la porte",
        security_lock_active = "Le verrou de sécurité est actif, ouverture de la porte impossible",
        wrong_type = "%{receiver} n'a pas reçu le bon type pour l'argument '%{argument}'\nreçu type: %{receivedType}\nreçu valeur: %{receivedValue}\n attendu type: %{expected}",
        fuses_already_blown = "Les fusibles sont déjà sautés...",
        event_trigger_wrong = "%{event}%{extraInfo} a été déclenché quand certaines conditions n'ont pas été remplies, source: %{source}",
        missing_ignition_source = "Il vous manque une source d'allumage"
    },
    general = {
        breaking_open_safe = "Ouvre le coffre...",
        connecting_hacking_device = "Connecte le matériel de hack...",
        fleeca_robbery_alert = "Tentative de braquage de la Fleeca Bank",
        paleto_robbery_alert = "Tentative de braquage de la Blain County Savings Bank",
        pacific_robbery_alert = "Tentative de braquage de la Pacific Standard",
        break_safe_open_option_target = "Ouvrir le coffre",
        break_safe_open_option_drawtext = "[E] Ouvrir le coffre",
        validating_bankcard = "Validation de la carte...",
        thermite_detonating_in_seconds = "Thermite va exploser dans %{time} seconde(s)",
        bank_robbery_police_call = "10-90: Braquage de banque"
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
