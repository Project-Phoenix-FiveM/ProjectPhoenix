local Translations = {
    success = {
        you_have_been_clocked_in = "لقد تم تسجيل دخولك",
    },
    text = {
        point_enter_warehouse = "[E] أدخل المستودع",
        enter_warehouse= "أدخل المستودع",
        exit_warehouse= "خروج من المستودع",
        point_exit_warehouse = "[E] مستودع الخروج",
        clock_out = "[E] تسجيل خروج",
        clock_in = "[E] تسجيل دخول",
        hand_in_package = "تسليم حزمة",
        point_hand_in_package = "[E] تسليم حزمة",
        get_package = "احصل على الحزمة",
        point_get_package = "[E] احصل على الحزمة",
        picking_up_the_package = "استلام الطرد",
        unpacking_the_package = "تفريغ حزمة",
    },
    error = {
        you_have_clocked_out = "لقد تم تسجيل خروج"
    },
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end