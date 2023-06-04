local Translations = {
    error = {
        ["failed_notification"] = "¡Ha fallado!",
        ["not_near_veh"] = "¡No estás cerca de un vehículo!",
        ["out_range_veh"] = "¡Está demasiado lejos del vehículo!",
        ["inside_veh"] = "¡No se puede reparar el motor de un vehículo desde el interior!",
        ["healthy_veh"] = "¡El vehículo está bien y necesita mejores herramientas!",
        ["inside_veh_req"] = "¡Debes estar en un vehículo para repararlo!",
        ["roadside_avail"] = "¡Hay asistencia en carretera disponible para llamar a través de su teléfono!",
        ["no_permission"] = "No tienes permiso para reparar vehículos.",
        ["fix_message"] = "¡%{message}, ahora ve a un garaje!",
        ["veh_damaged"] = "¡Tu vehículo está demasiado dañado!",
        ["nofix_message_1"] = "Miraste el nivel de aceite y parecía normal",
        ["nofix_message_2"] = "Miraste tu bicicleta y nada parece estar mal",
        ["nofix_message_3"] = "Miraste la cinta adhesiva en la goma de aceite y parece estar bien",
        ["nofix_message_4"] = "Subiste la radio. El extraño ruido del motor ahora se ha ido.",
        ["nofix_message_5"] = "El desoxidante que usaste no tuvo efecto",
        ["nofix_message_6"] = "Nunca intentes hacer algo que no esté roto, pero no escuchaste",
    },
    success = {
        ["cleaned_veh"] = "¡Vehículo limpiado!",
        ["repaired_veh"] = "¡Vehículo reparado!",
        ["fix_message_1"] = "Revisaste el nivel de aceite",
        ["fix_message_2"] = "Tapaste el derrame de gasolina con un chicle",
        ["fix_message_3"] = "Hiciste la manguera de aceite con cinta",
        ["fix_message_4"] = "Ha detenido temporalmente la fuga de aceite.",
        ["fix_message_5"] = "Pateaste la bicicleta y vuelve a funcionar",
        ["fix_message_6"] = "Quitaste algo de óxido",
        ["fix_message_7"] = "Le gritaste a tu auto, y vuelve a funcionar",
    },
    progress = {
        ["clean_veh"] = "Limpiando el coche...",
        ["repair_veh"] = "Reparando vehiculo...",

    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
