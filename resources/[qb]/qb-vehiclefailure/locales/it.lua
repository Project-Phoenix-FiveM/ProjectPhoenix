local Translations = {
    error = {
        ["failed_notification"] = "Non riuscito!",
        ["not_near_veh"] = "Non sei vicino ad un veicolo!",
        ["out_range_veh"] = "Sei troppo lontano dal veicolo!",
        ["inside_veh"] = "Non puoi riparare un motore di un veicolo dall'interno!",
        ["healthy_veh"] = "Veicolo è troppo riparato e ha bisogno di strumenti migliori!",
        ["inside_veh_req"] = "Devi essere in un veicolo per ripararlo!",
        ["roadside_avail"] = "L'assistenza stradale è disponibile da chiamare tramite il telefono!",
        ["no_permission"] = "Non hai il permesso di riparare i veicoli",
        ["fix_message"] = "%{message}, e ora vai in un garage!",
        ["veh_damaged"] = "Il tuo veicolo è troppo danneggiato!",
        ["nofix_message_1"] = "Hai guardato il tuo livello di olio, e sembra normale",
        ["nofix_message_2"] = "Hai guardato la tua moto e non c'è niente che non va",
        ["nofix_message_3"] = "Hai guardato il nastro adesivo sul tubo dell'olio e sembra a posto",
        ["nofix_message_4"] = "Hai acceso la radio. Lo strano rumore del motore è sparito",
        ["nofix_message_5"] = "L'antiruggine che hai usato non ha avuto effetto",
        ["nofix_message_6"] = "Non provare mai a sistemare qualcosa che non è rotto, ma non hai ascoltato",
    },
    success = {
        ["cleaned_veh"] = "Veicolo pulito!",
        ["repaired_veh"] = "Veicolo riparato!",
        ["fix_message_1"] = "Hai controllato il livello dell'olio",
        ["fix_message_2"] = "Hai chiuso la fuoriuscita di olio con una chewing gum",
        ["fix_message_3"] = "Hai sistemato il tubo dell'olio con il nastro",
        ["fix_message_4"] = "Hai temporaneamente fermato la perdita di olio",
        ["fix_message_5"] = "Hai dato un calcio alla moto e funziona di nuovo",
        ["fix_message_6"] = "Hai rimosso un po' di ruggine",
        ["fix_message_7"] = "Hai urlato alla macchina e funziona di nuovo",
    },
    progress = {
        ["clean_veh"] = "Lavando la macchina...",
        ["repair_veh"] = "Riparando il veicolo..",

    }
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
