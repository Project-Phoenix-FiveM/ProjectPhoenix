local Translations = {
    error = {
        ["failed_notification"] = "Falhou!",
        ["not_near_veh"] = "Não estás perto de um veículo!",
        ["out_range_veh"] = "Estás demasiado longe do veículo!",
        ["inside_veh"] = "Não podes reparar o motor dentro do veículo!",
        ["healthy_veh"] = "O veículo está demasiado bem e por isso precisas de ferramentas melhores!",
        ["inside_veh_req"] = "Tens de estar num veículo para o reparar!",
        ["roadside_avail"] = "Existem serviços de apoio disponíveis! Consulta os serviços no teu telemóvel.",
        ["no_permission"] = "Não tens permissão para reparar veículos",
        ["fix_message"] = "%{message}. Visita uma oficina agora!",
        ["veh_damaged"] = "Este veículo está demasiado danificado!",
        ["nofix_message_1"] = "Olhaste para o nível de óleo e nada parece errado",
        ["nofix_message_2"] = "Olhaste para o teu motociclo e nada parece errado",
        ["nofix_message_3"] = "Olhaste para a fita adesiva na mangueira do óleo e a mesma parece estar bem",
        ["nofix_message_4"] = "Ligaste o rádio. O barulho estranho no motor desapareceu",
        ["nofix_message_5"] = "O removedor de ferrugem que usaste não teve qualquer efeito",
        ["nofix_message_6"] = "Tentaste resolver o problema mas ficou tudo na mesma",
    },
    success = {
        ["cleaned_veh"] = "Veículo limpo!",
        ["repaired_veh"] = "Veículo reparado!",
        ["fix_message_1"] = "Verificaste o nível do óleo",
        ["fix_message_2"] = "Reparaste o derrame de óleo com pastilha elástica",
        ["fix_message_3"] = "Fizeste a mangueira do óleo com fita adesiva",
        ["fix_message_4"] = "Paraste a fuga de óleo temporariamente",
        ["fix_message_5"] = "Deste um pontapé no motociclo e voltou a funcionar",
        ["fix_message_6"] = "Removeste alguma ferrugem",
        ["fix_message_7"] = "Gritaste com o carro e ele voltou a funcionar",
    },
    progress = {
        ["clean_veh"] = "A limpar veículo...",
        ["repair_veh"] = "A reparar veículo..",

    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
