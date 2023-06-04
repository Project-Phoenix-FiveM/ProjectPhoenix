QBCore = exports['qb-core']:GetCoreObject()

-- Functions
exports('GetDealers', function()
    return Config.Dealers
end)

-- Callbacks
QBCore.Functions.CreateCallback('qb-drugs:server:RequestConfig', function(_, cb)
    cb(Config.Dealers)
end)

-- Events
RegisterNetEvent('qb-drugs:server:updateDealerItems', function(itemData, amount, dealer)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    if Config.Dealers[dealer]["products"][itemData.slot].amount - 1 >= 0 then
        Config.Dealers[dealer]["products"][itemData.slot].amount -= amount
        TriggerClientEvent('qb-drugs:client:setDealerItems', -1, itemData, amount, dealer)
    else
        Player.Functions.RemoveItem(itemData.name, amount)
        Player.Functions.AddMoney('cash', amount * Config.Dealers[dealer]["products"][itemData.slot].price)
        TriggerClientEvent("QBCore:Notify", src, Lang:t("error.item_unavailable"), "error")
    end
end)

RegisterNetEvent('qb-drugs:server:giveDeliveryItems', function(deliveryData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    local item = Config.DeliveryItems[deliveryData.item].item

    if not item then return end

    Player.Functions.AddItem(item, deliveryData.amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
end)

RegisterNetEvent('qb-drugs:server:successDelivery', function(deliveryData, inTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    local item = Config.DeliveryItems[deliveryData.item].item
    local itemAmount = deliveryData.amount
    local payout = deliveryData.itemData.payout * itemAmount
    local copsOnline = QBCore.Functions.GetDutyCount('police')
    local curRep = Player.PlayerData.metadata["dealerrep"]
    local invItem = Player.Functions.GetItemByName(item)
    if inTime then
        if invItem and invItem.amount >= itemAmount then -- on time correct amount
            Player.Functions.RemoveItem(item, itemAmount)
            if copsOnline > 0 then
                local copModifier = copsOnline * Config.PoliceDeliveryModifier
                if Config.UseMarkedBills then
                    local info = {worth = math.floor(payout * copModifier)}
                    Player.Functions.AddItem('markedbills', 1, false, info)
                else
                    Player.Functions.AddMoney('cash', math.floor(payout * copModifier), 'drug-delivery')
                end
            else
                if Config.UseMarkedBills then
                    local info = {worth = payout}
                    Player.Functions.AddItem('markedbills', 1, false, info)
                else
                    Player.Functions.AddMoney('cash', payout, 'drug-delivery')
                end
            end
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
            TriggerClientEvent('QBCore:Notify', src, Lang:t("success.order_delivered"), 'success')
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'perfect', deliveryData)
                Player.Functions.SetMetaData('dealerrep', (curRep + Config.DeliveryRepGain))
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.order_not_right"), 'error')-- on time incorrect amount
            if invItem then
                local newItemAmount = invItem.amount
                local modifiedPayout = deliveryData.itemData.payout * newItemAmount
                Player.Functions.RemoveItem(item, newItemAmount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
                Player.Functions.AddMoney('cash', math.floor(modifiedPayout / Config.WrongAmountFee))
            end
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'bad', deliveryData)
                if curRep - 1 > 0 then
                    Player.Functions.SetMetaData('dealerrep', (curRep - Config.DeliveryRepLoss))
                else
                    Player.Functions.SetMetaData('dealerrep', 0)
                end
            end)
        end
    else
        if invItem and invItem.amount >= itemAmount then -- late correct amount
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.too_late"), 'error')
            Player.Functions.RemoveItem(item, itemAmount)
            Player.Functions.AddMoney('cash', math.floor(payout / Config.OverdueDeliveryFee), "delivery-drugs-too-late")
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'late', deliveryData)
                if curRep - 1 > 0 then
                    Player.Functions.SetMetaData('dealerrep', (curRep - Config.DeliveryRepLoss))
                else
                    Player.Functions.SetMetaData('dealerrep', 0)
                end
            end)
        else
            if invItem then -- late incorrect amount
                local newItemAmount = invItem.amount
                local modifiedPayout = deliveryData.itemData.payout * newItemAmount
                TriggerClientEvent('QBCore:Notify', src, Lang:t("error.too_late"), 'error')
                Player.Functions.RemoveItem(item, itemAmount)
                Player.Functions.AddMoney('cash', math.floor(modifiedPayout / Config.OverdueDeliveryFee), "delivery-drugs-too-late")
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
                SetTimeout(math.random(5000, 10000), function()
                    TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'late', deliveryData)
                    if curRep - 1 > 0 then
                        Player.Functions.SetMetaData('dealerrep', (curRep - Config.DeliveryRepLoss))
                    else
                        Player.Functions.SetMetaData('dealerrep', 0)
                    end
                end)
            end
        end
    end
end)

-- Commands
QBCore.Commands.Add("newdealer", Lang:t("info.newdealer_command_desc"), {{
    name = Lang:t("info.newdealer_command_help1_name"),
    help = Lang:t("info.newdealer_command_help1_help")
}, {
    name = Lang:t("info.newdealer_command_help2_name"),
    help = Lang:t("info.newdealer_command_help2_help")
}, {
    name = Lang:t("info.newdealer_command_help3_name"),
    help = Lang:t("info.newdealer_command_help3_help")
}}, true, function(source, args)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    local dealerName = args[1]
    local minTime = tonumber(args[2])
    local maxTime = tonumber(args[3])
    local time = json.encode({min = minTime, max = maxTime})
    local pos = json.encode({x = coords.x, y = coords.y, z = coords.z})
    local result = MySQL.scalar.await('SELECT name FROM dealers WHERE name = ?', {dealerName})
    if result then return TriggerClientEvent('QBCore:Notify', source, Lang:t("error.dealer_already_exists"), "error") end
    MySQL.insert('INSERT INTO dealers (name, coords, time, createdby) VALUES (?, ?, ?, ?)', {dealerName, pos, time, Player.PlayerData.citizenid}, function()
        Config.Dealers[dealerName] = {
            ["name"] = dealerName,
            ["coords"] = {
                ["x"] = coords.x,
                ["y"] = coords.y,
                ["z"] = coords.z
            },
            ["time"] = {
                ["min"] = minTime,
                ["max"] = maxTime
            },
            ["products"] = Config.Products
        }
        TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
    end)
end, "admin")

QBCore.Commands.Add("deletedealer", Lang:t("info.deletedealer_command_desc"), {{
    name = Lang:t("info.deletedealer_command_help1_name"),
    help = Lang:t("info.deletedealer_command_help1_help")
}}, true, function(source, args)
    local dealerName = args[1]
    local result = MySQL.scalar.await('SELECT * FROM dealers WHERE name = ?', {dealerName})
    if result then
        MySQL.query('DELETE FROM dealers WHERE name = ?', {dealerName})
        Config.Dealers[dealerName] = nil
        TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
        TriggerClientEvent('QBCore:Notify', source, Lang:t("success.dealer_deleted", {dealerName = dealerName}), "success")
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.dealer_not_exists_command", {dealerName = dealerName}), "error")
    end
end, "admin")

QBCore.Commands.Add("dealers", Lang:t("info.dealers_command_desc"), {}, false, function(source, _)
    local DealersText = ""
    if Config.Dealers ~= nil and next(Config.Dealers) ~= nil then
        for _, v in pairs(Config.Dealers) do
            DealersText = DealersText .. Lang:t("info.list_dealers_name_prefix") .. v["name"] .. "<br>"
        end
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message advert"><div class="chat-message-body"><strong>' .. Lang:t("info.list_dealers_title") .. '</strong><br><br> ' .. DealersText .. '</div></div>',
            args = {}
        })
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.no_dealers"), 'error')
    end
end, "admin")

QBCore.Commands.Add("dealergoto", Lang:t("info.dealergoto_command_desc"), {{
    name = Lang:t("info.dealergoto_command_help1_name"),
    help = Lang:t("info.dealergoto_command_help1_help")
}}, true, function(source, args)
    local DealerName = tostring(args[1])
    if Config.Dealers[DealerName] then
        local ped = GetPlayerPed(source)
        SetEntityCoords(ped, Config.Dealers[DealerName]['coords']['x'], Config.Dealers[DealerName]['coords']['y'], Config.Dealers[DealerName]['coords']['z'])
        TriggerClientEvent('QBCore:Notify', source, Lang:t("success.teleported_to_dealer", {dealerName = DealerName}), 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.dealer_not_exists"), 'error')
    end
end, "admin")

CreateThread(function()
    Wait(500)
    local dealers = MySQL.query.await('SELECT * FROM dealers', {})
    if dealers[1] then
        for _, v in pairs(dealers) do
            local coords = json.decode(v.coords)
            local time = json.decode(v.time)

            Config.Dealers[v.name] = {
                ["name"] = v.name,
                ["coords"] = {
                    ["x"] = coords.x,
                    ["y"] = coords.y,
                    ["z"] = coords.z
                },
                ["time"] = {
                    ["min"] = time.min,
                    ["max"] = time.max
                },
                ["products"] = Config.Products
            }
        end
    end
    TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
end)
