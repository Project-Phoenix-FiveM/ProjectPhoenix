local Translations = {
    error = {
        no_money = 'مال غير كاف',
        too_far = 'أنت بعيد جدًا عن كشك هوت دوج الخاص بك',
        no_stand = 'ليس لديك حامل هوت دوج',
        cust_refused = 'العميل رفض',
        no_stand_found = 'لم يكن موقف النقانق الخاص بك في أي مكان يمكن رؤيته ، فلن تسترد وديعتك',
        no_more = 'المزيد عن هذا %{value} ليس لديك',
        deposit_notreturned = 'لم يكن لديك جناح هوت دوج',
    },
    success = {
        deposit = 'لقد دفعت إيداع %{deposit} دولارًا!',
        deposit_returned = 'تمت إعادة إيداعك بقيمة %{deposit} دولارًا',
        sold_hotdogs = '%{value} x Hotdog = $%{value2}',
        made_hotdog = 'هوت دوج %{value} قمت بعمل ',
        made_luck_hotdog = 'هوت دوج %{value} x %{value2} قمت بعمل ',
    },
    info = { -- you need font arabic --
        command = "حذف الحامل (المسؤول فقط)",
        blip_name = 'ﻖﻧﺎﻘﻧ ﺔﺑﺮﻋ',
        start_working = '[~g~E~s~] - ﻞﻤﻌﻟﺍ ﺀﺪﺑ',
        start_work = 'ﻞﻤﻌﻟﺍ ﺀﺪﺑ',
        stop_working = '[~g~E~s~] - ﻞﻤﻌﻟﺍ ﻦﻋ ﻒﻗﻮﺗ',
        stop_work = 'ﻞﻤﻌﻟﺍ ﻦﻋ ﻒﻗﻮﺗ',
        grab_stall = '[~g~G~s~] - ﻚﺸﻜﻟﺍ ﻚﻳﺮﺤﺗ',
        drop_stall = '[~g~G~s~] - ﻚﺸﻜﻟﺍ ﻙﺮﺗ',
        grab = 'ﻚﺸﻜﻟﺍ ﻚﻳﺮﺤﺗ',
        selling_prep = '[~g~E~s~] ﺝﻭﺩ ﺕﻮﻬﻟﺍ ﺮﻴﻀﺤﺗ / [~g~ﻊﻴﺒﺗ ﺖﻧﺍ~w~]',
        not_selling = '[~g~E~s~] ﺝﻭﺩ ﺕﻮﻬﻟﺍ ﺮﻴﻀﺤﺗ / [~r~ﻊﻴﺒﻟﺍ ﻦﻋ ﻒﻗﻮﺘﻣ~w~]',
        sell_dogs = '[~g~7~s~] %{value} x HotDogs = $%{value2} / [~g~8~s~] ﺾﻓﺭ',
        admin_removed = "إزالة موقف هوت دوج",
        label_a = "(A) الأفضل",
        label_b = "(B) متوسط",
        label_c = "(C) عادي"
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
