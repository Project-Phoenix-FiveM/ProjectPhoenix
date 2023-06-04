local Translations = {
    error = {
        no_people_nearby = "Yakınında oyuncu yok",
        no_vehicle_found = "Araç bulunamadı",
        extra_deactivated = "Extra %{extra} devre dışı bırakıldı",
        extra_not_present = "Extra %{extra} bu araçta yok",
        not_driver = "Aracı sen kullanmıyorsun",
        vehicle_driving_fast = "Bu araç çok hızlı gidiyor",
        seat_occupied = "Bu koltuk dolu",
        race_harness_on = "Yarış var değiştiremezsin",
        obj_not_found = "İstenen nesne oluşturulamadı",
        not_near_ambulance = "Ambulansın yakınında değilsin",
        far_away = "Çok uzaktasın",
        stretcher_in_use = "Bu sedye zaten kullanılıyor",
        not_kidnapped = "Bu kişiyi sen kaçırmadın",
        trunk_closed = "Bağaj kapalı",
        cant_enter_trunk = "Bu bağaja giremezsin",
        already_in_trunk = "Zaten bir bağajdasın",
        someone_in_trunk = "Birisi zaten bağajda"
    },
    success = {
        extra_activated = "Extra %{extra} aktif edildi",
        entered_trunk = "Bağajdasın"
    },
    info = {
        no_variants = "Bunun için herhangi bir varyant yok gibi görünüyor",
        wrong_ped = "Bu ped modeli bu seçeneğe izin vermiyor",
        nothing_to_remove = "Kaldıracak birşey yok gibi görünüyor",
        already_wearing = "Zaten bunu giyiyorsun",
        switched_seats = "Artık sıradasın %{seat}"
    },
    general = {
        command_description = "Radial menüyü aç",
        push_stretcher_button = "[E] - Sedyeyi it",
        stop_pushing_stretcher_button = "[E] - Sedyeyi bırak",
        lay_stretcher_button = "[G] - Sedyeye uzan",
        push_position_drawtext = "Buraya it",
        get_off_stretcher_button = "[G] - Sedyeden kalk",
        get_out_trunk_button = "[E] Bağajdan çık",
        close_trunk_button = "[G] Bağajı kapat",
        open_trunk_button = "[G] Bağajı aç",
        getintrunk_command_desc = "Bağaja gir",
        putintrunk_command_desc = "Oyuncuyu bağaja koy"
    },
    options = {
        emergency_button = "Acil bulton",
        driver_seat = "Sürcü koltuğu",
        passenger_seat = "Yolcu koltuğu",
        other_seats = "Diğer koltuk",
        rear_left_seat = "Arka sol koltuk",
        rear_right_seat = "Arka sağ koltuk"
    },
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
