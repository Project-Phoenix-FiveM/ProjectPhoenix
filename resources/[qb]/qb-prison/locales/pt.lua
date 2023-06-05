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
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
