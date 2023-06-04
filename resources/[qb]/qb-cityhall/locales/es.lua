local Translations = {
    error = {
        not_in_range = 'Muy lejos de la municipalidad'
    },
    success = {
        recived_license = 'Has recibido tu %{value} por $50'
    },
    info = {
        new_job_app = 'Your application was sent to the boss of (%{job})',
        bilp_text = 'Servicios municipales',
        city_services_menu = '[E] - Servicios municipales',
        id_card = 'DNI',
        driver_license = 'Licencia de conducir',
        weaponlicense = 'Licencia para portacion de armas',
        new_job = 'Felicidades por tu nuevo trabajo! (%{job})'
    },
    email = {
        jobAppSender = "%{job}",
        jobAppSub = "Thank you for applying to %(job).",
        jobAppMsg = "Hello %{gender} %{lastname}<br /><br />%{job} has received your application.<br /><br />The boss is looking into your request and will reach out to you for an interview at their earliest convienance.<br /><br />Once again, thank you for your application.",
        mr = 'Sr',
        mrs = 'Sra',
        sender = 'Municipalidad',
        subject = 'Solicitud de clases de conducir',
        message = 'Hola %{gender} %{lastname}<br /><br />Acabamos de recibir un mensaje de que deseas clases de conducir<br />Si deseas enseñar, contactanos:<br />Nombre: <strong>%{firstname} %{lastname}</strong><br />Numero de teléfono: <strong>%{phone}</strong><br/><br/>Saludos,<br />Ayuntamiento Los Santos'
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
