local Translations = {
    error = {
        no_vehicles = "Du har ingen køretøjer i denne garage!",
        not_impound = "Dit køretøj er ikke beslaglagt",
        not_owned = "Du ejer ikke dette køretøj",
        not_correct_type = "Du kan ikke parkere dette køretøj i denne garage",
        not_enough = "Ikke nok penge",
        no_garage = "Ingen",
    },
    success = {
        vehicle_parked = "Køretøj Parkeret",
    },
    menu = {
        header = {
            house_car = "Bolig Garage %{value}",
            public_car = "Offentlig Garage %{value}",
            public_sea = "Offentligt Bådhus %{value}",
            public_air = "Offentlig Hangar %{value}",
            job_car = "Job Garage %{value}",
            job_sea = "Job Bådhus %{value}",
            job_air = "Job Hangar %{value}",
            gang_car = "Gang Garage %{value}",
            gang_sea = "Gang Bådhus %{value}",
            gang_air = "Gang Hangar %{value}",
            depot_car = "Depot %{value}",
            depot_sea = "Depot %{value}",
            depot_air = "Depot %{value}",
            vehicles = "Tilgængelige Køretøjer",
            depot = "%{value} [ $%{value2} ]",
            garage = "%{value} [ %{value2} ]",
        },
        leave = {
            car = "⬅ Forlad Garage",
            sea = "⬅ Forlad Bådhus",
            air = "⬅ Forlad Hangar",
        },
        text = {
            vehicles = "Se parkeret køretøjer!",
            depot = "Plade: %{value}<br>Tank: %{value2} | Motor: %{value3} | Karosseri: %{value4}",
            garage = "Stand: %{value}<br>Tank: %{value2} | Motor: %{value3} | Karosseri: %{value4}",
        }
    },
    status = {
        out = "Ude",
        garaged = "Parkeret",
        impound = "Beslaglagt af politiet",
    },
    info = {
        car_e = "[E] Garage",
        sea_e = "[E] Bådhus",
        air_e = "[E] Hangar",
        park_e = "[E] Parker Køretøj",
        house_garage = "Bolig garage",
    }
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
