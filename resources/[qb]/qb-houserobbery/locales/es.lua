local Translations = {
    error = {
        ["missing_something"] = "Parece que te falta algo...",
        ["not_enough_police"] = "No hay suficiente policía..",
        ["door_open"] = "La puerta ya esta abierta..",
        ["process_cancelled"] = "Proceso cancelado..",
        ["didnt_work"] = "No funcionó..",
        ["emty_box"] = "La caja esta vacía..",
    },
    success = {
        ["worked"] = "¡Funcionó!",
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
