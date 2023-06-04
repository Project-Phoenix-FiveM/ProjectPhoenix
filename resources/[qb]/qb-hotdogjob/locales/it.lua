local Translations = {
    error = {
        no_money = 'Non hai abbastanza soldi',
        too_far = 'Sei troppo lontano dal tuo chiosco degli Hot Dog',
        no_stand = 'Non hai un chiosco di hotdog',
        cust_refused = 'Il cliente ha rifiutato!',
        no_stand_found = 'Il tuo chiosco degli hot dog non è stato riconsegnato, non ricevererai il tuo deposito indietro!',
        no_more = 'Non hai nessun %{value} davanti al chiosco',
        deposit_notreturned = 'Non hai un chiosco degli Hot Dog',
    },
    success = {
        deposit = 'Hai pagato un deposito di $%{deposit}!',
        deposit_returned = 'Il tuo deposito di $%{deposit} ti è stato restituito!',
        sold_hotdogs = '%{value} x Hotdog venduti per $%{value2}',
        made_hotdog = 'Hai prodotto un %{value} Hot Dogs',
        made_luck_hotdog = 'Hai prodotto %{value} x %{value2} Hot Dogs',
    },
    info = {
        command = "Cancella chiosco (Solo Admin)",
        blip_name = 'Chiosco Hotdog',
        start_working = '[~g~E~s~] Inizia a lavorare',
        start_work = 'Inizia a lavorare',
        stop_working = '[~g~E~s~] Smetti di lavorare',
        stop_work = 'Smetti di lavorare',
        grab_stall = '[~g~G~s~] Prendi chiosco',
        drop_stall = '[~g~G~s~] Lascia chiosco',
        grab = 'Prendi chiosco',
        selling_prep = '[~g~E~s~] Prepara Hotdog [Vendite: ~g~Vendendo~w~]',
        not_selling = '[~g~E~s~] Prepara Hotdog [Vendite: ~r~Non vendendo~w~]',
        sell_dogs = '[~g~7~s~] Vendi %{value} x HotDogs per $%{value2} / [~g~8~s~] Rifiuta',
        admin_removed = "Chiosco Hot Dog rimosso",
        label_a = "Perfetto (A)",
        label_b = "Raro (B)",
        label_c = "Comune (C)"
    }
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
