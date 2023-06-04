local Translations = {
    error = {
        ["canceled"] = "annulleret",
        ["911_chatmessage"] = "Alarmcentral",
        ["take_off"] = "/divingsuit for at tage din dykkerdragt af",
        ["not_wearing"] = "Du har ikke dykkerudstyr på ..",
        ["no_coral"] = "Du har ingen koraller du kan sælge..",
        ["not_standing_up"] = "Du skal stå op for at tage dykkerudstyret på",
        ["need_otube"] = "du har brug for iltslange",
        ["oxygenlevel"] = 'gearniveauet er %{oxygenlevel} skal være 0%'
    },
    success = {
        ["took_out"] = "Du tog din våddragt af",
        ["tube_filled"] = "Røret er blevet fyldt"
    },
    info = {
        ["collecting_coral"] = "Samler koraller",
        ["diving_area"] = "Dykker område",
        ["collect_coral"] = "Saml koraller",
        ["collect_coral_dt"] = "[E] - aml koraller",
        ["checking_pockets"] = "Du tjkker dine lommer for koraller du kan sælge",
        ["sell_coral"] = "Sælg koraller",
        ["sell_coral_dt"] = "[E] - Sælg koraller",
        ["blip_text"] = "112 - En person samler koraller ulovligt",
        ["put_suit"] = "Tag en dykkerdragt på",
        ["pullout_suit"] = "Træk en dykker dragt ud ..",
        ["cop_msg"] = "Disse koraller er muligvis stjålet",
        ["cop_title"] = "Ulovlig dykning",
        ["command_diving"] = "Tag din dykkerdragt af",
    },
    warning = {
        ["oxygen_one_minute"] = "Du har mindre end 1 minuts luft tilbage",
        ["oxygen_running_out"] = " Du er ved at løbe tør for luft",
    },
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
