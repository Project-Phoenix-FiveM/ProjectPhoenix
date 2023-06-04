local Translations = {
    error = {
        not_your_vehicle = 'Dit is niet jouw voertuig..',
        vehicle_does_not_exist = 'Voertuig bestaat niet',
        not_enough_money = 'Je hebt geen genoeg geld',
        finish_payments = 'Je moet dit voertuig afbetalen voordat je het kunt verkopen..',
        no_space_on_lot = 'Er is geen ruimte voor je voertuig op de kavel!'
    },
    success = {
        sold_car_for_price = 'je hebt je auto verkocht voor $%{value}',
        car_up_for_sale = 'Je auto is te koop gezet! Prijs - $%{value}',
        vehicle_bought = 'Voertuig Gekocht'
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Bevestigen / ~r~N~w~ - Annuleren ~g~',
        vehicle_returned = 'Je voertuig wordt teruggebracht',
        used_vehicle_lot = 'Tweedehands Auto',
        sell_vehicle_to_dealer = '[~g~E~w~] - Verkoop voertuig aan dealer voor ~g~$%{value}',
        view_contract = '[~g~E~w~] - Voertuigcontract bekijken',
        cancel_sale = '[~r~G~w~] - Verkoop Annuleren',
        model_price = '%{value}, Prijs: ~g~$%{value2}',
        are_you_sure = 'Weet je zeker dat je je voertuig niet langer wilt verkopen?',
        yes_no = '[~g~7~w~] - Ja | [~r~8~w~] - Nee',
        place_vehicle_for_sale = '[~g~E~w~] - Plaats voertuig te koop door eigenaar'
    },
    charinfo = {
        firstname = 'niet',
        lastname = 'bekend',
        account = 'Account niet bekend..',
        phone = 'telefoonnummer niet bekend..'
    },
    mail = {
        sender = 'TweedeKansje',
        subject = 'Je hebt een voertuig verkocht!',
        message = 'Je hebt $%{value} verdiend met de verkoop van je %{value2}.'
    }
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
