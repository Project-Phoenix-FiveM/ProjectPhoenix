local inventories = {
    ['qb-inventory'] = "qb-inventory/html/images/",
    ['lj-inventory'] = "lj-inventory/html/images/",
    ['ox_inventory'] = "ox_inventory/web/images/",
    ['qs-inventory'] = "qs-inventory/html/images/",
}

function GetInventoryPath()
    if inventories[Config.Inventory] then
        return inventories[Config.Inventory]
    end
    return false
end