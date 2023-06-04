local Translations = {
    error = {
        not_in_range = 'Zu weit vom Rathaus entfernt'
    },
    success = {
        recived_license = 'Du hast deinen %{value} für 50$ zurückbekommen'
    },
    info = {
        new_job_app = 'Your application was sent to the boss of (%{job})',
        bilp_text = 'Rathaus',
        city_services_menu = '~g~E~w~ - Rathaus',
        id_card = 'Ausweis',
        driver_license = 'Führerschein',
        weaponlicense = 'Waffenschein',
        new_job = 'Herzlichen Glückwunsch zu deinem neuen Job! (%{job})'
    },
    email = {
        jobAppSender = "%{job}",
        jobAppSub = "Thank you for applying to %(job).",
        jobAppMsg = "Hello %{gender} %{lastname}<br /><br />%{job} has received your application.<br /><br />The boss is looking into your request and will reach out to you for an interview at their earliest convienance.<br /><br />Once again, thank you for your application.",
        mr = 'Sehr geehrter Herr',
        mrs = 'Sehr geehrte Frau',
        sender = 'Gemeinde',
        subject = 'Anfrage für Fahrstunden',
        message = '%{gender} %{lastname}<br /><br />Wir haben gerade eine Nachricht erhalten, dass jemand Fahrstunden nehmen möchte<br />Wenn Sie bereit sind zu unterrichten, nehmen Sie bitte Kontakt mit uns auf:<br />Name: <strong>%{firstname} %{lastname}</strong><br />Telefonnummer: <strong>%{phone}</strong><br/><br/>Mit freundlichen Grüßen<br />Gemeinde Los Santos'
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
