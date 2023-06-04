local Translations = {
    error = {
        not_your_vehicle = 'Đây không phải xe của bạn.',
        vehicle_does_not_exist = 'Xe này không tồn tại',
        not_enough_money = 'Bạn không có đủ tiền',
        finish_payments = 'Bạn phải trả tiền xong cho chiếc xe này, trước khi bạn có thể bán nó.',
        no_space_on_lot = 'Không còn chỗ cho xe của bạn trên bãi!',
        not_in_veh = 'Bạn cần ở trong phương tiện!',
        not_for_sale = 'Xe này KHÔNG phải để bán!',
    },
    menu = {
        view_contract = 'Xem hợp đồng',
        view_contract_int = '[E] Xem hợp đồng',
        sell_vehicle = 'Bán xe',
        sell_vehicle_help = 'Bán xe cho cư dân!',
        sell_back = 'Bán lại xe!',
        sell_back_help = 'Bán lại xe của bạn ngay với giá giảm!',
        interaction = '[E] Bán xe',
    },
    success = {
        sold_car_for_price = 'Bạn đã bán chiếc xe của mình với giá $%{value}',
        car_up_for_sale = 'Xe của bạn đã được rao bán! Giá - $%{value}',
        vehicle_bought = 'Xe đã mua',
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Xác nhận / ~r~N~w~ - Cancel ~g~',
        vehicle_returned = 'Xe của bạn được trả lại',
        used_vehicle_lot = 'Lô xe đã qua sử dụng',
        sell_vehicle_to_dealer = '[~g~E~w~] - Bán xe cho đại lý ~g~$%{value}',
        view_contract = '[~g~E~w~] - Xem hợp đồng xe',
        cancel_sale = '[~r~G~w~] - Hủy bán xe',
        model_price = '%{value}, Giá: ~g~$%{value2}',
        are_you_sure = 'Bạn có chắc chắn rằng bạn không còn muốn bán chiếc xe của mình?',
        yes_no = '[~g~7~w~] - Có | [~r~8~w~] - Không',
        place_vehicle_for_sale = '[~g~E~w~] - Đặt Xe Chính Chủ Bán',
    },
    charinfo = {
        firstname = 'not',
        lastname = 'known',
        account = 'Account not known..',
        phone = 'telephone number not known..',
    },
    mail = {
        sender = 'Larrys RV Sales',
        subject = 'Bạn đã bán một chiếc xe!',
        message = 'Bạn nhận được $%{value} từ việc bán %{value2} của bạn.',
    }
}

if GetConvar('qb_locale', 'en') == 'vi' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
