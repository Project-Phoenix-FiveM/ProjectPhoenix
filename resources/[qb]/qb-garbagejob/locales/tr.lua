local Translations = {
    error = {
        ["cancled"] = "İptal edildi",
        ["no_truck"] = "Kamyonun yok!",
        ["not_enough"] = "Yeterli Paran Yok (%{value} gerekli)",
        ["too_far"] = "Bırakma noktasından çok uzaktasın",
        ["early_finish"] = "Erken bitirme nedeniyle (Tamamlandı: %{completed} Toplam: %{total}), depozitonuz iade edilmeyecektir.",
        ["never_clocked_on"] = "Hiç mesaiye başlamadın!",
        ["all_occupied"] = "Tüm park yerleri dolu",
        ["job"] = "İşi iş merkezinden almalısınız",
    },
    success = {
        ["clear_routes"] = "Kullanıcıların kayıtlı %{value} rotalası temizlendi",
        ["pay_slip"] = "$%{total} aldınız, maaş bordronuz %{deposit} banka hesabınıza ödendi!",
    },
    target = {
        ["talk"] = 'Çöpçü ile konuş',
        ["grab_garbage"] = "Çöp torbası al",
        ["dispose_garbage"] = "Çöp Torbasını At",
    },
    menu = {
        ["header"] = "Çöpcü Ana Menü",
        ["collect"] = "Maaşını Al",
        ["return_collect"] = "Kamyonu iade edin ve maaş çekini buradan alın!",
        ["route"] = "Rota Talep Et",
        ["request_route"] = "Bir çöp rotası isteyin",
    },
    info = {
        ["payslip_collect"] = "[E] - Maaş bordrosu",
        ["payslip"] = "Maaş bordrosu",
        ["not_enough"] = "Depozito için yeterli paranız yok. Depozito maliyeti $%{value}",
        ["deposit_paid"] = "$%{value} tutarında depozito ödediniz!",
        ["no_deposit"] = "Bu araç için ödemiş olduğunuz depozito yok..",
        ["truck_returned"] = "Kamyon iade edildi, depozitonuzu ve ödemenizi almak için maaş bordronuzu alın!",
        ["bags_left"] = "Hala %{value} torba kaldı!",
        ["bags_still"] = "Orada hala %{value} torba var!",
        ["all_bags"] = "Tüm çöp torbaları bitti, bir sonraki konuma geçin!",
        ["depot_issue"] = "Depoda bir sorun oluştu, lütfen hemen geri dönün!",
        ["done_working"] = "Çalışmanız bitti! Depoya geri dön.",
        ["started"] = "Çalışmaya başladınız, konum GPS'te işaretlendi!",
        ["grab_garbage"] = "[E] Çöp torbası al",
        ["stand_grab_garbage"] = "Çöp torbası almak için burada durun.",
        ["dispose_garbage"] = "[E] Çöp Torbasını Atın",
        ["progressbar"] = "Torba çöp arabasına koyuluyor ..",
        ["garbage_in_truck"] = "Torbayı çöp arabasına koy..",
        ["stand_here"] = "Burada dur..",
        ["found_crypto"] = "Yerde bir kripto çubuğu buldun",
        ["payout_deposit"] = "(+ $%{value} depozito)",
        ["store_truck"] =  "[E] - Çöp Kamyonunu Depola",
        ["get_truck"] =  "[E] - Çöp Kamyonu",
        ["picking_bag"] = "Çöp Torbası alınıyor..",
        ["talk"] = "[E] Çöpcü ile konuş",
    },
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
