local Translations = {
    error = {
        ["no_keys"] = "ليس لديك مفاتيح المنزل",
        ["not_in_house"] = "انت لست في منزل",
        ["out_range"] = "لقد خرجت عن النطاق",
        ["no_key_holders"] = "لم يتم العثور على حاملي المفاتيح",
        ["invalid_tier"] = "فئة المنزل غير صالحة",
        ["no_house"] = "لا يوجد منزل بالقرب منك",
        ["no_door"] = "أنت لست قريبًا بما يكفي من الباب",
        ["locked"] = "المنزل مقفل",
        ["no_one_near"] = "لا أحد بالجوار",
        ["not_owner"] = "أنت لا تملك هذا المنزل",
        ["no_police"] = "لا توجد قوة شرطة موجودة",
        ["already_open"] = "هذا المنزل مفتوح بالفعل",
        ["failed_invasion"] = "فشلت المحاولة مرة أخرى",
        ["inprogress_invasion"] = "شخص ما يعمل بالفعل على الباب",
        ["no_invasion"] = "هذا الباب غير مكسور مفتوحا",
        ["realestate_only"] = "يمكن للعقار فقط استخدام هذا الأمر",
        ["emergency_services"] = "هذا ممكن فقط لخدمات الطوارئ",
        ["already_owned"] = "هذا المنزل مملوك بالفعل",
        ["not_enough_money"] = "ليس لديك ما يكفي من المال",
        ["remove_key_from"] = "%{firstname} %{lastname} تمت إزالة المفاتيح من",
        ["already_keys"] = "هذا الشخص لديه بالفعل مفاتيح المنزل",
        ["something_wrong"] = "حدث خطأ ما حاول مرة أخرى",
    },
    success = {
        ["unlocked"] = "البيت مفتوح",
        ["home_invasion"] = "الباب مفتوح الآن",
        ["lock_invasion"] = "لقد أغلقت المنزل مرة أخرى",
        ["recieved_key"] = "%{value} لديك مفاتيح"
    },
    info = {
        ["door_ringing"] = "شخص ما يدق الباب",
        ["speed"] = "%{value} السرعة الان",
        ["added_house"] = "%{value} لقد قمت بإضافة منزل:",
        ["added_garage"] = "%{value} لقد قمت بإضافة مرآب لتصليح السيارات:"
    },
    menu = {
        ["house_options"] = "خيارات المنزل",
        ["enter_house"] = "أدخل منزلك",
        ["give_house_key"] = "إعطاء المفتاح",
        ["exit_property"] = "الخروج",
        ["front_camera"] = "الكاميرا",
        ["back"] = "عودة",
        ["remove_key"] = "إزالة المفتاح",
        ["open_door"] = "باب مفتوح",
        ["view_house"] = "عرض المنزل",
        ["ring_door"] = "جرس الباب",
        ["exit_door"] = "خروج",
        ["open_stash"] = "فتح الخزنة",
        ["stash"] = "ﺔﻧﺰﺨﻟﺍ",
        ["change_outfit"] = "الخزانة",
        ["outfits"] = "ﺔﻧﺍﺰﺨﻟﺍ",
        ["change_character"] = "النوم",
        ["characters"] = "ﻡﻮﻨﻟﺍ",
        ["enter_unlocked_house"] = "أدخل البيت المفتوح",
        ["lock_door_police"] = "قفل الباب"
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
