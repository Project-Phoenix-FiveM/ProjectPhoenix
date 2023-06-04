local Translations = {
    labels = {
        engine = 'Motor',
        bodsy = 'Carrocería',
        radiator = 'Radiador',
        axle = 'Eje motriz',
        brakes = 'Frenos',
        clutch = 'Embrague',
        fuel = 'Depósito de combustible',
        sign_in = 'Entrar',
        sign_off = 'Salir',
        o_stash = '[E] Abrir Stash',
        h_vehicle = '[E] Ocultar vehículo',
        g_vehicle = '[E]  Obtener vehículo',
        o_menu = '[E]  Abrir Menú',
        work_v = '[E]  Trabajar en el vehículo',
        progress_bar = 'Reparando...',
        veh_status = 'Estado del vehículo:',
        job_blip = 'Mecánico de Autocare',
    },

    lift_menu = {
        header_menu = 'Opciones del vehículo',
        header_vehdc = 'Desconectar vehículo',
        desc_vehdc = 'Desconectar vehículo en el ascensor',
        header_stats = 'Comprobar estado',
        desc_stats = 'Comprobar estado del vehículo',
        header_parts = 'Partes del vehículo',
        desc_parts = 'Reparar piezas del vehículo',
        c_menu = '⬅ Cerrar menú'
    },

    parts_menu = {
        status = 'Estado: ',
        menu_header = 'Menú de piezas',
        repair_op = 'Reparar:',
        b_menu = '⬅ Menú de vuelta',
        d_menu = 'Volver al menú de piezas',
        c_menu = '⬅ Cerrar menú'
    },

    nodamage_menu = {
        header = 'Sin daños',
        bh_menu = 'Menú Atrás',
        bd_menu = '¡No hay daños en esta parte!',
        c_menu = '⬅ Cerrar Menú'
    },

    notifications = {
        not_enough = 'No tienes suficiente',
        not_have = 'No tienes',
        not_materials = 'No hay suficientes materiales en la caja fuerte',
        rep_canceled = 'Reparación cancelada',
        repaired = 'Ha sido reparado',
        uknown = 'Estado desconocido',
        not_valid = 'Vehículo no válido',
        not_close = 'No estás lo suficientemente cerca del vehículo',
        veh_first = 'Debe estar en el vehículo primero',
        outside = 'Debe estar fuera del vehículo',
        wrong_seat = 'Usted no es el conductor o está en una bicicleta',
        not_vehicle = 'No estás en un vehículo',
        progress_bar = 'Reparando el vehículo..',
        process_canceled = 'Proceso cancelado',
        not_part = 'No es una pieza válida',
        partrep ='¡El %{value} está reparado!',
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
