local Translations = {
    error = {
        ["missing_something"] = "Parece que te falta algo...",
        ["not_enough_police"] = "No hay suficiente policía..",
        ["door_open"] = "La puerta ya está abierta..",
        ["cancelled"] = "Proceso cancelado..",
        ["didnt_work"] = "No funcionó..",
        ["emty_box"] = "La caja está vacía..",
        ["injail"] = "Estás en la cárcel durante %{Time} meses..",
        ["item_missing"] = "Te falta un objeto..",
        ["escaped"] = "Te has escapado... Sal de aquí.",
        ["do_some_work"] = "Haz algún trabajo para la reducción de la condena, trabajo instantáneo: %{currentjob}",
        ["security_activated"] = "¡El nivel de seguridad más alto está activado, quédate con los bloques de celdas!"
    },
    success = {
        ["found_phone"] = "Has encontrado un teléfono..",
        ["time_cut"] = "Has rebajado algo de tiempo de tu condena",
        ["free_"] = "¡Eres libre! ¡Disfrútalo! :)",
        ["timesup"] = "¡Tu tiempo se ha acabado! Comprueba tu estado en el centro de visitantes",
    },
    info = {
        ["timeleft"] = "Todavía tienes que... %{JAILTIME} meses",
        ["lost_job"] = "Estás en el paro",
        ["job_interaction"] = "Trabajo de Electricidad",
        ["job_interaction_target"] = "Haz %{job} Trabajo",
        ["received_property"] = "Has recuperado tu propiedad...",
        ["seized_property"] = "Tu propiedad ha sido confiscada, lo recuperarás todo cuando se cumpla tu tiempo..",
        ["cells_blip"] = "Celdas",
        ["freedom_blip"] = "Recepción de la cárcel",
        ["canteen_blip"] = "Comedor",
        ["work_blip"] = "Trabajo en la cárcel",
        ["target_freedom_option"] = "Hora de la revisión",
        ["target_canteen_option"] = "Conseguir comida",
        ["police_alert_title"] = "Nueva llamada",
        ["police_alert_description"] = "Brote de prisión",
        ["connecting_device"] = "Dispositivo de conexión",
        ["working_electricity"] = "Conexión de cables"
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
