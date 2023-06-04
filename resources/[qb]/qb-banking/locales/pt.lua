local Translations = {
    error = {
        not_give = "Não foi possível dar dinheiro ao id:",
        givecash = "/givecash [ID] [QUANTIA]",
        wrong_id = "ID errado.",
        dead = "Estás morto",
        too_far_away = "Estás muito longe, aproxima-te mais.",
        not_enough = "Não tens essa quantia de dinheiro.",
        invalid_amount = "Quantia Inválida"
    },
    success = {
        debit_card = "Pediste um cartão de Débito.",
        cash_deposit = "Fizeste um depósito em dinheiro de %{value}€.",
        cash_withdrawal = "Fizeste um levantamento de dinheiro de %{value}€.",
        updated_pin = "Actualizaste com sucesso o PIN do teu cartão de débito.",
        savings_deposit = "Fizeste um depósito de %{value}€ na tua conta poupança.",
        savings_withdrawal = "Fizeste um levantamento de %{value}€ da tua conta poupança.",
        opened_savings = "Abriste com sucesso uma conta poupança.",
        give_cash = "Deste %{cash}€ ao ID %{id}",
        received_cash = "Recebeu %{cash}€ do ID %{id}"
    },
    info = {
        bank_blip = "Banco",
        access_bank_target = "Aceder ao Banco",
        access_bank_key = "[E] - Aceder ao Banco",
        current_to_savings = "Transferir Conta Corrente para Poupança",
        savings_to_current = "Transferir Poupança para Conta Corrente",
        deposit = "Depositar €%{amount} para a conta corrente",
        withdraw = "Levantar €%{amount} da conta corrente",
    },
    command = {
        givecash = "Dar dinheiro ao jogador."
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
