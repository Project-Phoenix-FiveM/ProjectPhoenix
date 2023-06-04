local Translations = {
    error = {
        ["missing_something"] = "Het lijkt alsof je iets mist...",
        ["not_enough_police"] = "Niet genoeg politie..",
        ["door_open"] = "De deur staat al open..",
        ["cancelled"] = "Voortgang afgebroken..",
        ["didnt_work"] = "Het heeft niet gewerkt..",
        ["emty_box"] = "De doos is leeg..",
        ["injail"] = "Je zit %{Time} maanden in de gevangenis..",
        ["item_missing"] = "Je mist een Item..",
        ["escaped"] = "Je bent ontsnapt... Maak dat je wegkomt.!",
        ["do_some_work"] = "Werk voor een strafvermindering, huidige baan: %{currentjob} ",
        ["security_activated"] = "Noodalarm, blijf bij de cellen!"
    },
    success = {
        ["found_phone"] = "Je hebt een telefoon gevonden..",
        ["time_cut"] = "Je hebt wat tijd van je straf gewerkt.",
        ["free_"] = "Je bent vrij! Geniet ervan! :)",
        ["timesup"] = "Je tijd is voorbij! Check jezelf uit in het bezoekerscentrum",
    },
    info = {
        ["timeleft"] = "Je hebt nog... %{JAILTIME} maanden",
        ["lost_job"] = "Je bent Werkloos",
        ["job_interaction_target"] = "Doe %{job} Werk",
        ["received_property"] = "Je kreeg je eigendommen terug..",
        ["seized_property"] = "Jouw eigendommen zijn ingenomen, je krijgt ze terug zodra je tijd is verlopen..",
        ["cells_blip"] = "Cellen",
        ["freedom_blip"] = "Gevangenis Receptie",
        ["canteen_blip"] = "Kantine",
        ["work_blip"] = "Gevangeniswerk",
        ["target_freedom_option"] = "Check Tijd",
        ["target_canteen_option"] = "Pak Eten",
        ["police_alert_title"] = "Nieuwe Oproep",
        ["police_alert_description"] = "Gevangenisuitbraak",
        ["connecting_device"] = "Apparaat Koppelen",
        ["working_electricity"] = "Draden Vastzetten"
    }
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
