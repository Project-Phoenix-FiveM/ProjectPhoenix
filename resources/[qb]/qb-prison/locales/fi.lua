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
        ["do_some_work"] = "Tee työtä tuomion lyhentämiseksi, tämänhetkinen työ: %{currentjob} ",
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
    }
}
Lang = Locale:new({
phrases = Translations,
warnOnMissing = true})
