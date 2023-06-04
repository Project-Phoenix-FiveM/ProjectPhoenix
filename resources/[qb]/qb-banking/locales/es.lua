local Translations = {
    error = {
        not_give = "No se pudo dar a la ID que pusiste.",
        givecash = "Uso: /givecash [ID] [AMOUNT]",
        wrong_id = "ID erroneo.",
        dead = "Estas muerto LOL.",
        too_far_away = "Estas muy lejos lmfao.",
        not_enough = "No tienes esta cantidad.",
        invalid_amount = "Cantidad invalida"
    },
    success = {
        debit_card = "Has pedido exitosamente una tarjeta de débito.",
        cash_deposit = "Has hecho exitosamente un deposito de $%{value}.",
        cash_withdrawal = "Has retirado exitosamente $%{value} en metálico.",
        updated_pin = "Has actualizado exitosamente el PIN de tu tarjeta de débito.",
        savings_deposit = "Has hecho exitosamente en tu cuenta de ahorros un depósito de $%{value}.",
        savings_withdrawal = "Has hecho exitosamente en tu cuenta de ahorros un retiro de $%{value}.",
        opened_savings = "Has abierto exitosamente una cuenta de ahorros.",
        give_cash = "Diste exitosamente $%{cash} a la ID %{id}",
        received_cash = "Recibiste exitosamente $%{cash} de la ID %{id}"
    },
    info = {
        bank_blip = "Banco",
        access_bank_target = "Acceder al Banco",
        access_bank_key = "[E] - Accede al Banco",
        current_to_savings = "Transferir de la Cuenta Corriente a la Cuenta de Ahorros",
        savings_to_current = "Transferir Ahorros a la Cuenta Corriente"
    },
    command = {
        givecash = "Dar dinero a un jugador."
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
