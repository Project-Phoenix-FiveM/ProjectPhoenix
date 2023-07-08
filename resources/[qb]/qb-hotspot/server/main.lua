local QBCore = exports[Config.Core]:GetCoreObject()

local cart = {}

local function getItemInfo(item)
    local items = exports['qb-phone']:milkroadItems()

    for _, v in pairs(items) do
        if v.item == item then
            return v.info
        end
    end
end

local function removeFromCart(cid)
    local currentCart = {}
    
    for k, v in pairs(cart) do
        if v.cid ~= cid then
            currentCart[#currentCart+1] = cart[k]
        end
    end

    cart = currentCart
end

RegisterNetEvent('qb-hotspot:server:purchaseMilkroadItems', function(data)
    if not data.item or not data.crypto or not data.amount then return end

    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local cid = Player.PlayerData.citizenid

    local paid = exports['qb-phone']:RemoveCrypto(src, data.crypto, data.amount)
    if not paid then return TriggerClientEvent('qb-phone:client:CustomNotification', src, "WALLET", "Not enough crypto in your wallet", "fas fa-chart-line", "#D3B300", 7500) end
    
    cart[#cart+1] = {
        cid = cid,
        item = data.item,
    }

    TriggerClientEvent('QBCore:Notify', src, 'Item purchased', 'primary')
    TriggerClientEvent('qb-hotspot:client:createPickupZone', src)
end)

RegisterNetEvent('qb-hotspot:server:getItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local cid = Player.PlayerData.citizenid

    for _, v in pairs(cart) do
        if v.cid == cid then
            local info = getItemInfo(v.item)
            Player.Functions.AddItem(v.item, 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.item], 'add')
        end
    end

    removeFromCart(cid)
    TriggerClientEvent('qb-hotspot:client:removeHotspotBlip', src)
end)