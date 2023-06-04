local Translations = {
    error = {
        no_vehicles = "Selles kohas ei ole sõidukeid!",
        not_impound = "Teie sõiduk ei ole arestitud!",
        not_owned = "Seda sõidukit ei saa hoiustada",
        not_correct_type = "Seda tüüpi sõidukeid siin hoida ei saa",
        not_enough = "Pole piisavalt raha",
        no_garage = "Mitte ühtegi",
        vehicle_occupied = "Te ei saa seda sõidukit hoiustada, kuna see ei ole tühi",
    },
    success = {
        vehicle_parked = "Sõiduk hoiustatud",
    },
    menu = {
        header = {
            house_car = "Maja garaaž %{value}",
            public_car = "Avalik garaaž %{value}",
            public_sea = "Avalik paadimaja %{value}",
            public_air = "Avalik angaar %{value}",
            job_car = "Fraktsiooni garaaz %{value}",
            job_sea = "Fraktsiooni paadikuuri %{value}",
            job_air = "Fraktsiooni angaar %{value}",
            gang_car = "Grupeeringu garaaz %{value}",
            gang_sea = "Grupeeringu paadimaja %{value}",
            gang_air = "Grupeeringu angaar %{value}",
            depot_car = "Depoo %{value}",
            depot_sea = "Depoo %{value}",
            depot_air = "Depoo %{value}",
            vehicles = "Saadaval olevad sõidukid",
            depot = "%{value} [ $%{value2} ]",
            garage = "%{value} [ %{value2} ]",
        },
        leave = {
            car = "⬅ Lahku garaazist",
            sea = "⬅ Lahku paadimajast",
            air = "⬅ Lahku angaarist",
        },
        text = {
            vehicles = "Vaata hoiustatud sõidukeid!",
            depot = "Plaat: %{value}<br>Kütus: %{value2} | Mootor: %{value3} | Kere: %{value4}",
            garage = "Olek: %{value}<br>Kütus: %{value2} | Mootor: %{value3} | Kere: %{value4}",
        }
    },
    status = {
        out = "Väljas",
        garaged = "Garaazis",
        impound = "Politsei poolt arestitud",
    },
    info = {
        car_e = "[E] Garaaz",
        sea_e = "[E] Paadimaja",
        air_e = "[E] Angaar",
        park_e = "[E] Hoiusta sõiduk",
        house_garage = "Majagaraaz",
    }
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
