local maxBags = 3
local timer = 5 -- Minutes
local CleaningTable = {}

RegisterNetEvent('qb-casino:server:LoadLaundry', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not index then exports['qb-core']:ExploitBan(src, 'casino-washer-no-index') end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Cleaning[index].coords) > 10 then exports['qb-core']:ExploitBan(src, 'casino-washer') end

    local item = Player.Functions.GetItemByName("markedbills")
    local coin = Player.Functions.GetItemByName("krugerrand")
    if item and coin then
        if item.amount > maxBags then
            Player.Functions.RemoveItem('markedbills', maxBags)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["markedbills"], "remove", maxBags)

            Player.Functions.RemoveItem('krugerrand', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["krugerrand"], "remove", 1)

            print("^3[qb-casino] ^5Loaded Washer "..Player.PlayerData.name.." with "..maxBags.." bags worth: "..(maxBags*item.info.worth).."^7")
            TriggerClientEvent('QBCore:Notify', src, "The laundromat is now washing your inked bills..", "success")

            CleaningTable[Player.PlayerData.citizenid] = {
                worth = maxBags*item.info.worth,
                status = 'started',
                washer = index
            }

            CreateThread(function()
                Wait(timer * 60 * 1000)
                CleaningTable[Player.PlayerData.citizenid].status = 'completed'
                TriggerClientEvent('qb-phone:client:CustomNotification', src, "CASINO", "Your laundry is done..", 'fas fa-socks', '#9E771C', 4000)
                print("^3[qb-casino] ^5Finished Washer "..Player.PlayerData.name.." worth: "..CleaningTable[Player.PlayerData.citizenid].worth.."^7")
            end)
        else
            Player.Functions.RemoveItem('markedbills', item.amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["markedbills"], "remove", item.amount)

            Player.Functions.RemoveItem('krugerrand', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["krugerrand"], "remove", 1)

            print("^3[qb-casino] ^5Loaded Washer "..Player.PlayerData.name.." with "..item.amount.." bags worth: "..(item.amount * item.info.worth).."^7")
            TriggerClientEvent('QBCore:Notify', src, "The laundromat is now washing your inked bills..", "success")

            CleaningTable[Player.PlayerData.citizenid] = {
                worth = item.amount*item.info.worth,
                status = 'started',
                washer = index
            }

            CreateThread(function()
                Wait(timer * 60 * 1000)
                CleaningTable[Player.PlayerData.citizenid].status = 'completed'
                TriggerClientEvent('qb-phone:client:CustomNotification', src, "CASINO", "Your laundry is done..", 'fas fa-socks', '#9E771C', 4000)
                print("^3[qb-casino] ^5Finished Washer "..Player.PlayerData.name.." worth: "..CleaningTable[Player.PlayerData.citizenid].worth.."^7")
            end)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any inked bills!", "error")
    end
end)

RegisterNetEvent('qb-casino:server:GrabLaundry', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not index then exports['qb-core']:ExploitBan(src, 'casino-washer-no-index') end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Cleaning[index].coords) > 10 then exports['qb-core']:ExploitBan(src, 'casino-washer') end
    
    local citizenid = Player.PlayerData.citizenid
    if not CleaningTable[citizenid] then return end
    if CleaningTable[citizenid].status ~= 'completed' then return end

    CleaningTable[citizenid].status = 'taken'
    Player.Functions.AddMoney('cash', CleaningTable[citizenid].worth)
    print("^3[qb-casino] ^5Grab Washer "..Player.PlayerData.name.." worth: "..CleaningTable[citizenid].worth.."^7")
    TriggerEvent("qb-log:server:CreateLog", 'casino', "Moneywash", "yellow", "**"..Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *(" .. Player.PlayerData.source .. "))*: has received " .. CleaningTable[citizenid].worth .. "$")  
end)

QBCore.Functions.CreateCallback('qb-casino:client:CheckLaundry', function(source, cb, index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not index then exports['qb-core']:ExploitBan(src, 'casino-washer-no-index') end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Cleaning[index].coords) > 10 then exports['qb-core']:ExploitBan(src, 'casino-washer') end

    local citizenid = Player.PlayerData.citizenid
    if CleaningTable[citizenid] then
        cb(CleaningTable[citizenid])
    else
        cb(false)
    end
end)
