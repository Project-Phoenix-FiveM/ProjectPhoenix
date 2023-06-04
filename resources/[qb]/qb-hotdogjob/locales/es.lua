local Translations = {
    error = {
        no_money = 'No hay suficiente dinero',
        too_far = 'Estás demasiado lejos de tu puesto de perritos calientes',
        no_stand = 'No tienes un puesto de perritos calientes',
        cust_refused = '¡Cliente rechazado!',
        no_stand_found = 'Su puesto de perritos calientes no aparece por ningún lado, ¡No recibirá su depósito de vuelta!',
        no_more = 'No tiene %{valor} más sobre esto frente al consejo',
        deposit_notreted = 'Usted no tenía un puesto de perritos calientes',
        no_dogs = 'Usted no tiene ningún hotdogs',
    },
    success = {
        deposit = '¡Ha pagado un depósito de $%{deposit}!',
        deposit_returned = '¡Su depósito de $%{deposit} ha sido devuelto!',
        sold_hotdogs = '%{value} x Hotdog(s) vendidos por $%{value2}',
        made_hotdog = 'Has hecho un %{valor} perritos calientes',
        made_luck_hotdog = 'Has hecho %{valor} x %{valor2} perritos calientes',
    },
    info = {
        command = "Borrar puesto (sólo para administradores)",
        blip_name = 'Puesto de perritos calientes',
        start_working = '[E] Empezar a trabajar',
        start_work = 'Empezar a trabajar',
        stop_working = '[E] Dejar de trabajar',
        stop_work = 'Dejar de trabajar',
        grab_stall = '[~g~G~s~] Tomar puesto',
        drop_stall = '[~g~G~s~] dejar puesto',
        grab = 'Puesto de agarre',
        prepare = 'Preparar perro caliente',
        toggle_sell = 'Alternar la venta',
        selling_prep = '[~g~E~s~] preparar perro caliente [Venta: ~g~Vendiendo~w~]',
        not_selling = '[~g~E~s~] Hotdog prepare [Sale: ~r~Not Selling~w~]',
        sell_dogs = '[~g~7~s~] Vender %{value} x perros caliente por $%{value2} / [~g~8~s~] Rechazar',
        sell_dogs_target = 'Vender %{value} x perros caliente por $%{value2}',
        admin_removed = "Puesto de perritos calientes eliminado",
        label_a = "Perfecto (A)",
        label_b = "Raro (B)",
        label_c = "Común (C)"
    },
        keymapping = {
        gkey = 'Deja el puesto de perritos calientes',
        
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
