QBCore = exports['qb-core']:GetCoreObject()

jailedPlayers = {}

--- Jailtime management functions

--- Method to add a player to the jailed players, confiscate his items and send him to prison, returns true if successful, false if not successful
--- @param src number - playerId
--- @param takeItems boolean - Whether to confiscate a players items
--- @param time number - Time in minutes, not zero
--- @return boolean - Success
local jailPlayer = function(src, takeItems, time)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or type(time) ~= 'number' or time == 0 or type(takeItems) ~= 'boolean' then return false end
    if isPlayerInJail(src) then return false end
    jailedPlayers[src] = time
    Player.Functions.SetMetaData('injail', time)
    TriggerClientEvent('qb-prison:client:SendPlayerToPrison', src, takeItems, time)
    if takeItems and (not Player.PlayerData.metadata['jailitems'] or table.type(Player.PlayerData.metadata['jailitems']) == 'empty') then
        -- Take items
        Player.Functions.SetMetaData('jailitems', Player.PlayerData.items)
        Wait(2000)
        Player.Functions.ClearInventory()
        -- Take cash and put it in bank
        local cash = Player.PlayerData.money.cash
        if Player.Functions.RemoveMoney('cash', cash, 'prison-belongings') then
            Player.Functions.AddMoney('bank', cash, 'prison-belongings')
        end
        -- Set Unarmed
        SetCurrentPedWeapon(GetPlayerPed(src), `WEAPON_UNARMED`, true)
    end
    debugPrint('Added ' .. GetPlayerName(src) .. ' (' .. src .. ')' .. ' to jailedPlayers, time: ' .. time)
    return true
end

--- Method to remove a player from jailed players, Relinquish his items and release him, returns true if successful, false if not successful
--- @param src number - playerId
--- @return boolean - Success
local unJailPlayer = function(src)
    if not isPlayerInJail(src) then return false end
    jailedPlayers[src] = nil
    removeFromJobGroup(src, getPlayerJobGroup(src))
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Config.Inventory == 'exports' then
        exports['qb-inventory']:ClearInventory(src, nil)
        Wait(1000)
        for _, v in pairs(Player.PlayerData.metadata['jailitems']) do
            exports['qb-inventory']:AddItem(src, v.name, v.amount, false, v.info)
        end
        Player.Functions.SetMetaData('jailitems', {})
    elseif Config.Inventory == 'player' then
        Player.Functions.ClearInventory()
        Wait(1000)
        for _, v in pairs(Player.PlayerData.metadata['jailitems']) do
            Player.Functions.AddItem(v.name, v.amount, false, v.info)
        end
        Player.Functions.SetMetaData('jailitems', {})
    end
    local ped = GetPlayerPed(src)
    SetEntityCoords(ped, Config.Locations['exit'].xyz)
    SetEntityHeading(ped, Config.Locations['exit'].w)
    Player.Functions.SetMetaData('injail', 0)
    TriggerClientEvent('qb-jail:client:PostPrisonExit', src)
    debugPrint(GetPlayerName(src) .. ' (' .. src .. ')' .. ' has been unjailed')
    return true
end

--- Method to return a players remaining jail sentence
--- @param src number - playerId
--- @return number | boolean - Time in minutes | false
local getPlayerTimeRemaining = function(src)
    if isPlayerInJail(src) then
        return jailedPlayers[src]
    end
    return false
end

--- Method to check if a player can be released from prison, i.e. when his sentence is completed
--- @param src number - playerId
--- @return boolean - canReleasePlayer
local canReleasePlayer = function(src)
    return jailedPlayers[src] and jailedPlayers[src] < 0
end

--- Method to check if a player is supposed to be in prison, true can mean that the player is released and can exit prison on his request
--- @param src number - playerId
--- @return boolean - isPlayerInJail
isPlayerInJail = function(src)
    return jailedPlayers[src] and jailedPlayers[src] ~= 0 
end

--- Method to increase a players jail sentence, if player was already released, the amount is now his sentence
--- @param src number - playerId
--- @param amount number - Time in minutes
--- @return boolean - Was successful
increasePlayerJailSentence = function(src, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    if not isPlayerInJail(src) or type(amount) ~= 'number' then return false end
    local currentJailTime = getPlayerTimeRemaining(src)
    local newJailTime = currentJailTime + amount
    if currentJailTime < 0 then newJailTime = amount end
    jailedPlayers[src] = newJailTime
    Player.Functions.SetMetaData('injail', newJailTime)
    if newJailTime > 0 then
        TriggerClientEvent('QBCore:Notify', src, 'Your sentence has been increased by ' .. amount .. ' to ' .. newJailTime, 'primary', 4000)
    end
    debugPrint('Increased jail sentence of ' .. GetPlayerName(src) .. ' (' .. src .. ')' .. ' by ' .. amount .. ' to ' .. newJailTime)
    return true
end

--- Method to reduce a players jail sentence
--- @param src number - playerId
--- @param amount number - Time in minutes
--- @return boolean - Was successful
reducePlayerJailSentence = function(src, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    if not isPlayerInJail(src) or type(amount) ~= 'number' then return false end
    local currentJailTime = getPlayerTimeRemaining(src)
    local newJailTime = currentJailTime - amount
    if newJailTime == 0 then newJailTime = -1 end
    jailedPlayers[src] = newJailTime
    Player.Functions.SetMetaData('injail', newJailTime)
    if currentJailTime > 0 and newJailTime < 0 then
        TriggerClientEvent('QBCore:Notify', src, 'Your sentence is up. You have been released.', 'primary', 4000)
    end
    debugPrint('Reduced jail sentence of ' .. GetPlayerName(src) .. ' (' .. src .. ')' .. ' by ' .. amount .. ' to ' .. newJailTime)
    return true
end

--- Method to attempt to reduce a players jail sentence for good behaviour
--- @param src number - playerId
--- @return boolean - Was successful
reduceJailSentenceAttempt = function(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local group = getPlayerJobGroup(src)
    if not group or not isPlayerInJail(src) then return end
    local chance = Config.ReduceReward[group].chance
    local amount = Config.ReduceReward[group].amount
    if chance >= math.random(100) then
        local currentJailTime = Player.PlayerData.metadata.injail
        local newJailTime = currentJailTime - amount
        if newJailTime == 0 then newJailTime = -1 end
        if newJailTime < 0 then
            TriggerClientEvent('QBCore:Notify', src, 'Your sentence is up. You have been released.', 'primary', 4000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Your jail sentence has been reduced by ' .. amount .. ' months for good behavior', 'primary', 2500)
        end
        jailedPlayers[src] = newJailTime
        Player.Functions.SetMetaData('injail', newJailTime)
        debugPrint(GetPlayerName(src) .. ' (' .. src .. ')' .. ' reduced jail sentence by ' .. amount .. ' (' .. group .. ')')
        return true
    else
        return false
    end
end

--- Method to print debug messages to console when Config.Debug is enabled
--- @param message string - message to print
--- @return nil
debugPrint = function(message)
    if Config.Debug and type(message) == 'string' then
        print('^3[qb-jail] ^5' .. message .. '^7')
    end
end

--- Method to reduce every jailed players sentence by one, repeats every minute
--- @return nil
SentenceLoop = function()
    for k, v in pairs(jailedPlayers) do
        if v then
            jailedPlayers[k] -= 1
            if jailedPlayers[k] == 0 then
                jailedPlayers[k] = -1
                TriggerClientEvent('QBCore:Notify', k, 'Your sentence is up. You have been released.', 'primary', 4000)
            end
            local Player = QBCore.Functions.GetPlayer(k)
            Player.Functions.SetMetaData('injail', jailedPlayers[k])
        end
    end
    SetTimeout(60000, SentenceLoop)
end

CreateThread(SentenceLoop)

--- Start/Stop Events

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() ~= resource then return end
    for i=1, #skateParkObjects do
        if DoesEntityExist(skateParkObjects[i]) then
            DeleteEntity(skateParkObjects[i])
        end
    end

    for i=1, #cleaningSetup do
        if DoesEntityExist(cleaningSetup[i].handle) then
            DeleteEntity(cleaningSetup[i].handle)
        end
    end

    for i=1, #scrapYardObjects do 
        if DoesEntityExist(scrapYardObjects[i]) then
            DeleteEntity(scrapYardObjects[i])
        end
    end

    for i=1, #farmingSetup do
        if DoesEntityExist(farmingSetup[i].handle) then
            DeleteEntity(farmingSetup[i].handle)
        end
    end
    
    for i=1, #spawnedGuards, 1 do
        if DoesEntityExist(spawnedGuards[i]) then
            DeleteEntity(spawnedGuards[i])
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() ~= resource then return end
    Wait(1000)
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.metadata.injail ~= 0 then
            TriggerClientEvent('QBCore:Notify', v.PlayerData.source, 'Jail Script Restarting', 'primary', 4000)
            jailPlayer(v.PlayerData.source, false, v.PlayerData.metadata.injail)
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if isPlayerInJail(src) then 
        jailedPlayers[src] = nil
        removeFromJobGroup(src, getPlayerJobGroup(src))
    end
end)

--- Player Load/Unload event

AddEventHandler('QBCore:Server:OnPlayerUnload', function(src)
    if isPlayerInJail(src) then 
        jailedPlayers[src] = nil
        removeFromJobGroup(src, getPlayerJobGroup(src))
    end
end)

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.metadata.injail ~= 0 then
        jailPlayer(src, false, Player.PlayerData.metadata.injail)
    end
end)

--- Jail Events

RegisterNetEvent('qb-jail:server:RequestPrisonExit', function()
    local src = source
    local ped = GetPlayerPed(src)
    if #(GetEntityCoords(ped) - Config.Locations.services) > 15 then return end
    if canReleasePlayer(src) then
        unJailPlayer(src)
    end
end)

RegisterNetEvent('qb-jail:server:RequestSentenceReduction', function(sentGroup)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or not sentGroup or not isPlayerInJail(src) or not Config.ReduceReward[sentGroup] then return end
    if sentGroup == getPlayerJobGroup(src) then
        reduceJailSentenceAttempt(src)
    end
end)

--- Reception

RegisterNetEvent('qb-jail:server:RequestPrisoner', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(playerId)
    if not Player or not Target then return end
    local request = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    TriggerClientEvent('QBCore:Notify', playerId, request .. ' has requested for you at visitation!', 'primary', 8000)
end)

QBCore.Functions.CreateCallback('qb-jail:server:GetAllPrisoners', function(source, cb)
    local prisoners = {}
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if isPlayerInJail(v.PlayerData.source) then
            prisoners[#prisoners + 1] = {
                id = v.PlayerData.source,
                name = v.PlayerData.charinfo.firstname .. ' ' .. v.PlayerData.charinfo.lastname,
                time = getPlayerTimeRemaining(v.PlayerData.source)
            }
        end
    end
    cb(prisoners)
end)

--- Commands for confiscating and returning player items

QBCore.Commands.Add('confiscate', 'Confiscate Player Items', {{name = 'id', help = 'Player ID'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local playerId = tonumber(args[1])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player and OtherPlayer and Player.PlayerData.job.type == 'leo' and Player.PlayerData.job.onduty then -- if Player and OtherPlayer and Player.PlayerData.job.name == 'police' and Player.PlayerData.job.onduty then
        local ped = GetPlayerPed(src)
        local targetPed = GetPlayerPed(playerId)
        if #(GetEntityCoords(ped) - GetEntityCoords(targetPed)) < 2.5 then
            if OtherPlayer.PlayerData.metadata["ishandcuffed"] or OtherPlayer.PlayerData.metadata["isdead"] or OtherPlayer.PlayerData.metadata["inlaststand"] then
                if (not OtherPlayer.PlayerData.metadata['jailitems'] or table.type(OtherPlayer.PlayerData.metadata['jailitems']) == 'empty') then
                    -- Take items
                    OtherPlayer.Functions.SetMetaData('jailitems', OtherPlayer.PlayerData.items)
                    Wait(2000)
                    OtherPlayer.Functions.ClearInventory()
                    -- Take cash and put it in bank
                    local cash = OtherPlayer.PlayerData.money.cash
                    if OtherPlayer.Functions.RemoveMoney('cash', cash, 'prison-belongings') then
                        OtherPlayer.Functions.AddMoney('bank', cash, 'prison-belongings')
                    end
                    -- Set unarmed
                    SetCurrentPedWeapon(GetPlayerPed(playerId), `WEAPON_UNARMED`, true)
                else
                    TriggerClientEvent('QBCore:Notify', src, 'Could not confiscate items, player already has prison belongings!', 'error', 2500)
                end
            else
                TriggerClientEvent('QBCore:Notify', src, 'Player is not cuffed, dead or in last stand', 'error', 2500)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'Player is not close by enough.', 'error', 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'This command is only for on duty police.', 'error', 2500)
    end
end)

QBCore.Commands.Add('relinquish', 'Relinquish Confiscated Prison Items', {{name = 'id', help = 'Player ID'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local playerId = tonumber(args[1])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player and OtherPlayer and Player.PlayerData.job.type == 'leo' and Player.PlayerData.job.onduty then -- if Player and OtherPlayer and Player.PlayerData.job.name == 'police' and Player.PlayerData.job.onduty then
        local ped = GetPlayerPed(src)
        local targetPed = GetPlayerPed(playerId)
        if #(GetEntityCoords(ped) - GetEntityCoords(targetPed)) < 2.5 then
            if OtherPlayer.PlayerData.metadata['jailitems'] and table.type(OtherPlayer.PlayerData.metadata['jailitems']) ~= 'empty' then
                if Config.Inventory == 'exports' then
                    exports['qb-inventory']:ClearInventory(playerId, nil)
                    Wait(1000)
                    for _, v in pairs(OtherPlayer.PlayerData.metadata['jailitems']) do
                        exports['qb-inventory']:AddItem(playerId, v.name, v.amount, false, v.info)
                    end
                    OtherPlayer.Functions.SetMetaData('jailitems', {})
                elseif Config.Inventory == 'player' then
                    OtherPlayer.Functions.ClearInventory()
                    Wait(1000)
                    for _, v in pairs(OtherPlayer.PlayerData.metadata['jailitems']) do
                        OtherPlayer.Functions.AddItem(v.name, v.amount, false, v.info)
                    end
                    OtherPlayer.Functions.SetMetaData('jailitems', {})
                end
            else
                TriggerClientEvent('QBCore:Notify', src, 'Could not return items, player does not have any prison belongings.', 'error', 2500)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'Player is not close by enough.', 'error', 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'This command is only for on duty police.', 'error', 2500)
    end
end)

--- Exports

exports('jailPlayer', jailPlayer)
exports('unJailPlayer', unJailPlayer)
exports('isPlayerInJail', isPlayerInJail)
exports('canReleasePlayer', canReleasePlayer)
exports('getPlayerTimeRemaining', getPlayerTimeRemaining)
exports('increasePlayerJailSentence', increasePlayerJailSentence)
exports('reducePlayerJailSentence', reducePlayerJailSentence)

--- Testing: /jail command doesn't allow self-test, remove or comment when done testing, this requires server ace perms => server console

RegisterCommand('jailPlayer', function(source, args, rawCommand)
    local playerId = tonumber(args[1])
    local time = tonumber(args[2])
    if not playerId or not time then return end
    jailPlayer(playerId, true, time)
end, true)
