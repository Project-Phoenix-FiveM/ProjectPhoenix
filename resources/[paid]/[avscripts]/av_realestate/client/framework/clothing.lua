local clothingEvents = {
	['qb-clothing'] = function()
		return TriggerEvent('qb-clothing:client:openOutfitMenu')
	end,
	['fivem-appearance'] = function()
		return exports['fivem-appearance']:startPlayerCustomization()
	end,
	['illenium-appearance'] = function()
		return TriggerEvent('illenium-appearance:client:openOutfitMenu')
	end,
	['esx_skin'] = function()
		TriggerEvent('esx_skin:openSaveableMenu')
	end,
}

RegisterNetEvent('av_realestate:openClothing', function()
    -- Here you can trigger your clothing script menu to show player outfits
    -- Ask the author of your clothing script how to open the outfits menu.
    if clothingEvents[Config.ClothingScript] then
        clothingEvents[Config.ClothingScript]()
    else
        -- Add your custom event here:

    end
end)