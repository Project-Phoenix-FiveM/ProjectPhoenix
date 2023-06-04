local Translations = {
    error = {
        minimum_store_robbery_police = "No hay suficientes policia (%{MinimumStoreRobberyPolice} son requeridos)",
        not_driver = "No eres un conductor",
        demolish_vehicle = "No está permitido derribar vehículos ahora",
        process_canceled = "Proceso cancelado..",
        you_broke_the_lock_pick = "Has roto la ganzúa",
    },
    text = {
        the_cash_register_is_empty = "La caja registradora está vacía",
        try_combination = "~g~E~w~ - Ingresa la combinación",
        safe_opened = "Caja abierta",
        emptying_the_register= "Vaciando caja registradora..",
        safe_code = "Código de seguridad: "
    },
    email = {
        shop_robbery = "10-31 | Robo en progreso en Tienda",
        someone_is_trying_to_rob_a_store = "Alguien está tratando de robar una tienda en %{street} (CAMARA ID: %{cameraId1})",
        storerobbery_progress = "Robo en tienda en progreso"
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
