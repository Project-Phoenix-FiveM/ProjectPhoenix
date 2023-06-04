local Translations = {
    error = {
        smash_own = "No puedes desguazar tu propio vehículo.",
        cannot_scrap = "Este vehículo no se puede desguazar.",
        not_driver = "No eres el conductor",
        demolish_vehicle = "No estás autorizado a desguazar vehículos",
        canceled = "Cancelado",
    },
    text = {
        scrapyard = 'Desguace',
        disassemble_vehicle = '[E] - Desguazar vehículo',
        disassemble_vehicle_target = 'Desguazar vehículo',
        email_list = "[E] - Lista de Vehículos",
        email_list_target = "Lista de Vehículos",
        demolish_vehicle = "Desguazar vehículo",
    },
    email = {
        sender = "Desguace de vehículos de Turner",
        subject = "Lista de Vehículos",
        message = "Solo puedes demoler unos cuantos vehículos.<br />Puedes quedarte los materiales resultantes, siempre que no me molestes.<br /><br /><strong>Lista de Vehículos:</strong><br />",
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
