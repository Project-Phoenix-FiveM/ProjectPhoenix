local Translations = {
    error = {
        not_your_vehicle = 'Acesta nu este vehiculul tau..',
        vehicle_does_not_exist = 'Vehiculul nu exista',
        not_enough_money = 'Nu ai suficienti bani',
        finish_payments = 'Trebuie sa achiti de platit ratele, inainte de a putea vinde vehiculul...',
        no_space_on_lot = 'Din pacate, nu mai sunt spatii pentru a pune masina la vanzare!',
        not_in_veh = 'Nu esti intr-un vehicul!',
        not_for_sale = 'Acest vehicul nu este de vanzare!',
    },
    menu = {
        view_contract = 'Vezi contractul',
        view_contract_int = '[E] Vezi contractul',
        sell_vehicle = 'Vinde vehiculul',
        sell_vehicle_help = 'Vinde vehiculul tau catre cetateni interesati',
        sell_back = 'Cumpara inapoi vehiculul!',
        sell_back_help = 'Cumpara-ti masina inapoi la un pret promotional!',
        interaction = '[E] Vinde vehicul',
    },
    success = {
        sold_car_for_price = 'Ai vandut vehiculul pentru suma de $%{value}',
        car_up_for_sale = 'Vehiculul tau a fost pus la vanzare! Pretul - $%{value}',
        vehicle_bought = 'Vehiculul a fost cumparat',
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Confirma / ~r~N~w~ - Anuleaza ~g~',
        vehicle_returned = 'Ti-a fost returnat vehiculul',
        used_vehicle_lot = 'Masini Second hand',
        sell_vehicle_to_dealer = '[~g~E~w~] - Vine vehiculul pentru suma de ~g~$%{value}',
        view_contract = '[~g~E~w~] - Vezi contractul',
        cancel_sale = '[~r~G~w~] - Anuleaza vanzarea vehiculului',
        model_price = '%{value}, Pret: ~g~$%{value2}',
        are_you_sure = 'Esti sigur(a) ca nu mai vrei sa vinzi acest vehicul?',
        yes_no = '[~g~7~w~] - Da | [~r~8~w~] - Nu',
        place_vehicle_for_sale = '[~g~E~w~] - Vanzare vehicul de la proprietar',
    },
    charinfo = {
        firstname = 'Necunoscut',
        lastname = 'Necunoscut',
        account = 'Necunoscut..',
        phone = 'Necunoscut..',
    },
    mail = {
        sender = 'Larrys RV Sales',
        subject = 'Un vehicul a fost vandut!',
        message = 'Ai castigat suma de $%{value} din vanzarea vehiculului %{value2}.',
    }
}

if GetConvar('qb_locale', 'en') == 'ro' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
