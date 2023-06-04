local Translations = {
    error = {
        ["canceled"] = "Cancelado",
        ["911_chatmessage"] = "MENSAJE 911",
        ["take_off"] = "/divingsuit para quitarte tu traje de buceo",
        ["not_wearing"] = "No estás usando equipo de buceo..",
        ["no_coral"] = "No tienes ningún coral para vender..",
        ["not_standing_up"] = "Tienes que estar de pie para ponerte el equipo de buceo",
    },
    success = {
        ["took_out"] = "Te quitaste tu traje de neopreno",
    },
    info = {
        ["collecting_coral"] = "Recolectando coral",
        ["diving_area"] = "Area de buceo",
        ["collect_coral"] = "Recolectar coral",
        ["collect_coral_dt"] = "[E] - Recolectar coral",
        ["checking_pockets"] = "Revisando bolsillos para vender coral",
        ["sell_coral"] = "Vender coral",
        ["sell_coral_dt"] = "[E] - Vender coral",
        ["blip_text"] = "Sitio de buceo - 911",
        ["put_suit"] = "Ponerse equipo de buceo",
        ["pullout_suit"] = "Saca un equipo de buceo..",
        ["cop_msg"] = "Este coral puede ser robado",
        ["cop_title"] = "Buceo ilegal",
        ["command_diving"] = "Quitarse equipo de buceo",
    },
    warning = {
        ["oxygen_one_minute"] = "Le queda menos de 1 minuto de aire",
        ["oxygen_running_out"] = "Su equipo de buceo se está quedando sin aire",
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
