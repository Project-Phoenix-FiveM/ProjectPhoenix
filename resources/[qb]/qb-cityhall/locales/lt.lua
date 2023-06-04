local Translations = {
    error = {
        not_in_range = 'Per toli nuo rotušės'
    },
    success = {
        recived_license = 'Jūs gavote savo %{value} už $50'
    },
    info = {
        new_job_app = 'Your application was sent to the boss of (%{job})',
        bilp_text = 'Miesto paslaugos',
        city_services_menu = '~g~E~w~ - Miesto paslaugų meniu',
        id_card = 'Tapatybės kortelė',
        driver_license = 'Vairuotojo pažymėjimas',
        weaponlicense = 'Ginklų leidimas',
        new_job = 'Sveikiname su jūsų nauju darbu! (%{job})'
    },
    email = {
        jobAppSender = "%{job}",
        jobAppSub = "Thank you for applying to %(job).",
        jobAppMsg = "Hello %{gender} %{lastname}<br /><br />%{job} has received your application.<br /><br />The boss is looking into your request and will reach out to you for an interview at their earliest convienance.<br /><br />Once again, thank you for your application.",
        mr = 'Pone',
        mrs = 'Ponia',
        sender = 'Los Santos',
        subject = 'Vairavimo pamokų prašymas',
        message = 'Sveiki %{gender} %{lastname}<br /><br />Mes ką tik gavome žinutę, kad kažkas nori lankyti vairavimo pamokas<br />Jeigu tu viliesi mokyti, susisiekite su mumis:<br />Vardas: <strong>%{firstname} %{lastname}</strong><br />Telefono numeris: <strong>%{phone}</strong><br/><br/>Su pagarba,<br />Los Santos'
    }
}

if GetConvar('qb_locale', 'en') == 'lt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
