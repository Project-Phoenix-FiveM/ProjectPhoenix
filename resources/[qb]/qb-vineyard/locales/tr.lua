local Translations = {
    error = {
        ["invalid_job"] = "Burada çalıştığımı sanmıyorum...",
        ["invalid_items"] = "Doğru itemlere sahip değilsin!",
        ["no_items"] = "Herhangi bir iteminiz yok!",
    },
    progress = {
        ["pick_grapes"] = "Üzüm toplanıyor ..",
        ["process_grapes"] = "Üzüm İşleniyor ..",
    },
    task = {
        ["start_task"] = "[E] Başla",
        ["load_ingrediants"] = "[E] Malzemeleri Yükle",
        ["wine_process"] = "[E] Şarap İşlemeye Başla",
        ["get_wine"] = "[E] Şarap Al",
        ["make_grape_juice"] = "[E] Üzüm Suyu Yap",
        ["countdown"] = "Kalan süre %{time}s",
        ['cancel_task'] = "Görevi iptal ettiniz"
    },
    text = {
        ["start_shift"] = "Bağda mesaiye başladın!",
        ["end_shift"] = "Bağdaki vardiyanız sona erdi!",
        ["valid_zone"] = "Geçerli Bölge!",
        ["invalid_zone"] = "Geçersiz Bölge!",
        ["zone_entered"] = "%{zone} Bölgesine Girildi",
        ["zone_exited"] = "%{zone} Bölgesinden Çıkıldı",
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
