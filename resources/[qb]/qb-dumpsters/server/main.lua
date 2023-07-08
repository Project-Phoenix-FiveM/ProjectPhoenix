local QBCore = exports['qb-core']:GetCoreObject()

Loot = {
    {'recyclablematerial', math.random(1,3)}, -- Need to ad dmore entries.
}

RegisterServerEvent('qb-trashsearch:server:startDumpsterTimer')
AddEventHandler('qb-trashsearch:server:startDumpsterTimer', function(dumpster)
    startTimer(source, dumpster)
end)

RegisterNetEvent('qb-trashsearch:server:recieveItem', function()
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    local chosenrandomItem = Loot[math.random(1, #Loot)]
    print(chosenrandomItem[1], chosenrandomItem[2])
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[chosenrandomItem[1]], "add")
    ply.Functions.AddItem(chosenrandomItem[1], chosenrandomItem[2])
end)

RegisterNetEvent('qb-trashsearch:server:givemoney', function(money)
local src = source
local ply = QBCore.Functions.GetPlayer(src)
ply.Functions.AddMoney("cash", money)
end)

function startTimer(id, object)
    local timer = 10 * 1000

    while timer > 0 do
        Wait(10)
        timer = timer - 10
        if timer == 0 then
            TriggerClientEvent('qb-trashsearch:server:removeDumpster', id, object)
        end
    end
end


