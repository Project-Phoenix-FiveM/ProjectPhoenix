QBCore = exports['qb-core']:GetCoreObject()

local copsCalled = false

accessCodes = nil

-- Events

RegisterNetEvent('qb-humanelabsheist:server:BuyPurpleLaptop', function()
    local src = source

    local coords = GetEntityCoords(GetPlayerPed(src))
    if #(coords - Shared.Laptop.xyz) > 5 then
        exports['qb-core']:CheatingBan(src, "humanelabs-purple-laptop")
        return 
    end

    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local item = "usb_purple"
    local laptop = "laptop_purple"
    local info = {
        uses = 3
    }

    if exports['qb-inventory']:GetItemByName(src, item) then
        if Player.PlayerData.money.crypto >= Shared.LaptopPrice then
            -- Remove USB
            exports['qb-inventory']:RemoveItem(src, item, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", 1)

            -- Remove Crypto
            --exports['qb-inventory']:RemoveItem(src, 'crypto', Shared.LaptopPrice)
            exports['qb-phone']:RemoveCrypto(src, 'gne', 30)
            Wait(250)

            -- Give Item
            exports['qb-inventory']:AddItem(src, laptop, 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[laptop], "add", 1)

            -- Notify + log
            TriggerEvent("qb-log:server:CreateLog", "humanelabs", "Purchased Laptop", "pink", "**".. Player.PlayerData.name .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) purchased one "..laptop.." from "..Shared.PedName.." for "..Shared.LaptopPrice.." QBit")
            TriggerClientEvent('QBCore:Notify', src, "You purchased a laptop from "..Shared.PedName.." for "..Shared.LaptopPrice.." QBit", "success", 2500)
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough QBit", "error", 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have anything to offer", "error", 2500)
    end
end)

RegisterNetEvent('qb-humanelabsheist:server:RemoveExplosive', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    exports['qb-inventory']:RemoveItem(src, 'explosive', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["explosive"], "remove", 1)
end)

RegisterNetEvent('qb-humanelabsheist:server:ExplosiveHit', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local coords = GetEntityCoords(GetPlayerPed(src))
    if #(coords - Shared.Explosive.coords) > 50 then
        exports['qb-core']:CheatingBan(src, "humanelabs-explosive")
        return 
    end

    if Shared.Explosive.hit then return end
    print("^3[qb-humanelabsheist] ^5"..Player.PlayerData.name.." ("..src..") Explosive hit^7")
    TriggerEvent("qb-log:server:CreateLog", "humanelabs", "Explosives", "black", "**"..Player.PlayerData.name.."** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*)"..' has blasted the backdoor open.')
    Shared.Explosive.hit = true
    TriggerClientEvent('qb-humanelabsheist:client:ExplosiveHit', -1)
        
    -- Spawn Vehicles
    CreateVehicle("baller6", 3619.23, 3735.03, 28.69, 323.74, true, false)
    CreateVehicle("schafter6", 3612.21, 3739.04, 28.69, 316.24, true, false)
    print('^3[qb-humanelabsheist] ^5Spawn Vehicles^7')
end)

RegisterNetEvent('qb-humanelabsheist:server:RemoveCopperWires', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    exports['qb-inventory']:RemoveItem(src, 'copper_wires', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["copper_wires"], "remove", 1)
end)

RegisterNetEvent('qb-humanelabsheist:server:RemoveThermite', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    exports['qb-inventory']:RemoveItem(src, 'thermite', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["thermite"], "remove", 1)
end)

RegisterNetEvent('qb-humanelabsheist:server:ToggleWires', function(index)
    local src = source

    local coords = GetEntityCoords(GetPlayerPed(src))
    if #(coords - Shared.Wiring[index].coords.xyz) > 50 then
        exports['qb-core']:CheatingBan(src, "humanelabs-togglewires")
        return 
    end

    print("^3[qb-humanelabsheist] ^5"..GetPlayerName(src).." Toggled Wires "..index.."^7")
    Shared.Wiring[index].thermited = not Shared.Wiring[index].thermited
    TriggerClientEvent('qb-humanelabsheist:client:ToggleWires', -1, index, Shared.Wiring[index].thermited)
end)

RegisterNetEvent('qb-humanelabsheist:server:ThermitePtfx', function(coords)
    TriggerClientEvent('qb-humanelabsheist:client:ThermitePtfx', -1, coords)
end)

RegisterNetEvent('qb-humanelabsheist:server:CopsCalled', function()
    copsCalled = true
end)

-- Callbacks

QBCore.Functions.CreateCallback('qb-humanelabsheist:server:GetShared', function(source, cb)
    cb(Shared)
end)

QBCore.Functions.CreateCallback('qb-humanelabsheist:server:IsCopsCalled', function(source, cb)
    cb(copsCalled)
end)

QBCore.Functions.CreateCallback('qb-humanelabsheist:server:getCops', function(source, cb)
	local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

QBCore.Functions.CreateCallback('qb-humanelabsheist:server:SpawnNPC', function(source, cb)
    local netIds = {}
    local netId
    local playerPed = GetPlayerPed(source)

    local coords = GetEntityCoords(playerPed)
    if #(coords - Shared.Explosive.coords) > 50 then
        exports['qb-core']:CheatingBan(src, "humanelabs-spawnnpc")
        return 
    end

    local guard1 = CreatePed(30, `s_m_m_armoured_01`, 3524.16, 3682.46, 20.99, 8.76, true, false)
    GiveWeaponToPed(guard1, `WEAPON_CARBINERIFLE`, 250, false, true)
    TaskCombatPed(guard1, playerPed, 0, 16)
    SetPedArmour(guard1, 200)
    while not DoesEntityExist(guard1) do Wait(0) end
    netId = NetworkGetNetworkIdFromEntity(guard1)
    netIds[#netIds+1] = netId
    ------------------------
    local guard2 = CreatePed(30, `s_m_m_armoured_01`, 3521.83, 3682.21, 20.99, 5.09, true, false)
    GiveWeaponToPed(guard2, `WEAPON_CARBINERIFLE`, 250, false, true)
    TaskCombatPed(guard2, playerPed, 0, 16)
    SetPedArmour(guard2, 200)
    while not DoesEntityExist(guard2) do Wait(0) end
    netId = NetworkGetNetworkIdFromEntity(guard2)
    netIds[#netIds+1] = netId
    ------------------------
    local guard3 = CreatePed(30, `s_m_m_armoured_01`, 3526.37, 3673.01, 20.99, 251.18, true, false)
    GiveWeaponToPed(guard3, `WEAPON_CARBINERIFLE`, 250, false, true)
    TaskCombatPed(guard3, playerPed, 0, 16)
    SetPedArmour(guard3, 200)
    while not DoesEntityExist(guard3) do Wait(0) end
    netId = NetworkGetNetworkIdFromEntity(guard3)
    netIds[#netIds+1] = netId
    ------------------------
    local guard4 = CreatePed(30, `s_m_m_armoured_01`, 3532.96, 3673.03, 20.99, 96.77, true, false)
    GiveWeaponToPed(guard4, `WEAPON_CARBINERIFLE`, 250, false, true)
    TaskCombatPed(guard4, playerPed, 0, 16)
    SetPedArmour(guard4, 200)
    while not DoesEntityExist(guard4) do Wait(0) end
    netId = NetworkGetNetworkIdFromEntity(guard4)
    netIds[#netIds+1] = netId
    ------------------------
    cb(netIds)

    print('^3[qb-humanelabsheist] ^5Spawn Guards^7')
end)

QBCore.Functions.CreateUseableItem("explosive", function(source, item)
    local src = source
    TriggerClientEvent("explosive:UseExplosive", src)
end)

-- Threads

CreateThread(function() -- Fetch access codes upon server start
    accessCodes = MySQL.scalar.await("SELECT config FROM configs WHERE name = 'humanelabs'", {})
    print("^3[qb-humanelabsheist] ^5Access Code: "..accessCodes.."^7")
end)
