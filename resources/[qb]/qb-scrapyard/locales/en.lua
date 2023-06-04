local Translations = {
    error = {
        smash_own = "You can't smash a vehicle that owns it.",
        cannot_scrap = "This Vehicle Cannot Be Scrapped.",
        not_driver = "You Are Not The Driver",
        demolish_vehicle = "You Are Not Allowed To Demolish Vehicles Now",
        canceled = "Canceled",
    },
    text = {
        scrapyard = 'Scrap Yard',
        disassemble_vehicle = '[E] - Disassemble Vehicle',
        disassemble_vehicle_target = 'Disassemble Vehicle',
        email_list = "[E] - E-mail Vehicle List",
        email_list_target = "E-mail Vehicle List",
        demolish_vehicle = "Demolish Vehicle",
    },
    email = {
        sender = "Turner’s Auto Wrecking",
        subject = "Vehicle List",
        message = "You Can Only Demolish A Number Of Vehicles.<br />You Can Keep Everything You Demolish For Yourself As Long As You Dont Bother Me.<br /><br /><strong>Vehicle List:</strong><br />",
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
