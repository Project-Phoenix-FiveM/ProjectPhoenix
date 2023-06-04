local Translations = {
    error = {
        no_deposit = "€%{value} Caução necessária",
        cancelled = "Cancelado",
        vehicle_not_correct = "Isto não é um veículo comercial!",
        no_driver = "Precisa de estar a conduzir para fazer isso..",
        no_work_done = "Não completou nenhuma tarefa..",
        backdoors_not_open = "A porta traseira não está aberta",
        get_out_vehicle = "Precisa de sair fora do veículo para completar esta ação",
        too_far_from_trunk = "Tem de levantar as caixas na parte de trás do seu veículo",
        too_far_from_delivery = "Precisa de estar mais perto do local da entrega"
    },
    success = {
        paid_with_cash = "€%{value} de caução paga em dinheiro",
        paid_with_bank = "€%{value} de caução paga por transferência",
        refund_to_cash = "€%{value} de caução devolvida em dinheiro",
        you_earned = "Recebeu: €%{value}",
        payslip_time = "Completou todas as tarefas .. Pode ir levantar o seu salário!",
    },
    menu = {
        header = "Veículos Disponíveis",
        close_menu = "⬅ Fechar Menu",
    },
    mission = {
        store_reached = "Chegou à loja, levante uma caixa na traseira com [E] e entregue-a no marcador",
        take_box = "Pegar numa caixa com produtos",
        deliver_box = "Entregar uma caixa com produtos",
        another_box = "Vá buscar outra caixa de produtos",
        goto_next_point = "Entregou todas as caixas necessárias, vá para a próxima entrega",
        return_to_station = "Entregou todos os produtos, vá para a empresa",
        job_completed = "Completou a sua rota, pode levantar o seu salário"
    },
    info = {
        deliver_e = "[E] - Entregar produtos",
        deliver = "Entregar produtos",
    }
}
if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end