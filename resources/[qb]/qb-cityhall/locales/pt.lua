local Translations = {
    error = {
        not_in_range = 'Encontra-se muito longe da camara municipal'
    },
    success = {
        recived_license = 'Recebeu  %{value} por €50'
    },
    info = {
        new_job_app = 'Your application was sent to the boss of (%{job})',
        bilp_text = 'Camâra Municipal',
        city_services_menu = 'E - Menu Serviços',
        id_card = 'Cartão do Cidadão',
        driver_license = 'Carta de Condução',
        weaponlicense = 'Licença porte de arma',
        new_job = 'Parabéns! O seu novo trabalho: (%{job})'
    },
    email = {
        jobAppSender = "%{job}",
        jobAppSub = "Thank you for applying to %(job).",
        jobAppMsg = "Hello %{gender} %{lastname}<br /><br />%{job} has received your application.<br /><br />The boss is looking into your request and will reach out to you for an interview at their earliest convienance.<br /><br />Once again, thank you for your application.",
        mr = 'Sr',
        mrs = 'Sra',
        sender = 'Serviços Municipais',
        subject = 'Solicitação de aulas de condução',
        message = 'Olá %{gender} %{lastname}<br /><br />Acabamos de receber uma mensagem de que alguém quer fazer aulas de condução<br />Se quiser fazer de instructor por favor contacte-nos:<br />Nome: <strong>%{firstname} %{lastname}</strong><br />Telemóvel: <strong>%{phone}</strong><br/><br/>Melhores Cumprimentos,<br />Serviços Municipais'
    }
}
if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
