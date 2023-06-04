local Translations = {
    error = {
        not_your_vehicle = 'Dies ist nicht Ihr Fahrzeug..',
        vehicle_does_not_exist = 'Das Fahrzeug existiert nicht',
        not_enough_money = 'Sie haben nicht genug Geld',
        finish_payments = 'Sie müssen dieses Fahrzeug abbezahlen, bevor Sie es verkaufen können.',
        no_space_on_lot = 'Es gibt keinen Platz für Ihr Auto auf dem Parkplatz!',
        not_in_veh = 'Sie befinden sich nicht in einem Fahrzeug!',
        not_for_sale = 'Dieses Fahrzeug steht nicht zum verkauf!',
    },
    menu = {
        view_contract = 'Vertrag ansehen',
        view_contract_int = '[E] Vertrag ansehen',
        sell_vehicle = 'Fahrzeug verkaufen',
        sell_vehicle_help = 'Fahrzeug an Mitbürger verkaufen!',
        sell_back = 'Auto zurückkaufen!',
        sell_back_help = 'Verkaufen Sie Ihr Auto sofort zu einem reduzierten Preis zurück!',
        interaction = '[E] Fahrzeug verkaufen',
    },
    success = {
        sold_car_for_price = 'Sie haben Ihr Auto verkauft für $%{value}',
        car_up_for_sale = 'Ihr Auto ist zum Verkauf angeboten worden! Preis - $%{value}',
        vehicle_bought = 'Gekauftes Fahrzeug',
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Bestätigen / ~r~N~w~ - Abbrechen ~g~',
        vehicle_returned = 'Ihr Fahrzeug wird zurückgebracht',
        used_vehicle_lot = 'Gebrauchtwagenplatz',
        sell_vehicle_to_dealer = '[~g~E~w~] - Fahrzeug an Händler verkaufen für ~g~$%{value}',
        view_contract = '[~g~E~w~] - Fahrzeugvertrag ansehen',
        cancel_sale = '[~r~G~w~] - Fahrzeugverkauf stornieren',
        model_price = '%{value}, Preis: ~g~$%{value2}',
        are_you_sure = 'Sind Sie sicher, dass Sie Ihr Fahrzeug nicht mehr verkaufen wollen?',
        yes_no = '[~g~7~w~] - Ja | [~r~8~w~] - Nein',
        place_vehicle_for_sale = '[~g~E~w~] - Platziere Fahrzeug zum Verkauf',
    },
    charinfo = {
        firstname = 'Vorname',
        lastname = 'Nachname',
        account = 'Konto nicht bekannt..',
        phone = 'Telefonnummer nicht bekannt..',
    },
    mail = {
        sender = 'Larrys RV-Verkäufe',
        subject = 'Sie haben ein Fahrzeug verkauft!',
        message = 'Sie haben $%{value} aus dem Verkauf Ihrer %{value2}.',
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
