local Translations = {
    error = {
        no_vehicles = "Não tens nenhum veículo nesta garagem!",
        not_impound = "O teu veículo não está nos apreendidos",
        not_owned = "Este veículo não te pertence",
        not_correct_type = "Não podes guardar veículos deste tipo aqui",
        not_enough = "Dinheiro insuficiente",
        no_garage = "Nenhuma",
    },
    success = {
        vehicle_parked = "Veículo guardado",
    },
    menu = {
        header = {
            house_car = "Garagem Particular %{value}",
            public_car = "Garagem %{value}",
            public_sea = "Doca %{value}",
            public_air = "Hangar %{value}",
            job_car = "Garagem De Emprego %{value}",
            job_sea = "Doca De Emprego %{value}",
            job_air = "Hangar De Emprego %{value}",
            gang_car = "Garagem De Gang %{value}",
            gang_sea = "Doca De Gang %{value}",
            gang_air = "Hangar De Gang %{value}",
            depot_car = "Apreendidos %{value}",
            depot_sea = "Apreendidos %{value}",
            depot_air = "Apreendidos %{value}",
            vehicles = "Veículos Disponíveis",
            depot = "%{value} [ $%{value2} ]",
            garage = "%{value} [ %{value2} ]",
        },
        leave = {
            car = "⬅ Sair Da Garagem",
            sea = "⬅ Sair Da Doca",
            air = "⬅ Sair Do Hangar",
        },
        text = {
            vehicles = "Ver veículos guardados!",
            depot = "Placa: %{value}<br>Combu: %{value2} | Motor: %{value3} | Chassi: %{value4}",
            garage = "Estado: %{value}<br>Combu: %{value2} | Motor: %{value3} | Chassi: %{value4}",
        }
    },
    status = {
        out = "Fora",
        garaged = "Guardado",
        impound = "Apreendido Pela Polícia",
    },
    info = {
        car_e = "[E] Garagem",
        sea_e = "[E] Doca",
        air_e = "[E] Hangar",
        park_e = "[E] Guardar Veículo",
        house_garage = "Garagem Particular",
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
