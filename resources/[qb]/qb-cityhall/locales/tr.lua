local Translations = {
    error = {
        not_in_range = 'Belediye binasına çok uzak'
    },
    success = {
        recived_license = '$50 karşılığında %{value} aldınız'
    },
    info = {
        new_job_app = 'Your application was sent to the boss of (%{job})',
        bilp_text = 'Şehir Hizmetleri',
        city_services_menu = '~g~E~w~ - Şehir Hizmetleri Menüsü',
        id_card = 'Kimlik kartı',
        driver_license = 'Ehliyet',
        weaponlicense = 'Silah Ruhsatı',
        new_job = 'Yeni işin için tebrikler! (%{job})'
    },
    email = {
        jobAppSender = "%{job}",
        jobAppSub = "Thank you for applying to %(job).",
        jobAppMsg = "Hello %{gender} %{lastname}<br /><br />%{job} has received your application.<br /><br />The boss is looking into your request and will reach out to you for an interview at their earliest convienance.<br /><br />Once again, thank you for your application.",
        mr = 'Bay',
        mrs = 'Bayan',
        sender = 'Belediye',
        subject = 'Sürücü kursu talebi',
        message = 'Merhaba %{gender} %{lastname}<br /><br />Az önce birisinin sürüş dersi almak istediğine dair bir mesaj aldık<br />Eğer öğretmek istiyorsanız, lütfen bizimle iletişime geçin:<br />İsim: <strong>%{firstname} %{lastname}</strong><br />Telefon numarası: <strong>%{phone}</strong><br/><br/>Saygılarımla,<br />Los Santos Belediyesi'
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
