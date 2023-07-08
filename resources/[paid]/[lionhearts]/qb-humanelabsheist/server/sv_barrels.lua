local barrelsTaken = 0
local maxBarrels = 120 -- Maximum amount of barrels that can be taken

RegisterNetEvent("qb-humanelabsheist:server:GrabBarrel", function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local coords = GetEntityCoords(GetPlayerPed(src))
    if #(coords - vector3(3628.1, 3736.73, 28.69)) > 5 then
        exports['qb-core']:CheatingBan(src, "humanelabs-barrels")
    end

    if not Shared.Explosive.hit then return end

    if barrelsTaken <= maxBarrels then
        if Player then
            if item == "ecgonine" or item == "methylamine" then
                if exports['qb-inventory']:AddItem(src, item, 1, false) then
                    barrelsTaken += 1
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", 1)
                    TriggerEvent("qb-log:server:CreateLog", "humanelabs", "Barrel Reward", "red", "**".. Player.PlayerData.name .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*)"..' has received 1x '..item)
                else
                    TriggerClientEvent('QBCore:Notify', src, "Your inventory is full..", "error", 3000)
                end
            else
                exports['qb-core']:CheatingBan(src, "humanelabs-invalid-barrel")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "There are no more barrels left..", "error", 3000)
    end
end)

RegisterNetEvent('qb-humanelabsheist:server:LaptopDamage', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local item = exports['qb-inventory']:GetItemByName(src, 'laptop_purple')
    if not item then return end
    
    if not item.info.uses then
        print('^3[qb-humanelabsheist] ^5'..Player.PlayerData.name..' has a '..item.name..' without info.uses! ^7')
        Player.PlayerData.items[item.slot].info.uses = 2
        exports['qb-inventory']:SetInventory(src, Player.PlayerData.items)
        return
    end

    if (Player.PlayerData.items[item.slot].info.uses - 1) <= 0 then
        exports['qb-inventory']:RemoveItem(src, item.name, 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item.name], "remove", 1)
        TriggerEvent('qb-log:server:CreateLog', 'humanelabs', 'Removed Purple Laptop', 'default', '**'..Player.PlayerData.name..'** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) removed: **Purple Laptop**')
        print('^3[qb-humanelabsheist] ^5Removed Purple Laptop from '..Player.PlayerData.name..' (citizenid: '..Player.PlayerData.citizenid..' | id: '..src..')^7')
    else
        Player.PlayerData.items[item.slot].info.uses = (Player.PlayerData.items[item.slot].info.uses - 1)
        exports['qb-inventory']:SetInventory(src, Player.PlayerData.items)
        TriggerEvent('qb-log:server:CreateLog', 'humanelabs', 'Removed Purple Laptop Use', 'default', '**'..Player.PlayerData.name..'** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) Uses: '..Player.PlayerData.items[item.slot].info.uses..'/3')
        print('^3[qb-humanelabsheist] ^5Removed Purple Laptop Use from '..Player.PlayerData.name..' (citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') Uses: '..Player.PlayerData.items[item.slot].info.uses..'/3^7')
    end
end)

RegisterNetEvent('qb-humanelabsheist:server:PDLock', function()
    if not Shared.Explosive.hit then return end
    Shared.Explosive.hit = false
    TriggerClientEvent('qb-humanelabsheist:client:PDLock', -1)
end)

RegisterServerEvent('qb-humanelabsheist:server:GateHack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    if Shared.Gates.hit then return end
    Shared.Gates.hit = true
    TriggerClientEvent('qb-humanelabsheist:client:GateHack', -1)
    
    TriggerEvent("qb-log:server:CreateLog", "humanelabs", "Gate Hack", "blue", "**".. Player.PlayerData.name .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*)"..' has hacked the gates.')
end)

QBCore.Functions.CreateUseableItem("laptop_purple", function(source, item)
    TriggerClientEvent("qb-humanelabsheist:client:UseLaptop", source)
end)
