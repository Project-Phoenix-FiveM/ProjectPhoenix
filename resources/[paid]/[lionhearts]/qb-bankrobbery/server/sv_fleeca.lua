--- Events

RegisterNetEvent('qb-bankrobbery:server:GrabFleecaKeycard', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bank = data.bank
    if not Player or not Shared.Banks[bank] then return end
    local pos = GetEntityCoords(GetPlayerPed(src))
    if #(pos - Shared.Banks[bank].coords) > 15.0 then return end
    local bankType = Shared.Banks[bank].type
    if bankType ~= 'fleeca' then return end

    if Shared.Banks[bank].keycardTaken then
        TriggerClientEvent('QBCore:Notify', src, _U('keycard_taken'), 'error', 2500)
        return
    end

    if getCopCount() < Shared.MinCops[bankType] then
        TriggerClientEvent('QBCore:Notify', src, _U('not_enough_cops') .. '(' .. Shared.MinCops[bankType] .. ') required', 'error', 4000)
        return
    end

    Shared.Banks[bank].keycardTaken = true
    local info = { bank = bank }
    Player.Functions.AddItem('fleeca_bankcard', 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fleeca_bankcard'], 'add', 1)
    TriggerClientEvent('qb-bankrobbery:client:SetFleecaCardTaken', -1, bank)
end)

RegisterNetEvent('qb-bankrobbery:server:HackInnerPanel', function(bank)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not Shared.Banks[bank] then return end
    Shared.Banks[bank].innerDoor.hacked = true
    TriggerEvent('qb-doorlock:server:updateState', Shared.Banks[bank].innerDoor.id, false, false, false, true, false, false, src)
    TriggerClientEvent('qb-bankrobbery:client:SetInnerHacked', -1, bank)
end)

--- Items

QBCore.Functions.CreateUseableItem('fleeca_bankcard', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player.Functions.GetItemByName('fleeca_bankcard') then return end
    local coords = GetEntityCoords(GetPlayerPed(src))
    if not item.info.bank then return end
    if #(coords - Shared.Banks[item.info.bank].door.coords) < 2.0 then
        if getCopCount() >= Shared.MinCops['fleeca'] then
            if Player.Functions.RemoveItem('fleeca_bankcard', 1, false) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fleeca_bankcard'], 'remove', 1)
                TriggerClientEvent('QBCore:Notify', src, _U('keycard_used'), 'success', 2500)
                TriggerEvent('qb-doorlock:server:updateState', Shared.Banks[item.info.bank].door.id, false, false, false, true, false, false, src)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, _U('not_enough_cops') .. '(' .. Shared.MinCops['fleeca'] .. ') required', 'error', 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Nothing happens..', 'error', 2500)
    end
end)
