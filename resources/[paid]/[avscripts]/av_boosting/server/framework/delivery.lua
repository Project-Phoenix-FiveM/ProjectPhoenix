-- Assigns delivery coords to contract
function AddContractMission(plate,type,netId)
    if not permiso then return end
    startedContracts[plate] = startedContracts[plate] or {}
    local random = math.random(1,#Config.Delivery[type])
    local delivery = Config.Delivery[type][random]
    startedContracts[plate]["delivery"] = delivery
    startedContracts[plate]['time'] = stime(os.date())
    startedContracts[plate]['netId'] = netId
end

-- Send blip to all cops
RegisterServerEvent('av_boosting:sendBlip', function(coords,plates)
    if not permiso then return end
    TriggerClientEvent('av_boosting:getBlips',-1,coords,plates)
end)

RegisterServerEvent('av_boosting:removeBlip', function(plates)
    if not permiso then return end
    TriggerClientEvent('av_boosting:deleteBlip',-1,plates)
end)

-- Pay the person who delivered the vehicle + hacker
RegisterServerEvent('av_boosting:pay', function(netId, plates)
    local src = source
    local hackerSrc = "None"
    local identifier = exports['av_laptop']:getIdentifier(src)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not vehicle then return end
    DeleteEntity(vehicle)
    while DoesEntityExist(vehicle) do
        DeleteEntity(vehicle)
        Wait(100)
    end
    WipeGuards(plates)
    if not startedContracts[plates] then return end
    local owner = startedContracts[plates]['owner']
    if players[identifier] then
        players[identifier]['busy'] = false
    end
    if players[owner] then
        players[owner]['busy'] = false
    end
    local class = "D"
    local payout = 0
    local currentTime = stime(os.date())
    local seconds = currentTime - startedContracts[plates]['time']
    for k, v in pairs(contracts[owner]) do
        if v['serial'] == plates then
            class = v['class']
            payout = v['price'] + Config.Classes[class]["Prices"]['payout']
            table.remove(contracts[owner],k)
            break
        end
    end
    local driverExists = MySQL.single.await('SELECT * FROM av_boosting WHERE identifier = ?', {identifier})
    if driverExists then
        local bestTime = driverExists.best
        local driverEXP = Config.Classes[class]["EXP"]['driver']
        driverEXP = math.random(driverEXP['min'], driverEXP['max'])
        if bestTime then
            if tonumber(seconds) < tonumber(bestTime) then
                bestTime = seconds
            end
        else
            bestTime = seconds
        end
        MySQL.update.await('UPDATE av_boosting SET deliveries = (deliveries + 1), level = (level + ?), time = ? WHERE identifier = ?', {driverEXP,bestTime,identifier})
    else
        local name = "User-"..math.random(11,9999)
        MySQL.insert.await('INSERT INTO av_boosting (identifier, name, photo, level, hacks, deliveries, time) VALUES (?, ?, ?, ?, ?, ?, ?)', {identifier, name, Config.DefaultPicture, driverEXP, 0, 1, 9999990000})
    end
    if startedContracts[plates]['hacker'] and startedContracts[plates]['hacker'] ~= identifier then
        local hackerEXP = Config.Classes[class]["EXP"]['hacker']
        hackerEXP = math.random(hackerEXP['min'], hackerEXP['max'])
        local hackerExists = MySQL.single.await('SELECT * FROM av_boosting WHERE identifier = ?', {startedContracts[plates]['hacker']})
        if hackerExists then
            local hacks = hackerExists.hacks + 1
            MySQL.update.await('UPDATE av_boosting SET hacks = ?, level = (level + ?) WHERE identifier = ?', {hacks,hackerEXP,startedContracts[plates]['hacker']})
        else
            local name = "User-"..math.random(11,9999)
            MySQL.insert.await('INSERT INTO av_boosting (identifier, name, photo, level, hacks, deliveries, time) VALUES (?, ?, ?, ?, ?, ?, ?)', {startedContracts[plates]['hacker'], name, Config.DefaultPicture, hackerEXP, 1, 0, 9999990000})
        end
        hackerSrc = exports['av_laptop']:getSourceByIdentifier(startedContracts[plates]['hacker'])
        if tonumber(hackerSrc) then
            TriggerClientEvent('av_boosting:wipe',tonumber(hackerSrc))
        end
    end
    exports['av_laptop']:addMoney(src, Config.CryptoAccount, payout) -- + Driver money
    TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['received']..' '..payout..' '..Lang['crypto_label'])
    TriggerClientEvent('av_boosting:wipe',src)
    local driver = GetPlayerName(src)
    local hacker = "None"
    local finalTime = SecondsToClock(seconds)
    if tonumber(hackerSrc) then
        hacker = GetPlayerName(tonumber(hackerSrc))
    end
    local discord = {
        {
            ['title'] = 'Contract Completed',
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = "**Driver:** "..driver.."\n **Hacker:** "..hacker.."\n **Class:** "..class.."\n **Payout:** "..payout.."\n **Time:** "..finalTime,
        } 
    }
    exports['av_laptop']:Discord(webhook,discord)
    startedContracts[plates] = nil
end)