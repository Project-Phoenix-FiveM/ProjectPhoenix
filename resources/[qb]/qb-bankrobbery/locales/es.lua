local Translations = {
    success = {
        success_message = "Se han fundido los fusibles",
        fuses_are_blown = "Los fusibles se han fundido",
        door_has_opened = "La puerta se ha abierto"
    },
    error = {
        cancel_message = "Cancelado",
        safe_too_strong = "Parece que la cerradura de la caja fuerte es demasiado fuerte...",
        missing_item = "Te falta un artículo...",
        bank_already_open = "El banco ya está abierto...",
        minimum_police_required = "Se necesita un mínimo de %{police} policías",
        security_lock_active = "El bloqueo de seguridad está activo, actualmente no es posible abrir la puerta",
        wrong_type = "%{receiver} no ha recibido el tipo correcto para el argumento '%{argument}'\ntipo recibido: %{receivedType}\nvalor recibido: %{receivedValue}\ntipo esperado: %{expected}",
        fuses_already_blown = "Los fusibles ya están fundidos...",
        event_trigger_wrong = "%{event}%{extraInfo} se ha disparado al no cumplirse algunas condiciones, fuente: %{source}",
        missing_ignition_source = "Le falta una fuente de ignición"
    },
    general = {
        breaking_open_safe = "Abriendo la caja fuerte...",
        connecting_hacking_device = "Conectando el dispositivo de hacking...",
        fleeca_robbery_alert = "Intento de robo en el banco de Fleeca",
        paleto_robbery_alert = "Intento de atraco a la Caja de Ahorros del Condado de Blain",
        pacific_robbery_alert = "Intento de robo en el Pacific Standard Bank",
        break_safe_open_target = "Romper caja fuerte abierta",
        break_safe_open_option_drawtext = "[E] Romper la caja fuerte",
        validating_bankcard = "Validando tarjeta...",
        thermite_detonating_in_seconds = "La termita estallará en %{time} segundo(s)",
        bank_robbery_police_call = "10-90: Robo de banco"
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
