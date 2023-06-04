local Translations = {
    error = {
        not_give = "لا يمكن إعطاء العنصر للمعرّف المحدد.",
        givecash = "الاستخدام /givecash [المعرّف] [المبلغ]",
        wrong_id = "معرف غير صحيح.",
        dead = "أنت ميت .",
        too_far_away = "أنت بعيد جدا",
        not_enough = "ليس لديك هذا المبلغ.",
        invalid_amount = "تم إعطاء مبلغ غير صالح"
    },
    success = {
        debit_card = "لقد نجحت في طلب بطاقة الخصم.",
        cash_deposit = "لقد نجحت في إجراء إيداع نقدي بقيمة$%{value}.",
        cash_withdrawal = "لقد نجحت في إجراء سحب نقدي بقيمة$%{value}.",
        updated_pin = "لقد قمت بتحديث رقم التعريف الشخصي لبطاقة الخصم الخاصة بك بنجاح.",
        savings_deposit = "لقد نجحت في إيداع مبلغ$%{value}.",
        savings_withdrawal = "لقد نجحت في تحقيق سحب مدخرات بقيمة$%{value}.",
        opened_savings = "لقد قمت بفتح حساب توفير بنجاح.",
        give_cash = "تم بنجاح منح $%{cash} الي %{id}",
        received_cash = "من ID %{id} تم بنجاح استلام $%{cash} "
    },
    info = {
        bank_blip = "Bank",
        access_bank_target = "الوصول إلى البنك",
        access_bank_key = "[E] - الوصول إلى البنك",
        current_to_savings = "تحويل الحساب الجاري إلى التوفير",
        savings_to_current = "قم بتحويل المدخرات إلى الحساب الجاري",
        deposit = "قم بإيداع $٪{amount} في الحساب الجاري",
        withdraw = "سحب $%{amount} من الحساب الجاري",
    },
    command = {
        givecash = "أعط المال للاعب."
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
