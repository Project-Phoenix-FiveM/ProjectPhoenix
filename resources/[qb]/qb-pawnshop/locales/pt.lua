local Translations = {
    error = {
        negative = 'A tentar vender uma quantidade negativa?',
        no_melt = 'Não me deste nada para fundir..',
        no_items = 'Items insuficientes',
    },
    success = {
        sold = 'Tu vendeste %{value} x %{value2} por %{value3}€',
        items_received = 'Tu recebeste %{value} x %{value2}',
    },
    info = {
        title = 'Loja De Penhores',
        subject = 'Fundição De Items',
        message = 'Terminámos de fundir os teus items. Podes vir buscá-los a qualquer hora.',
        open_pawn = 'Abrir a loja de penhores',
        sell = 'Vender Items',
        sell_pawn = 'Vender Items À Loja De Penhores',
        melt = 'Fundir Items',
        melt_pawn = 'Abrir A Loja De Fundição',
        melt_pickup = 'Recolher Items Fundidos',
        pawn_closed = 'Loja De Penhores Fechada. Volta entre as %{value}:00 AM - %{value2}:00 PM',
        sell_items = 'Preço De Venda %{value}€',
        back = '⬅ Voltar',
        melt_item = 'Fundição %{value}',
        max = 'Quantidade Máxima %{value}',
        submit = 'Fundição',
        melt_wait = 'Dá-me %{value} minutos e eu terei os teu items todos fundidos',
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
