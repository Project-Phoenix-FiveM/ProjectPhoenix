local Translations = {
    error = {
        no_vehicles = "Bu konumda ki garajda araç yok!",
        not_impound = "Aracınız çekilmişlerde değil",
        not_owned = "Bu araç park edilemez",
        not_correct_type = "Bu tür bir aracı burada depolayamazsınız",
        not_enough = "Yetersiz para",
        no_garage = "Hiçbiri",
    },
    success = {
        vehicle_parked = "Araç park edildi",
    },
    menu = {
        header = {
            house_car = "Ev Garajı %{value}",
            public_car = "Garaj %{value}",
            public_sea = "Tekne Garajı %{value}",
            public_air = "Uçak Garajı %{value}",
            job_car = "Meslek Garajı %{value}",
            job_sea = "Meslek tekne Garajı %{value}",
            job_air = "Meslek uçak garajı %{value}",
            gang_car = "Çete garajı %{value}",
            gang_sea = "Çete tekne Garaj %{value}",
            gang_air = "Çete uçak garajı %{value}",
            depot_car = "Depo %{value}",
            depot_sea = "Depo %{value}",
            depot_air = "Depo %{value}",
            vehicles = "Mevcut Araçlar",
            depot = "%{value} [ $%{value2} ]",
            garage = "%{value} [ %{value2} ]",
        },
        leave = {
            car = "⬅ Garajdan ayrıl",
            sea = "⬅ Tekne garajından ayrıl",
            air = "⬅ Uçak garajından ayrıl",
        },
        text = {
            vehicles = "Depolanan araçları görüntüle!",
            depot = "Plaka: %{value} Yakıt: %{value2} | Motor: %{value3} | Gövde: %{value4}",
            garage = "Durum: %{value} Yakıt: %{value2} | Motor: %{value3} | Gövde: %{value4}",
        }
    },
    status = {
        out = "Dışarda",
        garaged = "Garajda",
        impound = "Çekilmiş",
    },
    info = {
        car_e = "[E] Garaj",
        sea_e = "[E] Botgarajı",
        air_e = "[E] Uçak garajı",
        park_e = "[E] Mağaza Aracı",
        house_garage = "Ev garajı",
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
