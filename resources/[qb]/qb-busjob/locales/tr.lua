local Translations = {
    error = {
        already_driving_bus = 'Zaten otobüs kullanıyorsun',
        not_in_bus = 'Otobüste değilsin',
        one_bus_active = 'Aynı anda yalnızca bir aktif otobüsünüz olabilir',
        drop_off_passengers = 'Çalışmayı bırakmadan önce yolcuları bırakın'
    },
    success = {
        dropped_off = 'Kişi bırakıldı',
    },
    info = {
        bus = 'Standart Otobüs',
        goto_busstop = 'Otobüs durağına git',
        busstop_text = '[E] Otobüs durağı',
        bus_plate = 'OTOBUS', -- Can be 3 or 4 characters long (uses random 4 digits)
        bus_depot = 'Otobüs Deposu',
        bus_stop_work = '[E] "Calışmayı Bırak',
        bus_job_vehicles = '[E] İş Araçları'
    },
    menu = {
        bus_header = 'Otobüs Araçları',
        bus_close = '⬅ Menüyü Kapat'
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
