local Translations = {
    error = {
        ["failed_notification"] = "فشل",
        ["not_near_veh"] = "أنت لست بالقرب من سيارة",
        ["out_range_veh"] = "أنت بعيد جدًا عن السيارة",
        ["inside_veh"] = "لا يمكنك إصلاح محرك السيارة من الداخل",
        ["healthy_veh"] = "السيارة صحية للغاية وتحتاج إلى أدوات أفضل",
        ["inside_veh_req"] = "يجب أن تكون في مركبة لإصلاحها",
        ["roadside_avail"] = "تتوفر خدمة المساعدة على الطريق ، يمكنك الاتصال بذلك عبر هاتفك!",
        ["no_permission"] = "ليس لديك إذن لإصلاح المركبات",
        ["fix_message"] = "%{message} والآن اذهب إلى المرآب",
        ["veh_damaged"] = "سيارتك تالفة للغاية",
        ["nofix_message_1"] = "نظرت إلى مستوى الزيت الخاص بك وبدا هذا طبيعيًا",
        ["nofix_message_2"] = "نظرت إلى دراجتك ولا يبدو أن هناك شيئًا خطأ",
        ["nofix_message_3"] = "نظرت إلى شريط البط الموجود على خرطوم الزيت وبدا أنك بخير",
        ["nofix_message_4"] = "لقد قمت بتشغيل الراديو وذهب الآن ضجيج المحرك الغريب",
        ["nofix_message_5"] = "لم يكن لمزيل الصدأ الذي استخدمته أي تأثير",
        ["nofix_message_6"] = "لا تحاول أبدًا صنع شيء لم يتم كسره ولكنك لم تستمع إليه",
    },
    success = {
        ["cleaned_veh"] = "تم تنظيف السيارة",
        ["repaired_veh"] = "مركبة تم تصليحها",
        ["fix_message_1"] = "لقد قمت بفحص مستوى الزيت",
        ["fix_message_2"] = "لقد أغلقت بقعة الزيت",
        ["fix_message_3"] = "لقد صنعت خرطوم الزيت بشريط لاصق",
        ["fix_message_4"] = "لقد قمت بإيقاف تسرب الزيت مؤقتًا",
        ["fix_message_5"] = "لقد ركلت الدراجة وهي تعمل مرة أخرى",
        ["fix_message_6"] = "قمت بإزالة بعض الصدأ",
        ["fix_message_7"] = "صرخت في سيارتك وهي تعمل مرة أخرى",
    },
    progress = {
        ["clean_veh"] = "تنظيف السيارة",
        ["repair_veh"] = "تصليح المركبة",

    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
