local Translations = {
    error = {
        ["cancled"] = "Annullato",
        ["no_truck"] = "Non hai un camion!",
        ["not_enough"] = "Non hai abbastanza soldi, (%{value} richiesti per la cauzione)",
        ["too_far"] = "Sei troppo lontano dal punto di consegna",
        ["early_finish"] = "A causa della fine anticipata (Completati: %{completed} Totali: %{total}), la cauzione non verrà restituita",
        ["never_clocked_on"] = "Non hai mai timbrato il cartellino!",
        ["job"] = "Devi ottenere il lavoro dal centro per l'impiego",
    },
    success = {
        ["clear_routes"] = "Percorso cancellato. Avevi %{value} percorsi",
        ["pay_slip"] = "Hai ottenuto $%{total} in busta paga più %{deposit} e sono stati accreditati sul tuo conto bancario!",
    },
    target = {
        ["talk"] = 'Talk to Garbageman',
        ["grab_garbage"] = "Grab garbage bag",
        ["dispose_garbage"] = "Dispose Garbage Bag",
    },
    menu = {
        ["header"] = "Garbage Main Menu",
        ["collect"] = "Collect Paycheck",
        ["return_collect"] = "Return truck and collect paycheck here!",
        ["route"] = "Request Route",
        ["request_route"] = "Request a garbage Route",
    },
    info = {
        ["payslip_collect"] = "[E] - Busta paga",
        ["payslip"] = "Busta paga",
        ["not_enough"] = "Non hai abbastanza soldi.. La cauzione costa $%{value}",
        ["deposit_paid"] = "Hai pagato $%{value} per la cauzione!",
        ["no_deposit"] = "Non hai versato alcuna cauzione su questo veicolo..",
        ["truck_returned"] = "Camion depositato, ritira la busta paga per ricevere la paga e la cauzione!",
        ["bags_left"] = "Ci sono %{value} sacchi da raccogliere!",
        ["bags_still"] = "Ci sono ancora %{value} sacchi da raccogliere!",
        ["all_bags"] = " Hai preso tutti i sacchi della spazzatura, procedi alla posizione successiva!",
        ["depot_issue"] = "C'è stato un problema al deposito, torna al deposito!",
        ["done_working"] = "Hai finito di lavorare! Torna al deposito.",
        ["started"] = "Hai iniziato a lavorare, posizione segnata sul GPS!",
        ["grab_garbage"] = "[E] Prendi un sacco della spazzatura",
        ["stand_grab_garbage"] = "Prendi un sacco della spazzatura",
        ["dispose_garbage"] = "[E] Smaltisci il sacco della spazzatura",
        ["progressbar"] = "Mettendo il sacco nel camion..",
        ["garbage_in_truck"] = "Metti il sacco nel camion..",
        ["stand_here"] = "Stai qui..",
        ["found_crypto"] = "Hai trovato una cryptostick!",
        ["payout_deposit"] = "(+ $%{value} di cauzione)",
        ["store_truck"] =  "[E] - Deposita camion",
        ["get_truck"] =  "[E] - Camion della spazzatura",
        ["picking_bag"] = "Grabbing garbage bag..",
        ["talk"] = "[E] Talk to Garbage Man",
    },
    warning = {},
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
