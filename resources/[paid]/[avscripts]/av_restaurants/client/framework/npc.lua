CreateThread(function()
	local shop = AddBlipForCoord(Config.NPCSpawn[1], Config.NPCSpawn[2], Config.NPCSpawn[3])
    SetBlipSprite(shop, Config.BlipIcon)
    SetBlipScale(shop, Config.BlipScale)
    SetBlipDisplay(shop, 4)
    SetBlipColour(shop, Config.BlipColor)
    SetBlipAsShortRange(shop, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Lang['blip_text'])
    EndTextCommandSetBlipName(shop)
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())
		local npcCoords = #(playerCoords - vector3(Config.NPCSpawn[1],Config.NPCSpawn[2],Config.NPCSpawn[3]))
		if npcCoords < 50 and not ShopNPC then
			ShopNPC = SpawnPed()
			exports[Config.TargetSystem]:AddTargetEntity(ShopNPC, {
				options = {
					{
						type = "client",
						event = "av_restaurants:shop",
						icon = "fas fa-comment",
						label = Lang['talk_npc'],
					},
				},
				distance = 2.5
			})
		end
		if npcCoords >= 51 and ShopNPC then
			for i = 255, 0, -51 do
				Citizen.Wait(50)
				SetEntityAlpha(ShopNPC, i, false)
			end
			SetEntityAsNoLongerNeeded(ShopNPC)
        	exports[Config.TargetSystem]:RemoveTargetEntity(ShopNPC, Lang['talk_npc'])
			DeletePed(ShopNPC)
			ShopNPC = nil
		end
		Wait(1000)
	end
end)

AddEventHandler('av_restaurants:shop', function()
    local options = {}
    for k, v in pairs(Config.ShopItems) do
        options[#options+1] = {
            title = 'x'..Config.IngredientsPerPurchase..' '..v['label'],
            description = "Price: $"..v['price'],
            serverEvent = "av_restaurants:buyIngredients",
            args = {
                item = k, 
                amount = Config.IngredientsPerPurchase, 
                price = v['price']
            }
        }
    end
    lib.registerContext({
        id = 'ingredients_shop',
        title = 'Ingredients',
        options = options
    })
    lib.showContext('ingredients_shop')
end)

function SpawnPed()
    lib.requestModel(Config.PedModel)
	spawnedPed = CreatePed(4, Config.PedModel, Config.NPCSpawn[1], Config.NPCSpawn[2], Config.NPCSpawn[3], Config.NPCSpawn[4], false, true)
	SetEntityAlpha(spawnedPed, 0, false)
	FreezeEntityPosition(spawnedPed, true)
	SetEntityInvincible(spawnedPed, true)
	SetBlockingOfNonTemporaryEvents(spawnedPed, true)
	for i = 0, 255, 51 do
        Citizen.Wait(50)
        SetEntityAlpha(spawnedPed, i, false)
    end
	SetModelAsNoLongerNeeded(Config.PedModel)
	return spawnedPed
end