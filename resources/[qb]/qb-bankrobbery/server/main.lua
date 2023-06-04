local QBCore = exports['qb-core']:GetCoreObject()
local robberyBusy = false
local timeOut = false

-- Functions

--- This will convert a table's keys into an array
--- @param tbl table
--- @return array
local function TableKeysToArray(tbl)
    local array = {}
    for k in pairs(tbl) do
        array[#array+1] = k
    end
    return array
end

--- This will loop over the given table to check if the power stations in the table have been hit
--- @param toLoop table
--- @return boolean
local function TableLoopStations(toLoop)
    local hits = 0
    for _, station in pairs(toLoop) do
        if type(station) == 'table' then
            local hits2 = 0
            for _, station2 in pairs(station) do
                if Config.PowerStations[station2].hit then hits2 += 1 end
                if hits2 == #station then return true end
            end
        else
            if Config.PowerStations[station].hit then hits += 1 end
            if hits == #toLoop then return true end
        end
    end
    return false
end

--- This will check what stations have been hit and update them accordingly
--- @return nil
local function CheckStationHits()
    local policeHits = {}
    local bankHits = {}

    for k, v in pairs(Config.CameraHits) do
        local allStationsHitPolice = false
        local allStationsHitBank = false
        if type(v.type) == 'table' then
            for _, cameraType in pairs(v.type) do
                if cameraType == 'police' then
                    if type(v.stationsToHitPolice) == 'table' then
                        allStationsHitPolice = TableLoopStations(v.stationsToHitPolice)
                    else
                        allStationsHitPolice = Config.PowerStations[v.stationsToHitPolice].hit
                    end
                elseif cameraType == 'bank' then
                    if type(v.stationsToHitBank) == 'table' then
                        allStationsHitBank = TableLoopStations(v.stationsToHitBank)
                    else
                        allStationsHitBank = Config.PowerStations[v.stationsToHitBank].hit
                    end
                end
            end
        else
            if v.type == 'police' then
                if type(v.stationsToHitPolice) == 'table' then
                    allStationsHitPolice = TableLoopStations(v.stationsToHitPolice)
                else
                    allStationsHitPolice = Config.PowerStations[v.stationsToHitPolice].hit
                end
            elseif v.type == 'bank' then
                if type(v.stationsToHitBank) == 'table' then
                    allStationsHitBank = TableLoopStations(v.stationsToHitBank)
                else
                    allStationsHitBank = Config.PowerStations[v.stationsToHitBank].hit
                end
            end
        end

        if allStationsHitPolice then
            policeHits[k] = true
        end

        if allStationsHitBank then
            bankHits[k] = true
        end
    end

    policeHits = TableKeysToArray(policeHits)
    bankHits = TableKeysToArray(bankHits)

    -- table.type checks if it's empty as well, if it's empty it will return the type 'empty' instead of 'array'
    if table.type(policeHits) == 'array' then Config.OnPoliceCameraHit(policeHits) end
    if table.type(bankHits) == 'array' then TriggerClientEvent("qb-bankrobbery:client:BankSecurity", -1, bankHits, false) end
end

--- This will do a quick check to see if all stations have been hit
--- @return boolean
local function AllStationsHit()
    local hit = 0
    for k in pairs(Config.PowerStations) do
        if Config.PowerStations[k].hit then
            hit += 1
        end
    end
    return hit >= Config.HitsNeeded
end

--- This will check if the given coords are in the area of the given distance of a powerstation
--- @param coords vector3
--- @param dist number
--- @return boolean
local function IsNearPowerStation(coords, dist)
    for _, v in pairs(Config.PowerStations) do
        if #(coords - v.coords) < dist then
            return true
        end
    end
    return false
end

-- Events

RegisterNetEvent('qb-bankrobbery:server:setBankState', function(bankId)
    if robberyBusy then return end
    if bankId == "paleto" then
        if Config.BigBanks["paleto"]["isOpened"] or #(GetEntityCoords(GetPlayerPed(source)) - Config.BigBanks["paleto"]["coords"]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:setBankState", extraInfo = " (paleto) ", source = source}))
        end
        Config.BigBanks["paleto"]["isOpened"] = true
        TriggerEvent('qb-bankrobbery:server:setTimeout')
    elseif bankId == "pacific" then
        if Config.BigBanks["pacific"]["isOpened"] or #(GetEntityCoords(GetPlayerPed(source)) - Config.BigBanks["pacific"]["coords"][2]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:setBankState", extraInfo = " (pacific) ", source = source}))
        end
        Config.BigBanks["pacific"]["isOpened"] = true
        TriggerEvent('qb-bankrobbery:server:setTimeout')
    else
        if Config.SmallBanks[bankId]["isOpened"] or #(GetEntityCoords(GetPlayerPed(source)) - Config.SmallBanks[bankId]["coords"]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:setBankState", extraInfo = " (smallbank "..bankId..") ", source = source}))
        end
        Config.SmallBanks[bankId]["isOpened"] = true
        TriggerEvent('qb-bankrobbery:server:SetSmallBankTimeout', bankId)
    end
    TriggerClientEvent('qb-bankrobbery:client:setBankState', -1, bankId)
    robberyBusy = true
    Config.OnRobberyStart(bankId)
end)

RegisterNetEvent('qb-bankrobbery:server:setLockerState', function(bankId, lockerId, state, bool)
    if bankId == "paleto" or bankId == "pacific" then
        if #(GetEntityCoords(GetPlayerPed(source)) - Config.BigBanks[bankId]["lockers"][lockerId]["coords"]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:setLockerState", extraInfo = " ("..bankId..") ", source = source}))
        end
        Config.BigBanks[bankId]["lockers"][lockerId][state] = bool
    else
        if #(GetEntityCoords(GetPlayerPed(source)) - Config.SmallBanks[bankId]["lockers"][lockerId]["coords"]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:setLockerState", extraInfo = " (smallbank "..bankId..") ", source = source}))
        end
        Config.SmallBanks[bankId]["lockers"][lockerId][state] = bool
    end
    TriggerClientEvent('qb-bankrobbery:client:setLockerState', -1, bankId, lockerId, state, bool)
end)

RegisterNetEvent('qb-bankrobbery:server:recieveItem', function(type, bankId, lockerId)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    if not ply then return end
    if type == "small" then
        if #(GetEntityCoords(GetPlayerPed(src)) - Config.SmallBanks[bankId]["lockers"][lockerId]["coords"]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:receiveItem", extraInfo = " (smallbank "..bankId..") ", source = source}))
        end
        local itemType = math.random(#Config.RewardTypes)
        local WeaponChance = math.random(1, 50)
        local odd1 = math.random(1, 50)
        local tierChance = math.random(1, 100)
        local tier
        if tierChance < 50 then tier = 1 elseif tierChance >= 50 and tierChance < 80 then tier = 2 elseif tierChance >= 80 and tierChance < 95 then tier = 3 else tier = 4 end
        if WeaponChance ~= odd1 then
            if tier ~= 4 then
                 if Config.RewardTypes[itemType].type == "item" then
                    local item = Config.LockerRewards["tier"..tier][math.random(#Config.LockerRewards["tier"..tier])]
                    local itemAmount = math.random(item.minAmount, item.maxAmount)
                    ply.Functions.AddItem(item.item, itemAmount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                 elseif Config.RewardTypes[itemType].type == "money" then
                    local info = {
                        worth = math.random(2300, 3200)
                    }
                    ply.Functions.AddItem('markedbills', math.random(2,3), false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                end
            else
                ply.Functions.AddItem('security_card_01', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_01'], "add")
            end
        else
            ply.Functions.AddItem('weapon_stungun', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_stungun'], "add")
        end
    elseif type == "paleto" then
        if #(GetEntityCoords(GetPlayerPed(source)) - Config.BigBanks["paleto"]["lockers"][lockerId]["coords"]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:receiveItem", extraInfo = " (paleto) ", source = source}))
        end
        local itemType = math.random(#Config.RewardTypes)
        local tierChance = math.random(1, 100)
        local WeaponChance = math.random(1, 10)
        local odd1 = math.random(1, 10)
        local tier
        if tierChance < 25 then tier = 1 elseif tierChance >= 25 and tierChance < 70 then tier = 2 elseif tierChance >= 70 and tierChance < 95 then tier = 3 else tier = 4 end
        if WeaponChance ~= odd1 then
            if tier ~= 4 then
                 if Config.RewardTypes[itemType].type == "item" then
                    local item = Config.LockerRewardsPaleto["tier"..tier][math.random(#Config.LockerRewardsPaleto["tier"..tier])]
                    local itemAmount = math.random(item.minAmount, item.maxAmount)
                    ply.Functions.AddItem(item.item, itemAmount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                 elseif Config.RewardTypes[itemType].type == "money" then
                    local info = {
                        worth = math.random(4000, 6000)
                    }
                    ply.Functions.AddItem('markedbills', math.random(1,4), false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                 end
            else
                ply.Functions.AddItem('security_card_02', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_02'], "add")
            end
        else
            ply.Functions.AddItem('weapon_vintagepistol', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_vintagepistol'], "add")
        end
    elseif type == "pacific" then
        if #(GetEntityCoords(GetPlayerPed(source)) - Config.BigBanks["pacific"]["lockers"][lockerId]["coords"]) > 2.5 then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:receiveItem", extraInfo = " (pacific) ", source = source}))
        end
        local itemType = math.random(#Config.RewardTypes)
        local WeaponChance = math.random(1, 100)
        local odd1 = math.random(1, 100)
        local odd2 = math.random(1, 100)
        local tierChance = math.random(1, 100)
        local tier
        if tierChance < 10 then tier = 1 elseif tierChance >= 25 and tierChance < 50 then tier = 2 elseif tierChance >= 50 and tierChance < 95 then tier = 3 else tier = 4 end
        if WeaponChance ~= odd1 or WeaponChance ~= odd2 then
            if tier ~= 4 then
                if Config.RewardTypes[itemType].type == "item" then
                    local item = Config.LockerRewardsPacific["tier"..tier][math.random(#Config.LockerRewardsPacific["tier"..tier])]
                    local maxAmount
                    if tier == 3 then maxAmount = 7 elseif tier == 2 then maxAmount = 18 else maxAmount = 25 end
                    local itemAmount = math.random(maxAmount)
                    ply.Functions.AddItem(item.item, itemAmount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.item], "add")
                elseif Config.RewardTypes[itemType].type == "money" then
                    local info = {
                        worth = math.random(19000, 21000)
                    }
                    ply.Functions.AddItem('markedbills', math.random(1,4), false, info)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                end
            else
                local info = {
                    worth = math.random(19000, 21000)
                }
                ply.Functions.AddItem('markedbills', math.random(1,4), false, info)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
                info = {
                    crypto = math.random(1, 3)
                }
                ply.Functions.AddItem("cryptostick", 1, false, info)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cryptostick'], "add")
            end
        else
            local chance = math.random(1, 2)
            local odd = math.random(1, 2)
            if chance == odd then
                ply.Functions.AddItem('weapon_microsmg', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_microsmg'], "add")
            else
                ply.Functions.AddItem('weapon_minismg', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_minismg'], "add")
            end
        end
    end
end)

AddEventHandler('qb-bankrobbery:server:setTimeout', function()
    if robberyBusy or timeOut then return end
    timeOut = true
    CreateThread(function()
        SetTimeout(60000 * 90, function()
            for k in pairs(Config.BigBanks["pacific"]["lockers"]) do
                Config.BigBanks["pacific"]["lockers"][k]["isBusy"] = false
                Config.BigBanks["pacific"]["lockers"][k]["isOpened"] = false
            end
            for k in pairs(Config.BigBanks["paleto"]["lockers"]) do
                Config.BigBanks["paleto"]["lockers"][k]["isBusy"] = false
                Config.BigBanks["paleto"]["lockers"][k]["isOpened"] = false
            end
            TriggerClientEvent('qb-bankrobbery:client:ClearTimeoutDoors', -1)
            Config.BigBanks["paleto"]["isOpened"] = false
            Config.BigBanks["pacific"]["isOpened"] = false
            timeOut = false
            robberyBusy = false
            Config.OnRobberyTimeoutEnd("paleto")
            Config.OnRobberyTimeoutEnd("pacific")
        end)
    end)
end)

AddEventHandler('qb-bankrobbery:server:SetSmallBankTimeout', function(bankId)
    if robberyBusy or timeOut then return end
    timeOut = true
    CreateThread(function()
        SetTimeout(60000 * 30, function()
            for k in pairs(Config.SmallBanks[bankId]["lockers"]) do
                Config.SmallBanks[bankId]["lockers"][k]["isOpened"] = false
                Config.SmallBanks[bankId]["lockers"][k]["isBusy"] = false
            end
            TriggerClientEvent('qb-bankrobbery:client:ResetFleecaLockers', -1, bankId)
            timeOut = false
            robberyBusy = false
            Config.OnRobberyTimeoutEnd(bankId)
        end)
    end)
end)

RegisterNetEvent('qb-bankrobbery:server:callCops', function(type, bank, coords)
    if type == "small" then
        if not Config.SmallBanks[bank]["alarm"] then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:callCops", extraInfo = " (smallbank "..bank..") ", source = source}))
        end
    elseif type == "paleto" then
        if not Config.BigBanks["paleto"]["alarm"] then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:callCops", extraInfo = " (paleto) ", source = source}))
        end
    elseif type == "pacific" then
        if not Config.BigBanks["pacific"]["alarm"] then
            return error(Lang:t("error.event_trigger_wrong", {event = "qb-bankrobbery:server:callCops", extraInfo = " (pacific) ", source = source}))
        end
    end
    TriggerClientEvent("qb-bankrobbery:client:robberyCall", -1, type, coords)
end)

RegisterNetEvent('qb-bankrobbery:server:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
    TriggerClientEvent("qb-bankrobbery:client:SetStationStatus", -1, key, isHit)
    if AllStationsHit() then
        exports["qb-weathersync"]:setBlackout(true)
        TriggerClientEvent("qb-bankrobbery:client:disableAllBankSecurity", -1)
        Config.OnBlackout(true)
        CreateThread(function()
            SetTimeout(60000 * Config.BlackoutTimer, function()
                exports["qb-weathersync"]:setBlackout(false)
                TriggerClientEvent("qb-bankrobbery:client:enableAllBankSecurity", -1)
                Config.OnBlackout(false)
            end)
        end)
    else
        CheckStationHits()
    end
end)

RegisterNetEvent('qb-bankrobbery:server:removeElectronicKit', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem('electronickit', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["electronickit"], "remove")
    Player.Functions.RemoveItem('trojan_usb', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["trojan_usb"], "remove")
end)

RegisterNetEvent('qb-bankrobbery:server:removeBankCard', function(number)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem('security_card_'..number, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_'..number], "remove")
end)

RegisterNetEvent('thermite:StartServerFire', function(coords, maxChildren, isGasFire)
    local src = source
    local ped = GetPlayerPed(src)
    local coords2 = GetEntityCoords(ped)
    local thermiteCoords = Config.BigBanks['pacific'].thermite[1].coords
    local thermite2Coords = Config.BigBanks['pacific'].thermite[2].coords
    local thermite3Coords = Config.BigBanks['paleto'].thermite[1].coords
    if #(coords2 - thermiteCoords) < 10 or #(coords2 - thermite2Coords) < 10 or #(coords2 - thermite3Coords) < 10 or IsNearPowerStation(coords2, 10) then
        TriggerClientEvent("thermite:StartFire", -1, coords, maxChildren, isGasFire)
    end
end)

RegisterNetEvent('thermite:StopFires', function()
    TriggerClientEvent("thermite:StopFires", -1)
end)

-- Callbacks

QBCore.Functions.CreateCallback('qb-bankrobbery:server:isRobberyActive', function(_, cb)
    cb(robberyBusy)
end)

QBCore.Functions.CreateCallback('qb-bankrobbery:server:GetConfig', function(_, cb)
    cb(Config.PowerStations, Config.BigBanks, Config.SmallBanks)
end)

QBCore.Functions.CreateCallback("thermite:server:check", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return cb(false) end
    if Player.Functions.RemoveItem("thermite", 1) then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["thermite"], "remove")
        cb(true)
    else
        cb(false)
    end
end)

-- Items

QBCore.Functions.CreateUseableItem("thermite", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player or not Player.Functions.GetItemByName('thermite') then return end
	if Player.Functions.GetItemByName('lighter') then
        TriggerClientEvent("thermite:UseThermite", source)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.missing_ignition_source"), "error")
    end
end)

QBCore.Functions.CreateUseableItem("security_card_01", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
	if not Player or not Player.Functions.GetItemByName('security_card_01') then return end
    TriggerClientEvent("qb-bankrobbery:UseBankcardA", source)
end)

QBCore.Functions.CreateUseableItem("security_card_02", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
	if not Player or not Player.Functions.GetItemByName('security_card_02') then return end
    TriggerClientEvent("qb-bankrobbery:UseBankcardB", source)
end)

QBCore.Functions.CreateUseableItem("electronickit", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player or not Player.Functions.GetItemByName('electronickit') then return end
    TriggerClientEvent("electronickit:UseElectronickit", source)
end)
