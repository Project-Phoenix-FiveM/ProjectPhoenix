local isSentenced = false
local communityServiceFinished = false
local actionsRemaining = 0
local availableActions = {}
local disable_actions = false
local vassour_net = nil
local spatula_net = nil

local function ApplyServicerSkin()
	if IsPedModel(PlayerPedId(), 'mp_m_freemode_01') then
		SetPedComponentVariation(PlayerPedId(), 1 , Config.Outfits.male.mask.item,Config.Outfits.male.mask.texture) -- Mask
		SetPedComponentVariation(PlayerPedId(), 4, Config.Outfits.male.pants.item,Config.Outfits.male.pants.texture) -- Pants
		SetPedComponentVariation(PlayerPedId(), 8 ,Config.Outfits.male.shirt.item,Config.Outfits.male.shirt.texture) -- Shirt
		SetPedComponentVariation(PlayerPedId(), 11 ,Config.Outfits.male.jacket.item,Config.Outfits.male.jacket.texture) -- Jacket
		SetPedComponentVariation(PlayerPedId(), 3 ,Config.Outfits.male.arms.item,Config.Outfits.male.arms.texture) -- Arms
		SetPedComponentVariation(PlayerPedId(), 6 ,Config.Outfits.male.shoes.item,Config.Outfits.male.shoes.texture) -- Shoes
		SetPedComponentVariation(PlayerPedId(), 7 ,Config.Outfits.male.accessories.item,Config.Outfits.male.accessories.texture) -- Accessory
	elseif IsPedModel(PlayerPedId(), 'mp_f_freemode_01') then
		SetPedComponentVariation(PlayerPedId(), 1 ,Config.Outfits.female.mask.item,Config.Outfits.female.mask.texture) -- Mask
		SetPedComponentVariation(PlayerPedId(), 4 ,Config.Outfits.female.pants.item,Config.Outfits.female.pants.texture) -- Pants
		SetPedComponentVariation(PlayerPedId(), 8 ,Config.Outfits.female.shirt.item,Config.Outfits.female.shirt.texture) -- Shirt
		SetPedComponentVariation(PlayerPedId(), 11 ,Config.Outfits.female.jacket.item,Config.Outfits.female.jacket.texture) -- Jacket
		SetPedComponentVariation(PlayerPedId(), 3 ,Config.Outfits.female.arms.item,Config.Outfits.female.arms.texture) -- Arms
		SetPedComponentVariation(PlayerPedId(), 6 ,Config.Outfits.female.shoes.item,Config.Outfits.female.shoes.texture) -- Shoes
		SetPedComponentVariation(PlayerPedId(), 7 ,Config.Outfits.female.accessories.item,Config.Outfits.female.accessories.texture) -- Accessory
	end
end

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
	TriggerEvent("qb-communityservice:inCommunityService", PlayerData.metadata.communityservice)
end)

function FillActionTable(last_action)
	while #availableActions < 5 do
		local service_does_not_exist = true

		local random_selection = Config.ServiceLocations[math.random(1,#Config.ServiceLocations)]

		for i = 1, #availableActions do
			if random_selection.coords.x == availableActions[i].coords.x and random_selection.coords.y == availableActions[i].coords.y and random_selection.coords.z == availableActions[i].coords.z then
				service_does_not_exist = false
			end
		end

		if last_action ~= nil and random_selection.coords.x == last_action.coords.x and random_selection.coords.y == last_action.coords.y and random_selection.coords.z == last_action.coords.z then
			service_does_not_exist = false
		end

		if service_does_not_exist then
			table.insert(availableActions, random_selection)
		end
	end
end



RegisterNetEvent('qb-communityservice:inCommunityService')
AddEventHandler('qb-communityservice:inCommunityService', function(actions_remaining)
	if isSentenced or actions_remaining == 0 then
		return
	end
	actionsRemaining = tonumber(actions_remaining)
	FillActionTable()	
	if Config.Outfits.enabled then
		ApplyServicerSkin()
	end
	SetEntityCoords(PlayerPedId(), Config.ServiceLocation)
	isSentenced = true
	communityServiceFinished = false

	while actionsRemaining > 0 and not communityServiceFinished do
		local playerPed = PlayerPedId()
		local mesafe = #(GetEntityCoords(playerPed) - Config.ServiceLocation)
		if mesafe > 45 then
			if IsPedInAnyVehicle(playerPed, false) then
				ClearPedTasksImmediately(playerPed)
			end
			SetEntityCoords(playerPed, Config.ServiceLocation)
			TriggerServerEvent('qb-communityservice:extendService')
			actionsRemaining = actionsRemaining + Config.ServiceExtensionOnEscape
			QBCore.Functions.Notify("You can not escape. Your community service has been extended.")
		end
		Citizen.Wait(20000)
	end

	TriggerServerEvent('qb-communityservice:finishCommunityService', QBCore.Key)

	isSentenced = false
end)

RegisterNetEvent('qb-communityservice:finishCommunityService')
AddEventHandler('qb-communityservice:finishCommunityService', function(source)
	communityServiceFinished = true
	isSentenced = false
	actionsRemaining = 0
end)

Citizen.CreateThread(function()
	while true do
		local time = 3000
		if actionsRemaining > 0 and isSentenced then
			time = 1
			draw2dText("~b~" .."You have " ..QBCore.Shared.Round(actionsRemaining).. ' ~b~ ~s~ more actions to complete before you can finish your service.', { 0.70, 0.955 } )
			DrawAvailableActions()
			DisableViolentActions()

			local pCoords = GetEntityCoords(PlayerPedId())

			for i = 1, #availableActions do
				local distance = GetDistanceBetweenCoords(pCoords, availableActions[i].coords, true)

				if distance < 1.5 then
					QBCore.Functions.DrawText3D(pCoords.x,pCoords.y,pCoords.z, "[E] Clear")

					if(IsControlJustReleased(1, 38))then
						tmp_action = availableActions[i]
						RemoveAction(tmp_action)
						FillActionTable(tmp_action)
						disable_actions = true

						TriggerServerEvent('qb-communityservice:completeService', QBCore.Key)
						actionsRemaining = actionsRemaining - 1

						if (tmp_action.type == "cleaning") then
							local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
							local vassouspawn = CreateObject(`prop_tool_broom`, cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
							local netid = ObjToNet(vassouspawn)

							TaskStartScenarioInPlace(PlayerPedId(), "world_human_janitor", 0, false)
								AttachEntityToEntity(vassouspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
								vassour_net = netid

							Citizen.Wait(10000)
							disable_actions = false
							DetachEntity(NetToObj(vassour_net), 1, 1)
							DeleteEntity(NetToObj(vassour_net))
							vassour_net = nil
							ClearPedTasks(PlayerPedId())
						end

						if (tmp_action.type == "gardening") then
							local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
							local spatulaspawn = CreateObject(`bkr_prop_coke_spatula_04`, cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
							local netid = ObjToNet(spatulaspawn)

							TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, false)
							AttachEntityToEntity(spatulaspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,190.0,190.0,-50.0,1,1,0,1,0,1)
							spatula_net = netid

							Citizen.Wait(14000)
							disable_actions = false
							DetachEntity(NetToObj(spatula_net), 1, 1)
							DeleteEntity(NetToObj(spatula_net))
							spatula_net = nil
							ClearPedTasks(PlayerPedId())
						
						end

						if actionsRemaining == 0 then
							QBCore.Functions.Notify("You have completed your community service", "success")
							if propIndex ~= -1 then -- If the ped has a prop
							    ClearPedProp(playerPed, 0) -- Remove the prop
							end
						end

					end
				end
			end
		end
		Citizen.Wait(time)
	end
end)

function RemoveAction(action)
	local action_pos = -1

	for i=1, #availableActions do
		if action.coords.x == availableActions[i].coords.x and action.coords.y == availableActions[i].coords.y and action.coords.z == availableActions[i].coords.z then
			action_pos = i
		end
	end

	if action_pos ~= -1 then
		table.remove(availableActions, action_pos)
	end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawAvailableActions()
	for i = 1, #availableActions do
		DrawMarker(21, availableActions[i].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 50, 50, 204, 100, false, true, 2, true, false, false, false)
	end
end

function DisableViolentActions()
	local playerPed = PlayerPedId()

	if disable_actions == true then
		DisableAllControlActions(0)
	end

	RemoveAllPedWeapons(playerPed, true)

	DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
	DisablePlayerFiring(playerPed,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
    DisableControlAction(0, 106, true) -- Disable in-game mouse controls
    DisableControlAction(0, 140, true)
	DisableControlAction(0, 141, true)
	DisableControlAction(0, 142, true)

	if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
		SetCurrentPedWeapon(playerPed,`WEAPON_UNARMED`,true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
	end

	if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
		SetCurrentPedWeapon(playerPed,`WEAPON_UNARMED`,true) -- If they click it will set them to unarmed
	end
end

function draw2dText(text, pos)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(table.unpack(pos))
end


RegisterCommand("comserv", function()
	if PlayerJob.name == "police" or PlayerJob.name == 'sheriff' then

	local qbinput1 = exports['qb-input']:ShowInput({
		header = "SEND COMMUNITY SERVICE",
		submitText = "Submit",
		inputs = {
            {
                text = "Player ID", 
                name = "id", 
                type = "number",
                isRequired = false, 
            },
            {
                text = "Count", 
                name = "kamu", 
                type = "number",
                isRequired = false, 
            },

			
			
		}
	})


 result = {
	id = 1,
	kamu = 1
  }

  if qbinput1.id == nil and qbinput1.kamu then
  else
	result.id =  qbinput1.id
	result.kamu = qbinput1.kamu
 
   print(json.encode(result))
 
	 TriggerServerEvent('sendserverdatass', result)
  end
end
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


AddEventHandler("onResourceStart", function(JobInfo)
    PlayerJob = QBCore.Functions.GetPlayerData().job
	PlayerData = QBCore.Functions.GetPlayerData()
	TriggerEvent("qb-communityservice:inCommunityService", PlayerData.metadata.communityservice)
end)
