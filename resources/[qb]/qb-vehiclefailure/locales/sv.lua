local Translations = {
    error = {
        ["failed_notification"] = "Misslyckades!",
        ["not_near_veh"] = "Du är inte nära ett fordon!",
        ["out_range_veh"] = "Du är för långt från fordonet!",
        ["inside_veh"] = "Du kan inte reparera en fordonsmotor från insidan!",
        ["healthy_veh"] = "Fordonet är för friskt och behöver bättre verktyg!",
        ["inside_veh_req"] = "Du måste vara i ett fordon för att reparera det!",
        ["roadside_avail"] = "Det finns vägassistans tillgängligt ring det via din telefon!",
        ["no_permission"] = "Du har inte tillstånd att reparera fordon!",
        ["fix_message"] = "%{message}, och nu gå till ett garage!",
        ["veh_damaged"] = "Ditt fordon är för skadat!",
        ["nofix_message_1"] = "Du tittade på din oljenivå och det här såg normalt ut",
        ["nofix_message_2"] = "Du tittade på din cykel och inget verkar fel",
        ["nofix_message_3"] = "Du tittade på ankbandet på din oljeslang och verkade bra",
        ["nofix_message_4"] = "Du satte upp radion. Det konstiga motorljudet är nu borta",
        ["nofix_message_5"] = "Rostborttagningsmedlet du använde hade ingen effekt",
        ["nofix_message_6"] = "Försök aldrig göra något som inte är trasigt, men du lyssnade inte",
    },
    success = {
        ["cleaned_veh"] = "Fordonet städat!",
        ["repaired_veh"] = "Fordonet reparerat!",
        ["fix_message_1"] = "Du kollade oljenivån",
        ["fix_message_2"] = "Du stängde oljespillet med tuggummi",
        ["fix_message_3"] = "Du gjorde oljeslangen med tejp",
        ["fix_message_4"] = "Du har tillfälligt stoppat oljeläckan",
        ["fix_message_5"] = "Du sparkade på cykeln och den fungerar igen",
        ["fix_message_6"] = "Du tog bort lite rost",
        ["fix_message_7"] = "Du skrek på din bil och den fungerar igen",
    },
    progress = {
        ["clean_veh"] = "Rengör bilen...",
        ["repair_veh"] = "Reparerar fordon..",

    }
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
