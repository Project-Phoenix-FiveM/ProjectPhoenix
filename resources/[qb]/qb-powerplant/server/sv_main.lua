local QBCore = exports['qb-core']:GetCoreObject()

local cityHit = false
local eastHit = false

--- Method to checks which stations are hit and trigger power plant explosions if needed
--- @param playerId number - player server id
--- @return nil
local CheckStationHits = function(playerId)
    Wait(20*1000)
    if Config.PowerStations[1].hit and Config.PowerStations[2].hit and Config.PowerStations[3].hit and Config.PowerStations[4].hit then
        if eastHit then return end
        -- east powerplant hit
        TriggerEvent("qb-powerplant:server:East", playerId)
        Wait(1400)
        -- blackout
        exports['qb-weathersync']:setBlackout(true)
        eastHit = true
        TriggerClientEvent('chatMessage', -1, "[LS Water & Power]", "error", "City wide power outage, we are working on it!")
        TriggerClientEvent("police:client:DisableAllCameras", -1)
        print("^3[qb-powerplant] ^5East Power Plant Hit^7")
        TriggerEvent("qb-log:server:CreateLog", "powerplants", "Blackout", "black", "**East Powerplant Hit**")
    elseif Config.PowerStations[5].hit and Config.PowerStations[6].hit and Config.PowerStations[7].hit then
        if cityHit then return end
        -- city powerplant hit
        TriggerEvent("qb-powerplant:server:City", playerId)
        Wait(1400)
        -- blackout
        exports['qb-weathersync']:setBlackout(true)
        cityHit = true
        TriggerClientEvent('chatMessage', -1, "[LS Water & Power]", "error", "City wide power outage, we are working on it!")
        TriggerClientEvent("police:client:DisableAllCameras", -1)
        print("^3[qb-powerplant] ^5City Power Plant Hit^7")
        TriggerEvent("qb-log:server:CreateLog", "powerplants", "Blackout", "black", "**City Powerplant Hit**")
    end
end

RegisterNetEvent('qb-powerplant:server:RemoveThermite', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    Player.Functions.RemoveItem('thermite', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['thermite'], "remove", 1)
end)

RegisterServerEvent('qb-powerplant:server:SetStationStatus', function(key, isHit)
    local src = source
    Config.PowerStations[key].hit = isHit
    TriggerEvent("qb-log:server:CreateLog", "powerplants", "Thermite", "red", "Station: "..key.." is hit successfully by "..GetPlayerName(src))
    print("^3[qb-powerplant] ^5Station: "..key.." is hit successfully by "..GetPlayerName(src).."^7")
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, key, isHit)
    CheckStationHits(src)
end)

RegisterServerEvent('qb-powerplant:server:City', function(playerId)
    TriggerClientEvent('qb-powerplant:client:City', -1)
    if Config.Artgallery then
        TriggerEvent('qb-artgalleryheist:server:SetPowerPlant', true)
        TriggerEvent('qb-artgalleryheist:server:SetLasers', false)
    end
    if Config.Bankrobbery then
        TriggerEvent('qb-bankrobbery:server:SetPowerPlant', true)
        TriggerEvent('qb-bankrobbery:server:SetLasers', false)
    end
    if Config.Casinoheist then
        TriggerEvent('qb-casinoheist:server:SetPowerPlant', true, playerId)
    end
end)

RegisterServerEvent('qb-powerplant:server:East', function(playerId)
    TriggerClientEvent('qb-powerplant:client:East', -1)
    if Config.JailBreak then
        TriggerEvent('qb-jail:server:SetPowerPlant', true, playerId)
    end
end)

RegisterServerEvent('qb-powerplant:server:ThermitePtfx', function(coords)
    TriggerClientEvent('qb-powerplant:client:ThermitePtfx', -1, coords)
end)

QBCore.Functions.CreateCallback('qb-powerplant:server:GetConfig', function(source, cb)
    cb(Config)
end)

QBCore.Functions.CreateCallback('qb-powerplant:server:getCops', function(source, cb)
	local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

QBCore.Functions.CreateUseableItem("thermite", function(source, item)
    local src = source
    TriggerClientEvent("thermite:UseThermite", src)
end)

CreateThread(function()
    while true do
        Wait(1000*60)
        local blackoutActive = exports['qb-weathersync']:getBlackoutState()
        if blackoutActive and (cityHit or eastHit) then
            Wait(1000*60*60*2) -- Cooldown
            exports['qb-weathersync']:setBlackout(false)
            TriggerClientEvent("police:client:EnableAllCameras", -1)
            TriggerClientEvent('chatMessage', -1, "[LS Water & Power]", "normal", "Power in the city is restored!")
            TriggerEvent("qb-log:server:CreateLog", "powerplants", "Blackout", "black", "**Blackout is over.**")
            if cityHit then
                cityHit = false
                Config.PowerStations[5].hit = false
                Config.PowerStations[6].hit = false
                Config.PowerStations[7].hit = false
                TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 5, false)
                TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 6, false)
                TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 7, false)
                if Config.Artgallery then
                    TriggerEvent('qb-artgalleryheist:server:SetPowerPlant', false)
                    TriggerEvent('qb-artgalleryheist:server:SetLasers', true)
                end
                if Config.Bankrobbery then
                    TriggerEvent('qb-bankrobbery:server:SetPowerPlant', false)
                    TriggerEvent('qb-bankrobbery:server:SetLasers', true)
                end
                if Config.Casinoheist then
                    TriggerEvent('qb-casinoheist:server:SetPowerPlant', false, false)
                end
                if Config.JailBreak then
                    TriggerEvent('qb-jail:server:SetPowerPlant', false, false)
                end
                print("^3[qb-powerplant] ^5Reset City Power Plant^7")
            elseif eastHit then
                eastHit = false
                Config.PowerStations[1].hit = false
                Config.PowerStations[2].hit = false
                Config.PowerStations[3].hit = false
                Config.PowerStations[4].hit = false
                TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 1, false)
                TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 2, false)
                TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 3, false)
                TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 4, false)
                print("^3[qb-powerplant] ^5Reset East Power Plant^7")
            end
        end
    end
end)

-- Testing
QBCore.Commands.Add("powerplant1", "Test Powerplant (God Only)", {}, false, function(source, args)
    Config.PowerStations[5].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 5, true)
    Config.PowerStations[6].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 6, true)
    Config.PowerStations[7].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 7, true)
    CheckStationHits(source)
end, "god")

QBCore.Commands.Add("powerplant2", "Test Powerplant (God Only)", {}, false, function(source, args)
    Config.PowerStations[1].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 1, true)
    Config.PowerStations[2].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 2, true)
    Config.PowerStations[3].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 3, true)
    Config.PowerStations[4].hit = true
    TriggerClientEvent("qb-powerplant:client:SetStationStatus", -1, 4, true)
    CheckStationHits(source)
end, "god")
