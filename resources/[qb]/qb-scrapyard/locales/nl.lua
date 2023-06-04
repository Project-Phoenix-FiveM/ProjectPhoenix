local Translations = {
    error = {
        smash_own = "Je kunt een voertuig dat in het bezit is niet slopen.",
        cannot_scrap = "Dit voertuig kan niet worden gesloopt.",
        not_driver = "Jij bent niet de bestuurder",
        demolish_vehicle = "Je mag nu geen voertuigen slopen",
        canceled = "Geannuleerd",
    },
    text = {
        scrapyard = 'Schrootwerf',
        disassemble_vehicle = '[E] - Voertuig Demonteren',
        disassemble_vehicle_target = 'Voertuig Demonteren',
        email_list = "[E] - E-mail Voertuiglijst",
        email_list_target = "E-mail Voertuiglijst",
        demolish_vehicle = "Voertuig Slopen",
    },
    email = {
        sender = "Turner’s Autosloop",
        subject = "Voertuiglijst",
        message = "Je kunt slechts een aantal voertuigen slopen.<br />Je kunt alles wat je sloopt voor jezelf houden zolang je mij er niet mee lastig valt.<br /><br /><strong>Voertuiglijst:</strong><br />",
    },
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
