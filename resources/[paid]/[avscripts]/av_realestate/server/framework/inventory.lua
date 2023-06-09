AddEventHandler('onServerResourceStart', function(resourceName)
    if Config.Inventory == "ox_inventory" then
        if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
            local data = MySQL.query.await('SELECT * FROM av_realestate', {})
            for k, v in pairs(data) do
                local inventory = json.decode(v['inventory'])
                exports.ox_inventory:RegisterStash(v['identifier'], v['identifier'], inventory['slots'], inventory['weight'])
            end
        end
    end
end)

lib.callback.register('av_realestate:getInventory', function(source,identifier)
    local inventory = nil
    local res = MySQL.single.await('SELECT * FROM av_realestate WHERE identifier = ?', {identifier})
    if res and res['inventory'] then
        inventory = json.decode(res['inventory'])
    end
    return inventory
end)