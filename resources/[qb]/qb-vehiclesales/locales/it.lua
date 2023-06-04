local Translations = {
    error = {
        not_your_vehicle = 'Questo non è il tuo veicolo..',
        vehicle_does_not_exist = 'Il veicolo non esiste',
        not_enough_money = 'Non hai abbastanza soldi',
        finish_payments = 'Devi finire di pagare questo veicolo, prima di poterlo vendere..',
        no_space_on_lot = 'Non c\'è spazio per la vostra auto sul lotto!'
    },
    success = {
        sold_car_for_price = 'Hai venduto la tua auto per $%{value}',
        car_up_for_sale = 'La tua auto è stata messa in vendita! Prezzo - $%{value}',
        vehicle_bought = 'Veicolo Acquistato'
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Conferma / ~r~N~w~ - Annulla ~g~',
        vehicle_returned = 'Il tuo veicolo è stato restituito',
        used_vehicle_lot = 'Lotto di veicoli usati',
        sell_vehicle_to_dealer = '[~g~E~w~] - Vendi veicolo al rivenditore per ~g~$%{value}',
        view_contract = '[~g~E~w~] - Visualizza contratto veicolo',
        cancel_sale = '[~r~G~w~] - Annullar la vendita del veicolo',
        model_price = '%{value}, Prezzo: ~g~$%{value2}',
        are_you_sure = 'Sei sicuro di non voler più vendere il tuo veicolo?',
        yes_no = '[~g~7~w~] - Si | [~r~8~w~] - No',
        place_vehicle_for_sale = '[~g~E~w~] - Metti veicolo in vendita'
    },
    charinfo = {
        firstname = 'non',
        lastname = 'conosciuto',
        account = 'Conto non noto..',
        phone = 'numero di telefono non noto..'
    },
    mail = {
        sender = 'Usato Larrys',
        subject = 'Hai venduto un veicolo!',
        message = 'Hai ricevuto $%{value} dalla vendite della tua %{value2}.'
    }
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
