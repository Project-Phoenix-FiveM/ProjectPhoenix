local Translations = {
    error = {
        not_your_vehicle = 'Det här är inte ditt fordon..',
        vehicle_does_not_exist = 'Fordonet existerar inte',
        not_enough_money = 'Du har inte tillräckligt med pengar',
        finish_payments = 'Du måste avsluta avbetalningen för fordonet innan du kan sälja det..',
        no_space_on_lot = 'Det finns ingen plats för din bil på parkeringen!'
    },
    success = {
        sold_car_for_price = 'Du har sålt din bil för $%{value}',
        car_up_for_sale = 'Din bil har lagts ut till försäljning för $%{value}',
        vehicle_bought = 'Fordon köpt'
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Godkänn / ~r~N~w~ - Avbryt ~g~',
        vehicle_returned = 'Ditt fordon har lämnats tillbaka',
        used_vehicle_lot = 'Begagnade bilar',
        sell_vehicle_to_dealer = '[~g~E~w~] - Sälj fordonet till bilförsäljaren för ~g~$%{value}',
        view_contract = '[~g~E~w~] - Visa fordonskontrakt',
        cancel_sale = '[~r~G~w~] - Avbrut försäljning',
        model_price = '%{value}, Pris: ~g~$%{value2}',
        are_you_sure = 'Är du säker på att du inte längre vill sälja fordonet?',
        yes_no = '[~g~7~w~] - Ja | [~r~8~w~] - Nej',
        place_vehicle_for_sale = '[~g~E~w~] - Sätt fordonet till försäljning av ägaren'
    },
    charinfo = {
        firstname = 'Inte',
        lastname = 'Känt',
        account = 'Kontonummer okänt',
        phone = 'Telefonnummer okänt..'
    },
    mail = {
        sender = 'Blocket',
        subject = 'Din bil är såld!',
        message = 'Du fick $%{value} för försäljningen av din %{value2}.'
    }
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
