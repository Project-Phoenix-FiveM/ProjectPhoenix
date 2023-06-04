local Translations = {
    error = {
        has_no_drugs = "أنت لا تحمل أي مخدرات معك",
        not_enough_police = "شرطة %{polices} يجب تواجد اكثر من",
        no_drugs_left = "لا يوجد المزيد",
        too_far_away = "تحركت بعيدا جدا",
        offer_declined = "رفض",
        no_player_nearby = "لا يوجد لاعب بالجوار",
        pending_delivery = "ما زلت بحاجة لإكمال التسليم ماذا تنتظر",
        item_unavailable = "هذا العنصر غير متوفر لديك استرداد",
        order_not_right = "هذا لا يفي بالترتيب",
        too_late = "أنت متأخر جدا",
        dealer_already_exists = "يوجد تاجر بالفعل بهذا الاسم",
        dealer_not_exists = "هذا التاجر غير موجود",
        no_dealers = "لم يتم وضع تجار",
        dealer_not_exists_command = "%{dealerName} غير معروف"
    },
    success = {
        helped_player = "لقد ساعدت الشخص",
        route_has_been_set = "تم تعيين الطريق إلى موقع التسليم على خريطتك",
        teleported_to_dealer = "%{dealerName} لقد تم نقلك إلى",
        offer_accepted = "تم القبول",
        order_delivered = "تم تسليم الطلب",
        dealer_deleted = "%{dealerName} تم الحدف"
    },
    info = {
        started_selling_drugs = "لقد بدأت في بيع المخدرات",
        stopped_selling_drugs = "لقد توقفت عن بيع المخدرات",
        has_been_robbed = "%{bags}x %{drugType} لقد تعرضت للسرقة والضياع",
        suspicious_situation = "حالة مريبة",
        possible_drug_dealing = "احتمال تداول المخدرات",
        drug_offer = "~g~E~w~ - %{bags}x %{drugLabel} = $%{randomPrice} | ~g~G~w~ - ﺾﻓﺭ", -- you need font arabic
        pick_up_button = "~g~E~w~ - ﻊﻤﺟ",
        knock_button = "~g~E~w~ - ﻕﺮﻃ",
        mystery_man_button = "~g~E~w~ - ﺀﺍﺮﺷ / ~g~G~w~ - $5000 ﺏ ﻢﻴﻋﺪﺗ",
        other_dealers_button = "~g~E~w~ - ﺀﺍﺮﺷ / ~g~G~w~ - ﺔﻤﻬﻣ ﺔﻳﺍﺪﺑ",
        reviving_player = "مساعدة و تدعيم",
        dealer_name = "%{dealerName} البائع",
        sending_delivery_email = "هذه هي المنتجات و سوف اتواصل معك",
        mystery_man_knock_message = "مرحبا. ماذا افعل من اجلك",
        treated_fred_bad = "لسوء الحظ ، لم أعد أمارس الأعمال التجارية بعد الآن. كان يجب أن تعاملني بشكل أفضل",
        fred_knock_message = "%{firstName} واش ؟",
        no_one_home = "يبدو أنه لا يوجد أحد في المنزل",
        delivery_info_email = "هنا جميع المعلومات حول التسليم  <br>المنتوج: <br> %{itemAmount}x %{itemLabel}<br><br> كن في الوقت",
        deliver_items_button = "~g~E~w~ - %{itemAmount}x %{itemLabel} ﻢﻴﻠﺴﺗ",
        delivering_products = "توصيل المنتجات",
        drug_deal_alert = "911: بيع مخدرات",
        perfect_delivery = "لقد قمت بعمل جيد ، أتمنى أن أراك مرة أخرى ;)<br><br> %{dealerName}",
        bad_delivery = "لقد تلقيت شكاوى بشأن التسليم الخاص بك ، فلا تدع هذا يحدث مرة أخرى",
        late_delivery = "لم تكن في الوقت المحدد هل كان لديك أشياء أكثر أهمية للقيام بها من العمل؟",
        police_message_server = "%{street} تم تحديد موقع مريب في",
        drug_deal = "تجارة المخدرات",
        newdealer_command_desc = "ضع تاجر مخدرات هنا",
        newdealer_command_help1_name = "name",
        newdealer_command_help1_help = "اسم البائع",
        newdealer_command_help2_name = "min",
        newdealer_command_help2_help = "بداية من وقت",
        newdealer_command_help3_name = "max",
        newdealer_command_help3_help = "نهاية البيع",
        deletedealer_command_desc = "حدف البائع",
        deletedealer_command_help1_name = "name",
        deletedealer_command_help1_help = "اسم البائع",
        dealers_command_desc = "معرفة كل البائعين",
        dealergoto_command_desc = "انتقل الى البائع",
        dealergoto_command_help1_name = "name",
        dealergoto_command_help1_help = "اسم البائع",
        list_dealers_title = "قائمة البائعين في المدينة: ",
        list_dealers_name_prefix = "الاسم: "
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
