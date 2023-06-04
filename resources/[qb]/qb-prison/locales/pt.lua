local Translations = {
    error = {
        ["missing_something"] = "Parece que te estás a esquecer de alguma coisa..",
        ["not_enough_police"] = "Agentes da autoridade insuficientes..",
        ["door_open"] = "A porta já está aberta..",
        ["cancelled"] = "Processo cancelado..",
        ["didnt_work"] = "Não funcionou..",
        ["emty_box"] = "A caixa está vazia..",
        ["injail"] = "Foste preso por %{Time} meses..",
        ["item_missing"] = "Falta-te um item..",
        ["escaped"] = "Tu escapaste... Sai daqui imediatamente!",
        ["do_some_work"] = "Trabalha para teres a pena reduzida. Trabalho atual: %{currentjob} ",
	["security_activated"] = "O nível de segurança mais alto está ativo, fique dentro da sua cela!"
    },
	success = {
        ["found_phone"] = "Encontraste um telemóvel..",
        ["time_cut"] = "Trabalhaste e foi te reduzido o tempo de prisão.",
        ["free_"] = "A tua pena terminou! Aproveita a liberdade! :)",
        ["timesup"] = "O teu tempo terminou! Dirige-te ao centro de visitantes",
    },
    info = {
        ["timeleft"] = "Ainda te faltam... %{JAILTIME} meses",
        ["lost_job"] = "Estás Desempregado",
        ["job_interaction"] = "[E] Trabalho de Electricista",
	["job_interaction_target"] = "Trabalhar como %{job} ",
        ["received_property"] = "Recebeu a sua propriedade de volta...",
        ["seized_property"] = "Sua propriedade foi confiscada, receberá tudo de volta quando seu tempo acabar.",
        ["cells_blip"] = "Celas",
        ["freedom_blip"] = "Recepção - Prisão",
        ["canteen_blip"] = "Refeitório",
        ["work_blip"] = "Trabalho Prisional",
        ["target_freedom_option"] = "Verificar o tempo restante",
        ["target_canteen_option"] = "Receber Comida",
        ["police_alert_title"] = "Nova Chamada",
        ["police_alert_description"] = "Fuga da¨Prisão",
        ["connecting_device"] = "A conectar o dispositivo...",
        ["working_electricity"] = "A conectar os cabos..."
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
