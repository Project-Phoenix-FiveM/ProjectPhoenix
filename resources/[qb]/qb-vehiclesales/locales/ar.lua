local Translations = {
    error = {
        not_your_vehicle = 'هذه ليست سيارتك',
        vehicle_does_not_exist = 'السيارة غير موجودة',
        not_enough_money = 'ليس لديك ما يكفي من المال',
        finish_payments = 'يجب عليك إنهاء سداد هذه السيارة قبل بيعها',
        no_space_on_lot = 'لا توجد مساحة لسيارتك'
    },
    success = {
        sold_car_for_price = '$%{value} لقد قمت ببيع سيارتك مقابل',
        car_up_for_sale = '$%{value} سيارتك معروضة للبيع مقابل',
        vehicle_bought = 'السيارة تم شراؤها'
    },
    info = {
        confirm_cancel = '~g~Y~w~ - ﺀﺍﺮﺷ / ~r~N~w~ - ﺀﺎﻐﻟﺍ ~g~',
        vehicle_returned = 'يتم إرجاع سيارتك',
        used_vehicle_lot = 'سيارات مستعملة',
        sell_vehicle_to_dealer = '[~g~E~w~] - ~g~$%{value} ~w~ﻞﺑﺎﻘﻣ ﺮﺟﺎﺘﻠﻟ ﺓﺭﺎﻴﺴﻟﺍ ﻊﻴﺑ',
        view_contract = '[~g~E~w~] - ﺔﺒﻛﺮﻤﻟﺍ ﺪﻘﻋ ﺽﺮﻋ',
        cancel_sale = '[~r~G~w~] - ﺓﺭﺎﻴﺴﻟﺍ ﻊﻴﺑ ﺀﺎﻐﻟﺇ',
        model_price = '%{value}, :ﺮﻌﺴﻟﺍ ~g~$%{value2}',
        are_you_sure = '؟ﻚﺗﺭﺎﻴﺳ ﻊﻴﺑ ﻲﻓ ﺐﻏﺮﺗ ﺪﻌﺗ ﻢﻟ ﻚﻧﺃ ﺪﻛﺄﺘﻣ ﺖﻧﺃ ﻞﻫ',
        yes_no = '[~g~7~w~] - ﻢﻌﻧ | [~r~8~w~] - ﻻ',
        place_vehicle_for_sale = '[~g~E~w~] - ﻊﻴﺒﻠﻟ ﺓﺭﺎﻴﺴﻟﺍ ﻊﺿﻭ'
    },
    charinfo = {
        firstname = 'ليس',
        lastname = 'معروف',
        account = 'الحساب غير معروف',
        phone = 'رقم الهاتف غير معروف'
    },
    mail = {
        sender = 'السيارات المستعملة',
        subject = 'لقد قمت ببيع سيارة',
        message = '$%{value} = %{value2} تم البيع'
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
