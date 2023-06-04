local Translations = {
    error = {
        ["failed_notification"] = "Fehlgeschlagen!",
        ["not_near_veh"] = "Du bist nicht in der Nähe eines Fahrzeugs!",
        ["out_range_veh"] = "Du bist zu weit vom Fahrzeug!",
        ["inside_veh"] = "Du kannst keinen Fahrzeug Motor von Innen Reparieren!",
        ["healthy_veh"] = "Fahrzeug ist in guter Kondition und benötigt bessere Werkzeuge!",
        ["inside_veh_req"] = "Du musst in einem Fahrzeug sein!",
        ["roadside_avail"] = "Es ist ein Mechaniker verfügbar rufe ihn!",
        ["no_permission"] = "Du hast keine Recht zum Reparieren!",
        ["fix_message"] = "%{message}, und gehe jetzt zu deiner Garage!",
        ["veh_damaged"] = "Dein Fahrzeug ist zu Kapputt!",
        ["nofix_message_1"] = "Du hast den Ölstand geprüft, Er Sieht gut aus!",
        ["nofix_message_2"] = "Du hast dein Bike gechecked, es sieht gut aus!",
        ["nofix_message_3"] = "Du hast das klebeband auf deiner Öl Leitung geprüft alles ok!",
        ["nofix_message_4"] = "Du hast das Radio lauter gemacht das komische motor geräusch ist nun weg!",
        ["nofix_message_5"] = "Der Rost Entferner machte keinen Unterschied",
        ["nofix_message_6"] = "Repariere nie was was nicht Kaputt ist!",
    },
    success = {
        ["cleaned_veh"] = "Fahrzeug geputzt!",
        ["repaired_veh"] = "Fahrzeug repariert!",
        ["fix_message_1"] = "Du hast den Öl-Stand geprüft.",
        ["fix_message_2"] = "Du hast das Öl-loch gestopft mit Kaugummi",
        ["fix_message_3"] = "Du hast eine Neue Öl Verbindung gebaut mit Klebeband",
        ["fix_message_4"] = "Du hast das Öl Problem temporär repariert",
        ["fix_message_5"] = "Du hast das Bike getreten es geht wieder!",
        ["fix_message_6"] = "Du hast etwas Rost entfernt",
        ["fix_message_7"] = "Du hast das Auto angeschrien, Es geht wieder!",
    },
    progress = {
        ["clean_veh"] = "Putze das Auto...",
        ["repair_veh"] = "Repariere Fahrzeug..",

    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
