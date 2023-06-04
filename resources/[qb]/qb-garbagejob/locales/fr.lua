local Translations = {
    error = {
        ["cancled"] = "Annulé",
        ["no_truck"] = "Vous n'avez pas de camion!",
        ["not_enough"] = "Pas assez d'argent (%{value} requis)",
        ["too_far"] = "Vous êtes trop loin du point de dépôt",
        ["early_finish"] = "En raison de votre performance (Complété: %{completed} sur Total: %{total}), votre caution ne sera pas restituée.",
        ["never_clocked_on"] = "Tu n'as pas assez travaillé pour être payé!",
        ["job"] = "Vous devez obtenir le poste auprès du Pôle Emploi",
    },
    success = {
        ["clear_routes"] = "Optimisations des itinéraires, il y'avait %{value} itinéraires enregistrés",
        ["pay_slip"] = "Vous avez eu $%{total}, votre salaire de %{deposit} a été transféré à votre compte bancaire!",
    },
    target = {
        ["talk"] = 'Parler avec le patron',
        ["grab_garbage"] = "Prendre le sac",
        ["dispose_garbage"] = "Déposer le sac",
    },
    info = {
        ["payslip_collect"] = "[E] - Recevoir sa fiche de paie",
        ["payslip"] = "fiche de paie",
        ["not_enough"] = "Vous n'avez pas assez d'argent pour la caution. Les frais de caution sont de $%{value}",
        ["deposit_paid"] = "Vous avez payé $%{value} de caution!",
        ["no_deposit"] = "Vous n'avez pas de caution payée pour ce véhicule..",
        ["truck_returned"] = "Camion garé, récupérez votre fiche de paie pour recevoir votre paie et reprendre votre caution!",
        ["bags_left"] = "Il reste %{value} sac poubelle!",
        ["bags_still"] = "Il reste encore %{value} sac poubelle!",
        ["all_bags"] = "Tous les sacs à ordures ont été collecté, passez à l'emplacement suivant!",
        ["depot_issue"] = "Il y a eu un problème au dépôt, veuillez revenir immédiatement!",
        ["done_working"] = "Vous avez fini de tournée ! Retournez au dépôt.",
        ["started"] = "Vous avez commencé à travailler, emplacement marqué sur le GPS!",
        ["grab_garbage"] = "[E] Attraper un sac poubelle",
        ["stand_grab_garbage"] = "Tenez-vous ici pour attraper un sac poubelle.",
        ["dispose_garbage"] = "[E] Jeter le sac poubelle",
        ["progressbar"] = "En train de mettre le sac dans la benne à ordures..",
        ["garbage_in_truck"] = "Jeter le sac dans la benne à ordures..",
        ["stand_here"] = "Tenez vous ici..",
        ["found_crypto"] = "Vous avez trouvé une cryptostick sur le sol",
        ["payout_deposit"] = "(+ $%{value} deposit)",
        ["store_truck"] =  "[E] - Garer le Camion Benne",
        ["get_truck"] =  "[E] - Sortir un Camion Benne",
        ["picking_bag"] = "Grabbing garbage bag..",
        ["talk"] = "[E] Talk to Garbage Man",
    },
    warning = {},
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
