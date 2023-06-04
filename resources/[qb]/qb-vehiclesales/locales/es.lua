local Translations = {
    error = {
        not_your_vehicle = 'Este no es tu vehículo..',
        vehicle_does_not_exist = 'El vehículo no existe',
        not_enough_money = 'No tienes suficiente dinero',
        finish_payments = 'Debe terminar de pagar este vehículo, antes de poder venderlo..',
        no_space_on_lot = '¡No hay espacio para su vehículo en el lote!'
    },
    success = {
        sold_car_for_price = 'Has vendido tu coche por $%{value}',
        car_up_for_sale = '¡Tu coche ha sido puesto a la venta! Precio - $%{value}',
        vehicle_bought = 'Vehículo comprado'
    },
    info = {
        confirm_cancel = '~g~S~w~ - Confirmar / ~r~N~w~ - Cancelar ~g~',
        vehicle_returned = 'Su vehículo se ha devuelto',
        used_vehicle_lot = 'Lote de vehículos usados',
        sell_vehicle_to_dealer = '[~g~E~w~] - Vender vehículo al concesionario por ~g~$%{value}',
        view_contract = '[~g~E~w~] - Ver contrato de vehículo',
        cancel_sale = '[~r~G~w~] - Cancelar venta del vehículo',
        model_price = '%{value}, Precio: ~g~$%{value2}',
        are_you_sure = '¿Estás seguro de que ya no quieres vender tu vehículo?',
        yes_no = '[~g~7~w~] - Sí | [~r~8~w~] - No',
        place_vehicle_for_sale = '[~g~E~w~] - Colocar vehículo a la venta por el propietario'
    },
    charinfo = {
        firstname = 'no',
        lastname = 'conocido',
        account = 'Cuenta desconocida..',
        phone = 'número de teléfono desconocido..'
    },
    mail = {
        sender = 'Venta de vehículos Larrys RV',
        subject = '¡Has vendido un vehículo!',
        message = 'Ha ganado $%{value} con la venta de tu %{value2}.'
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
