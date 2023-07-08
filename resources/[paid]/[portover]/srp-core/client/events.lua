-- SRPCore Command Events
--local localMes = true

RegisterNetEvent('SRPCore:Command:TeleportToPlayer')
AddEventHandler('SRPCore:Command:TeleportToPlayer', function(coords)
	local ped = PlayerPedId()
    SetPedCoordsKeepVehicle(ped, coords.x, coords.y, coords.z)
end)

RegisterNetEvent('SRPCore:Command:TeleportToCoords')
AddEventHandler('SRPCore:Command:TeleportToCoords', function(x, y, z)
	local entity = PlayerPedId()
	if IsPedInAnyVehicle(entity, false) then
		entity = GetVehiclePedIsUsing(entity)
	end
	SetEntityCoords(entity, x, y, z)
end)

RegisterNetEvent('SRPCore:Command:SetNewWaypoint')
AddEventHandler('SRPCore:Command:SetNewWaypoint', function(x, y)
	SetNewWaypoint(x,y)
end)

RegisterNetEvent('SRPCore:Command:SpawnVehicle')
AddEventHandler('SRPCore:Command:SpawnVehicle', function(model)
	SRPCore.Functions.SpawnVehicle(model, function(vehicle)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
	end)
end)

RegisterNetEvent('SRPCore:Command:DeleteVehicle')
AddEventHandler('SRPCore:Command:DeleteVehicle', function()
	local vehicle = SRPCore.Functions.GetClosestVehicle()
	if IsPedInAnyVehicle(PlayerPedId()) then vehicle = GetVehiclePedIsIn(PlayerPedId(), false) else vehicle = SRPCore.Functions.GetClosestVehicle() end
	SRPCore.Functions.DeleteVehicle(vehicle)
end)

RegisterNetEvent('SRPCore:Command:AdvancedDeleteVehicle')
AddEventHandler('SRPCore:Command:AdvancedDeleteVehicle', function()
	local ped = PlayerPedId()
	local entity = nil
	if (IsPedSittingInAnyVehicle(ped)) then
		entity = GetVehiclePedIsIn(ped, false)
	else
		entity = SRPCore.Functions.GetClosestVehicle()
	end

	if IsEntityAMissionEntity(entity) then
		Citizen.Trace("BEFORE: Entity IS a mission entity")
	else
		Citizen.Trace("BEFORE: Entity IS NOT a mission entity")
	end


	NetworkRequestControlOfEntity(entity)

	local timeout = 2000
	while timeout > 0 and not NetworkHasControlOfEntity(entity) do
		Wait(100)
		timeout = timeout - 100
	end

	SetEntityAsMissionEntity(entity, true, true)

	local timeout = 2000
	while timeout > 0 and not IsEntityAMissionEntity(entity) do
		Wait(100)
		timeout = timeout - 100
	end

	if IsEntityAMissionEntity(entity) then
		Citizen.Trace("Entity IS a mission entity")
	else
		Citizen.Trace("Entity IS NOT a mission entity")
	end

	Citizen.Trace("Owner of entity: "..GetPlayerServerId(NetworkGetEntityOwner(entity)))
	Citizen.Trace("NETID of entity: "..NetworkGetNetworkIdFromEntity(entity))

	if NetworkHasControlOfEntity(entity) then
		Citizen.Trace("Entity IS in my control")
	else
		Citizen.Trace("Entity IS NOT in my control")
	end

	Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )

	if ( DoesEntityExist( entity ) ) then
		Citizen.Trace("Entity FAILED to delete! If you see this please contact a developer!")
		SRPCore.Functions.Notify('Can\'t delete the vehicle!')
		DeleteEntity(entity)
		if ( DoesEntityExist( entity ) ) then
			Citizen.Trace("Entity FAILED to delete on attempt 2! If you see this please contact a developer!")
			SRPCore.Functions.Notify('Can\'t delete the vehicle!')
			return false
		else
			SRPCore.Functions.Notify('Vehicle was deleted!')
			return true
		end
	else
		SRPCore.Functions.Notify('Vehicle was deleted!')
		return true
	end
end)

RegisterNetEvent('SRPCore:Command:Revive')
AddEventHandler('SRPCore:Command:Revive', function()
	local coords = SRPCore.Functions.GetCoords(PlayerPedId())
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z+0.2, coords.a, true, false)
	SetPlayerInvincible(PlayerPedId(), false)
	ClearPedBloodDamage(PlayerPedId())
end)

RegisterNetEvent('SRPCore:Command:GoToMarker')
AddEventHandler('SRPCore:Command:GoToMarker', function()
	Citizen.CreateThread(function()
		local entity = PlayerPedId()
		if IsPedInAnyVehicle(entity, false) then
			entity = GetVehiclePedIsUsing(entity)
		end
		local success = false
		local blipFound = false
		local blipIterator = GetBlipInfoIdIterator()
		local blip = GetFirstBlipInfoId(8)

		while DoesBlipExist(blip) do
			if GetBlipInfoIdType(blip) == 4 then
				cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) --GetBlipInfoIdCoord(blip)
				blipFound = true
				break
			end
			blip = GetNextBlipInfoId(blipIterator)
		end

		if blipFound then
			DoScreenFadeOut(250)
			while IsScreenFadedOut() do
				Citizen.Wait(250)
			end
			local groundFound = false
			local yaw = GetEntityHeading(entity)
			
			for i = 0, 1000, 1 do
				SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
				SetEntityRotation(entity, 0, 0, 0, 0 ,0)
				SetEntityHeading(entity, yaw)
				SetGameplayCamRelativeHeading(0)
				Citizen.Wait(0)
				--groundFound = true
				if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then --GetGroundZFor3dCoord(cx, cy, i, 0, 0) GetGroundZFor_3dCoord(cx, cy, i)
					cz = ToFloat(i)
					groundFound = true
					break
				end
			end
			if not groundFound then
				cz = -300.0
			end
			success = true
		end

		if success then
			SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
			SetGameplayCamRelativeHeading(0)
			if IsPedSittingInAnyVehicle(PlayerPedId()) then
				if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
					SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
				end
			end
			--HideLoadingPromt()
			DoScreenFadeIn(250)
		end
	end)
end)

-- Other stuff
RegisterNetEvent('SRPCore:Player:SetPlayerData')
AddEventHandler('SRPCore:Player:SetPlayerData', function(val)
	SRPCore.PlayerData = val
end)

RegisterNetEvent('SRPCore:Player:UpdatePlayerData')
AddEventHandler('SRPCore:Player:UpdatePlayerData', function(data)
	local data = data or {}

	data.position = SRPCore.Functions.GetCoords(PlayerPedId())
	TriggerServerEvent('SRPCore:UpdatePlayer', data)
end)

RegisterNetEvent('SRPCore:Player:UpdatePlayerPosition')
AddEventHandler('SRPCore:Player:UpdatePlayerPosition', function()
	local position = SRPCore.Functions.GetCoords(PlayerPedId())
	TriggerServerEvent('SRPCore:UpdatePlayerPosition', position)
end)

-- RegisterNetEvent('SRPCore:Client:LocalOutOfCharacter')
-- AddEventHandler('SRPCore:Client:LocalOutOfCharacter', function(playerId, playerName, message)
-- 	local sourcePos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerId)), false)
--     local pos = GetEntityCoords(PlayerPedId(), false)
--     if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, sourcePos.x, sourcePos.y, sourcePos.z, true) < 20.0) then
-- 		TriggerEvent("chatMessage", "OOC " .. playerName, "normal", message)
--     end
-- end)

-- RegisterNetEvent('SRPCore:Client:LocalMeSet')
-- AddEventHandler('SRPCore:Client:LocalMeSet', function(playerId, playerName, message)
-- 	localMes = not localMes
--
-- 	if localMes then
-- 		SRPCore.Functions.Notify('/me\'s on chat [ON]')
-- 	else
-- 		SRPCore.Functions.Notify('/me\'s on chat [OFF]')
-- 	end
-- end)

-- RegisterNetEvent('SRPCore:Client:LocalMe')
-- AddEventHandler('SRPCore:Client:LocalMe', function(playerId, playerName, message)
-- 	local sourcePos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerId)), false)
--     local pos = GetEntityCoords(PlayerPedId(), false)
--     if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, sourcePos.x, sourcePos.y, sourcePos.z, true) < 10.0) then
-- 		if localMes then
-- 			TriggerEvent("chatMessage", playerName, "warning", message)
-- 		end
--     end
-- end)

RegisterNetEvent('SRPCore:Notify')
AddEventHandler('SRPCore:Notify', function(text, type, length)
	SRPCore.Functions.Notify(text, type, length)
end)

RegisterNetEvent('SRPCore:Client:TriggerCallback')
AddEventHandler('SRPCore:Client:TriggerCallback', function(name, ...)
	if SRPCore.ServerCallbacks[name] ~= nil then
		SRPCore.ServerCallbacks[name](...)
		SRPCore.ServerCallbacks[name] = nil
	end
end)

RegisterNetEvent("SRPCore:Client:UseItem")
AddEventHandler('SRPCore:Client:UseItem', function(item)
	TriggerServerEvent("SRPCore:Server:UseItem", item)
end)


-- Me command

local function Draw3DText(coords, str)
    local onScreen, worldX, worldY = World3dToScreen2d(coords.x, coords.y, coords.z+1)
	local camCoords = GetGameplayCamCoord()
	local scale = 200 / (GetGameplayCamFov() * #(camCoords - coords))

    if onScreen then
        SetTextScale(1.0, 0.5 * scale)
        SetTextFont(4)
        SetTextColour(255, 255, 255, 255)
        SetTextEdge(2, 0, 0, 0, 150)
		SetTextProportional(1)
		SetTextOutline()
		SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(str)
        DrawText(worldX, worldY)
    end
end

RegisterNetEvent('SRPCore:Command:ShowMe3D', function(senderId, msg)
    local sender = GetPlayerFromServerId(senderId)

    CreateThread(function()
        local displayTime = 5000 + GetGameTimer()

        while displayTime > GetGameTimer() do
            local targetPed = GetPlayerPed(sender)
            local tCoords = GetEntityCoords(targetPed)

            Draw3DText(tCoords, msg)
            Wait(0)
        end
    end)
end)