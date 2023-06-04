local Translations = {
    error = {
        no_vehicles = "Er zijn geen voertuigen op deze locatie!",
        not_impound = "Uw voertuig is niet in beslag genomen",
        not_owned = "Dit voertuig kan niet gestald worden",
        not_correct_type = "U kunt dit type voertuig hier niet stallen",
        not_enough = "Niet genoeg geld",
        no_garage = "Geen",
    },
    success = {
        vehicle_parked = "Voertuig opgeslagen",
    },
    menu = {
        header = {
            house_car = "Huis Garage %{value}",
            public_car = "Openbaar Garage %{value}",
            public_sea = "Openbaar Boot Garage %{value}",
            public_air = "Openbaar Hangar %{value}",
            job_car = "Werk Garage %{value}",
            job_sea = "Werk Boot Garage %{value}",
            job_air = "Werk Hangar %{value}",
            gang_car = "Gang Garage %{value}",
            gang_sea = "Gang Boot Garage %{value}",
            gang_air = "Gang Hangar %{value}",
            depot_car = "Depot %{value}",
            depot_sea = "Depot %{value}",
            depot_air = "Depot %{value}",
            vehicles = "Beschikbare voertuigen",
            depot = "%{value} [ $%{value2} ]",
            garage = "%{value} [ %{value2} ]",
        },
        leave = {
            car = "⬅ Verlaat Garage",
            sea = "⬅ Verlaat Boot Garage",
            air = "⬅ Verlaat Hangar",
        },
        text = {
            vehicles = "Bekijk opgeslagen voertuigen!",
            depot = "Kenteken: %{value}<br>Brandstof: %{value2} | Motor: %{value3} | Carrosserie: %{value4}",
            garage = "Status: %{value}<br>Brandstof: %{value2} | Motor: %{value3} | Carrosserie: %{value4}",
        }
    },
    status = {
        out = "Buiten",
        garaged = "Garage",
        impound = "In Beslag",
    },
    info = {
        car_e = "[E] Garage",
        sea_e = "[E] Boot Garage",
        air_e = "[E] Hangar",
        park_e = "[E] Voertuig opslaan",
        house_garage = "Huis garage",
    }
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
