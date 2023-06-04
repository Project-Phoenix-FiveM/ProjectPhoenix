local Translations = {
    error = {
        no_deposit = "$%{value} الايداع مطلوب",
        cancelled = "تم الالغاء",
        vehicle_not_correct = "ليست سيارة تجارية خاصة بوظيفة التوصيل!",
        no_driver = "يجب ان تكون السائق لتقوم بعمل هذا..",
        no_work_done = "لم تقم بعمل اي توصيل لحد الان..",
        backdoors_not_open = "الصندوق الخلفي للسيارة غير مفتوح",
        get_out_vehicle = "يجب ان تخرج من السيارة لكي تقوم بهذا العمل",
        too_far_from_trunk = "يجيب ان تقوم بحمل السلع من الصندوق الخلفي للسيارة",
        too_far_from_delivery = "يجب ان تكون قريبا من نقطة التوصيل"
    },
    success = {
        paid_with_cash = "$%{value} تم جحز مبلغ الرهن نقدا",
        paid_with_bank = "$%{value} تم جحز مبلغ الرهن من البنك ",
        refund_to_cash = "$%{value} استرجاع مبلغ الرهان نقدا",
        you_earned = "حصلت علي $%{value}",
        payslip_time = "لقد قمت بتوصيل جميع السلع اتجه لنقطة سحب الاموال!",
    },
    menu = {
        header = "السيارات التجارية",
        close_menu = "⬅ إغلاق",
    },
    mission = {
        store_reached = "وصلت الي المتجر، قم بإنزال الصندوق من السيارة وأوصله فيي داخل المتجر [E]",
        take_box = "أخذ صندوق السلع",
        deliver_box = "توصيل صندوق السلع",
        another_box = "تم توصيل الصندوق قم بأخذ صندوق آخر",
        goto_next_point = "تم توصيل السلع اتجه للنقطة الموالية",
    },
    info = {
        deliver_e = "~g~E~w~ - توصيل السلع",
        deliver = "توصيل السلع",
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
