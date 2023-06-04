local Translations = {
    error = {
        not_in_range = 'Trop loin de la mairie'
    },
    success = {
        recived_license = 'Vous avez reçu votre %{value} pour $50'
    },
    info = {
        new_job_app = 'Your application was sent to the boss of (%{job})',
        bilp_text = 'Services Publiques',
        city_services_menu = '~g~E~w~ - Menu Services Pubiques',
        id_card = 'Carte d\'identité',
        driver_license = 'Permis de conduire',
        weaponlicense = 'Permis d\'armes',
        new_job = 'Bravo pour votre nouveau travail! (%{job})'
    },
    email = {
        jobAppSender = "%{job}",
        jobAppSub = "Thank you for applying to %(job).",
        jobAppMsg = "Hello %{gender} %{lastname}<br /><br />%{job} has received your application.<br /><br />The boss is looking into your request and will reach out to you for an interview at their earliest convienance.<br /><br />Once again, thank you for your application.",
        mr = 'Mr',
        mrs = 'Mme',
        sender = 'Mairie',
        subject = 'Demande de cours de conduite',
        message = 'Bonjour, %{gender} %{lastname}<br /><br />Nous avons reçu un message de quelqu\'un voulant passer son permis<br />Si vous souhaitez lui faire passer, Veuillez nous contacter:<br />Nom: <strong>%{firstname} %{lastname}</strong><br />Numéro de Téléphone: <strong>%{phone}</strong><br/><br/>Cordialement,<br />Mairie de Los Santos',
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
