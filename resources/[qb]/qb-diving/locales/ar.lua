local Translations = {
    error = {
        ["canceled"] = "تم الالغاء",
        ["911_chatmessage"] = "911 رسالة",
        ["take_off"] = "/divingsuit لنزع بدلة الغوص الخاصة بك",
        ["not_wearing"] = "أنت لا ترتدي معدات الغوص",
        ["no_coral"] = "ليس لديك أي مرجان للبيع",
        ["not_standing_up"] = "الوقوف لاستخدام خزان الأكسجين",
    },
    success = {
        ["took_out"] = "جاري اخد لباس الغوض",
    },
    info = {
        ["collecting_coral"] = "جمع المرجان",
        ["diving_area"] = "ﺹﻮﻐﻟﺍ ﺔﻘﻄﻨﻣ", -- you need to add font arabic
        ["collect_coral"] = "جمع المرجان",
        ["collect_coral_dt"] = "[E] - جمع المرجان",
        ["checking_pockets"] = "فحص الحقيبة لبيع المرجان",
        ["sell_coral"] = "بيع المرجان",
        ["sell_coral_dt"] = "[E] - بيع المرجان",
        ["blip_text"] = "موقع الغوص 991",
        ["put_suit"] = "وضعت  بدلة الغوص",
        ["pullout_suit"] = "ترك بدلة الغوص",
        ["cop_msg"] = "سرقة المرجان",
        ["cop_title"] = "الغوص غير القانوني",
        ["command_diving"] = "خلع بدلة الغوص الخاصة بك",
    },
    warning = {
        ["oxygen_one_minute"] = "لديك أقل من ستين ثانية متبقية",
        ["oxygen_running_out"] = "الأكسجين ينفد منك",
    },
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
