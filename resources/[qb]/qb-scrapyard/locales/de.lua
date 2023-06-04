local Translations = {
    error = {
        smash_own = "Man kann kein Fahrzeug zertrümmern, dem es gehört.",
        cannot_scrap = "Dieses Fahrzeug kann nicht verschrottet werden.",
        not_driver = "Sie sind nicht der Fahrer",
        demolish_vehicle = "Sie dürfen jetzt keine Fahrzeuge demolieren",
        canceled = "Abgebrochen",
    },
    text = {
        scrapyard = 'Schrottplatz',
        disassemble_vehicle = '[E] - Fahrzeug demontieren',
        disassemble_vehicle_target = 'Fahrzeug demontieren',
        email_list = "[E] - E-Mail Fahrzeugliste",
        email_list_target = "E-Mail Fahrzeugliste",
        demolish_vehicle = "Fahrzeug demolieren",
    },
    email = {
        sender = "Turner's Autoverschrottung",
        subject = "Fahrzeugliste",
        message = "Sie können nur eine bestimmte Anzahl von Fahrzeugen demolieren.<br />Du kannst alles, was du abreißt, für dich behalten, solange du mich nicht störst.<br /><br /><strong>Fahrzeugliste:</strong><br />",
    },
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
