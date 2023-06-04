local Translations = {
    error = {
        ["canceled"] = "İptal edildi",
        ["911_chatmessage"] = "911 MESAJI",
        ["take_off"] = "dalış kıyafetini çıkarmak için /divingsuit yaz",
        ["not_wearing"] = "Dalış teçhizatı takmıyorsun..",
        ["no_coral"] = "Satacak mercanınız yok..",
        ["not_standing_up"] = "Dalış teçhizatını takmak için ayağa kalkman gerekiyor",
    },
    success = {
        ["took_out"] = "Dalgıç giysini çıkardın",
    },
    info = {
        ["collecting_coral"] = "Mercan toplanıyor",
        ["diving_area"] = "Dalış Alanı",
        ["collect_coral"] = "Mercan topla",
        ["collect_coral_dt"] = "[E] - Mercan Topla",
        ["checking_pockets"] = "Mercan Satmak İçin Ceplerin Kontrol Ediliyor",
        ["sell_coral"] = "Mercan Sat",
        ["sell_coral_dt"] = "[E] - Mercan Sat",
        ["blip_text"] = "911 - Dalış Alanı",
        ["put_suit"] = "Dalış kıyafeti giy",
        ["pullout_suit"] = "Dalgıç kıyafeti çıkarılıyor..",
        ["cop_msg"] = "Çalıntı mercan olabilir",
        ["cop_title"] = "Yasadışı dalış",
        ["command_diving"] = "Dalış elbiseni çıkar",
    },
    warning = {
        ["oxygen_one_minute"] = "1 dakikadan az havanız kaldı",
        ["oxygen_running_out"] = "Dalış teçhizatınızın havası bitiyor",
    },
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
