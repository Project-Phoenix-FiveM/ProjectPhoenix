RegisterServerEvent('av_realestate:logout', function()
    local src = source
    if Config.Framework == "QBCore" then
        QBCore.Player.Logout(src)
        if GetResourceState("av_multicharacter") == "started" then
            TriggerClientEvent('av_multicharacter:init', src)
        else
            TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
        end
    else
        if GetResourceState("av_multicharacter") == "started" then
            TriggerEvent('esx:playerLogout', src)
            TriggerClientEvent('av_multicharacter:init', src)
        else
            TriggerEvent('esx:playerLogout', src)
        end
    end
end)

RegisterServerEvent('av_realestate:spawn', function(lastLocation)
    local src = source
    local identifier = exports['av_laptop']:getIdentifier(src)
    local isOwner = false
    if players[identifier] then
        if not lastLocation then
            players[identifier] = nil
            SaveResourceFile(GetCurrentResourceName(), "players.json", json.encode(players), -1)
            return
        end
        local motelIdentifier = players[identifier]
        local data = GetMotelCache(motelIdentifier)
        if not data then
            data = MySQL.single.await('SELECT * FROM av_realestate WHERE identifier = ?', {motelIdentifier})
        end
        if data then
            if data['customer_identifier'] == identifier then isOwner = true end
            TriggerClientEvent('av_realestate:spawnInMotel',src,data,isOwner)
            if not isOwner then
                players[identifier] = nil
                SaveResourceFile(GetCurrentResourceName(), "players.json", json.encode(players), -1)
            end
        end
    end
end)