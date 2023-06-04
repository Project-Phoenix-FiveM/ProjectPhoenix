local Translations = {
    error = {
        not_enough = "لا تملك مال كافي",
        no_slots = "لا توجد فتحات",
        occured = "حدث خطأ",
        have_keys = "هذا الشخص لديه بالفعل مفاتيح",
        p_have_keys = "%{value} هذا الشخص لديه بالفعل مفاتيح",
        not_owner = "أنت لا تملك مفتاح أو لست المالك",
        not_online = "هذا الشخص ليس في المدينة",
        no_money = "ليس هناك أي أموال في خزانة",
        incorrect_code = "هذا الكود غير صحيح",
        up_to_6 = "يمكنك اعطاء النفتاح الى 6 أشخاص فقط",
        cancelled = "عمليات التحصيل ملغية",
    },
    success = {
        added = "%{value} تم اضافتها الى التراب هاوس",
    },
    info = {
        enter = "دخول تراب هاوس",
        give_keys = "اعطاء مفاتيح التراب هاوس",
        pincode = "%{value} الكود هو",
        taking_over = "جاري",
        pin_code_see = "~b~G~w~ - ﺩﻮﻜﻟﺍ ﺽﺮﻋ", -- you need font arabic
        pin_code = "%{value} الكود هو",
        multikeys = "~b~/multikeys~w~ [id] - ﺢﻴﺗﺎﻔﻤﻟﺍ ﺀﺎﻄﻋﺍ",
        take_cash = "~b~E~w~ - (~g~$%{value}~w~) ﻞﻴﺼﺤﺗ",
        inventory = "~b~H~w~ - ﺔﻧﺰﺨﻟﺍ ﺽﺮﻋ",
        take_over = "~b~E~w~ - (~g~$5000~w~) ﻲﻟﻮﺗ",
        leave = "~b~E~w~ - ﺝﻭﺮﺧ",
    },
    targetInfo = {
        options = "التراب هاوس",
        enter = "دخول",
        give_keys = "اعطاء المفاتيح",
        pincode = "%{value} كود التراب هاوس",
        taking_over = "السيطرة",
        pin_code_see = "عرض الكود",
        pin_code = "%{value} الكود",
        multikeys = "(/multikey [id]) اعطاء المفاتيح",
        take_cash = "($%{value}) تحصيل",
        inventory = "عرض الخزنة",
        take_over = "($5000) تولي",
        leave = "خروج",
        close_menu = "⬅ عودة",
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
