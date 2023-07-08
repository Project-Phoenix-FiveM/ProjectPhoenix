CreateThread(function()
    for k, v in pairs(Shared.Laptop) do
        QBCore.Functions.LoadModel(v.pedModel)
        local LaptopPed = CreatePed(0, v.pedModel, v.coords.x, v.coords.y, v.coords.z-1.0, v.coords.w, false, false)
        TaskStartScenarioInPlace(LaptopPed, '', true)
        FreezeEntityPosition(LaptopPed, true)
        SetEntityInvincible(LaptopPed, true)
        SetBlockingOfNonTemporaryEvents(LaptopPed, true)

        exports['qb-target']:AddTargetEntity(LaptopPed, {
            options = {
                {
                    type = 'server',
                    event = 'qb-bankrobbery:server:BuyLaptop', 
                    icon = 'fas fa-hand-holding',
                    label = _U('laptop_target_label'),
                    colour = k
                }
            },
            distance = 2.0
        })
    end
end)
