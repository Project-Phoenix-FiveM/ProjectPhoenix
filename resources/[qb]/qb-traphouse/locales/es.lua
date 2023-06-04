local Translations = {
    error = {
        not_enough = "No tienes suficiente dinero..",
        no_slots = "No hay espacios disponibles",
        occured = "Ocurrió un error",
        have_keys = "Esta persona ya tiene llaves",
        p_have_keys = "%{value} ya tiene las llaves",
        not_owner = "No tienes una casa trampa o no eres el dueño",
        not_online = "Esta persona no esta en la ciudad",
        no_money = "No hay dinero en el armario",
        incorrect_code = "Este código es incorrecto",
        up_to_6 = "Puedes darle acceso hasta 6 personas a la casa trampa",
        cancelled = "Adquisición cancelada",
    },
    success = {
        added = "¡%{value} ha sido agregado(a) a la casa trampa!",
    },
    info = {
        enter = "Entrar a casa trampa",
        give_keys = "Dar llaves de casa trampa",
        pincode = "Código de casa trampa: %{value}",
        taking_over = "Tomando control",
        pin_code_see = "[G] - Ver código",
        pin_code = "Código: %{value}",
        multikeys = "[/multikeys] [id] - Para dar llaves",
        take_cash = "[E] - Tomar dinero ([$%{value}])",
        inventory = "[H] - Ver inventario",
        take_over = "[E] - Tomar control ([$5000])",
        leave = "[E] - Salir de casa trampa",
    },
    targetInfo = {
        options = "Opciones de casa trampa",
        enter = "Entrar a casa trampa",
        give_keys = "Dar llaves de casa trampa",
        pincode = "Código de casa trampa: %{value}",
        taking_over = "Tomando control",
        pin_code_see = "Ver código",
        pin_code = "Código: %{value}",
        multikeys = "Dar llaves (usar /multikey [id])",
        take_cash = "Tomar dinero ($%{value})",
        inventory = "Ver inventario",
        take_over = "Tomar dinero ($5000)",
        leave = "Irse de casa trampa",
        close_menu = "⬅ Cerrar menú",
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
