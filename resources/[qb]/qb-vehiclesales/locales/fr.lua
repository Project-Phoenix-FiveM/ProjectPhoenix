local Translations = {
    error = {
        not_your_vehicle = 'Ce n\'est pas votre véhicule..',
        vehicle_does_not_exist = 'Le véhicule n\'existe pas',
        not_enough_money = 'Vous n\'avez pas assez d\'argent',
        finish_payments = 'Vous devez finir de financer le véhicule avant de pouvoir le vendre..',
        no_space_on_lot = 'Il n\'y a plus de place pour votre véhicule!'
    },
    success = {
        sold_car_for_price = 'Vous avez vendu votre véhicule pour: $%{value}',
        car_up_for_sale = 'Votre véhicule a été mis en vente! Prix - $%{value}',
        vehicle_bought = 'Véhicule acheté !'
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Confirmer / ~r~N~w~ - Annuler ~g~',
        vehicle_returned = 'Votre véhicule a été retourné',
        used_vehicle_lot = 'Vendeur de voitures d\'occasion',
        sell_vehicle_to_dealer = '[~g~E~w~] - Vendre le véhicule pour ~g~$%{value}',
        view_contract = '[~g~E~w~] - Voir le contrat',
        cancel_sale = '[~r~G~w~] - Annuler la vente',
        model_price = '%{value}, Prix: ~g~$%{value2}',
        are_you_sure = 'Êtes vous sûr de ne plus vouloir vendre le véhicule?',
        yes_no = '[~g~7~w~] - Oui | [~r~8~w~] - Non',
        place_vehicle_for_sale = '[~g~E~w~] - Placer le vehicule en vente'
    },
    charinfo = {
        firstname = 'Pas',
        lastname = 'Connu',
        account = 'Compte Inconnu..',
        phone = 'Numéro Inconnu..'
    },
    mail = {
        sender = 'Larrys RV Sales',
        subject = 'Vous avez vendu un véhicule!',
        message = 'Vous avez gagné $%{value} Pour la vente de votre %{value2}.'
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
