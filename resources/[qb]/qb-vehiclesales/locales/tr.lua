local Translations = {
    error = {
        not_your_vehicle = 'Bu senin aracın değil..',
        vehicle_does_not_exist = 'Araç mevcut değil',
        not_enough_money = 'Yeterli paran yok',
        finish_payments = 'Bu aracı satmadan önce borcunu ödemelisin..',
        no_space_on_lot = 'Otoparkta arabanız için yer yok!'
    },
    success = {
        sold_car_for_price = 'Arabanızı $%{value} karşılığında sattınız',
        car_up_for_sale = 'Arabanız satışa çıkarıldı! Fiyat - $%{value}',
        vehicle_bought = 'Araç Satın Alındı'
    },
    info = {
        confirm_cancel = '~g~Y~w~ - Onayla / ~r~N~w~ - İptal Et ~g~',
        vehicle_returned = 'Aracınız iade edildi',
        used_vehicle_lot = 'İkinci El Araba',
        sell_vehicle_to_dealer = '[~g~E~w~] - Aracı Satıcıya $%{value} karşılığında Sat',
        view_contract = '[~g~E~w~] - Araç Sözleşmesini Görüntüle',
        cancel_sale = '[~r~G~w~] - Araç Satışını İptal Et',
        model_price = '%{value}, Fiyat: ~g~$%{value2}',
        are_you_sure = 'Artık aracınızı satmak istemediğinizden emin misiniz?',
        yes_no = '[~g~7~w~] - Evet | [~r~8~w~] - Hayır',
        place_vehicle_for_sale = '[~g~E~w~] - Sahibinden Satılık Aracı Yerleştirin'
    },
    charinfo = {
        firstname = 'veri',
        lastname = 'yok',
        account = 'Hesap bilinmiyor..',
        phone = 'telefon numarası bilinmiyor..'
    },
    mail = {
        sender = 'Sahibinden',
        subject = 'Bir araç sattın!',
        message = '%{value2} satışından $%{value} kazandınız.'
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
