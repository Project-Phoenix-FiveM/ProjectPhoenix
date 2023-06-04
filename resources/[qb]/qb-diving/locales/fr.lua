local Translations = {
    error = {
        ["canceled"] = "Annulé",
        ["911_chatmessage"] = "MESSAGE 911",
        ["take_off"] = "/divingsuit pour prendre votre kit de plongée",
        ["not_wearing"] = "Vous n'êtes pas en plonge",
        ["no_coral"] = "Vous n'avez pas de corail à vendre",
        ["not_standing_up"] = "Vous devez être debout pour vous equiper",
        ["need_otube"] = "Vous avez besoin d'une bouteille d'oxygène",
        ["oxygenlevel"] = "Le niveau d'oxygène est %{oxygenlevel}, Il doit être à 0%"
    },
    success = {
        ["took_out"] = "Vous avez enlevé votre kit de plongée",
        ["tube_filled"] = "La Bouteille à été rempli"
    },
    info = {
        ["collecting_coral"] = "Vous récupérez des coraux",
        ["diving_area"] = "Zone de plongée",
        ["collect_coral"] = "Récupérer des coraux",
        ["collect_coral_dt"] = "[E] - Récupérer des coraux",
        ["checking_pockets"] = "Vend des coraux...",
        ["sell_coral"] = "Vendre des coraux",
        ["sell_coral_dt"] = "[E] - Vendre des coraux",
        ["blip_text"] = "911 - Site de plongée",
        ["put_suit"] = "Mettre votre kit de plongée",
        ["pullout_suit"] = "Enlever votre kit de plongée",
        ["cop_msg"] = "Ce corail peut être volé",
        ["cop_title"] = "Plongée illégale",
        ["command_diving"] = "Prendre votre kit de plongée",
    },
    warning = {
        ["oxygen_one_minute"] = "Il vous reste une minute d'oxygène",
        ["oxygen_running_out"] = "Vous n'avez plus d'oxygène",
    },
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
