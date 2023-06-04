local Translations = {
    error = {
        ["missing_something"] = "Näyttää siltä, että sinulta puuttuu jotain...",
        ["not_enough_police"] = "Ei tarpeeksi poliiseja",
        ["door_open"] = "Ovi on jo auki!",
        ["cancelled"] = "Toiminto peruutettu",
        ["didnt_work"] = "Et onnistunut..",
        ["emty_box"] = "Laatikko on tyhjä..",
        ["injail"] = "Olet vankilassa %{Time} kuukautta..",
        ["item_missing"] = "Sinulta puuttuu esine..",
        ["escaped"] = "Pääsit pakoon... painu hiiteen!",
        ["do_some_work"] = "Tee töitä rangaistuksen keventämiseksi, välitöntä työtä: %{currentjob} ",
        ["security_activated"] = "Korkein suojaustaso on aktiivinen, pysy sellissäsi!"
    },
    success = {
        ["found_phone"] = "Löysit puhelimen..",
        ["time_cut"] = "Olet lyhentänyt tuomiotasi!",
        ["free_"] = "Pääsit vapaaksi! Ethän tee enään mitään tyhmää ;)",
        ["timesup"] = "Aikasi on päättynyt! Ilmoita itsesi vierailijapisteellä",
    },
    info = {
        ["timeleft"] = "Tuomiosi kestää vielä %{JAILTIME} kuukautta",
        ["lost_job"] = "Olet saaut potkut",
        ["job_interaction"] = "[E] Sähkötyöt", -- This needs to be translated
        ["job_interaction_target"] = "Tee %{job} Töitä",
        ["received_property"] = "Sait omaisuutesi takaisin..",
        ["seized_property"] = "Omaisuutesi on takavarikoitu, saat kaiken takaisin, kun aikasi loppuu..",
        ["cells_blip"] = "Sellit",
        ["freedom_blip"] = "Vankilan vastaanotto",
        ["canteen_blip"] = "Kahvila",
        ["work_blip"] = "Vankilatyöt",
        ["target_freedom_option"] = "Katso tuomion pituus",
        ["target_canteen_option"] = "Hae ruokaa",
        ["police_alert_title"] = "Uusi puhelu",
        ["police_alert_description"] = "Vankila Pako",
        ["connecting_device"] = "Yhdistetään laitetta",
        ["working_electricity"] = "Yhdistetään johtoja"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
