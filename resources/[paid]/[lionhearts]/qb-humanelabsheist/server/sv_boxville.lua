local attempted = 0
local pickingup = false
local pickup = false

RegisterNetEvent('qb-humanelabsheist:server:UpdatePlates', function(plate)
    Shared.RobbedPlates[plate] = true
    TriggerClientEvent('qb-humanelabsheist:client:UpdatePlates', -1, plate)
end)

RegisterNetEvent('qb-humanelabsheist:server:RemoveSecurityCard', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    exports['qb-inventory']:RemoveItem(src, 'security_card_05', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["security_card_05"], "remove", 1)
end)

RegisterNetEvent('qb-humanelabsheist:server:BoxvilleReward', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local info = {
        label = "Lab Access code: "..accessCodes
    }
    exports['qb-inventory']:AddItem(src, "stickynote", 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["stickynote"], "add", 1)
    
    TriggerEvent("qb-log:server:CreateLog", "humanelabs", "Humanelabs Transport", "green", "**"..Player.PlayerData.name.."** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*)"..' has gotten the access codes from a transport truck.')
end)

QBCore.Functions.CreateUseableItem("security_card_05", function(source, item)
    TriggerClientEvent("qb-humanelabsheist:client:UseBlueCard", source)
end)
