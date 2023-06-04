local Translations = {
    error = {
        ["missing_something"] = "Zdá se, že vám něco chybí...",
        ["not_enough_police"] = "Nedostatek policejních složek..",
        ["door_open"] = "Dveře jsou již otevřené..",
        ["cancelled"] = "Proces přerušen..",
        ["didnt_work"] = "Nefunguje to..",
        ["emty_box"] = "Box je prázdný..",
        ["injail"] = "Jste ve vězení na %{Time} měsíců..",
        ["item_missing"] = "Chybí vám item..",
        ["escaped"] = "Utekl jsi... Vezmi nohy na ramena a utíkej pryč.!",
        ["do_some_work"] = "Udělejte nějakou práci pro snížení trestu, okamžitou práci: %{currentjob} ",
    },
    success = {
        ["found_phone"] = "Našel jste telefon..",
        ["time_cut"] = "Z trestu jste si odpracoval nějaký čas.",
        ["free_"] = "Byl jste propuštěn! Užívejte! :)",
        ["timesup"] = "Váš čas ve vězení vypršel! Podívejte se na návštěvnické centrum",
    },
    info = {
        ["timeleft"] = "Stále zde budeš... %{JAILTIME} měsíců",
        ["lost_job"] = "Jste nezaměstnaný",
    }
}

if GetConvar('qb_locale', 'en') == 'cs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
