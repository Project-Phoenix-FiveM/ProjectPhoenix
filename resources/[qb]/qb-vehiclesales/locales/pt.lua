local Translations = {
    error = {
        not_your_vehicle = 'Este não é o teu veículo...',
        vehicle_does_not_exist = 'Veículo não existe',
        not_enough_money = 'Não tens dinheiro suficiente',
        finish_payments = 'Tens que terminar de pagar este veículo antes de o conseguires vender...',
        no_space_on_lot = 'Não existem lugares livres neste parque para o teu veículo!'
    },
    success = {
        sold_car_for_price = 'Vendeste a tua viatura por $%{value}',
        car_up_for_sale = 'A tua viatura foi colocada à venda! Preço - $%{value}',
        vehicle_bought = 'Veículo Comprado'
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Confirmar / ~r~N~w~ - Cancelar ~g~',
        vehicle_returned = 'O teu veículo foi devolvido',
        used_vehicle_lot = 'Parque de Veículos Usados',
        sell_vehicle_to_dealer = '[~g~E~w~] - Vender o teu veiculo ao negociante por ~g~$%{value}',
        view_contract = '[~g~E~w~] - Ver Contracto do Veículo',
        cancel_sale = '[~r~G~w~] - Cancelar Venda do Veículo',
        model_price = '%{value}, Preço: ~g~$%{value2}',
        are_you_sure = 'Tens a certeza que já não queres vender o teu veículo?',
        yes_no = '[~g~7~w~] - Sim | [~r~8~w~] - Não',
        place_vehicle_for_sale = '[~g~E~w~] - Colocar veículo à venda pelo dono'
    },
    charinfo = {
        firstname = 'sem',
        lastname = 'conhecimento',
        account = 'Conta desconhecida...',
        phone = 'número de telefone desconhecido...'
    },
    mail = {
        sender = 'Vendas RV',
        subject = 'Vendeste um veículo!',
        message = 'Fizeste $%{value} na venda do teu %{value2}.'
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
