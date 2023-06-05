local QBCore = exports['qb-core']:GetCoreObject()

local AlarmActivated = false


RegisterNetEvent('prison:server:SetJailStatus', function(jailTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.SetMetaData("injail", jailTime)
    if jailTime > 0 then
        if Config.RemoveJobs then
            if Player.PlayerData.job.name ~= "unemployed" then
                Player.Functions.SetJob("unemployed", 0)
                TriggerClientEvent('QBCore:Notify', src, Lang:t("info.lost_job"))
            end
        end
    end
end)

RegisterNetEvent('prison:server:SaveJailItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.metadata["jailitems"] == nil or next(Player.PlayerData.metadata["jailitems"]) == nil then
        Player.Functions.SetMetaData("jailitems", Player.PlayerData.items)
        Player.Functions.AddMoney('cash', 80)
        Wait(2000)
        Player.Functions.ClearInventory()
    end
end)

RegisterNetEvent('rs-prison:server:getCommissary', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', Config.PrisonWage)
end)

RegisterNetEvent('prison:server:GiveJailItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Wait(1000)
    for k, v in pairs(Player.PlayerData.metadata["jailitems"]) do
        Player.Functions.AddItem(v.name, v.amount, false, v.info)
    end
    Wait(1000)
    Player.Functions.SetMetaData("jailitems", {})
end)

RegisterNetEvent('prison:server:CheckRecordStatus', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CriminalRecord = Player.PlayerData.metadata["criminalrecord"]
    local currentDate = os.date("*t")

    if (CriminalRecord["date"].month + 1) == 13 then
        CriminalRecord["date"].month = 0
    end

    if CriminalRecord["hasRecord"] then
        if currentDate.month == (CriminalRecord["date"].month + 1) or currentDate.day == (CriminalRecord["date"].day - 1) then
            CriminalRecord["hasRecord"] = false
            CriminalRecord["date"] = nil
        end
    end
end)

---------------------
-- CRAFTING ITEMS --
---------------------

-- Get Random Crafting Item
RegisterNetEvent('rs-prison:server:GetCraftingItems', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local itemamount = tonumber(amount)
    local craftingitem = tostring(item)

    if Config.Debug then
        print(craftingitem, itemamount)
    end

    Player.Functions.AddItem(craftingitem, itemamount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[craftingitem], 'add', itemamount)
end)

-- Get Crafted Item
RegisterNetEvent('rs-prison:server:GetCraftedItem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = data

    if Config.Debug then
        print(item)
    end

    Player.Functions.AddItem(item, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', 1)
end)

-- Remove Crafting Materials
RegisterNetEvent('rs-prison:server:RemoveCraftingItems', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for k, v in pairs(Config.CraftingItems[item].materials) do
        Player.Functions.RemoveItem(v.item, v.amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.item], 'remove', v.amount)
    end
end)

-- Checks for Materials
QBCore.Functions.CreateCallback('rs-prison:server:CraftingMaterials', function(source, cb, materials)
    local src = source
    local hasItems = false
    local matscheck = 0
    local player = QBCore.Functions.GetPlayer(source)
    for k, v in pairs(materials) do
        if player.Functions.GetItemByName(v.item) and player.Functions.GetItemByName(v.item).amount >= v.amount then
            matscheck = matscheck + 1
            if matscheck == #materials then
                cb(true)
            end
        else
            cb(false)
            return
        end
    end
end)



QBCore.Functions.CreateUseableItem("slushy", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("rs-prison:client:Slushy", src, item.name)
    end
end)

----------------------------
------- PRISON BREAK -------
----------------------------
-- Remove Prison Break Items
RegisterNetEvent('prison:server:RemovePrisonBreakItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for k,v in pairs(Config.PrisonBreak.Hack.Items) do
        Player.Functions.RemoveItem(v.item, v.amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.item], 'remove', v.amount)
    end
end)

-- Jail Alarm
RegisterNetEvent('prison:server:JailAlarm', function()
    if not AlarmActivated then
        TriggerClientEvent('prison:client:JailAlarm', -1, true)
        SetTimeout(5 * (60 * 1000), function()
            TriggerClientEvent('prison:client:JailAlarm', -1, false)
        end)
    end
end)

-- Lockdown
RegisterNetEvent('prison:server:SecurityLockdown', function()
    TriggerClientEvent("prison:client:SetLockDown", -1, true)
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("prison:client:PrisonBreakAlert", v)
            end
        end
	end
end)

-- Gate State
RegisterNetEvent('prison:server:SetGateHit', function(key)
    TriggerClientEvent("prison:client:SetGateHit", -1, key, true)
    if math.random(1, 100) <= 50 then
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player ~= nil then
                if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                    TriggerClientEvent("prison:client:PrisonBreakAlert", v)
                end
            end
        end
    end
end)

-- Alarm Callback
QBCore.Functions.CreateCallback('prison:server:IsAlarmActive', function(source, cb)
    cb(AlarmActivated)
end)

----------------------------
---------- LOCKERS ---------
----------------------------
-- Check if stash exist
QBCore.Functions.CreateCallback('rs-prison:server:DoesStashExist', function(source, cb, stashID)
    local retval = false
    local result = MySQL.Sync.fetchSingle('SELECT * from stashitems WHERE stash = ?', {stashID})

    if result then
        retval = true
    end
    cb(retval)
end)