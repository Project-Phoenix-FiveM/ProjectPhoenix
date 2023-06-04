local Translations = {
    error = {
        ["canceled"] = "Hætt",
        ["911_chatmessage"] = "911 SKILABOÐ",
        ["take_off"] = "/divingsuit til að fara úr köfunarbúningnum",
        ["not_wearing"] = "Þú ert ekki í köfunarbúnaði ..",
        ["no_coral"] = "Þú hefur engan kóral til að selja..",
        ["not_standing_up"] = "Þú þarft að standa upp til að setja á þig köfunarbúnaðinn",
    },
    success = {
        ["took_out"] = "Þú tókst blautbúninginn þinn af þér",
    },
    info = {
        ["collecting_coral"] = "Söfnun kórals",
        ["diving_area"] = "Köfunarsvæði",
        ["collect_coral"] = "Safna kóral",
        ["collect_coral_dt"] = "[E] - Safna kóral",
        ["checking_pockets"] = "Athuga vasa til að selja kóral",
        ["sell_coral"] = "Selja Kóral",
        ["sell_coral_dt"] = "[E] - Selja Kóral",
        ["blip_text"] = "911 - Köfunarsíða",
        ["put_suit"] = "Farðu í köfunargalla",
        ["pullout_suit"] = "Dragðu fram köfunargalla ..",
        ["cop_msg"] = "Þessum kóral gæti verið stolið",
        ["cop_title"] = "Ólögleg köfun",
        ["command_diving"] = "Farðu úr köfunarbúningnum",
    },
    warning = {
        ["oxygen_one_minute"] = "Þú átt innan við 1 mínútu af lofti eftir",
        ["oxygen_running_out"] = "Köfunarbúnaðurinn þinn er að verða uppiskroppa með loftið",
    },
}

if GetConvar('qb_locale', 'en') == 'is' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
