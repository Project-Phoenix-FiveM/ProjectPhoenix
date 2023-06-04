local Translations = {
    error = {
        ["invalid_job"] = "No creo que trabaje aquí...",
        ["invalid_items"] = "¡No tienes el item correcto!",
        ["no_items"] = "No tienes ningun item",
    },
    progress = {
        ["pick_grapes"] = "Recogiendo uvas..",
        ["process_grapes"] = "Procesando uvas.. ..",
    },
    task = {
        ["start_task"] = "[E] Para empezar",
        ["load_ingrediants"] = "[E] Cargar Ingredientes",
        ["wine_process"] = "[E] Comenzar la elaboracion del vino",
        ["get_wine"] = "[E] Obtener Vino",
        ["make_grape_juice"] = "[E] Hacer zumo de uva (Mosto)",
        ["countdown"] = "Tiempo restante %{time}s",
        ['cancel_task'] = "Has cancelado la tarea"
    },
    text = {
        ["start_shift"] = "¡Has comenzado tu turno en el viñedo!",
        ["end_shift"] = "¡Has finalizado tu turno en el viñedo!",
        ["valid_zone"] = "Zona Valida!",
        ["invalid_zone"] = "Zona NO Valida!",
        ["zone_entered"] = "%{zone} Entrando en zona",
        ["zone_exited"] = "%{zone} Saliendo de zona",
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
