local Translations = {
    error = {
        not_give = "Verilen id ye eşya verilemedi.",
        givecash = "Kullanım: /givecash [ID] [MİKTAR]",
        wrong_id = "Yanlış ID.",
        dead = "Öldün.",
        too_far_away = "Çok uzaksın.",
        not_enough = "Bu miktara sahip değilsiniz.",
        invalid_amount = "Geçersiz Miktar Verildi"
    },
    success = {
        debit_card = "Başarıyla bir Banka Kartı sipariş ettiniz.",
        cash_deposit = "Başarıyla nakit para yatırdınız. Miktar: $%{value}",
        cash_withdrawal = "Para çekme işlemini başarıyla gerçekleştirdiniz. Miktar: $%{value}",
        updated_pin = "Banka kartı şifrenizi başarıyla güncellediniz.",
        savings_deposit = "Başarılı bir şekilde tasarruf hesabına para yatırdınız. Miktar $%{value}",
        savings_withdrawal = "Bir tasarruf hesabından para çekme işlemi gerçekleştirdiniz. Miktar: $%{value}.",
        opened_savings = "Başarılı bir tasarruf hesabı açtınız.",
        give_cash = " $%{cash} Miktar para %{id} ID ye verildi ",
        received_cash = " $%{cash} miktar para aldın. Gönderen ID %{id}"
    },
    info = {
        bank_blip = "Banka",
        access_bank_target = "Bankaya Eriş",
        access_bank_key = "[E] - Bankaya Eriş",
        current_to_savings = "Cari Hesabı Birikimlere Aktar",
        savings_to_current = "Birikimleri Cari Hesaba Aktar",
    },
    command = {
        givecash = "Oyuncuya nakit ver."
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
