local ShopNPC = nil

CreateThread(function()
	local closeToNPC = false
	while true do
		local inZone = false
		local playerCoords = GetEntityCoords(PlayerPedId())
		for i=1, #Gangs.NPC do
			local npcCoords = #(playerCoords - vector3(Gangs.NPC[i]['coords'][1],Gangs.NPC[i]['coords'][2], Gangs.NPC[i]['coords'][3]))
			if npcCoords < 50 then
				inZone = true
				if not ShopNPC then
					ShopNPC = SpawnPed(Gangs.NPC[i]['model'],Gangs.NPC[i]['coords'])
					exports[Gangs.TargetSystem]:AddTargetEntity(ShopNPC, {
						options = {
							{
								type = "client",
								event = "av_gangs:shop",
								icon = "fas fa-comment",
								label = Lang['talk_npc'],
							},
						},
						distance = 2.5
					})
				end
			end
			if inZone and not closeToNPC then
				closeToNPC = true
			end
		end
		if not inZone and closeToNPC then
			closeToNPC = false
			if ShopNPC then
				for i = 255, 0, -51 do
					Citizen.Wait(50)
					SetEntityAlpha(ShopNPC, i, false)
				end
				SetEntityAsNoLongerNeeded(ShopNPC)
				exports[Gangs.TargetSystem]:RemoveTargetEntity(ShopNPC, Lang['talk_npc'])
				DeletePed(ShopNPC)
				ShopNPC = nil
			end
		end
		Wait(1000)
	end
end)

function SpawnPed(model,coords)
    lib.requestModel(model)
	spawnedPed = CreatePed(4, model, coords[1], coords[2], coords[3], coords[4], false, true)
	SetEntityAlpha(spawnedPed, 0, false)
	FreezeEntityPosition(spawnedPed, true)
	SetEntityInvincible(spawnedPed, true)
	SetBlockingOfNonTemporaryEvents(spawnedPed, true)
	for i = 0, 255, 51 do
        Citizen.Wait(50)
        SetEntityAlpha(spawnedPed, i, false)
    end
	SetModelAsNoLongerNeeded(model)
	return spawnedPed
end