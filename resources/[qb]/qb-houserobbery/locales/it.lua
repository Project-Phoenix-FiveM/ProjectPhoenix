local Translations = {
    error = {
        ["missing_something"] = "Sembra che ti manchi qualcosa...",
        ["not_enough_police"] = "Non c'è abbastanza polizia..",
        ["door_open"] = "La porta è già aperta..",
        ["process_cancelled"] = "Processo Annullato..",
        ["didnt_work"] = "Non ha funzionato..",
        ["emty_box"] = "La scatola è vuota..",
    },
    success = {
        ["worked"] = "Ha funzionato!",
    }
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
