QBCore = exports['qb-core']:GetCoreObject()

local paid = {}
local cooldown = 60 -- cooldown for parking to expire (minutes)


-- Events

RegisterNetEvent('qb-parkingmeter:server:payParking', function(pos)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney("cash", 5) then
        local id = math.random(10000, 99999)
        paid[id] = {
            coords = pos,
        }
        TriggerClientEvent("QBCore:Notify", src, "You paid parking fee!", "success", 5000)
        Wait(cooldown * 60000)
        paid[id] = nil
        TriggerClientEvent("QBCore:Notify", src, "Parking payment expired!", "error", 5000)
    else
        TriggerClientEvent("QBCore:Notify", src, "You don't have enough cash!", "error", 5000)
    end
end)

-- Callbacks

QBCore.Functions.CreateCallback('qb-parkingmeter:server:checkParking', function(source, cb, pos)
    for k, v in pairs(paid) do
        if #(pos - v.coords) <= 3 then
            cb(true)
        end
    end
    cb(false)
end)