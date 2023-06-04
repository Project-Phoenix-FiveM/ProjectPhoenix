local Translations = {
    error = {
        ["invalid_job"] = "Je ne pense pas que je travaille ici...",
        ["invalid_items"] = "Vous n'avez pas les bons items !",
        ["no_items"] = "Vous n'avez aucun item !",
    },
    progress = {
        ["pick_grapes"] = "Vendange...",
        ["process_grapes"] = "Traitement des raisins...",
    },
    task = {
        ["start_task"] = "[E] pour Démarrer",
        ["load_ingrediants"] = "[E] Chargement des ingredients",
        ["wine_process"] = "[E] Démarrage du traitement du vin",
        ["get_wine"] = "[E] Récupérer vin",
        ["make_grape_juice"] = "[E] Faire du jus de raisin",
        ["countdown"] = "Temps restant %{time}s",
        ['cancel_task'] = "Vous avez annulé la tâche"
    },
    text = {
        ["start_shift"] = "Vous avez commencé votre shift au vignoble !",
        ["end_shift"] = "Votre shift au vignoble est fini !",
        ["valid_zone"] = "Zone Valide !",
        ["invalid_zone"] = "Zone Invalide!",
        ["zone_entered"] = "%{zone} Entrée de zone",
        ["zone_exited"] = "%{zone} Sortie de zone",
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang
    })
end
