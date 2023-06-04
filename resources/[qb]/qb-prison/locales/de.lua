local Translations = {
    error = {
        ["missing_something"] = "Es sieht dir aus wie als würde dir was Fehlen...",
        ["not_enough_police"] = "Nicht genug Polizisten..",
        ["door_open"] = "Die Türe ist bereits offen..",
        ["cancelled"] = "Prozess abgebrochen..",
        ["didnt_work"] = "Es hat nicht Funktioniert..",
        ["emty_box"] = "Die Box ist leer..",
        ["injail"] = "Du bist im Gefängnis für %{Time} weitere Monate..",
        ["item_missing"] = "Dir fehlt ein Gegenstand..",
        ["escaped"] = "Du bist ausgebrochen, Schnell weg!",
        ["do_some_work"] = "Mache etwas Arbeit um deine Haftzeit zu verkürzen, Job: %{currentjob} ",
    },
    success = {
        ["found_phone"] = "Du findest ein Handy..",
        ["time_cut"] = "Du hast deine Haftzeit verkürzt.",
        ["free_"] = "Du bist frei, Viel Spaß :)",
        ["timesup"] = "Deine Zeit ist Vorbei, Gehe zum Besucher Zentrum",
    },
    info = {
        ["timeleft"] = "Du hast noch %{JAILTIME} Monate",
        ["lost_job"] = "Du hast deine Job verloren und bist jetzt Arbeitslos",
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
