local Translations = {
    error = {
        ["no_keys"] = "Evin anahtarları sende değil.",
        ["not_in_house"] = "Bir evde değilsin",
        ["out_range"] = "Menzil dışına çıktın",
        ["no_key_holders"] = "Anahtar sahibi bulunamadı..",
        ["invalid_tier"] = "Geçersiz ev aşaması",
        ["no_house"] = "Yakınınızda ev yok",
        ["no_door"] = "Kapıya yeterince yakın değilsin..",
        ["locked"] = "Ev kilitli!",
        ["no_one_near"] = "Etrafta kimse yok!",
        ["not_owner"] = "Bu evin sahibi değilsin.",
        ["no_police"] = "Yeterli polis yok..",
        ["already_open"] = "Bu ev zaten açık..",
        ["failed_invasion"] = "Başarısız! Tekrar deneyin",
        ["inprogress_invasion"] = "Birisi zaten kapıyla uğraşıyor..",
        ["no_invasion"] = "Bu kapı kırılmaz..",
        ["realestate_only"] = "Bu komutu yanlızca emlakçı kullanabilir.",
        ["emergency_services"] = "Bu sadece acil servisler için mümkündür!",
        ["already_owned"] = "Bu ev zaten alınmış!",
        ["not_enough_money"] = "Yeterli paran yok..",
        ["remove_key_from"] = "Anahtarlar kırıldı %{firstname} %{lastname}",
        ["already_keys"] = "Bu kişi zaten evin anahtarlarına sahip!",
        ["something_wrong"] = "Bişeyler ters gitti tekrar deneyin!",
    },
    success = {
        ["unlocked"] = "Kilit açıldı!",
        ["home_invasion"] = "Kapı şimdi açık.",
        ["lock_invasion"] = "Evi tekrar kilitledin..",
        ["recieved_key"] = "%{value} Anahtarlarını aldın"
    },
    info = {
        ["door_ringing"] = "Birisi kapıyı çalıyor!",
        ["speed"] = "Hız %{value}",
        ["added_house"] = "Bir ev eklendi: %{value}",
        ["added_garage"] = "Garaj eklendi: %{value}",
        ["exit_camera"] = "Kameradan çık",
        ["house_for_sale"] = "Satılık evler",
        ["decorate_interior"] = "İç dekorasyon",
        ["create_house"] = "Ev oluştur (Sadece Emlakçı)",
        ["price_of_house"] = "Evin fiyatı",
        ["tier_number"] = "Evin kapı numarası",
        ["add_garage"] = "Eve garaj ekle (Sadece Emlakçı)",
        ["ring_doorbell"] = "Zili çal"
    },
    menu = {
        ["house_options"] = "Ev ayarları",
        ["enter_house"] = "Evine gir",
        ["give_house_key"] = "Evin anahtarlarını ver",
        ["exit_property"] = "Evden çık",
        ["front_camera"] = "Ön kamera",
        ["back"] = "Geri",
        ["remove_key"] = "Anahtar sil",
        ["open_door"] = "Açık kapı",
        ["view_house"] = "Evi gör",
        ["ring_door"] = "Zili çal",
        ["exit_door"] = "Evden çık",
        ["open_stash"] = "Depo aç",
        ["stash"] = "Depo",
        ["change_outfit"] = "Kıyafet Değiş",
        ["outfits"] = "Gardrop",
        ["change_character"] = "Karakter değiştir",
        ["characters"] = "Karakterler",
        ["enter_unlocked_house"] = "Kilitlenmemiş eve girin",
        ["lock_door_police"] = "Kilitli kapı"
    },
    log = {
        ["house_created"] = "Ev oluşturuldu:",
        ["house_address"] = "**Adres**: %{label}\n\n**Satış fiyatı**: %{price}\n\n**No**: %{tier}\n\n**Aracı**: %{agent}",
        ["house_purchased"] = "Ev satın alındı.:",
        ["house_purchased_by"] = "**Adres**: %{house}\n\n**Alış fiyatı**: %{price}\n\n**Alıcı**: %{firstname} %{lastname}"
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
