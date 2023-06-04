--[[
Romanian base language translation for qb-garages
Translation done by wanderrer (Martin Riggs#0807 on Discord)
]]--
local Translations = {
    error = {
        no_vehicles = "Nu ai niciun vehicul parcat in aceasta locatie!",
        not_impound = "Vehiculul tau nu a fost confiscat de stat",
        not_owned = "Nu poti parca acest vehicul",
        not_correct_type = "Acest tip de vehicul, nu poate fi parcat aici",
        not_enough = "Nu ai suficienti bani",
        no_garage = "Absolut nimic",
        vehicle_occupied = "Nu poti parca acest vehicul, nu este gol :)",
    },
    success = {
        vehicle_parked = "Vehiculul a fost parcat cu succes",
    },
    menu = {
        header = {
            house_car = "Garajul casei %{value}",
            public_car = "Parcare publica %{value}",
            public_sea = "Debarcader public %{value}",
            public_air = "Hangar public %{value}",
            job_car = "Garaj pentru %{value}",
            job_sea = "Debarcader pentru %{value}",
            job_air = "Hangar pentru %{value}",
            gang_car = "Garaj pentru %{value}",
            gang_sea = "Debarcader pentru %{value}",
            gang_air = "Hangar pentru %{value}",
            depot_car = "Depozit %{value}",
            depot_sea = "Depozit %{value}",
            depot_air = "Depozit %{value}",
            vehicles = "Vehicule disponibile",
            depot = "%{value} [ $%{value2} ]",
            garage = "%{value} [ %{value2} ]",
        },
        leave = {
            car = "⬅ Paraseste garajul",
            sea = "⬅ Paraseste debarcaderul",
            air = "⬅ Paraseste Hangarul",
        },
        text = {
            vehicles = "Lista vehicule parcate!",
            depot = "Numar: %{value}<br>Combustibil: %{value2} | Motor: %{value3} | Caroserie: %{value4}",
            garage = "Stare: %{value}<br>Combustibil: %{value2} | Motor: %{value3} | Caroserie: %{value4}",
        }
    },
    status = {
        out = "Undeva pe strazi",
        garaged = "Parcat",
        impound = "Confiscat de Stat",
    },
    info = {
        car_e = "[E] Garaj",
        sea_e = "[E] Debarcader",
        air_e = "[E] Hangar",
        park_e = "[E] Parcheaza vehicul",
        house_garage = "Parcare domiciuliu",
    }
}

if GetConvar('qb_locale', 'en') == 'ro' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
