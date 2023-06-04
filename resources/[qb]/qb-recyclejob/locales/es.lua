local Translations = {
    success = {
        you_have_been_clocked_in = "Has registrado la entrada",
    },
    text = {
        point_enter_warehouse = "[E] Entrar al almacén",
        enter_warehouse= "Entrar al almacén",
        exit_warehouse= "Salir del almacén",
        point_exit_warehouse = "[E] Salir del almacén",
        clock_out = "[E] Marcar la salida",
        clock_in = "[E] Marcar la entrada",
        hand_in_package = "Paquete de mano",
        point_hand_in_package = "[E] Paquete de mano",
        get_package = "Obtener paquete",
        point_get_package = "[E] Obtener paquete",
        picking_up_the_package = "Recogiendo el paquete",
        unpacking_the_package = "Desempacando",
    },
    error = {
        you_have_clocked_out = "Has registrado la salida"
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Lang or Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })
end