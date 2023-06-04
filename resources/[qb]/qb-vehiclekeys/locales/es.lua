local Translations = {
    notify = {
        ydhk = 'No tienes las llaves de este vehículo',
        nonear = 'No hay nadie cerca a quién darle las llaves',
        vlock = '¡Vehículo cerrado!',
        vunlock = '¡Vehículo abierto!',
        vlockpick = '¡Lograste abrir la cerradura!',
        fvlockpick = 'No logras encontrar las llaves y te frustras',
        vgkeys = 'Has entregado las llaves',
        vgetkeys = '¡Has recibido las llaves al vehículo!',
        fpid = 'Llena los argumentos de ID y placa del jugador',
        cjackfail = '¡Robo de carro falló!',
        vehclose = '¡No hay vehículo cerca!',
    },
    progress = {
        takekeys = 'Obteniendo las llaves del cuerpo...',
        hskeys = 'Buscando las llaves del carro...',
        acjack = 'Intentando robar carro...',
    },
    info = {
        skeys = '[H] - Buscar llaves',
        tlock = 'Habilitar/deshabilitar seguro de carro',
        palert = 'Robo de vehículo en progreso. Tipo: ',
        engine = 'Encender/apagar motor',
    },
    addcom = {
        givekeys = 'Entregar llaves a alguien. Si no hay ID, entregar a la persona más cercana o a todos en el vehículo.',
        givekeys_id = 'id',
        givekeys_id_help = 'ID de jugador',
        addkeys = 'Agrega llaves a un vehículo para alguien.',
        addkeys_id = 'id',
        addkeys_id_help = 'ID de jugador',
        addkeys_plate = 'placa',
        addkeys_plate_help = 'Placa',
        rkeys = 'Quitar llaves de un vehículo a alguien.',
        rkeys_id = 'id',
        rkeys_id_help = 'ID de jugador',
        rkeys_plate = 'placa',
        rkeys_plate_help = 'Placa',
    }

}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
