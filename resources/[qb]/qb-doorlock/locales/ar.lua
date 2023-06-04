local Translations = {
    error = {
        lockpick_fail = "فشل",
        door_not_found = "لم تحصل الباب إذا كان الباب شفافًا فتأكد من أن تهدف إلى إطار الباب",
        same_entity = "لا يمكن أن يكون كلا البابين نفس الباب",
        door_registered = "هذا الباب مسجل بالفعل",
        door_identifier_exists = "(%s) الاسم موجود بالفعل",
    },
    success = {
        lockpick_success = "نجحت"
    },
    general = {
        locked = "مقفل",
        unlocked = "مفتوحة",
        locked_button = "[E] - مقفل",
        unlocked_button = "[E] - مفتوحة",
        keymapping_description = "تفاعل مع أقفال الباب",
        keymapping_remotetriggerdoor = "الزناد عن بُعد الباب",
        locked_menu = "مقفل",
        pickable_menu = "يمكن كسره",
        cantunlock_menu = 'لا يمكن فتحه',
        hidelabel_menu = 'اخفاء الكتابة',
        distance_menu = "أقصى مسافة",
        item_authorisation_menu = "عنصر مسموح",
        citizenid_authorisation_menu = "تصريح المواطن",
        gang_authorisation_menu = "العصابة",
        job_authorisation_menu = "الوظيفة",
        doortype_title = "نوع الباب",
        doortype_door = "باب",
        doortype_double = "بابين",
        doortype_sliding = "باب متحرك",
        doortype_doublesliding = "بابين متحركين",
        doortype_garage = "غراج",
        dooridentifier_title = "المعرف",
        doorlabel_title = "اسم الباب",
        configfile_title = "ملف الكونفيغ",
        submit_text = "تأكيد",
        newdoor_menu_title = "اضافة باب جديد",
        newdoor_command_description = "أضف بابًا جديدًا إلى نظام قفل الباب",
        doordebug_command_description = "تبديل وضع التصحيح",
        warning = "تحذير",
        created_by = "انشأ من قبل",
        warn_no_permission_newdoor = "%{player} (%{license}) حاول إضافة باب جديد دون إذن (المصدر: %{source})",
        warn_no_authorisation = "%{player} (%{license}) حاولت فتح باب بدون إذن (أرسلت: %{doorID})",
        warn_wrong_doorid = "%{player} (%{license}) حاول تحديث الباب غير الصحيح (أرسلت: %{doorID})",
        warn_wrong_state = "%{player} (%{license}) حاول التحديث إلى حالة غير صالحة (أرسلت: %{state})",
        warn_wrong_doorid_type = "%{player} (%{license}) لم ترسل بابًا مناسبًا (أرسلت: %{doorID})",
        warn_admin_privilege_used = "%{player} (%{license}) فتح الباب باستخدام امتيازات المسؤول"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
