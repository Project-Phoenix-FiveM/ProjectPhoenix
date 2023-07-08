QBCore = exports['qb-core']:GetCoreObject()

robberyBusy = {
    fleeca = false,
    maze = false,
    paleto = false,
    pacific = false    
}

--- Functions

--- Method to print debug messages to console when Config.Debug is enabled
--- @param message string - message to print
--- @return nil
debugPrint = function(message)
    if type(message) == 'string' then
        print('^3[qb-bankrobbery] ^5' .. message .. '^7')
    end
end

--- Method to grab amount of cops on duty
--- @return amount number - Amount of cops on duty
getCopCount = function()
    local amount = 0
    local Players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(Players) do
    -- if Player.PlayerData.job.name == 'police' and Player.PlayerData.job.onduty then
        if Player.PlayerData.job.type == 'leo' and Player.PlayerData.job.onduty then
            amount += 1
        end
    end
    return amount
end

--- Method to generate a random alphanumeric password with length k
--- @param k number - Password length
--- @return string string - Password string
generatePassword = function(k)
    local charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local string = ''
    for i=1, k do
        local rand = math.random(#charset)
        string = string .. string.sub(charset, rand, rand)
    end
    return string
end

local ResetBank = function(bank)
    -- Door    
    Shared.Banks[bank].hacked = false
    Shared.Banks[bank].policeClose = false

    -- lockers
    for i=1, #Shared.Banks[bank].lockers, 1 do
        Shared.Banks[bank].lockers[i].busy = false
        Shared.Banks[bank].lockers[i].taken = false
    end

    -- Trollys
    ClearTrollys()
    for j=1, #Shared.Banks[bank].trolly, 1 do
        Shared.Banks[bank].trolly[j].taken = false
    end

    -- Thermite spots
    if Shared.Banks[bank].thermite then
        for k=1, #Shared.Banks[bank].thermite, 1 do
            Shared.Banks[bank].thermite[k].hit = false
        end
    end

    -- Fleeca
    if Shared.Banks[bank].type == 'fleeca' then
        Shared.Banks[bank].keycardTaken = false
        Shared.Banks[bank].innerDoor.hacked = false
    end

    -- Big Banks
    if bank == 'Paleto' then
        ResetPaletoValues()
    elseif bank == 'Pacific' then
        ResetPaletoValues()
    end

    robberyBusy[Shared.Banks[bank].type] = false
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', Shared.Banks[bank].type, false)
    TriggerClientEvent('qb-bankrobbery:client:ResetBank', -1, bank)
    debugPrint('Resetting ' .. bank)
end

--- Events

RegisterNetEvent('qb-bankrobbery:server:SetBankHacked', function(bank)
    if not Shared.Banks[bank] then return end
    if Shared.Banks[bank].hacked then return end
    Shared.Banks[bank].hacked = true
    robberyBusy[Shared.Banks[bank].type] = true
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', Shared.Banks[bank].type, true)
    CreateTrollys(bank)

    SetTimeout(Shared.BankSettings.VaultUnlockTime * 1000, function()
        TriggerClientEvent('qb-bankrobbery:client:SetBankHacked', -1, bank)
    end)

    SetTimeout(Shared.Cooldown[Shared.Banks[bank].type] * 60 * 1000, function() -- Cooldown timer
        ResetBank(bank)
    end)
end)

RegisterNetEvent('qb-bankrobbery:server:PDClose', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local bank = data.bank
    if not Shared.Banks[bank] then return end
    
    -- if Player.PlayerData.job.name ~= 'police' then return end
    if Player.PlayerData.job.type ~= 'leo' then return end
    Shared.Banks[bank].policeClose = not Shared.Banks[bank].policeClose
    TriggerClientEvent('qb-bankrobbery:client:PDClose', -1, bank)
end)

RegisterNetEvent('qb-bankrobbery:server:SetTrollyBusy', function(bank, index)
    local src = source
    local coords = GetEntityCoords(GetPlayerPed(src))
    if not Shared.Banks[bank] or not Shared.Banks[bank].trolly[index] then return end
    if #(coords - Shared.Banks[bank].trolly[index].coords.xyz) > 2.0 then return end
    Shared.Banks[bank].trolly[index].busy = true
    TriggerClientEvent('qb-bankrobbery:client:SetTrollyBusy', -1, bank, index)
end)

RegisterNetEvent('qb-bankrobbery:server:TrollyReward', function(netId, bank, index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or type(netId) ~= 'number' or not Shared.Banks[bank] or not Shared.Banks[bank].trolly[index] then return end
    local entity = NetworkGetEntityFromNetworkId(netId)
    if entity ~= trollies[bank][index] then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Banks[bank].trolly[index].coords.xyz) > 10 then return end
    if Shared.Banks[bank].trolly[index].taken then return end
    TriggerClientEvent('qb-bankrobbery:client:SetTrollyTaken', -1, bank, index)
    Shared.Banks[bank].trolly[index].taken = true
    SwapTrolly(bank, index, entity)

    local bankType = Shared.Banks[bank].type
    local rewardType = Shared.Banks[bank].trolly[index].type

    if rewardType == 'money' then
        local receiveAmount = math.random(Rewards.Trollys[rewardType][bankType].minAmount, Rewards.Trollys[rewardType][bankType].maxAmount)
        local info = {
            worth = math.random(Rewards.Trollys[rewardType][bankType].minWorth, Rewards.Trollys[rewardType][bankType].maxWorth)
        }

        Player.Functions.AddItem('markedbills', receiveAmount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], 'add', receiveAmount)
    elseif rewardType == 'gold' then
        local receiveAmount = math.random(Rewards.Trollys[rewardType][bankType].minAmount, Rewards.Trollys[rewardType][bankType].maxAmount)
        Player.Functions.AddItem('goldbar', receiveAmount, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add', receiveAmount)
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetLockerBusy', function(bank, index)
    local src = source
    local coords = GetEntityCoords(GetPlayerPed(src))
    if not Shared.Banks[bank] or not Shared.Banks[bank].lockers[index] then return end
    if #(coords - Shared.Banks[bank].lockers[index].coords.xyz) > 5.0 then return end
    Shared.Banks[bank].lockers[index].busy = true
    TriggerClientEvent('qb-bankrobbery:client:SetLockerBusy', -1, bank, index)
end)

RegisterNetEvent('qb-bankrobbery:server:LockerReward', function(bank, index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not Shared.Banks[bank] or not Shared.Banks[bank].lockers[index] then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Banks[bank].lockers[index].coords.xyz) > 10 then return end
    if Shared.Banks[bank].lockers[index].taken then return end
    TriggerClientEvent('qb-bankrobbery:client:SetLockerTaken', -1, bank, index)
    Shared.Banks[bank].lockers[index].taken = true

    local bankType = Shared.Banks[bank].type

    if math.random(100) < Rewards.Lockers[bankType].rareChance then -- Rare item loot
        Player.Functions.AddItem(Rewards.Lockers[bankType].rareItem, 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Rewards.Lockers[bankType].rareItem], 'add', 1)
    else
        local randomItem = Rewards.Lockers[bankType].items[math.random(#Rewards.Lockers[bankType].items)]
        local receiveAmount = math.random(Rewards.Lockers[bankType].amount.minAmount, Rewards.Lockers[bankType].amount.maxAmount)
        Player.Functions.AddItem(randomItem, receiveAmount, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', receiveAmount)
    end
end)

RegisterNetEvent('qb-bankrobbery:server:RemoveThermite', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem('thermite', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['thermite'], 'remove', 1)
end)

RegisterNetEvent('qb-bankrobbery:server:SetThermiteHit', function(bank, index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Shared.Banks[bank].thermite[index].hit = true
    TriggerClientEvent('qb-bankrobbery:client:SetThermiteHit', -1, bank, index)
end)

RegisterNetEvent('qb-bankrobbery:server:ThermitePtfx', function(coords)
    TriggerClientEvent('qb-bankrobbery:client:ThermitePtfx', -1, coords)
end)

--- Callbacks

QBCore.Functions.CreateCallback('qb-bankrobbery:server:GetConfig', function(source, cb)
    cb(Shared)
end)

QBCore.Functions.CreateCallback('qb-bankrobbery:server:CanAttemptBankRobbery', function(source, cb, bank)
    local src = source
    local bankType = Shared.Banks[bank].type
    if robberyBusy[bankType] then
        TriggerClientEvent('QBCore:Notify', src, _U('bank_cooldown'), 'error', 4000)
        cb(false)
    elseif getCopCount() < Shared.MinCops[bankType] then
        TriggerClientEvent('QBCore:Notify', src, _U('not_enough_cops') .. ' (' .. Shared.MinCops[bankType] .. ') required', 'error', 4000)
        cb(false)
    else
        cb(true)
    end
end)

--- Items

QBCore.Functions.CreateUseableItem('thermite', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player.Functions.GetItemByName('thermite') then return end
    TriggerClientEvent('thermite:UseThermite', src)
end)
