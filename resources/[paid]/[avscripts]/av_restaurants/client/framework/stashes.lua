AddEventHandler('av_restaurant:stash', function(data)
    if Config.Framework == 'QBCore' then
        if Config.Inventory == "ox_inventory" then
            if exports.ox_inventory:openInventory('stash', data['zoneName']) == false then
				TriggerServerEvent('ox:loadStashes')
				exports.ox_inventory:openInventory('stash', data['zoneName'])
			end
        else
            TriggerEvent("inventory:client:SetCurrentStash", data['zoneName'])
            TriggerServerEvent("inventory:server:OpenInventory", "stash", data['zoneName'], {
                maxweight = Config.StashWeight,
                slots = Config.StashSlots,
            })
        end
    elseif Config.Framework == 'ESX' then
        if Config.Inventory == 'ox_inventory' then
			if exports.ox_inventory:openInventory('stash', data['zoneName']) == false then
				TriggerServerEvent('ox:loadStashes')
				exports.ox_inventory:openInventory('stash', data['zoneName'])
			end
		elseif Config.Inventory == 'mf-inventory' then
			exports["mf-inventory"]:openOtherInventory(data['zoneName'])
        elseif Config.Inventory == 'qs-inventory' then
            local other = {}
            other.maxweight = Config.StashWeight
            other.slots = Config.StashSlots
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_"..data['zoneName'], other)
            TriggerEvent("inventory:client:SetCurrentStash", "Stash_"..data['zoneName'])
		end
    end
end)

AddEventHandler('av_restaurant:tray', function(data)
    if Config.Framework == 'QBCore' then
        if Config.Inventory == "ox_inventory" then
            if exports.ox_inventory:openInventory('stash', data['zoneName']) == false then
				TriggerServerEvent('ox:loadStashes')
				exports.ox_inventory:openInventory('stash', data['zoneName'])
			end
        else
            TriggerEvent("inventory:client:SetCurrentStash", data['zoneName'])
            TriggerServerEvent("inventory:server:OpenInventory", "stash", data['zoneName'], {
                maxweight = Config.TrayWeight,
                slots = Config.TraySlots,
            })
        end
    elseif Config.Framework == 'ESX' then
		if Config.Inventory == 'ox_inventory' then
			if exports.ox_inventory:openInventory('stash', data['zoneName']) == false then
				TriggerServerEvent('ox:loadStashes')
				exports.ox_inventory:openInventory('stash', data['zoneName'])
			end
		elseif Config.Inventory == 'mf-inventory' then
			exports["mf-inventory"]:openOtherInventory(data['zoneName'])
        elseif Config.Inventory == 'qs-inventory' then
            local other = {}
            other.maxweight = Config.TrayWeight
            other.slots = Config.TraySlots
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_"..data['zoneName'], other)
            TriggerEvent("inventory:client:SetCurrentStash", "Stash_"..data['zoneName'])
		end
    end
end)