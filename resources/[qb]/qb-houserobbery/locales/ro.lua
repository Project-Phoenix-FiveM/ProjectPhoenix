local Translations = {
    error = {
        ["missing_something"] = "Se pare ca-ti lipseste ceva...",
        ["not_enough_police"] = "Insuficiente forte de ordine disponibile..",
        ["door_open"] = "Usa este deja deschisa..",
        ["process_cancelled"] = "Actiune anulata..",
        ["didnt_work"] = "Se pare ca nu a functionat..",
        ["emty_box"] = "Nu am gasit nimic, cutia e goala..",
    },
    success = {
        ["worked"] = "Excelent, a functionat!",
    },
}

if GetConvar('qb_locale', 'en') == 'ro' then
    Lang = Lang or Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })
end
