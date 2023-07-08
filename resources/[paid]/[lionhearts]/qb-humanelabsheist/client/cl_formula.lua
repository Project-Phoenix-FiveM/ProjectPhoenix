RegisterNetEvent('qb-humanelabsheist:client:UseSecretFormula', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        display = true
    })
end)

RegisterNUICallback('esc', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNetEvent('qb-humanelabsheist:client:SmallLabChemicals', function(data)
    local index = data.index
    local ped = PlayerPedId()
    if Shared.SmallLab[index].hit then return end
    TriggerServerEvent('qb-humanelabsheist:server:SmallLabChemicalsHit', index)

    -- Evidence
    if not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(ped))
    end

    -- Animation
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
    QBCore.Functions.Progressbar("pickup_reycle_package", "Stealing Chemicals..", 3500, false, true, {}, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-humanelabsheist:server:SmallLabReward', index)
        ClearPedTasks(ped)
    end, function() -- cancel
        ClearPedTasks(ped)
    end)

end)

RegisterNetEvent('qb-humanelabsheist:client:SmallLabChemicalsHit', function(index)
    Shared.SmallLab[index].taken = true
end)

RegisterNetEvent('qb-humanelabsheist:client:UseChemicals', function()
    local result = QBCore.Functions.HasItem({'hlabs_formula', 'markedbills'})
    if result then
        QBCore.Functions.Progressbar("hlabs_cleaning", "Adding chemicals to marked bills..", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('qb-humanelabsheist:server:CleanMoney')
        end, function() -- Cancel
            QBCore.Functions.Notify("Canceled..", "error", 2500)
        end)
    else
        QBCore.Functions.Notify("You are missing something(s)..", "error", 2500)
    end
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("hlabs_chem1", vector3(3558.975, 3672.995, 28.117), 0.4, 0.6, {
        name = "hlabs_chem1",
        heading = 349.999,
        debugPoly = false,
        minZ = 28.117,
        maxZ = 28.417,
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-humanelabsheist:client:SmallLabChemicals',
                icon = 'fas fa-user-secret',
                label = 'Grab Chemicals',
                canInteract = function()
                    return not Shared.SmallLab[1].taken
                end,
                index = 1
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("hlabs_chem2", vector3(3559.710, 3673.843, 28.117), 0.4, 0.6, {
        name = "hlabs_chem2",
        heading = 169.999,
        debugPoly = false,
        minZ = 28.117,
        maxZ = 28.417,
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-humanelabsheist:client:SmallLabChemicals',
                icon = 'fas fa-user-secret',
                label = 'Grab Chemicals',
                canInteract = function()
                    return not Shared.SmallLab[2].taken
                end,
                index = 2
            }
        },
        distance = 1.5,
    })
end)
