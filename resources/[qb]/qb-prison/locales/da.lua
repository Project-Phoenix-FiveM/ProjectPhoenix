local Translations = {
    error = {
        ["missing_something"] = "Det ser ud til at du mangler noget...",
        ["not_enough_police"] = "Ikke nok betjente..",
        ["door_open"] = "Døren er allerede åben..",
        ["cancelled"] = "Handlingen afbrudt..",
        ["didnt_work"] = "Det virkede ikke..",
        ["emty_box"] = "Kassen er tom..",
        ["injail"] = "Du er i spjældet i %{Time} måneder..",
        ["item_missing"] = "Du mangler en enhed..",
        ["escaped"] = "Du flygtede! Se at kom væk i en fart!",
        ["do_some_work"] = "Udfør noget arbejde for at nedsætte din straf, nuværende job: %{currentjob} ",
    },
    success = {
        ["found_phone"] = "Du fandt en mobil..",
        ["time_cut"] = "Du fik nedsat din tid for at arbejde.",
        ["free_"] = "Du er fri! Nyd det! :)",
        ["timesup"] = "Din tid er omme! Udskriv dig selv i receptionen",
    },
    info = {
        ["timeleft"] = "Du har stadig %{JAILTIME} måneder tilbage...",
        ["lost_job"] = "Du er arbejdsløs",
    }
}
Lang = Locale:new({
phrases = Translations,
warnOnMissing = true})
