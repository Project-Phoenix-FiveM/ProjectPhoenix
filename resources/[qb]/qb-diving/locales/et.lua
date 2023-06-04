local Translations = {
    error = {
        ["canceled"] = "Tühistatud",
        ["911_chatmessage"] = "911 KIRI",
        ["take_off"] = "/divingsuit kui soovid võtta seljast sukeldumisvarustust",
        ["not_wearing"] = "Te ei kanna sukeldumisvarustust ..",
        ["no_coral"] = "Teil pole koralle, mida müüa..",
        ["not_standing_up"] = "Sukeldumisvarustuse selga panemiseks peate püsti seisma",
    },
    success = {
        ["took_out"] = "Sa võtsid sukeldumisülikonna seljast",
    },
    info = {
        ["collecting_coral"] = "Korallide kogumine",
        ["diving_area"] = "Sukeldumiskoht",
        ["collect_coral"] = "Koguge koralle",
        ["collect_coral_dt"] = "[E] - Koguge koralle",
        ["checking_pockets"] = "Taskute kontrollimine koralli müümiseks",
        ["sell_coral"] = "Müü koralle",
        ["sell_coral_dt"] = "[E] - Müü koralle",
        ["blip_text"] = "911 - Sukeldumiskoht",
        ["put_suit"] = "Pane selga sukeldumisvarustust",
        ["pullout_suit"] = "Võta välja sukeldumisvarustus ..",
        ["cop_msg"] = "Se korall võib olla varastatud",
        ["cop_title"] = "Ebaseaduslik sukeldumine",
        ["command_diving"] = "Võta seljast Sukeldumisvarustuse",
    },
    warning = {
        ["oxygen_one_minute"] = "Teil on järelejäänud vähem kui 1 minut õhku",
        ["oxygen_running_out"] = "Õhk hakkab otsa saama",
    },
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
