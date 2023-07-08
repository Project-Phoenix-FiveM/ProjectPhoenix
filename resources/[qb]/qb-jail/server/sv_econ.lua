--- Slushie Stuff

QBCore.Functions.CreateUseableItem("prisonslushie", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Config.Inventory == 'exports' then
        if exports['qb-inventory']:RemoveItem(src, 'prisonslushie', 1, false) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonslushie'], 'remove', 1)
            TriggerClientEvent('qb-jail:client:UseSlushie', src)
            if Config.SlushieSpoonChance >= math.random(100) and isPlayerInJail(src) then
                exports['qb-inventory']:AddItem(src, 'prisonspoon', 1, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonspoon'], 'add', 1)
            end
        end
    elseif Config.Inventory == 'player' then
        if Player.Functions.RemoveItem('prisonslushie', 1, false) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonslushie'], 'remove', 1)
            TriggerClientEvent('qb-jail:client:UseSlushie', src)
            if Config.SlushieSpoonChance >= math.random(100) and isPlayerInJail(src) then
                Player.Functions.AddItem('prisonspoon', 1, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['prisonspoon'], 'add', 1)
            end
        end
    end
end)

--- Crafting Stuff

RegisterNetEvent('qb-jail:server:CraftItem', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not Config.CraftingCost[index] then return end
    if not isPlayerInJail(src) then return end

    local hasItems = true
    for _, v in pairs(Config.CraftingCost[index].items) do
        if not QBCore.Functions.HasItem(src, v.item, v.amount) then
            hasItems = false
            TriggerClientEvent('QBCore:Notify', src, "You don't have all the required items..", "error", 2500)
            return
        end
    end

    if hasItems then
        for _, v in pairs(Config.CraftingCost[index].items) do
            if Config.Inventory == 'exports' and exports['qb-inventory']:RemoveItem(src, v.item, v.amount, false) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.item], "remove", v.amount)
                Wait(250)
            elseif Config.Inventory == 'player' and Player.Functions.RemoveItem(v.item, v.amount, false) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.item], "remove", v.amount)
                Wait(250)
            end
        end

        if Config.Inventory == 'exports' and exports['qb-inventory']:AddItem(src, Config.CraftingCost[index].item, Config.CraftingCost[index].amount, false) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.CraftingCost[index].item], "add", Config.CraftingCost[index].amount)
        elseif Config.Inventory == 'player' and Player.Functions.AddItem(Config.CraftingCost[index].item, Config.CraftingCost[index].amount, false) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.CraftingCost[index].item], "add", Config.CraftingCost[index].amount)
        end
    end
end)

--- Prison Gangster Stuff

RegisterNetEvent('qb-jail:server:PurchaseItem', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not Config.PrisonerPedShop[index] then return end
    if not isPlayerInJail(src) then return end

    if QBCore.Functions.HasItem(src, Config.PrisonerPedShop[index].cost.item, Config.PrisonerPedShop[index].cost.amount) then
        if Config.Inventory == 'exports' and exports['qb-inventory']:RemoveItem(src, Config.PrisonerPedShop[index].cost.item, Config.PrisonerPedShop[index].cost.amount, false) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.PrisonerPedShop[index].cost.item], "remove", Config.PrisonerPedShop[index].cost.amount)
            Wait(250)
        elseif Config.Inventory == 'player' and Player.Functions.RemoveItem(Config.PrisonerPedShop[index].cost.item, Config.PrisonerPedShop[index].cost.amount, false) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.PrisonerPedShop[index].cost.item], "remove", Config.PrisonerPedShop[index].cost.amount)
            Wait(250)
        end
        if Config.Inventory == 'exports' and exports['qb-inventory']:AddItem(src, Config.PrisonerPedShop[index].item, 1, false) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.PrisonerPedShop[index].item], "add", 1)
        elseif Config.Inventory == 'player' and Player.Functions.AddItem(Config.PrisonerPedShop[index].item, 1, false) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.PrisonerPedShop[index].item], "add", 1)
        end
    end
end)