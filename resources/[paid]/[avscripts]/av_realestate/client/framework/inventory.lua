local inventories = {}

function OpenInventory(name)
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:openInventory('stash', {id = name})
        return
    end
    if not inventories[name] then
        local inventory = lib.callback.await('av_realestate:getInventory', false, name)
        if inventory then
            inventories[name] = inventory
        else
            print("^1[ERROR] This inventory doesn't exist(?)")
            return
        end
    end
    if Config.Inventory == "qb-inventory" or Config.Inventory == "lj-inventory" then
        TriggerEvent("inventory:client:SetCurrentStash", name)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", name, {
            maxweight = inventories[name]['weight'],
            slots = inventories[name]['slots'],
        })
        return
    end
    if Config.Inventory == "qs-inventory" then
        local other = {}
        other.maxweight = inventories[name]['weight']
        other.slots = inventories[name]['slots']
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_"..name, other)
        TriggerEvent("inventory:client:SetCurrentStash", "Stash_"..name)
    end
end