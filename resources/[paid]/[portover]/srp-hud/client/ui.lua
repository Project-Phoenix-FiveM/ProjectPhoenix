local speed = 0.0
local seatbeltOn = false
local cruiseOn = false
local vehicleCruiser = 'off'

local bleedingPercentage = 0

local stress = 0
local StressGain = 0
local IsGaining = false

local hunger = 100
local thirst = 100

local toggleHud = true

local mumbleInfo = 2

local radarActive = false
local radarSettings = true

local nitrousLevel = 0
local nitrousColor = false

RegisterNetEvent('srp-hud:toggleHud')
AddEventHandler('srp-hud:toggleHud', function(toggleHud1)
    toggleHud = toggleHud1
end)

RegisterNetEvent('srp-hud:toggleHudFitbit')
AddEventHandler('srp-hud:toggleHudFitbit', function(toggleHud1)
    toggleHudFB = toggleHud1
end)

RegisterNetEvent('srp-hud:toggleCruise')
AddEventHandler('srp-hud:toggleCruise', function(toggleCruise)
    vehicleCruiser = toggleCruise
end)

RegisterNetEvent('srp-hud:client:openHudSettings')
AddEventHandler('srp-hud:client:openHudSettings', function()
	SetNuiFocus(true, true)
    SendNUIMessage({
        action = "HudSettings"
    })	
end)

RegisterNetEvent('srp-hud:client:closeNUI')
AddEventHandler('srp-hud:client:closeNUI', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('closeUI', function(data)
    SetNuiFocus(false, false)
    TriggerServerEvent('srp-hud:server:saveHud', data)
end)

local minimapOn = true
local borderOn = true

RegisterNUICallback('toggleMinimap', function(data)
    radarActive = data.status
	radarSettings = data.status
	DisplayRadar(radarActive)
	
	if data.status == true then
		SendNUIMessage({
			action = "UpdateBorder",
			toggle = true
		})
		minimapOn = true
		borderOn = true
	else
		SendNUIMessage({
			action = "UpdateBorder",
			toggle = false
		})
		minimapOn = false
		borderOn = false
	end
	
end)

RegisterNUICallback('toggleBorder', function(data)
	if data.status == true then
		if minimapOn == true then
			SendNUIMessage({
				action = "UpdateBorder",
				toggle = true
			})
			borderOn = true
		end
	else
		SendNUIMessage({
			action = "UpdateBorder",
			toggle = false
		})
		borderOn = false
	end
	
end)

local reticle = false

RegisterNUICallback('toggleReticle', function(data)
    if data.status then
        reticle = true
    else
        reticle = false
    end
end)

local postalcode = false

RegisterNUICallback('togglePostal', function(data)

    if data.init and not postalcode then
        postalcode = true
        TriggerEvent('srp-postal:client:togglePostal')
    elseif data.status == true or data.status == false then
        TriggerEvent('srp-postal:client:togglePostal')
    end
end)

local postalmap = false

RegisterNUICallback('togglePostalMap', function(data)
    
	Citizen.CreateThread(function()
	
	RequestStreamedTextureDict("minimap_0_0", false)
	while not HasStreamedTextureDictLoaded("minimap_0_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_0_1", false)
	while not HasStreamedTextureDictLoaded("minimap_0_1") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_1_0", false)
	while not HasStreamedTextureDictLoaded("minimap_1_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_1_1", false)
	while not HasStreamedTextureDictLoaded("minimap_1_1") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_2_0", false)
	while not HasStreamedTextureDictLoaded("minimap_2_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_2_1", false)
	while not HasStreamedTextureDictLoaded("minimap_2_1") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_lod_128", false)
	while not HasStreamedTextureDictLoaded("minimap_lod_128") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_sea_0_0", false)
	while not HasStreamedTextureDictLoaded("minimap_sea_0_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_sea_0_1", false)
	while not HasStreamedTextureDictLoaded("minimap_sea_0_1") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_sea_1_0", false)
	while not HasStreamedTextureDictLoaded("minimap_sea_1_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_sea_1_1", false)
	while not HasStreamedTextureDictLoaded("minimap_sea_1_1") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_sea_2_0", false)
	while not HasStreamedTextureDictLoaded("minimap_sea_2_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("minimap_sea_2_1", false)
	while not HasStreamedTextureDictLoaded("minimap_sea_2_1") do
		Wait(5)
	end
	
	RequestStreamedTextureDict("pminimap_0_0", false)
	while not HasStreamedTextureDictLoaded("pminimap_0_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_0_1", false)
	while not HasStreamedTextureDictLoaded("pminimap_0_1") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_1_0", false)
	while not HasStreamedTextureDictLoaded("pminimap_1_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_1_1", false)
	while not HasStreamedTextureDictLoaded("pminimap_1_1") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_2_0", false)
	while not HasStreamedTextureDictLoaded("pminimap_2_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_2_1", false)
	while not HasStreamedTextureDictLoaded("pminimap_2_1") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_lod_128", false)
	while not HasStreamedTextureDictLoaded("pminimap_lod_128") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_sea_0_0", false)
	while not HasStreamedTextureDictLoaded("pminimap_sea_0_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_sea_0_1", false)
	while not HasStreamedTextureDictLoaded("pminimap_sea_0_1") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_sea_1_0", false)
	while not HasStreamedTextureDictLoaded("pminimap_sea_1_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_sea_1_1", false)
	while not HasStreamedTextureDictLoaded("pminimap_sea_1_1") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_sea_2_0", false)
	while not HasStreamedTextureDictLoaded("pminimap_sea_2_0") do
		Wait(5)
	end
	RequestStreamedTextureDict("pminimap_sea_2_1", false)
	while not HasStreamedTextureDictLoaded("pminimap_sea_2_1") do
		Wait(5)
	end
	
	
	if data.init and not postalmap then
        if not postalmap then
            AddReplaceTexture('minimap_0_0','minimap_0_0','pminimap_0_0','minimap_0_0')
            AddReplaceTexture('minimap_0_1','minimap_0_1','pminimap_0_1','minimap_0_1')
            AddReplaceTexture('minimap_1_0','minimap_1_0','pminimap_1_0','minimap_1_0')
            AddReplaceTexture('minimap_1_1','minimap_1_1','pminimap_1_1','minimap_1_1')
            AddReplaceTexture('minimap_2_0','minimap_2_0','pminimap_2_0','minimap_2_0')
            AddReplaceTexture('minimap_2_1','minimap_2_1','pminimap_2_1','minimap_2_1')
            AddReplaceTexture('minimap_lod_128','minimap_lod_128','pminimap_lod_128','minimap_lod_128')
            AddReplaceTexture('minimap_sea_0_0','minimap_sea_0_0','pminimap_sea_0_0','minimap_sea_0_0')
            AddReplaceTexture('minimap_sea_0_1','minimap_sea_0_1','pminimap_sea_0_1','minimap_sea_0_1')
            AddReplaceTexture('minimap_sea_1_0','minimap_sea_1_0','pminimap_sea_1_0','minimap_sea_1_0')
            AddReplaceTexture('minimap_sea_1_1','minimap_sea_1_1','pminimap_sea_1_1','minimap_sea_1_1')
            AddReplaceTexture('minimap_sea_2_0','minimap_sea_2_0','pminimap_sea_2_0','minimap_sea_2_0')
            AddReplaceTexture('minimap_sea_2_1','minimap_sea_2_1','pminimap_sea_2_1','minimap_sea_2_1')
        else
            AddReplaceTexture('minimap_0_0','minimap_0_0','minimap_0_0','minimap_0_0')
            AddReplaceTexture('minimap_0_1','minimap_0_1','minimap_0_1','minimap_0_1')
            AddReplaceTexture('minimap_1_0','minimap_1_0','minimap_1_0','minimap_1_0')
            AddReplaceTexture('minimap_1_1','minimap_1_1','minimap_1_1','minimap_1_1')
            AddReplaceTexture('minimap_2_0','minimap_2_0','minimap_2_0','minimap_2_0')
            AddReplaceTexture('minimap_2_1','minimap_2_1','minimap_2_1','minimap_2_1')
            AddReplaceTexture('minimap_lod_128','minimap_lod_128','minimap_lod_128','minimap_lod_128')
            AddReplaceTexture('minimap_sea_0_0','minimap_sea_0_0','minimap_sea_0_0','minimap_sea_0_0')
            AddReplaceTexture('minimap_sea_0_1','minimap_sea_0_1','minimap_sea_0_1','minimap_sea_0_1')
            AddReplaceTexture('minimap_sea_1_0','minimap_sea_1_0','minimap_sea_1_0','minimap_sea_1_0')
            AddReplaceTexture('minimap_sea_1_1','minimap_sea_1_1','minimap_sea_1_1','minimap_sea_1_1')
            AddReplaceTexture('minimap_sea_2_0','minimap_sea_2_0','minimap_sea_2_0','minimap_sea_2_0')
            AddReplaceTexture('minimap_sea_2_1','minimap_sea_2_1','minimap_sea_2_1','minimap_sea_2_1')
        end
    elseif data.status == true or data.status == false then
        if not postalmap then
            AddReplaceTexture('minimap_0_0','minimap_0_0','pminimap_0_0','minimap_0_0')
            AddReplaceTexture('minimap_0_1','minimap_0_1','pminimap_0_1','minimap_0_1')
            AddReplaceTexture('minimap_1_0','minimap_1_0','pminimap_1_0','minimap_1_0')
            AddReplaceTexture('minimap_1_1','minimap_1_1','pminimap_1_1','minimap_1_1')
            AddReplaceTexture('minimap_2_0','minimap_2_0','pminimap_2_0','minimap_2_0')
            AddReplaceTexture('minimap_2_1','minimap_2_1','pminimap_2_1','minimap_2_1')
            AddReplaceTexture('minimap_lod_128','minimap_lod_128','pminimap_lod_128','minimap_lod_128')
            AddReplaceTexture('minimap_sea_0_0','minimap_sea_0_0','pminimap_sea_0_0','minimap_sea_0_0')
            AddReplaceTexture('minimap_sea_0_1','minimap_sea_0_1','pminimap_sea_0_1','minimap_sea_0_1')
            AddReplaceTexture('minimap_sea_1_0','minimap_sea_1_0','pminimap_sea_1_0','minimap_sea_1_0')
            AddReplaceTexture('minimap_sea_1_1','minimap_sea_1_1','pminimap_sea_1_1','minimap_sea_1_1')
            AddReplaceTexture('minimap_sea_2_0','minimap_sea_2_0','pminimap_sea_2_0','minimap_sea_2_0')
            AddReplaceTexture('minimap_sea_2_1','minimap_sea_2_1','pminimap_sea_2_1','minimap_sea_2_1')
        else
            AddReplaceTexture('minimap_0_0','minimap_0_0','minimap_0_0','minimap_0_0')
            AddReplaceTexture('minimap_0_1','minimap_0_1','minimap_0_1','minimap_0_1')
            AddReplaceTexture('minimap_1_0','minimap_1_0','minimap_1_0','minimap_1_0')
            AddReplaceTexture('minimap_1_1','minimap_1_1','minimap_1_1','minimap_1_1')
            AddReplaceTexture('minimap_2_0','minimap_2_0','minimap_2_0','minimap_2_0')
            AddReplaceTexture('minimap_2_1','minimap_2_1','minimap_2_1','minimap_2_1')
            AddReplaceTexture('minimap_lod_128','minimap_lod_128','minimap_lod_128','minimap_lod_128')
            AddReplaceTexture('minimap_sea_0_0','minimap_sea_0_0','minimap_sea_0_0','minimap_sea_0_0')
            AddReplaceTexture('minimap_sea_0_1','minimap_sea_0_1','minimap_sea_0_1','minimap_sea_0_1')
            AddReplaceTexture('minimap_sea_1_0','minimap_sea_1_0','minimap_sea_1_0','minimap_sea_1_0')
            AddReplaceTexture('minimap_sea_1_1','minimap_sea_1_1','minimap_sea_1_1','minimap_sea_1_1')
            AddReplaceTexture('minimap_sea_2_0','minimap_sea_2_0','minimap_sea_2_0','minimap_sea_2_0')
            AddReplaceTexture('minimap_sea_2_1','minimap_sea_2_1','minimap_sea_2_1','minimap_sea_2_1')
        end
    end

	postalmap = not postalmap
	
	SetRadarBigmapEnabled(true, false)
	Wait(0)
	SetRadarBigmapEnabled(false, false)
	SetMapZoomDataLevel(0, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 0
	SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
	SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
	SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
	SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
	
	local minimap = RequestScaleformMovie("minimap")
	while not HasScaleformMovieLoaded(minimap) do
      Wait(0)
    end
	
	SetMinimapComponentPosition('minimap', 'L', 'B', -0.002, -0.060, 0.105, 0.16)
	SetMinimapComponentPosition('minimap_mask', 'L', 'B', -0.012, 0.015, 0.2, 0.292)
	SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.015, 0.015, 0.2, 0.292)
	
	Wait(100)
	SetRadarZoom(950)
	end)
	
end)

Citizen.CreateThread(function()
    Citizen.Wait(500)
    while true do 
        if SRPCore ~= nil and isLoggedIn then
            speed = GetEntitySpeed(GetVehiclePedIsIn(GLOBAL_PED, false)) * 2.236936
            local pos = GetEntityCoords(GLOBAL_PED)
            local street1, street2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
            local current_zone = GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))
            local fuel = exports['LegacyFuel']:GetFuel(GetVehiclePedIsIn(GLOBAL_PED))
            local engine = GetVehicleEngineHealth(GetVehiclePedIsIn(GLOBAL_PED))
            local stamina = (100 - GetPlayerSprintStaminaRemaining(GLOBAL_PLYID))
            local inwater = IsPedSwimmingUnderWater(GLOBAL_PED)
            local oxygen = GetPlayerUnderwaterTimeRemaining(GLOBAL_PLYID)
			local veh = GetVehiclePedIsIn(GLOBAL_PED, false)
			local flyer = IsPedInAnyPlane(GLOBAL_PED) or IsPedInAnyHeli(GLOBAL_PED)
			local altitude = false
			
			local talking = false
			local mumbleData = exports["srp-voice"]:RetrieveMumbleData()

			if mumbleData then 
                talking = 'radio'
            elseif NetworkIsPlayerTalking(GLOBAL_PLYID) then
                talking = 'normal'
            end
			
			if flyer then
                altitude = math.floor(GetEntityHeightAboveGround(veh) * 3.28084)
            end

            SendNUIMessage({
                action = "hudtick",
                show = IsPauseMenuActive(),
                --show = true,
                health = GetEntityHealth(GLOBAL_PED),
                armor = GetPedArmour(GLOBAL_PED),
				bleeding = bleedingPercentage,
                thirst = thirst,
                hunger = hunger,
                stress = stress,
                street1 = GetStreetNameFromHashKey(street1),
                street2 = GetStreetNameFromHashKey(street2),
                area_zone = current_zone,
                speed = math.ceil(speed),
				altitude = altitude,
				altitudeShow = altitude ~= false,
                fuel = fuel,
                engine = engine,
                stamina = stamina,
                inwater = inwater,
                oxygen = oxygen,
                togglehud = true,
				mumble = mumbleInfo,
				talking = talking,
				vehicleCruiser = vehicleCruiser,
                nos = nitrousLevel,
                nospressed = nitrousColor
                --togglehud = toggleHud
                
            })
            Citizen.Wait(500)
        else
            Citizen.Wait(1000)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        if SRPCore ~= nil and isLoggedIn and PSHud.Show then
            if IsPedInAnyVehicle(GLOBAL_PED, false) then
                speed = GetEntitySpeed(GetVehiclePedIsIn(GLOBAL_PED, false)) * 2.236936
                if speed >= FXStress.MinimumSpeed then
                    TriggerServerEvent('srp-hud:Server:GainStress', math.random(1, 2))
                end
            end
        end
        Citizen.Wait(20000)
    end
end)



Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1000)
        TriggerEvent("hud:client:SetMoney")
        if (IsPedInAnyVehicle(PlayerPedId()) or toggleHudFB) and isLoggedIn and radarSettings then
            
			if borderOn then
				SendNUIMessage({
					action = "UpdateBorder",
					toggle = true
				})
			else
				SendNUIMessage({
					action = "UpdateBorder",
					toggle = false
				})
			end
			if IsPedInAnyVehicle(PlayerPedId()) then
				SendNUIMessage({
					action = "car",
					show = true,
				})
			else
				SendNUIMessage({
					action = "car",
					show = false,
				})
			end
            radarActive = true
        else
            SendNUIMessage({
                action = "car",
                show = false,
            })
            seatbeltOn = false
            cruiseOn = false

            SendNUIMessage({
                action = "seatbelt",
                seatbelt = seatbeltOn,
            })

            SendNUIMessage({
                action = "cruise",
                cruise = cruiseOn,
            })
			SendNUIMessage({
				action = "UpdateBorder",
				toggle = false
			})
			
            radarActive = false
        end
		
		DisplayRadar(radarActive)
    end
end)

RegisterNetEvent('mumble:updateMumbleInfo')
AddEventHandler('mumble:updateMumbleInfo', function(mode)
	mumbleInfo = mode
	-- 1 - Whisper
	-- 2 - Normal
	-- 3 - Shouting
end)

RegisterNetEvent("seatbelt:client:ToggleSeatbelt")
AddEventHandler("seatbelt:client:ToggleSeatbelt", function(toggle)
    if toggle == nil then
        seatbeltOn = not seatbeltOn
        SendNUIMessage({
            action = "seatbelt",
            seatbelt = seatbeltOn,
        })
    else
        seatbeltOn = toggle
        SendNUIMessage({
            action = "seatbelt",
            seatbelt = toggle,
        })
    end
end)

RegisterNetEvent('srp-hud:client:ToggleHarness')
AddEventHandler('srp-hud:client:ToggleHarness', function(toggle)
    SendNUIMessage({
        action = "harness",
        toggle = toggle
    })
end)

RegisterNetEvent('srp-hud:client:UpdateNitrous')
AddEventHandler('srp-hud:client:UpdateNitrous', function(level)
    nitrousLevel = level
end)

RegisterNetEvent('srp-hud:client:UpdateNitrousColor')
AddEventHandler('srp-hud:client:UpdateNitrousColor', function(level)
    nitrousColor = level
end)

RegisterNetEvent('srp-hud:client:UpdateDrivingMeters')
AddEventHandler('srp-hud:client:UpdateDrivingMeters', function(toggle, amount)
    SendNUIMessage({
        action = "UpdateDrivingMeters",
        amount = amount,
        toggle = toggle,
    })
end)

local LastHeading = nil
local Rotating = "left"
local toggleCompass = false

RegisterNetEvent('srp-hud:toggleCompass')
AddEventHandler('srp-hud:toggleCompass', function(toggleCompass1)
    toggleCompass = toggleCompass1
end)

RegisterNetEvent('srp-hud:toggleCompassFitbit')
AddEventHandler('srp-hud:toggleCompassFitbit', function(toggleCompass1)
    toggleCompassFB = toggleCompass1
	toggleCompass = toggleCompass1
end)

RegisterNetEvent("SRPCore:Client:OnPlayerLoaded")
AddEventHandler("SRPCore:Client:OnPlayerLoaded", function()
    isLoggedIn = true
    PlayerJob = SRPCore.Functions.GetPlayerData().job
    local PlayerData = SRPCore.Functions.GetPlayerData()
    SendNUIMessage({
        action = "Init",
        healthtoggle = PlayerData.metadata["hud"].healthtoggle,
        healthvalue =  PlayerData.metadata["hud"].healthvalue,
        armortoggle = PlayerData.metadata["hud"].armortoggle,
        armorvalue = PlayerData.metadata["hud"].armorvalue,
        foodtoggle = PlayerData.metadata["hud"].foodtoggle,
        foodvalue = PlayerData.metadata["hud"].foodvalue,
        watertoggle = PlayerData.metadata["hud"].watertoggle,
        watervalue = PlayerData.metadata["hud"].watervalue,
        stresstoggle = PlayerData.metadata["hud"].stresstoggle,
        oxygentoggle = PlayerData.metadata["hud"].oxygentoggle,
        bleedingtoggle = PlayerData.metadata["hud"].bleedingtoggle,
        minimaptoggle = PlayerData.metadata["hud"].minimaptoggle,
        carhudtoggle = PlayerData.metadata["hud"].carhudtoggle,
        mapbordertoggle = PlayerData.metadata["hud"].mapbordertoggle,
        bordercolor = PlayerData.metadata["hud"].bordercolor,
        compasstoggle = PlayerData.metadata["hud"].compasstoggle,
        streetstoggle = PlayerData.metadata["hud"].streetstoggle,
        postalstoggle = PlayerData.metadata["hud"].postalstoggle,
        secondmap = PlayerData.metadata["hud"].secondmap,
        reticle = PlayerData.metadata["hud"].reticle
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedInAnyVehicle(GLOBAL_PED, false) then
            toggleCompass = true
        else
			if not toggleCompassFB then
				toggleCompass = false
			end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if isLoggedIn and SRPCore ~= nil and toggleCompass then
            local ped = GLOBAL_PED
            local PlayerHeading = GetEntityHeading(ped)
            if LastHeading ~= nil then
                if PlayerHeading < LastHeading then
                    Rotating = "right"
                elseif PlayerHeading > LastHeading then
                    Rotating = "left"
                end
            end
            LastHeading = PlayerHeading
            SendNUIMessage({
                action = "UpdateCompass",
                heading = PlayerHeading,
                lookside = Rotating,
                toggle = toggleCompass
            })
            Citizen.Wait(50)
        else
            SendNUIMessage({
                action = "UpdateCompass",
                heading = 1,
                lookside = 1,
                toggle = toggleCompass
            })
            Citizen.Wait(1500)
        end
    end
end)

--[[
function GetDirectionText(heading)
    if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
        return "Noord"
    elseif (heading >= 45 and heading < 135) then
        return "Oost"
    elseif (heading >=135 and heading < 225) then
        return "Zuid"
    elseif (heading >= 225 and heading < 315) then
        return "West"
    end
end
]]


RegisterNetEvent("hud:client:UpdateNeeds")
AddEventHandler("hud:client:UpdateNeeds", function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

RegisterNetEvent('hud:client:UpdateStress')
AddEventHandler('hud:client:UpdateStress', function(newStress)
    stress = newStress
end)

Citizen.CreateThread(function()
    while true do
        if not IsGaining then
            StressGain = math.ceil(StressGain)
            if StressGain > 0 then
                SRPCore.Functions.Notify('Stress levels are rising', "primary", 2000)
                TriggerServerEvent('srp-hud:Server:UpdateStress', StressGain)
                StressGain = 0
            end
        end

        Citizen.Wait(3000)
    end
end)

Citizen.CreateThread(function()
    while true do
        if SRPCore ~= nil and isLoggedIn then
            if IsPedInAnyVehicle(GLOBAL_PED, false) then
                speed = GetEntitySpeed(GetVehiclePedIsIn(GLOBAL_PED, false)) * 3.6
                if speed >= FXStress.MinimumSpeed then
                    TriggerServerEvent('srp-hud:Server:GainStress', math.random(2, 4))
                end
            end
        end
        Citizen.Wait(20000)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6)

        if IsPedShooting(GLOBAL_PED) then
            local StressChance = math.random(1, 40)
            local odd = math.random(1, 40)
            if StressChance == odd then
                local PlusStress = math.random(1, 3) / 100
                StressGain = StressGain + PlusStress
            end
            if not IsGaining then
                IsGaining = true
            end
        else
            if IsGaining then
                IsGaining = false
            end
        end
    end
end)

function GetShakeIntensity(stresslevel)
    local retval = 0.05
    for k, v in pairs(FXStress.Intensity["shake"]) do
        if stresslevel >= v.min and stresslevel < v.max then
            retval = v.intensity
            break
        end
    end
    return retval
end

function GetEffectInterval(stresslevel)
    local retval = 60000
    for k, v in pairs(FXStress.EffectInterval) do
        if stresslevel >= v.min and stresslevel < v.max then
            retval = v.timeout
            break
        end
    end
    return retval
end

Citizen.CreateThread(function()
    while true do
        local Wait = GetEffectInterval(stress)
        if stress >= 100 then
            local ShakeIntensity = GetShakeIntensity(stress)
            local FallRepeat = math.random(2, 4)
            local RagdollTimeout = (FallRepeat * 1750)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
            SetFlash(0, 0, 500, 3000, 500)

            if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                local player = PlayerPedId()
                SetPedToRagdollWithFall(player, RagdollTimeout, RagdollTimeout, 1, GetEntityForwardVector(player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
            end

            Citizen.Wait(500)
            for i = 1, FallRepeat, 1 do
                Citizen.Wait(750)
                DoScreenFadeOut(200)
                Citizen.Wait(1000)
                DoScreenFadeIn(200)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
                SetFlash(0, 0, 200, 750, 200)
            end
        elseif stress >= FXStress.MinimumStress then
            local ShakeIntensity = GetShakeIntensity(stress)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
            SetFlash(0, 0, 500, 2500, 500)
        end
        Citizen.Wait(Wait)
    end
end)

Citizen.CreateThread(function()
    while true do
        if isLoggedIn and PSHud.Show and SRPCore ~= nil then
            SRPCore.Functions.TriggerCallback('hospital:GetPlayerBleeding', function(playerBleeding)
                if playerBleeding == 0 then
                    bleedingPercentage = 0
                elseif playerBleeding == 1 then
                    bleedingPercentage = 25
                elseif playerBleeding == 2 then
                    bleedingPercentage = 50
                elseif playerBleeding == 3 then
                    bleedingPercentage = 75
                elseif playerBleeding == 4 then
                    bleedingPercentage = 100
                end			
            end)
        end

        Citizen.Wait(2500)
    end
end)

--- Minimap

Citizen.CreateThread(function()
	RequestStreamedTextureDict("circlemap", false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
	
	SetMinimapClipType(1)
	SetMinimapComponentPosition('minimap', 'L', 'B', -0.002, -0.060, 0.105, 0.16)
	SetMinimapComponentPosition('minimap_mask', 'L', 'B', -0.012, 0.015, 0.2, 0.292)
	SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.015, 0.015, 0.2, 0.292)
	
	local minimap = RequestScaleformMovie("minimap")
	while not HasScaleformMovieLoaded(minimap) do
      Wait(0)
    end
	
	SetRadarBigmapEnabled(true, false)
	Wait(0)
	SetRadarBigmapEnabled(false, false)
	  
	SetBlipAlpha(GetNorthRadarBlip(), 0)

	while true do
		Wait(100)
		BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
		ScaleformMovieMethodAddParamInt(3)
		EndScaleformMovieMethod()
		if IsBigmapActive() or IsBigmapFull() then
			SetBigmapActive(false, false)
		end		

		if (not invehicle and IsPedInAnyVehicle(GLOBAL_PED, false)) or toggleHudFB then
			invehicle = true
			SetMapZoomDataLevel(0, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 0
			SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
			SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
			SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
			SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4

			Wait(100)
			SetRadarZoom(950)
		end 
	end
end)

-- No idle cams
Citizen.CreateThread(function()
    while true do
      InvalidateIdleCam()
      N_0x9e4cfff989258472() -- Disable the vehicle idle camera
      Wait(10000) --The idle camera activates after 30 second so we don't need to call this per frame
    end 
end)

-- reticle
Citizen.CreateThread(function()
	while true do
	    if not reticle then
            HideHudComponentThisFrame(14)
		end

		Citizen.Wait(4)
	end
end)