local keycardCode = nil
local varAttempt = 0
local varMax = 5
usbs = {}

usbLocations = {
    vector3(955.691, 72.608, 112.599),
    vector3(944.615, 29.863, 112.020),
    vector3(965.118, 47.879, 71.232),
    vector3(992.212, 28.232, 71.288),
    vector3(997.971, 32.611, 70.466),
    vector3(1001.469, 27.001, 70.505),
    vector3(992.366, -0.9958, 70.466),
    vector3(1002.716, -9.133, 70.466),
    vector3(1003.430, -11.004, 70.466),
    vector3(1025.062, -4.757, 70.466),
    vector3(1031.964, 6.4511, 70.466)
}

--- Method to generate a random 8 character password using numbers and letters
--- @return string string - Password string
local RandomPassword = function()
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local string = ""
    for i=1, 8 do
        local rand = math.random(#charset)
        string = string .. string.sub(charset, rand, rand)
    end
    return string
end

RegisterNetEvent('qb-casinoheist:server:CompleteVarHack', function(success)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - vector3(1016.82, 9.78, 71.47)) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-varhack') end

    if success then
        Shared.MagnetsEnabled = true
        TriggerClientEvent('qb-casinoheist:client:MagnetsEnabled', -1, true)
        local message = GenerateMagnetString(magnetOrder)
        TriggerClientEvent('var-ui:on', src, message)
        print("^3[qb-casinoheist] ^5Enabled Magnets^7")
    else
        varAttempt += 1
    end
end)

RegisterNetEvent('qb-casinoheist:server:SetMagnetBusy', function(index, state)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(state) ~= 'boolean' or type(index) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-magnet') return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Magnets[index].coords) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-magnet') return end

    Shared.Magnets[index].busy = state
    TriggerClientEvent('qb-casinoheist:client:SetMagnetBusy', -1, index, state)
end)

RegisterNetEvent('qb-casinoheist:server:MagnetHit', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(index) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-magnethit') return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Magnets[index].coords) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-magnethit') return end

    magnetHit[#magnetHit+1] = index
    CheckMagnets()
end)

RegisterNetEvent('qb-casinoheist:server:GrabUSB', function(netId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(netId) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-grabusb') return end

    local usb = NetworkGetEntityFromNetworkId(netId)
    if usb == usbs[1] then
        DeleteEntity(usb)
        usbs[1] = nil
        Player.Functions.AddItem('casino_usb1', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_usb1'], 'add', 1)
    elseif usb == usbs[2] then
        DeleteEntity(usb)
        usbs[2] = nil
        Player.Functions.AddItem('casino_usb2', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_usb2'], 'add', 1)
    end
end)

RegisterNetEvent('qb-casinoheist:server:ManagementComputer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - vector3(997.75, 53.92, 75.07)) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-mgmt') end

    local item = Player.Functions.GetItemByName('casino_usb1')
    if item then
        Player.Functions.RemoveItem(item.name, 1, item.slot)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'remove', 1)
        
        local info = {code = string.sub(keycardCode, 1, #keycardCode/2)}
        Player.Functions.AddItem('casino_accesscode1', 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_accesscode1'], 'add', 1)
        print("^3[qb-casinoheist] ^5Management Computer Hit^7")
    end
end)

RegisterNetEvent('qb-casinoheist:server:SecretaryComputer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - vector3(1006.69, 60.14, 75.07)) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-secr') end

    local item = Player.Functions.GetItemByName('casino_usb2')
    if item then
        Player.Functions.RemoveItem(item.name, 1, item.slot)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], 'remove', 1)
        
        local info = {code = string.sub(keycardCode, #keycardCode/2+1, #keycardCode)}
        Player.Functions.AddItem('casino_accesscode2', 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_accesscode2'], 'add', 1)
        print("^3[qb-casinoheist] ^5Secretary Computer Hit^7")
    end
end)

RegisterNetEvent('qb-casinoheist:server:GrabKeyCard', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Shared.KeycardTaken then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - vector3(1003.21, 7.52, 71.47)) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-keycard') end

    Shared.KeycardTaken = true
    TriggerClientEvent('qb-casinoheist:client:KeycardTaken', -1, true)
    Player.Functions.AddItem('casino_keycard', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_keycard'], 'add', 1)
    print("^3[qb-casinoheist] ^5Keycard Grabbed^7")
end)

RegisterNetEvent('qb-casinoheist:server:SetLadderActive', function(state)
    Shared.SetLadder = state
    print("^3[qb-casinoheist] ^5Elevator Shaft Ladder Enabled^7")
    TriggerClientEvent('qb-casinoheist:client:SetLadderActive', -1, state)
end)

QBCore.Functions.CreateCallback('qb-casinoheist:server:CanVarHack', function(source, cb)
    if varAttempt < varMax then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-casinoheist:server:KeycardCode', function(source, cb, input)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - vector3(1005.13, 8.81, 71.47)) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-keycardcode') end

    if input == keycardCode then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateUseableItem("casino_magnet", function(source, item)
    local src = source
    TriggerClientEvent('qb-casinoheist:client:UseMagnets', src)
end)

QBCore.Functions.CreateUseableItem("casino_keycard", function(source, item)
    local src = source
    if #(GetEntityCoords(GetPlayerPed(src)) - vector3(1011.7, 39.32, 75.06)) < 3 then
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-restrkeycard', false, false, false, true, false, true, src)
    end
end)

CreateThread(function()
    keycardCode = RandomPassword()
    print("^3[qb-casinoheist] ^5Keycard Code: "..keycardCode.."^7")
    
    magnetOrder = GenerateMagnets()
    print("^3[qb-casinoheist] ^5Magnets Order: "..GenerateMagnetString(magnetOrder).."^7")
end)
