local Translations = {
    error = {
        ["canceled"] = "Cancelado",
        ["911_chatmessage"] = "911 MENSAGEM",
        ["take_off"] = "/divingsuit para tirar a roupa de mergulho",
        ["not_wearing"] = "Você não está usando equipamento de mergulho..",
        ["no_coral"] = "Você não tem nenhum coral para vender..",
        ["not_standing_up"] = "Você precisa estar de pé para colocar o equipamento de mergulho",
        ["need_otube"] = "você precisa de tubo de oxigênio",
        ["oxygenlevel"] = 'o nível do equipamento é %{oxygenlevel}, deve ser 0%'
    },
    success = {
        ["took_out"] = "Você tirou sua roupa de mergulho",
        ["tube_filled"] = "O tubo foi preenchido com sucesso"
    },
    info = {
        ["collecting_coral"] = "Coletando coral",
        ["diving_area"] = "Área de mergulho",
        ["collect_coral"] = "Colete o Coral",
        ["collect_coral_dt"] = "[E] - Colete o Coral",
        ["checking_pockets"] = "Verificando bolsos para vender coral",
        ["sell_coral"] = "Vender Coral",
        ["sell_coral_dt"] = "[E] - Vender Coral",
        ["blip_text"] = "911 - Local de Mergulho",
        ["put_suit"] = "Vestir traje de mergulho",
        ["pullout_suit"] = "Retirar traje de mergulho ..",
        ["cop_msg"] = "Este coral pode ser roubado",
        ["cop_title"] = "Mergulho ilegal",
        ["command_diving"] = "Remova seu traje de mergulho",
    },
    warning = {
        ["oxygen_one_minute"] = "Você tem menos de 1 minuto de ar restante",
        ["oxygen_running_out"] = "Seu equipamento de mergulho está ficando sem ar",
    },
}

if GetConvar('qb_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
