local rewardTable = { -- Minimum and maximum amount of marked bills for given amount of correct minigames
    ['0'] = {min = 1, max = 2},
    ['1'] = {min = 2, max = 4},
    ['2'] = {min = 3, max = 6},
    ['3'] = {min = 8, max = 10},
    ['4'] = {min = 12, max = 15}
}

local randomQuestions = { -- You can add more random questions here
    [1] = "What is my favourite food?",
    [2] = "What is my favourite car?",
    [3] = "What is my favourite animal?",
    [4] = "Who is my best friend?"
}

local randomEquations = { -- {<equation>, <answer for 114>, <answer for 115>}
    [1] = {"(A+B+C)", 6, 7},
}

local maxFlags = 7 -- Maximum incorrect vault keypad inputs
local flags = 0
local randomEq = nil
local canEnter = true
local copsCalled = false

local accessCodes = {
    [1] = {code = math.random(1000, 9999), correct = false},
    [2] = {code = math.random(1000, 9999), correct = false},
    [3] = {code = math.random(1000, 9999), correct = false},
    [4] = {code = math.random(1000, 9999), correct = false}
}

local randomQ = nil
local loginAttempt = 1

--- Method to generate a unique random 8 digit number
--- @return string - Password string
local RandomId = function()
    local random = math.random(10000000, 99999999)
    local result = MySQL.scalar.await('SELECT id FROM stashitems WHERE stash = ?', {'duffelbag_'..random})
    if result then
        return RandomId()
    else
        return random
    end
end

--- Checks if all input codes are correct
--- @return nil
local verifyCodes = function(playerId)
    if accessCodes[1].correct and accessCodes[2].correct and accessCodes[3].correct and accessCodes[4].correct then
        -- Alert Cops
        if not copsCalled then
            copsCalled = true
            TriggerClientEvent('qb-casinoheist:client:AlertCops', playerId)
            print('^3[qb-casinoheist] ^5Police Alerted^7')
        end
        Shared.VaultStage += 1
        print('^3[qb-casinoheist] ^5Set Vault Stage: '..Shared.VaultStage..'^7')
        TriggerClientEvent('qb-casinoheist:client:SetVaultStage', -1, Shared.VaultStage)
        -- Update new codes
        for i=1, #accessCodes do
            accessCodes[i].code = math.random(1000, 9999)
            accessCodes[i].correct = false
        end
        TriggerClientEvent('QBCore:Notify', playerId, "Correct input..", "success")
        canEnter = true
    end
end

--- Method to check if maxFlags has been reached
--- @return nil
local checkFlags = function() 
    if flags >= maxFlags then
        canEnter = false
    end
end

RegisterNetEvent('qb-casinoheist:server:VaultLogin', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    loginAttempt += 1
    TriggerClientEvent('qb-casinoheist:client:LoginAttempt', -1, loginAttempt)
    if loginAttempt <= 5 then
        TriggerClientEvent('qb-casinoheist:client:VaultLogin', src)
        return 
    end
    if Shared.VaultLogin then return end
    if Shared.VaultOpen then return end
    Shared.VaultLogin = true
    Shared.VaultOpen = true
    TriggerClientEvent('qb-casinoheist:client:OpenVaultDoor', -1)
    print('^3[qb-casinoheist] ^5Vault Door Opened^7')
    CreateBags()
end)

RegisterNetEvent('qb-casinoheist:server:GrabBag', function(netId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(netId) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-grabbag') return end
    if not Shared.VaultOpen then return end

    local bag = NetworkGetEntityFromNetworkId(netId)
    for i=1, #bagCache do
        if bagCache[i] == bag then
            local info = {id = RandomId()}
            DeleteEntity(bag)
            bagCache[i] = nil
            Player.Functions.AddItem('casino_bag', 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_bag'], 'add', 1)
            break
        end
    end
end)

RegisterNetEvent('qb-casinoheist:server:SetLockerHit', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(index) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-lockerhit') return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Lockers[index].coords) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-lockerhit') return end

    Shared.Lockers[index].hit = true
    TriggerClientEvent('qb-casinoheist:client:SetLockerHit', -1, index)
end)

RegisterNetEvent('qb-casinoheist:server:VaultLaptopReward', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(index) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-getlaptops') return end
    if index > 2 then exports['qb-core']:ExploitBan(src, 'casinoheist-getlaptops') return end

    local info = {uses = 2}

    Player.Functions.AddItem('casino_green', 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_green'], 'add', 1)
    Wait(250)

    Player.Functions.AddItem('casino_blue', 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_blue'], 'add', 1)
    Wait(250)

    Player.Functions.AddItem('casino_red', 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_red'], 'add', 1)
    Wait(250)

    Player.Functions.AddItem('casino_gold', 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_gold'], 'add', 1)

    print('^3[qb-casinoheist] ^5'..Player.PlayerData.name..' received casino laptops^7')
end)

RegisterNetEvent('qb-casinoheist:server:ConsumeLaptopUse', function(laptopType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not laptopType then return end

    local item
    if laptopType == 'green' then
        item = Player.Functions.GetItemByName('casino_green')
    elseif laptopType == 'blue' then
        item = Player.Functions.GetItemByName('casino_blue')
    elseif laptopType == 'red' then
        item = Player.Functions.GetItemByName('casino_red')
    elseif laptopType == 'gold' then
        item = Player.Functions.GetItemByName('casino_gold')
    end

    if not item then return end
    if not item.info.uses then
        print('^3[qb-casinoheist] ^5'..Player.PlayerData.name..' has a '..item.name..' without info.uses! ^7')
        Player.PlayerData.items[item.slot].info.uses = 1
        --Player.PlayerData.items[item.slot].info.quality = 50
        Player.Functions.SetInventory(Player.PlayerData.items)
        return
    end

    if (Player.PlayerData.items[item.slot].info.uses - 1) <= 0 then
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item.name], "remove", 1)
        Player.Functions.RemoveItem(item.name, 1, item.slot)
    else
        Player.PlayerData.items[item.slot].info.uses -= 1
        --Player.PlayerData.items[item.slot].info.quality -= 50
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('qb-casinoheist:server:VaultLockerReward', function(index, correctMinigames)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(index) ~= 'number' or type(correctMinigames) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-vaultreward') return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Lockers[index].coords) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-vaultreward') return end
    if not Shared.Lockers[index].hit then exports['qb-core']:ExploitBan(src, 'casinoheist-vaultreward') return end
    local bag = Player.Functions.GetItemByName('casino_bag')
    if not bag then return end

    -- Calculate Reward
    correctMinigames = tostring(correctMinigames)
    local receiveAmount = math.random(rewardTable[correctMinigames].min, rewardTable[correctMinigames].max)
    local info = {
        worth = math.random(12000, 14000) -- Individual worth of money bag is a random number between these two values
    }

    -- Add Reward
    Player.Functions.AddItem('markedbills', receiveAmount, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], 'add', receiveAmount)
    TriggerEvent('qb-log:server:CreateLog', 'casinoheist', 'Vault Reward', 'green', '**'.. Player.PlayerData.name .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..receiveAmount..'x inked money: $'..(receiveAmount*info.worth)..' Correct minigames: '..correctMinigames..'**')
    print('^3[qb-casinoheist] ^5'..Player.PlayerData.name..' received '..receiveAmount..' moneybags, Locker: '..index..'^7')
end)

RegisterNetEvent('qb-casinoheist:server:EquationInput', function(input)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(input) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-equation-input') return end

    if Shared.VaultStage == 0 then
        if input == randomEq[2] then
            info = {codes = accessCodes[1].code.." - "..accessCodes[2].code.." - "..accessCodes[3].code.." - "..accessCodes[4].code}
            Player.Functions.AddItem("casino_vaultcode", 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casino_vaultcode"], "add", 1)
        else
            TriggerClientEvent('QBCore:Notify', src, "Incorrect input..", "error")
        end
    elseif Shared.VaultStage == 1 then
        if input == randomEq[3] then
            info = {codes = accessCodes[1].code.." - "..accessCodes[2].code.." - "..accessCodes[3].code.." - "..accessCodes[4].code}
            Player.Functions.AddItem("casino_vaultcode", 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casino_vaultcode"], "add", 1)
        else
            TriggerClientEvent('QBCore:Notify', src, "Incorrect input..", "error")
        end
    end
end)

RegisterNetEvent('qb-casinoheist:server:VaultKeypadInput', function(index, input)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(index) ~= 'number' or type(input) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-keypad-input') return end
    if not canEnter then return end
    if Shared.VaultStage == 2 then return end
    
    if accessCodes[index].code == input then
        accessCodes[index].correct = true
        verifyCodes(src)
    else
        flags = flags + 1
        checkFlags()
    end
end)

QBCore.Functions.CreateCallback('qb-casinoheist:server:GetLogin', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local copCount = getCopCount()

    if copCount < Shared.MinCops then
        cb(false)
    elseif randomQ then
        cb(randomQ)
    else
        local rndm = math.random(#randomQuestions)
        randomQ = randomQuestions[rndm]
        print('^3[qb-casinoheist] ^5Vault Login: '..randomQ..'^7')
        cb(randomQ)
    end
end)

QBCore.Functions.CreateCallback('qb-casinoheist:server:GetVaultEquation', function(source, cb)
    if randomEq then
        cb(randomEq[1])
    else
        local rndm = math.random(#randomEquations)
        randomEq = randomEquations[rndm]
        print('^3[qb-casinoheist] ^5Vault Controls: Stage 1: '..randomEq[2]..' - Stage 2: '..randomEq[3]..'^7')
        cb(randomEq[1])
    end
end)

QBCore.Functions.CreateUseableItem("casino_bag", function(source, item)
    local src = source
    if not item.info.id then return end
    TriggerClientEvent('qb-casinoheist:client:OpenDuffelBag', src, item.info.id)
end)
