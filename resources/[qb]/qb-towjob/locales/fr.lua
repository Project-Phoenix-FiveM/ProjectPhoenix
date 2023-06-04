local Translations = {
    error = {
        finish_work = "Dabord finissez votre travail",
        vehicle_not_correct = "ce n'est pas le bon véhicule",
        failed = "échec",
        not_towing_vehicle = "Vous devez être dans une dépanneuse",
        too_far_away = 'Vous êtes trop loin',
        no_work_done = "Vous n'avez pas encore travaillé.",
        no_deposit = "$%{value} dépôt requis",
    },
    success = {
        paid_with_cash = "$%{value} Depôt payé avec l'argent",
        paid_with_bank = "$%{value} Depôt payé avec la banque",
        refund_to_cash = "$%{value} Depôt payé avec l'argent",
        you_earned = "You Earned $%{value}",
    },
    menu = {
        header = "Dépaneuses disponibles",
        close_menu = "⬅ Fermer le Menu",
    },
    mission = {
        delivered_vehicle = "Vous avez livré un véhicule",
        get_new_vehicle = "Un nouveau véhicule peut être récupéré",
        towing_vehicle = "Dépanage du véhicule...",
        goto_depot = "Amenez le véhicule à l'entrepôt",
        vehicle_towed = "Véhicule dépanné",
        untowing_vehicle = "Retirer le véhicule",
        vehicle_takenoff = "Véhicule retiré",
    },
    info = {
        tow = "Placez un véhicule sur le dessus de votre dépanneuse",
        toggle_npc = "Activer Mission PNJ",
        skick = "Tentative d'exploit",
    },
    label = {
        payslip = "Paie",
        vehicle = "Vehicule",
        npcz = "ZonePNJ",
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
