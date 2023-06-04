local Translations = {
    error = {
        no_money = 'Dinheiro insuficiente',
        too_far = 'Estás muito longe do teu stand',
        no_stand = 'Não tens um stand de cachorros quentes',
        cust_refused = 'Cliente recusado!',
        no_stand_found = 'Não devolvemos o teu depósito, porque não entregaste o teu stand!',
        no_more = 'Não consegues carregar mais stock de %{value} no teu rank',
        deposit_notreturned = 'Não tens um stand de cachorros quentes',
        no_dogs = 'Não tens cachorros quentes',
    },
    success = {
        deposit = 'Pagaste um depósito de %{deposit}€ pelo stand!',
        deposit_returned = 'Recebeste um depósito de %{deposit}€ por entregares o stand!',
        sold_hotdogs = '%{value} x Cachorros Quente(\'s) vendidos por %{value2}€',
        made_hotdog = 'Fizeste %{value} Cachorros Quentes',
        made_luck_hotdog = 'Fizeste %{value} x %{value2} Cachorros Quentes',
    },
    info = {
        command = "Apagar Stand (Apenas Admin)",
        blip_name = 'Stand De Cachorros Quentes',
        start_working = '[~g~E~s~] Começar Trabalho',
        start_work = 'Começar Trabalho',
        stop_working = '[~g~E~s~] Parar Trabalho',
        stop_work = 'Parar Trabalho',
        grab_stall = '[~g~G~s~] Empurrar Stand',
        drop_stall = '[~g~G~s~] Soltar Stand',
        grab = 'Soltar Stand',
        prepare = 'Preparar cachorro-quente',
        toggle_sell = 'Ativar venda',
        selling_prep = '[~g~E~s~] A preparar cachorro [Vendas: ~g~Abertas~w~]',
        not_selling = '[~g~E~s~] A preparar cachorro [Vendas: ~r~Fechadas~w~]',
        sell_dogs = '[~g~7~s~] Vender %{value} x Cachorros por %{value2}€ / [~g~8~s~] Rejeitar',
        sell_dogs_target = 'Vender %{value} x Cachorros for $%{value2}€',
        admin_removed = "Stand De Cachorros Quentes Removido",
        label_a = "Perfeito (A)",
        label_b = "Raro (B)",
        label_c = "Comum (C)"
    },
    keymapping = {
        gkey = 'Apagar Stand de Cachorro Quentes',
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
