RegisterNetEvent('qb-bankrobbery:server:BuyLaptop', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local colour = data.colour
    if not Player or not Shared.Laptop[colour] then return end
    local pos = GetEntityCoords(GetPlayerPed(src))
    if #(pos - Shared.Laptop[colour].coords.xyz) > 5.0 then return end

    if Player.Functions.GetItemByName(Shared.Laptop[colour].usb) then
        if exports['qb-phone']:hasEnough(src, "gne", Shared.Laptop[colour].price) then
            Player.Functions.RemoveItem(Shared.Laptop[colour].usb, 1, false) 
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.Laptop[colour].usb], 'remove', 1)
            local info = { uses = Shared.LaptopUses }
            Player.Functions.AddItem(Shared.Laptop[colour].reward, 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.Laptop[colour].reward], 'add', 1)
            
            debugPrint(Player.PlayerData.name .. ' (citizenid: ' .. Player.PlayerData.citizenid .. ' | id: ' .. src .. ') Purchased ' .. Shared.Laptop[colour].reward .. ' for ' .. Shared.Laptop[colour].price .. ' ' .. Shared.LaptopMoneyType)
        else
            TriggerClientEvent('QBCore:Notify', src, _U('laptop_not_enough') .. Shared.LaptopMoneyType, 'error', 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have what i need", 'error', 2500)
    end
end)

RegisterNetEvent('qb-bankrobbery:server:LaptopDamage', function(itemName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local item = Player.Functions.GetItemByName(itemName)
    if not item then return end

    if not item.info.uses then
        Player.PlayerData.items[item.slot].info.uses = Shared.LaptopUses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
        debugPrint(Player.PlayerData.name .. ' has a ' .. item.name .. ' without info.uses!')
        return
    end

    if (item.info.uses - 1) <= 0 then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'remove', 1)
        Player.Functions.RemoveItem(item.name, 1, item.slot)
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)
