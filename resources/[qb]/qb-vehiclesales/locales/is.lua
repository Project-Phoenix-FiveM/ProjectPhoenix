local Translations = {
    error = {
        not_your_vehicle = 'Þetta er ekki þitt farartæki..',
        vehicle_does_not_exist = 'Ökutæki er ekki til',
        not_enough_money = 'Þú átt ekki nóg af peningum',
        finish_payments = 'Þú verður að klára að borga af þessu ökutæki, áður en þú getur selt það..',
        no_space_on_lot = 'Það er ekki pláss fyrir bílinn þinn á lóðinni!'
    },
    success = {
        sold_car_for_price = 'Þú hefur selt bílinn þinn fyrir ISK%{value}',
        car_up_for_sale = 'Bíllinn þinn hefur verið settur á sölu! Verð - ISK%{value}',
        vehicle_bought = 'Vehicle Bought'
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Staðfesta / ~r~N~w~ - Afturkalla ~g~',
        vehicle_returned = 'Ökutækinu þínu er skilað',
        used_vehicle_lot = 'Notaður bíll lota',
        sell_vehicle_to_dealer = '[~g~E~w~] - Selja ökutæki til söluaðila fyrir ~g~ISK%{value}',
        view_contract = '[~g~E~w~] - Skoða samning um ökutæki',
        cancel_sale = '[~r~G~w~] - Hætta við sölu ökutækja',
        model_price = '%{value}, Verð: ~g~ISK%{value2}',
        are_you_sure = 'Ertu viss um að þú viljir ekki lengur selja bílinn þinn?',
        yes_no = '[~g~7~w~] - Já | [~r~8~w~] - Nei',
        place_vehicle_for_sale = '[~g~E~w~] - Settu ökutæki til sölu af eiganda'
    },
    charinfo = {
        firstname = 'ekki',
        lastname = 'þekktur',
        account = 'Reikningur ekki þekktur..',
        phone = 'símanúmer ekki þekkt..'
    },
    mail = {
        sender = 'Larrys RV Sales',
        subject = 'Þú hefur selt ökutæki!',
        message = 'Þú gerðir ISK%{value} frá sölu þinni %{value2}.'
    }
}

if GetConvar('qb_locale', 'en') == 'is' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
