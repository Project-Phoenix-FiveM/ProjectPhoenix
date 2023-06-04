local Translations = {
    error = {
        ["already_mission"] = "Zaten Bir NPC Görevi Yapıyorsunuz",
        ["not_in_taxi"] = "Takside Değilsin",
        ["missing_meter"] = "Bu Aracın Taksimetresi Yok",
        ["no_vehicle"] = "Bir araçta değilsin",
        ["not_active_meter"] = "Taksimetre Aktif Değil",
        ["no_meter_sight"] = "Görünürde Taksimetre Yok",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "Kişi Bırakıldı!",
        ["npc_on_gps"] = "NPC, GPS'inizde Belirtildi",
        ["go_to_location"] = "NPC'yi Belirtilen Yere Götürün",
        ["vehicle_parking"] = "[E] Araç Otoparkı",
        ["job_vehicles"] = "[E] İş Araçları",
        ["drop_off_npc"] = "[E] NPC'yi Bırak",
        ["call_npc"] = "[E] NPC'yi Çağır",
        ["blip_name"] = "Downtown Cab",
        ["taxi_label_1"] = "Standart Cab",
    },
    menu = {
        ["taxi_menu_header"] = "Taksi Araçları",
        ["close_menu"] = "⬅ Menüyü Kapat",
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
