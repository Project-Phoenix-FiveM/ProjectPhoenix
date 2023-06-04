local Translations = {
    error = {
        no_deposit = "$%{value} dépôt requis",
        cancelled = "Annulé",
        vehicle_not_correct = "Ce n'est pas un véhicule Commercial!",
        no_driver = "Vous devez être le conducteur du véhicule!",
        no_work_done = "Vous n'avez pas encore travaillé.",
        backdoors_not_open = "Les portes arrière ne sont pas ouvertes",
        get_out_vehicle = "Vous devez sortir du véhicule",
        too_far_from_trunk = "Vous devez prendre les boites dans le coffre du véhicule",
        too_far_from_delivery = "Vous être trop loin du point de livraison"
    },
    success = {
        paid_with_cash = "$%{value} Depôt payé avec l'argent",
        paid_with_bank = "$%{value} Depôt payé avec la banque",
        refund_to_cash = "$%{value} Depôt payé avec l'argent",
        you_earned = "Vous avez gagné $%{value}",
        payslip_time = "Vous avez finis de travaillé... temps de récuperer votre paie",
    },
    menu = {
        header = "Camions disponibles",
        close_menu = "⬅ Fermer le Menu",
    },
    mission = {
        store_reached = "Vous avez atteint la destination, Récuperez une boite dans le coffre avec [E] et livrez-la au marqueur.",
        take_box = "Prenez une boite dans le coffre avec [E]",
        deliver_box = "Livrez la boite au marqueur",
        another_box = "Prenez une autre boite dans le coffre.",
        goto_next_point = "Aller au prochain point",
        return_to_station = "Vous avez livrer toute la marchandise, retournez au dépot",
        job_completed = "Vous avez fini votre parcours, Veuilllez collecter votre paie"
    },
    info = {
        deliver_e = "~g~E~w~ - Livrer la boite",
        deliver = "Livrer la boite",
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
