local Translations = {
    error = {
        not_your_vehicle = 'See ei ole sinu sõiduk..',
        vehicle_does_not_exist = 'Sõidukit ei eksisteeri',
        not_enough_money = 'Sul ei ole piisavalt raha',
        finish_payments = 'Peate lõpetama selle sõiduki tasumise, enne kui saate selle müüa.',
        no_space_on_lot = 'Krundil pole teie auto jaoks ruumi!'
    },
    success = {
        sold_car_for_price = 'Olete müünud oma auto hinnaga $%{value}',
        car_up_for_sale = 'Teie auto on müüki pandud! Hind – %{value} $',
        vehicle_bought = 'Sõiduk ostetud'
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Kinnita / ~r~N~w~ - Tühista ~g~',
        vehicle_returned = 'Teie sõiduk tagastatakse',
        used_vehicle_lot = 'Kasutatud autode plats',
        sell_vehicle_to_dealer = '[~g~E~w~] – müüge sõiduk edasimüüjale hinnaga ~g~$%{value}',
        view_contract = '[~g~E~w~] - Vaata sõiduki lepingut',
        cancel_sale = '[~r~G~w~] – Tühista sõidukite müük',
        model_price = '%{value}, hind: ~g~$%{value2}',
        are_you_sure = 'Kas olete kindel, et ei soovi enam oma sõidukit müüa?',
        yes_no = '[~g~7~w~] – jah | [~r~8~w~] – Ei',
        place_vehicle_for_sale = '[~g~E~w~] – sõiduki müük omaniku poolt'
    },
    charinfo = {
        firstname = 'mitte',
        lastname = 'teatud',
        account = 'Isik pole teada..',
        phone = 'telefoninumber pole teada..'
    },
    mail = {
        sender = 'Larrys RV Sales',
        subject = 'Olete müünud sõiduki!',
        message = 'Te teenisite oma %{value2} müügist $%{value}.'
    }
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end