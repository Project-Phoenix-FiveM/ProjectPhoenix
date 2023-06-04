local Translations = {
    error = {
        not_in_range = 'Oled linnahallist liiga kaugel.'
    },
    success = {
        recived_license = 'Oled saanud oma kraami: %{value} $50 eest.'
    },
    info = {
        new_job_app = 'Your application was sent to the boss of (%{job})',
        bilp_text = 'Linna teenused',
        city_services_menu = '~g~E~w~ - Teenuste menüü',
        id_card = 'ID Kaart',
        driver_license = 'Juhiluba',
        weaponlicense = 'Relvaluba',
        new_job = 'Leidsid endale uue töökoha: (%{job})'
    },
    email = {
        jobAppSender = "%{job}",
        jobAppSub = "Thank you for applying to %(job).",
        jobAppMsg = "Hello %{gender} %{lastname}<br /><br />%{job} has received your application.<br /><br />The boss is looking into your request and will reach out to you for an interview at their earliest convienance.<br /><br />Once again, thank you for your application.",
        mr = 'Mr',
        mrs = 'Mrs',
        sender = 'Kölbard',
        subject = 'Sõidu tundidele registreerimine',
        message = 'Tere %{gender} %{lastname}<br /><br />saime teie sõidutundide soovist kirja<br />Kui sa oled nõus õpetama kirjuta meile:<br />Nimi: <strong>%{firstname} %{lastname}</strong><br />NR: <strong>%{phone}</strong><br/><br/>Heade soovidega,<br />Kölbard'
    }
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
