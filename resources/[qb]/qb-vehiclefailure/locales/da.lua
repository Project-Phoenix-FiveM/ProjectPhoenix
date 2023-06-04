local Translations = {
    error = {
        ["failed_notification"] = "Fejlede!",
        ["not_near_veh"] = "Du er ikke i nærheden af et køretøj!",
        ["out_range_veh"] = "Du er for langt væk fra køretøjet!",
        ["inside_veh"] = "Du kan ikke reparere et køretøj indefra!",
        ["healthy_veh"] = "Køretøjet er ikke beskadigt nok, der skal et andet værktøj til!",
        ["inside_veh_req"] = "Du skal sidde inde i køretøjet for at kunne reparere den!",
        ["roadside_avail"] = "Der er vejhjælp at benytte sig af, giv dem et kald fra mobilen!",
        ["no_permission"] = "Du har ingen agang til dette",
        ["fix_message"] = "%{message}, og gå nu til din garage!",
        ["veh_damaged"] = "Dit køretøj er for ødelagt!",
        ["nofix_message_1"] = "Du kiggede på oliestanden, og det så normalt ud",
        ["nofix_message_2"] = "Du kiggede på din cykel, og noget ser forkert ud",
        ["nofix_message_3"] = "Du kiggede på gaffatapen på olieslangen, det så fint ud",
        ["nofix_message_4"] = "Du skruede op for højtalerne. Den mærkelig motor lyd er nu væk",
        ["nofix_message_5"] = "Rust fjerneren virkede vidst ikke her",
        ["nofix_message_6"] = "Aldrig reparere noget der ikke er istykker, men du lyttede ikke",
    },
    success = {
        ["cleaned_veh"] = "Køretøjet er vasket!",
        ["repaired_veh"] = "Køretøjet repareret!",
        ["fix_message_1"] = "Du kiggede på oliestanden",
        ["fix_message_2"] = "Du lukkede oliekappen med en klat tyggegummi",
        ["fix_message_3"] = "Du reparerede olieslangen med gaffatape",
        ["fix_message_4"] = "Du stoppede midlertidigt oliespilden",
        ["fix_message_5"] = "Du sparkede til cyklen og den virker igen!",
        ["fix_message_6"] = "Du fjernede rusten",
        ["fix_message_7"] = "Du råbte af køretøjet, og nu virker den fint igen!",
    },
    progress = {
        ["clean_veh"] = "Vasker bilen...",
        ["repair_veh"] = "Reparere køretøjet..",

    }
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
