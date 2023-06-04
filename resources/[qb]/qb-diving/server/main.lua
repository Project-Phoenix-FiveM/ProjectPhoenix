local QBCore = exports['qb-core']:GetCoreObject()
local currentDivingArea = math.random(1, #Config.CoralLocations)
local availableCoral = {}

-- Functions

local function getItemPrice(amount, price)
    for k, v in pairs(Config.BonusTiers) do
        local modifier = #Config.BonusTiers == k and amount >= v.minAmount or amount >= v.minAmount and amount <= v.maxAmount
        if modifier then
            local percent = math.random(v.minBonus, v.maxBonus) / 100
            local bonus = price * percent
            price = price + bonus
            price = math.ceil(price)
        end
    end
    return price
end

local function hasCoral(src)
    local Player = QBCore.Functions.GetPlayer(src)
    availableCoral = {}
    for _, v in pairs(Config.CoralTypes) do
        local item = Player.Functions.GetItemByName(v.item)
        if item then availableCoral[#availableCoral+1] = v end
    end
    return next(availableCoral)
end

-- Events

RegisterNetEvent('qb-diving:server:CallCops', function(coords)
    for _, Player in pairs(QBCore.Functions.GetQBPlayers()) do
        if Player then
            if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
                local msg = Lang:t("info.cop_msg")
                TriggerClientEvent('qb-diving:client:CallCops', Player.PlayerData.source, coords, msg)
                local alertData = {
                    title = Lang:t("info.cop_title"),
                    coords = coords,
                    description = msg
                }
                TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
            end
        end
    end
end)

RegisterNetEvent('qb-diving:server:SellCoral', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if hasCoral(src) then
        for _, v in pairs(availableCoral) do
            local item = Player.Functions.GetItemByName(v.item)
            local price = item.amount * v.price
            local reward = getItemPrice(item.amount, price)
            Player.Functions.RemoveItem(item.name, item.amount)
            Player.Functions.AddMoney('cash', reward, "sold-coral")
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_coral"), 'error')
    end
end)

RegisterNetEvent('qb-diving:server:TakeCoral', function(area, coral, bool)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local coralType = math.random(1, #Config.CoralTypes)
    local amount = math.random(1, Config.CoralTypes[coralType].maxAmount)
    local ItemData = QBCore.Shared.Items[Config.CoralTypes[coralType].item]
    if amount > 1 then
        for _ = 1, amount, 1 do
            Player.Functions.AddItem(ItemData["name"], 1)
            TriggerClientEvent('inventory:client:ItemBox', src, ItemData, "add")
            Wait(250)
        end
    else
        Player.Functions.AddItem(ItemData["name"], amount)
        TriggerClientEvent('inventory:client:ItemBox', src, ItemData, "add")
    end
    if (Config.CoralLocations[area].TotalCoral - 1) == 0 then
        for _, v in pairs(Config.CoralLocations[currentDivingArea].coords.Coral) do
            v.PickedUp = false
        end
        Config.CoralLocations[currentDivingArea].TotalCoral = Config.CoralLocations[currentDivingArea].DefaultCoral
        local newLocation = math.random(1, #Config.CoralLocations)
        while newLocation == currentDivingArea do
            Wait(0)
            newLocation = math.random(1, #Config.CoralLocations)
        end
        currentDivingArea = newLocation
        TriggerClientEvent('qb-diving:client:NewLocations', -1)
    else
        Config.CoralLocations[area].coords.Coral[coral].PickedUp = bool
        Config.CoralLocations[area].TotalCoral = Config.CoralLocations[area].TotalCoral - 1
    end
    TriggerClientEvent('qb-diving:client:UpdateCoral', -1, area, coral, bool)
end)

RegisterNetEvent('qb-diving:server:removeItemAfterFill', function()
   local src = source
   local Player = QBCore.Functions.GetPlayer(src)
   Player.Functions.RemoveItem("diving_fill", 1)
   TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["diving_fill"], "remove")
end)

-- Callbacks

QBCore.Functions.CreateCallback('qb-diving:server:GetDivingConfig', function(_, cb)
    cb(Config.CoralLocations, currentDivingArea)
end)

-- Items

QBCore.Functions.CreateUseableItem("diving_gear", function(source)
    TriggerClientEvent("qb-diving:client:UseGear", source)
end)

QBCore.Functions.CreateUseableItem("diving_fill", function(source)
    TriggerClientEvent("qb-diving:client:setoxygenlevel", source)
end)
