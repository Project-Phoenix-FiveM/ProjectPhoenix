local Translations = {
    error = {
        ["cancled"] = "Cancelada",
        ["no_truck"] = "¡No tienes camión!",
        ["not_enough"] = "Dinero insuficiente, necesitas (%{value})",
        ["too_far"] = "Estás demasiado lejos del punto de entrega",
        ["early_finish"] = "Porque regresaste antes de terminar (Completado: %{completed} total: %{total}), Tu depósito no será devuelto.",
        ["never_clocked_on"] = "You never clocked on!",
        ["all_occupied"] = "Todas los lugares de aparcamiento están ocupados",
        ["job"] = "Debe obtener el trabajo del centro de trabajo",
    },
    success = {
        ["clear_routes"] = "Rutas liberadas. %{value} rutas guardadas",
        ["pay_slip"] = "Tienes $%{total}, Tus %{deposit} estan en tu cuenta del banco!",
    },
    target = {
        ["talk"] = "Habla con Garbageman",
        ["grab_garbage"] = "Coge la bolsa de basura",
        ["dispose_garbage"] = "Deshazte de la bolsa de basura",
    },
    menu = {
        ["header"] = "Menú principal de la basura",
        ["collect"] = "Recoger el cheque de pago",
        ["return_collect"] = "¡Devuelve el camión y recoge el cheque de pago aquí!",
        ["route"] = "Solicitar ruta",
        ["request_route"] = "Solicite una ruta de basura",
    },
    info = {
        ["payslip_collect"] = "[E] - Recibir pago",
        ["payslip"] = "Pago",
        ["not_enough"] = "No tiene suficiente dinero para el depósito. Los costos de depósito son $%{value}",
        ["deposit_paid"] = "Has pagado $%{value} de deposito!",
        ["no_deposit"] = "No tiene depósito pagado en este vehículo.",
        ["truck_returned"] = "Camión devuelto, recolecte su recibo de pago para recibir su pago y depósito de regreso.",
        ["bags_left"] = "Aun hay %{value} bolsas faltantes!",
        ["bags_still"] = "Aun quedan %{value} bolsas por alla!",
        ["all_bags"] = "Todas las bolsas de basura están recolectadas, ¡continúe a la siguiente ubicación!",
        ["depot_issue"] = "Hubo un problema en el depósito, ¡regrese de inmediato!",
        ["done_working"] = "¡Ya terminaste de trabajar!Vuelve al depósito.",
        ["started"] = "¡Ha comenzado a trabajar, ubicación marcada en GPS!",
        ["grab_garbage"] = "[E] Agarrar una bolsa de basura",
        ["stand_grab_garbage"] = "Párate aquí para tomar una bolsa de basura.",
        ["dispose_garbage"] = "[E] Desechar la bolsa de basura",
        ["progressbar"] = "Poner bolsa en Trashmaster ..",
        ["garbage_in_truck"] = "Pon la bolsa en tu camión.",
        ["stand_here"] = "Parate aquí..",
        ["found_crypto"] = "Encontraste un cryptostick en el piso",
        ["payout_deposit"] = "(+ $%{value} deposito)",
        ["store_truck"] =  "[E] - Almacenar camión de basura",
        ["get_truck"] =  "[E] - Camión de la basura",
        ["picking_bag"] = "Agarrando bolsa de basura..",
        ["talk"] = "[E] Hablar con el hombre de la basura",
    },
    warning = {},
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
