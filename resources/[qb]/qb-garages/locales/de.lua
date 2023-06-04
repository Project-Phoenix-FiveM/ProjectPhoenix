local Translations = {
    error = {
        no_vehicles = "In dieser Garage hast du kein Fahrzeug!",
        not_impound = "Dein Auto wurde nicht abgeschleppt",
        not_owned = "Das Fahrzeug gehört dir nicht",
        not_correct_type = "Du kannst dieses Fahrzeug hier nicht parken. (Falscher Parkplatz)",
        not_enough = "Nicht genu Geld",
        no_garage = "None",
    },
    success = {
        vehicle_parked = "Auto geparkt",
    },
    menu = {
        header = {
            house_car = "Haus Garage %{value}",
            public_car = "Öffentliche  Garage %{value}",
            public_sea = "Öffentlichtes Bootshaus %{value}",
            public_air = "Öffentlicher Hangar %{value}",
            job_car = "Job Garage %{value}",
            job_sea = "Job Boathouse %{value}",
            job_air = "Job Hangar %{value}",
            gang_car = "Gang Garage %{value}",
            gang_sea = "Gang Bootshaus %{value}",
            gang_air = "Gang Hangar %{value}",
            depot_car = "Abschlepphof %{value}",
            depot_sea = "Abschlepphof %{value}",
            depot_air = "Abschlepphof %{value}",
            vehicles = "Verfügbare Fahrzeuge",
            depot = "%{value} [ $%{value2} ]",
            garage = "%{value} [ %{value2} ]",
        },
        leave = {
            car = "⬅ Verlasse Garage",
            sea = "⬅ Verlasse Bootshaus",
            air = "⬅ Verlasse Hangar",
        },
        text = {
            vehicles = "Deine geparkten Autos!",
            depot = "Nummernschild: %{value}<br>Tank: %{value2} | Motor: %{value3} | Karosserie: %{value4}",
            garage = "Status: %{value}<br>Tank: %{value2} | Motor: %{value3} | Karosserie: %{value4}",
        }
    },
    status = {
        out = "Ausgeparkt",
        garaged = "Eingeparkt",
        impound = "Abgeschleppt von der Polizei",
    },
    info = {
        car_e = "[E] Garage",
        sea_e = "[E] Bootshause",
        air_e = "[E] Hangar",
        park_e = "[E] Fahrzeug einparken",
        house_garage = "Haus Garage",
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
