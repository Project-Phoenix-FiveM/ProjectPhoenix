local Translations = {
    error = {
        ["missing_something"] = "Det ser ud som om du mangler noget...",
        ["not_enough_police"] = "Ikke nok Politi..",
        ["door_open"] = "Døren er allerede åben..",
        ["cancelled"] = "Proces annulleret..",
        ["didnt_work"] = "Det virkede ikke..",
        ["emty_box"] = "Kassen er tom..",
        ["injail"] = "Du er i fængsel i %{Time} måneder..",
        ["item_missing"] = "Du mangler en ting..",
        ["escaped"] = "Du slap... Kom for helvede væk herfra.!",
        ["do_some_work"] = "Gør noget arbejde for sætningsreduktion, øjeblikkeligt job: %{currentjob} ",
        ["security_activated"] = "Højeste sikkerhedsniveau er aktivt, bliv med celleblokkene!"
    },
    success = {
        ["found_phone"] = "Du fandt en telefon..",
        ["time_cut"] = "Du har arbejdet lidt fri fra din dom.",
        ["free_"] = "Du er fri! Nyd det! :)",
        ["timesup"] = "Din tid er gået! Tjek din tid i besøgscenteret",
    },
    info = {
        ["timeleft"] = "Du er stadig nød til... %{JAILTIME} måneder",
        ["lost_job"] = "Du er arbejdsløs",
        ["job_interaction"] = "[E] Elektricitet Arbejde",
        ["job_interaction_target"] = "Udfør %{job} arbejde",
        ["received_property"] = "Du har fået din ejendom tilbage..",
        ["seized_property"] = "Dine ting er blevet beslaglagt, du får alt tilbage, når din tid er gået..",
        ["cells_blip"] = "Celler",
        ["freedom_blip"] = "Fængsel reception",
        ["canteen_blip"] = "Kantine",
        ["work_blip"] = "Fængselsarbejde",
        ["target_freedom_option"] = "Tjek tid",
        ["target_canteen_option"] = "Få mad",
        ["police_alert_title"] = "Nyt Opkald",
        ["police_alert_description"] = "Fængselsudbrud",
        ["connecting_device"] = "Forbinder enhed",
        ["working_electricity"] = "Tilslutningsledninger"
    }
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
