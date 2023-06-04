local Translations = {
    error = {
        ["missing_something"] = "Bir şeyler eksik gibi görünüyor...",
        ["not_enough_police"] = "Yeterli polis yok..",
        ["door_open"] = "Kapı zaten açık..",
        ["cancelled"] = "İşlem İptal Edildi..",
        ["didnt_work"] = "İşe yaramadı..",
        ["emty_box"] = "Kutu Boş..",
        ["injail"] = "%{Time} aydır hapistesiniz..",
        ["item_missing"] = "Bir Öğe eksik..",
        ["escaped"] = "Hapisten Kaçtın... Yokol buradan.!",
        ["do_some_work"] = "Ceza indirimi için biraz çalışın, anlık iş: %{currentjob} ",
    },
    success = {
        ["found_phone"] = "Bir telefon buldun..",
        ["time_cut"] = "Ceza indirimin için biraz çalıştın.",
        ["free_"] = "Özgürsün! Tadını çıkar! :)",
        ["timesup"] = "Süren doldu! Ziyaretçi merkezine gidip çıkışınızı yapın.",
    },
    info = {
        ["timeleft"] = "Hala... %{JAILTIME} ay var",
        ["lost_job"] = "Sen işsizsin",
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
