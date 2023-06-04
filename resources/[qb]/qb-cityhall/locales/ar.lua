local Translations = {
    error = {
        not_in_range = 'بعيدا جدا عن قاعة المدينة'
    },
    success = {
        recived_license = '%{value} تم تحصيله مقابل $50'
    },
    info = {
        new_job_app = 'Your application was sent to the boss of (%{job})',
        bilp_text = 'ﻒﻴﻇﻮﺘﻟﺍ ﺰﻛﺮﻣ',
        city_services_menu = '~g~E~w~ - ﻒﻴﻇﻮﺘﻟﺍ ﺰﻛﺮﻣ', -- you need font arabic
        id_card = 'بطاقة التعريف',
        driver_license = 'رخصة السائق',
        weaponlicense = 'ترخيص الأسلحة النارية',
        new_job = '(%{job}) مبروك الوظيفة'
    },
    email = {
        jobAppSender = "%{job}",
        jobAppSub = "Thank you for applying to %(job).",
        jobAppMsg = "Hello %{gender} %{lastname}<br /><br />%{job} has received your application.<br /><br />The boss is looking into your request and will reach out to you for an interview at their earliest convienance.<br /><br />Once again, thank you for your application.",
        mr = 'سيد',
        mrs = 'سيدة',
        sender = 'مركز التوظيف',
        subject = 'طلب دروس القيادة',
        message = '%{gender} %{lastname} مرحبا<br /><br />لقد تلقينا للتو رسالة أن شخصا ما يريد أن يأخذ دروس القيادة<br />إذا كنت على استعداد للتدريس، يرجى الاتصال بنا:<br /><strong>%{firstname} %{lastname}</strong><br /><strong>%{phone}</strong><br/><br/>مع احترام,<br />مركز التوظيف'
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
