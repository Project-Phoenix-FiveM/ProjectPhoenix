local Translations = {
    error = {
        ["canceled"] = "Annullato",
        ["911_chatmessage"] = "911",
        ["take_off"] = "/divingsuit per togliersi la muta da sub",
        ["not_wearing"] = "Non indossi un'attrezzatura da sub..",
        ["no_coral"] = "Non hai coralli da vendere..",
        ["not_standing_up"] = "Devi essere in piedi per indossare l'attrezzatura subacquea",
    },
    success = {
        ["took_out"] = "Ti sei tolto la muta da sub",
    },
    info = {
        ["collecting_coral"] = "Raccogliendo coralli..",
        ["diving_area"] = "Area di immersione",
        ["collect_coral"] = "Raccogli coralli",
        ["collect_coral_dt"] = "[E] - Raccogli coralli",
        ["checking_pockets"] = "Controllando i coralli..",
        ["sell_coral"] = "Vendi coralli",
        ["sell_coral_dt"] = "[E] - Vendi coralli",
        ["blip_text"] = "911 - Area di immersione",
        ["put_suit"] = "Indossando muta da sub..",
        ["pullout_suit"] = "Rimuovendo muta da sub..",
        ["cop_msg"] = "Dei coralli potrebbero essere stati rubati",
        ["cop_title"] = "Pesca illegale",
        ["command_diving"] = "Togliti la muta da sub",
    },
    warning = {
        ["oxygen_one_minute"] = "Hai meno di 1 minuto di aria rimanente",
        ["oxygen_running_out"] = "La tua attrezzatura da sub sta finendo l'aria",
    },
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
