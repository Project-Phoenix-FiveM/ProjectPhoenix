local Translations = {
    error = {
        ["missing_something"] = "Birşeyleri kaçırıyormuşsun gibi görünüyor...",
        ["not_enough_police"] = "Yeterli polis yok..",
        ["door_open"] = "Kapı zaten açık..",
        ["process_cancelled"] = "İşlem iptal edildi..",
        ["didnt_work"] = "İşe yaramadı..",
        ["emty_box"] = "Kutu boş..",
    },
    success = {
        ["worked"] = "İşe yaradı!",
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
