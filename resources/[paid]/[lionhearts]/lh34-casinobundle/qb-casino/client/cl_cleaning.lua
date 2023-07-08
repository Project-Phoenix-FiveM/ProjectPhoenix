RegisterNetEvent('qb-casino:client:OpenLaundry', function(data)
    local menu = {
        {
            header = "Casino Laundry",
            txt = "ESC or click to close",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-menu:closeMenu",
            }
        }
    }

    QBCore.Functions.TriggerCallback('qb-casino:client:CheckLaundry', function(result)
        if result == false then -- New
            menu[#menu+1] = {
                header = "Load Washer",
                txt = "",
                icon = "fas fa-hand-holding-dollar",
                params = {
                    event = "qb-casino:client:LoadLaundry",
                    args = data.index
                }
            }
            exports['qb-menu']:openMenu(menu)
        else -- Already put stuff in
            if result.status == 'taken' then
                QBCore.Functions.Notify('You have already washed your laundry..', 'error', 2500)
            elseif result.washer ~= data.index then
                QBCore.Functions.Notify('This is not the washer you put your laundry in..', 'error', 2500)
            elseif result.status == 'started' then
                QBCore.Functions.Notify('The laundromat is still busy..', 'error', 2500)
            elseif result.status == 'completed' then
                menu[#menu+1] = {
                    header = "Grab Money",
                    txt = "($ "..result.worth..")",
                    icon = "fas fa-money-bill-1-wave",
                    params = {
                        event = "qb-casino:client:GrabLaundry",
                        args = data.index
                    }
                }
                exports['qb-menu']:openMenu(menu)
            end
        end
    end, data.index)
end)

RegisterNetEvent('qb-casino:client:LoadLaundry', function(index)
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local ped = PlayerPedId()
            TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
            QBCore.Functions.Progressbar("pickup_reycle_package", "Loading Money..", 5000, false, true, {}, {}, {}, {}, function() -- Done
                ClearPedTasks(ped)
                TriggerServerEvent('qb-casino:server:LoadLaundry', index)
            end, function() -- cancel
                QBCore.Functions.Notify('Canceled..', 'error')
                ClearPedTasks(ped)
            end)
        else
            QBCore.Functions.Notify('You need coins to put in the laundromat..', 'error', 2500)
        end
    end, 'krugerrand')
end)

RegisterNetEvent('qb-casino:client:GrabLaundry', function(index)
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
    QBCore.Functions.Progressbar("pickup_reycle_package", "Loading Money..", 5000, false, true, {}, {}, {}, {}, function() -- Done
        ClearPedTasks(ped)
        TriggerServerEvent('qb-casino:server:GrabLaundry', index)
    end, function() -- cancel
        QBCore.Functions.Notify('Canceled..', 'error')
        ClearPedTasks(ped)
    end)
end)

CreateThread(function()
    for i=1, #Shared.Cleaning do
        exports["qb-target"]:AddBoxZone("casino_laundry"..i, Shared.Cleaning[i].coords, 1.3, 1.3, {
            name = "casino_laundry"..i,
            heading = 238.00,
            debugPoly = false,
            minZ = 70.37,
            maxZ = 72.57
         }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-casino:client:OpenLaundry',
                    icon = 'fas fa-circle-chevron-right',
                    label = 'Laundry',
                    index = i
                },
            },
            distance = 1.5
        })
    end
end)
