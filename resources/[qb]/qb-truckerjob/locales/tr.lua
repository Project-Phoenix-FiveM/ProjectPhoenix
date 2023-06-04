local Translations = {
    error = {
        no_deposit = "$%{value} Depozito gerekli",
        cancelled = "İptal Edildi",
        vehicle_not_correct = "Bu ticari bir araç değil!",
        no_driver = "Bunu yapmak için sürücü olmalısınız..",
        no_work_done = "Henüz bir iş yapmadınız...",
    },
    success = {
        paid_with_cash = "$%{value} Depozitoyu nakit öde",
        paid_with_bank = "$%{value} Depozitoyu bankadan öde",
        refund_to_cash = "$%{value} Depozitoyu cash ile öde",
        you_earned = "$%{value} kazandın",
        payslip_time = "Bütün dükkanlara gittin. Maaş Zamanı!",
    },
    menu = {
        header = "Mevcut Kamyonlar",
        close_menu = "⬅ Menüyü Kapat",
    },
    mission = {
        store_reached = "Mağazaya ulaşıldı, [E] ile bagajdan bir kutu alın ve işaretli yere teslim edin",
        take_box = "Bir kutu ürün al",
        deliver_box = "Kutuyu teslim et",
        another_box = "Başka bir kutu al",
        goto_next_point = "Tüm ürünleri teslim ettiniz, sonraki noktaya ilerleyin",
    },
    info = {
        deliver_e = "~g~E~w~ - Ürünleri Teslim Et",
        deliver = "Ürünleri Teslim Et",
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
