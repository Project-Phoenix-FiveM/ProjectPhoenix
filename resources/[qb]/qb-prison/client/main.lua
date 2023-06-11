QBCore = exports['qb-core']:GetCoreObject()
inJail = false
jailTime = 0
currentJob = nil
CellsBlip = nil
TimeBlip = nil
ShopBlip = nil
WorkBlip = nil
PlayerJob = QBCore.Functions.GetPlayerData().job
local RandomStartPosition

local PlayerData = QBCore.Functions.GetPlayerData()
local sharedItems = QBCore.Shared.Items
local targetsCreated = false
local inRange = false
local TargetsTable = {}


-------------------------------------------
------ ONLY USED FOR rs-prisonJOBS --------
-------------------------------------------
local function GetJailTime()
	return jailTime
end
exports('GetJailTime', GetJailTime)


-------------------------------------------
-------- CHECK FOR LIFER CITIZENID --------
-------------------------------------------
local function LiferCheck()
	local cb = false
	for _, cid in pairs(Config.Lifers) do
		if PlayerData.citizenid == cid then
			cb = true
		else
			cb = false
		end

		if Config.Debug then
			print(cid)
		end
	end
	return cb
end

-------------------------------------------
------ CHECK FOR PRISON BREAK ITEMS -------
-------------------------------------------
local function HasPrisonBreakItems()
    local itemcheck = 0

	for k,v in pairs(Config.PrisonBreak.Hack.Items) do
        if QBCore.Functions.HasItem(v.item, v.amount) then
            itemcheck = itemcheck + 1
            if itemcheck == #Config.PrisonBreak.Hack.Items then
                return true
            end
        else
			return false
        end
    end
end

-------------------------------------------
------------ PRISONER CLOTHES -------------
-------------------------------------------

local function PrisonClothes()
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

-------------------------------------------
-------------- PRISON BLIPS ---------------
-------------------------------------------
local function CreateCellsBlip()
	if CellsBlip ~= nil then
		RemoveBlip(CellsBlip)
	end

	CellsBlip = AddBlipForCoord(Config.Locations["yard"].coords.x, Config.Locations["yard"].coords.y, Config.Locations["yard"].coords.z)

	SetBlipSprite (CellsBlip, 238)
	SetBlipDisplay(CellsBlip, 4)
	SetBlipScale  (CellsBlip, 0.6)
	SetBlipAsShortRange(CellsBlip, true)
	SetBlipColour(CellsBlip, 4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Cells")
	EndTextCommandSetBlipName(CellsBlip)

	if TimeBlip ~= nil then
		RemoveBlip(TimeBlip)
	end
	TimeBlip = AddBlipForCoord(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z)

	SetBlipSprite (TimeBlip, 466)
	SetBlipDisplay(TimeBlip, 4)
	SetBlipScale  (TimeBlip, 0.6)
	SetBlipAsShortRange(TimeBlip, true)
	SetBlipColour(TimeBlip, 4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Time check")
	EndTextCommandSetBlipName(TimeBlip)

	if ShopBlip ~= nil then
		RemoveBlip(ShopBlip)
	end
	ShopBlip = AddBlipForCoord(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z)

	SetBlipSprite (ShopBlip, 52)
	SetBlipDisplay(ShopBlip, 4)
	SetBlipScale  (ShopBlip, 0.5)
	SetBlipAsShortRange(ShopBlip, true)
	SetBlipColour(ShopBlip, 0)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Canteen")
	EndTextCommandSetBlipName(ShopBlip)

	if WorkBlip ~= nil then
		RemoveBlip(WorkBlip)
	end
	WorkBlip = AddBlipForCoord(Config.Locations["work"].coords.x, Config.Locations["work"].coords.y, Config.Locations["work"].coords.z)

	SetBlipSprite (WorkBlip, 440)
	SetBlipDisplay(WorkBlip, 4)
	SetBlipScale  (WorkBlip, 0.5)
	SetBlipAsShortRange(WorkBlip, true)
	SetBlipColour(WorkBlip, 0)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Prison Work")
	EndTextCommandSetBlipName(WorkBlip)
end

--------------------------------
-- CREATE / DESTROY ALL ZONES --
--------------------------------

local function CreateAllTargets()
	if not targetsCreated then
		CheckTime = exports['qb-target']:AddBoxZone("prisontime", vector3(1827.3, 2587.72, 46.01), 0.4, 0.55, {
			name = "prisontime",
			heading = 0,
			debugPoly = Config.DebugPoly,
			minZ = 46.11,
			maxZ = 47.01,
			}, {
				options = {
				{
					type = "client",
					event = "rs-prison:client:checkTime",
					icon = "fas fa-clock",
					label = "Check Jail Time",
				},
				{
					type = "client",
					event = "rs-prison:client:jobMenu",
					icon = "fas fa-cash-register",
					label = "Choose Another Job",
				},
			},
			distance = 2,
		})
		table.insert(TargetsTable, "prisontime")

		for k,v in pairs(Config.Locations.PrisonBreak) do
			exports['qb-target']:AddBoxZone("prisonbreak"..k, vector3(v.coords.x, v.coords.y, v.coords.z), v.length, v.width, {
				name = "prisonbreak"..k,
				heading = v.coords.w,
				debugPoly = Config.DebugPoly,
				minZ = v.coords.z - 1,
				maxZ = v.coords.z + 1,
				}, {
					options = {
					{
						type = "client",
						event = "rs-prison:StartPrisonBreak",
						icon = "fas fa-laptop-code",
						label = "Prison Break",
						canInteract = function()
							if HasPrisonBreakItems() then
								return true
							end
						end
					},
				},
				distance = 2,
			})
			table.insert(TargetsTable, "prisonbreak"..k)
		end

		Canteen = exports['qb-target']:AddBoxZone("prisoncanteen", vector3(1780.95, 2560.05, 45.67), 3.8, 0.5, {
			name = "prisoncanteen",
			heading = 90,
			debugPoly = Config.DebugPoly,
			minZ = 45.40,
			maxZ = 45.85,
			}, {
				options = {
				{
					type = "client",
					event = "rs-prison:client:useCanteen",
					icon = "fas fa-utensils",
					label = "Open Canteen",
				},
			},
			distance = 2,
		})
		table.insert(TargetsTable, "prisoncanteen")

		Slushy = exports['qb-target']:AddBoxZone("prisonslushy", vector3(1777.64, 2559.97, 45.67), 0.5, 0.7, {
			name = "prisonslushy",
			heading = 0,
			debugPoly = Config.DebugPoly,
			minZ = 45.50,
			maxZ = 46.75,
			}, {
				options = {
				{
					type = "client",
					event = "rs-prison:client:slushy",
					icon = "fas fa-wine-bottle",
					label = "Make Slushy",
				},
			},
			distance = 2,
		})
		table.insert(TargetsTable, "prisonslushy")

		Coffee = exports['qb-target']:AddBoxZone("prisoncoffee", vector3(1778.83, 2560.04, 45.67), 0.5, 0.3, {
			name = "prisoncoffee",
			heading = 0,
			debugPoly = Config.DebugPoly,
			minZ = 45.50,
			maxZ = 46.75,
			}, {
				options = {
				{
					type = "client",
					event = "rs-prison:client:coffee",
					icon = "fas fa-mug-hot",
					label = "Make Coffee",
				},
			},
			distance = 2,
		})
		table.insert(TargetsTable, "prisoncoffee")

		Soda = exports['qb-target']:AddBoxZone("prisonsoda", vector3(1778.26, 2560.02, 45.67), 0.6, 0.55, {
			name = "prisonsoda",
			heading = 0,
			debugPoly = Config.DebugPoly,
			minZ = 45.50,
			maxZ = 46.75,
			}, {
				options = {
				{
					type = "client",
					event = "rs-prison:client:soda",
					icon = "fas fa-cash-register",
					label = "Make Soda",
				},
			},
			distance = 2,
		})
		table.insert(TargetsTable, "prisonsoda")

		if Config.Crafting then
			Crafting = exports['qb-target']:AddBoxZone("prisoncrafting", vector3(Config.CraftingLocation.x, Config.CraftingLocation.y, Config.CraftingLocation.z), 1.4, 0.5, {
				name = "prisoncrafting",
				heading = Config.CraftingLocation.w,
				debugPoly = Config.DebugPoly,
				minZ = Config.CraftingLocation.z - 1,
				maxZ = Config.CraftingLocation.z + 1,
				}, {
					options = {
					{
						type = "client",
						event = "rs-prison:CraftingMenu",
						icon = "fas fa-toolbox",
						label = "Prison Crafting",
					},
				},
				distance = 2,
			})

			table.insert(TargetsTable, "prisoncrafting")
		end

		if not Config.QB_PrisonJobs then
			exports['qb-target']:AddBoxZone("PrisonChinUp", Config.Workout.Chinup.coords, 1, 2.0, {
				name = "PrisonChinUp",
				heading = 30,
				debugPoly = Config.DebugPoly,
				minZ = Config.Workout.Chinup.coords.z - 1,
				maxZ = Config.Workout.Chinup.coords.z + 1,
			}, {
				options = {
					{
						type = "client",
						event = "rs-prison:client:DoChinUp",
						icon = "fas fa-dumbbell",
						label = "Do Chin-Ups",
						canInteract = function()
							if inJail then
								return true
							else
								return false
							end
						end,
					},
				},
				distance = 1.5
			})

			table.insert(TargetsTable, "PrisonChinUp")
		end

		targetsCreated = true
	end

    if Config.Debug then
        print('All Prison Zones Created')
    end
end

local function DestroyAllTargets()
	if targetsCreated then
		for k,v in pairs(TargetsTable) do
			exports['qb-target']:RemoveZone(v)
		end

		targetsCreated = false
	end

    if Config.Debug then
        print('All Zones Destroyed')
    end
end

----------------------------------
-- RESOURCE START / PLAYER LOAD --
----------------------------------

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
		QBCore.Functions.GetPlayerData(function(PlayerData)
			if PlayerData.metadata["injail"] > 0 then
				TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])

				if LiferCheck() then
					TriggerServerEvent('prison:server:SetJailStatus', 999)
				end
			end
		end)

	QBCore.Functions.TriggerCallback('prison:server:IsAlarmActive', function(active)
		if active then
			TriggerEvent('prison:client:JailAlarm', true)
		end
	end)

	TriggerEvent('rs-prison:client:SpawnLockers')
	PlayerJob = QBCore.Functions.GetPlayerData().job
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
		QBCore.Functions.GetPlayerData(function(PlayerData)
			if PlayerData.metadata["injail"] > 0 then
				TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])

				if LiferCheck() then
					TriggerServerEvent('prison:server:SetJailStatus', 999)
				end
			end
		end)

	QBCore.Functions.TriggerCallback('prison:server:IsAlarmActive', function(active)
		if not active then return end
		TriggerEvent('prison:client:JailAlarm', true)
	end)

	TriggerEvent('rs-prison:client:SpawnLockers')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

-----------------------------------
-- RESOURCE STOP / PLAYER UNLOAD --
-----------------------------------

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	inJail = false
	currentJob = nil
	RemoveBlip(currentBlip)
	DestroyAllTargets()
	TriggerEvent('rs-prison:client:RemoveLockers')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
		DestroyAllTargets()
		TriggerEvent('rs-prison:client:RemoveLockers')
    end
end)

RegisterNetEvent('prison:client:Enter', function(time)
	if LiferCheck() then
		QBCore.Functions.Notify('You\'re going to be here for a VERY long time...', "error")
	else
		QBCore.Functions.Notify( Lang:t("error.injail", {Time = time}), "error")
	end

	TriggerEvent("chatMessage", "SYSTEM", "warning", "Your property has been seized, you'll get everything back when your time is up..")
	DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Wait(10)
	end
	if Config.PrisonMap == 'gabz' then
		RandomStartPosition = Config.Locations.GabzSpawns[math.random(1, #Config.Locations.GabzSpawns)]
	else
		RandomStartPosition = Config.Locations.QBSpawns[math.random(1, #Config.Locations.QBSpawns)]
	end
	SetEntityCoords(PlayerPedId(), RandomStartPosition.coords.x, RandomStartPosition.coords.y, RandomStartPosition.coords.z - 0.9, 0, 0, 0, false)
	SetEntityHeading(PlayerPedId(), RandomStartPosition.coords.w)
	Wait(500)
	if Config.Outfits.enabled then
		PrisonClothes()
	end
	TriggerEvent('animations:client:EmoteCommandStart', {RandomStartPosition.animation})

	inJail = true
	jailTime = time

	-- Code to Select Random Job
	local randomJobIndex = math.random(1, #Config.PrisonJobs) -- Chooses Random Job
   	local RandomJobSelection = Config.PrisonJobs[randomJobIndex].name
	currentJob = RandomJobSelection

	TriggerServerEvent("prison:server:SetJailStatus", jailTime)
	TriggerServerEvent("prison:server:SaveJailItems", jailTime)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "jail", 0.5)
	if Config.QB_PrisonJobs then
		GetJailTime()
	end
	CreateCellsBlip()
	CreateAllTargets()
	Wait(2000)
	DoScreenFadeIn(1000)
	QBCore.Functions.Notify( Lang:t("error.do_some_work", {currentjob = Config.PrisonJobs[randomJobIndex].label}), "error")
end)

RegisterNetEvent('prison:client:Leave', function()
	if jailTime > 0 then
		QBCore.Functions.Notify( Lang:t("info.timeleft", {JAILTIME = jailTime}))
	else
		jailTime = 0
		TriggerServerEvent("prison:server:SetJailStatus", 0)
		TriggerServerEvent("prison:server:GiveJailItems")
		TriggerEvent("chatMessage", "SYSTEM", "warning", "you've received your property back..")
		inJail = false
		RemoveBlip(currentBlip)
		RemoveBlip(CellsBlip)
		CellsBlip = nil
		RemoveBlip(TimeBlip)
		TimeBlip = nil
		RemoveBlip(ShopBlip)
		ShopBlip = nil
		RemoveBlip(WorkBlip)
		WorkBlip = nil
		currentJob = nil
		QBCore.Functions.Notify(Lang:t("success.free_"))
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do
			Wait(10)
		end
		SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.w)
		DestroyAllTargets()

		Wait(500)

		DoScreenFadeIn(1000)
	end
end)

RegisterNetEvent('prison:client:UnjailPerson', function()
	if jailTime > 0 then
		TriggerServerEvent("prison:server:SetJailStatus", 0)
		TriggerServerEvent("prison:server:GiveJailItems")
		TriggerEvent("chatMessage", "SYSTEM", "warning", "You got your property back..")
		inJail = false
		RemoveBlip(currentBlip)
		RemoveBlip(CellsBlip)
		CellsBlip = nil
		RemoveBlip(TimeBlip)
		TimeBlip = nil
		RemoveBlip(ShopBlip)
		ShopBlip = nil
		RemoveBlip(WorkBlip)
		WorkBlip = nil
		QBCore.Functions.Notify(Lang:t("success.free_"))
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do
			Wait(10)
		end
		SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.w)
		Wait(500)
		DoScreenFadeIn(1000)
	end
end)

---------------------------------------------------
------------------ PRISON JOBS --------------------
-- Fix Electrical, Cook, or Sweep to Reduce Time --
---------------------------------------------------

-- Job Menu
RegisterNetEvent('rs-prison:client:jobMenu', function()
    if inJail then

		pjobMenu = {
			{
				isHeader = true,
				header = 'Prison Work',
				isMenuHeader = true
			},
			{
				header = "Electrician",
				txt = "Fix Electrical Boxes",
				icon = "fas fa-bolt",
				params = {
					isServer = false,
					event = "rs-prison:jobapplyElectrician",
				}
			},
			{
				header = "Cook",
				txt = "Cook Food",
				icon = "fas fa-utensils",
				params = {
					isServer = false,
					event = "rs-prison:jobapplyCook",
				}
			},
			{
				header = "Janitor",
				txt = "Clean Common Area",
				icon = "fas fa-broom",
				params = {
					isServer = false,
					event = "rs-prison:jobapplyJanitor",
				}
			},
			{
				header = "Close Menu",
				txt = "Close Menu",
				icon = "fas fa-x",
				params = {
					isServer = false,
					event = exports['qb-menu']:closeMenu(),
				}
			},
		}

        exports['qb-menu']:openMenu(pjobMenu)

		if Config.Debug then
        	print("Job Menu: Opened")
		end

    else
        QBCore.Functions.Notify("You are not an Inmate", "error", 3500)
    end
end)

----------------
-- JOB EVENTS --
----------------

RegisterNetEvent('rs-prison:jobapplyElectrician', function(args)
	local pos = GetEntityCoords(PlayerPedId())
	inRange = false

	local dist = #(pos - vector3(Config.CheckTimeLocation.x, Config.CheckTimeLocation.y, Config.CheckTimeLocation.z))

    if dist < 2 then
		inRange = true
        if inJail then
			if currentJob ~= "electrician" then
				currentJob = "electrician"
				CreatePrisonBlip()
				QBCore.Functions.Notify('New Job: Electrician')

				if Config.Debug then
					print("Job: Electrician")
				end
			else
				QBCore.Functions.Notify('You already have the electrician job!')
			end
		else
			QBCore.Functions.Notify('Job Not Available')
			TriggerEvent('rs-prison:client:jobMenu')
		end
	else
		QBCore.Functions.Notify('Not Close Enough To Pay Phone')
	end

	if not inRange then
		Wait(1000)
	end
end)

RegisterNetEvent('rs-prison:jobapplyCook', function(args)
	local pos = GetEntityCoords(PlayerPedId())
	inRange = false

	local dist = #(pos - vector3(Config.CheckTimeLocation.x, Config.CheckTimeLocation.y, Config.CheckTimeLocation.z))

    if dist < 2 then
		inRange = true
        if inJail then
			if currentJob ~= "cook" then
				currentJob = "cook"
				CreatePrisonBlip()
				QBCore.Functions.Notify('New Job: Cook')

				if Config.Debug then
					print("Job: Cook")
				end
			else
				QBCore.Functions.Notify('You already have the cooking job!')
			end
		else
			QBCore.Functions.Notify('Job Not Available')
			TriggerEvent('rs-prison:client:jobMenu')
		end
	else
		QBCore.Functions.Notify('Not Close Enough To Pay Phone')
	end

	if not inRange then
		Wait(1000)
	end
end)

RegisterNetEvent('rs-prison:jobapplyJanitor', function(args)
	local pos = GetEntityCoords(PlayerPedId())
	inRange = false

	local dist = #(pos - vector3(Config.CheckTimeLocation.x, Config.CheckTimeLocation.y, Config.CheckTimeLocation.z))

    if dist < 2 then
		inRange = true
        if inJail then
			if currentJob ~= "janitor" then
				currentJob = "janitor"
				CreatePrisonBlip()
				QBCore.Functions.Notify('New Job: Janitor')

				if Config.Debug then
					print("Job: Janitor")
				end
			else
				QBCore.Functions.Notify('You already have the janitor job!')
			end
		else
			QBCore.Functions.Notify('Job Not Available')
			TriggerEvent('rs-prison:client:jobMenu')
		end
	else
		QBCore.Functions.Notify('Not Close Enough To Pay Phone')
	end

	if not inRange then
		Wait(1000)
	end
end)

-------------------------------
---------- CHECK TIME ---------
-------------------------------

-- Check Time
RegisterNetEvent('rs-prison:client:checkTime', function()
	if inJail then
		local pos = GetEntityCoords(PlayerPedId())
		if #(pos - vector3(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z)) < 1.5 then
			TriggerEvent("prison:client:Leave")
		end
	end
end)


------------------------------------
---------- DRINK MACHINES  ---------
------------------------------------
-- Use Canteen
RegisterNetEvent('rs-prison:client:useCanteen', function()
	if inJail then
		local ShopItems = {}
		ShopItems.label = "Prison Canteen"
		ShopItems.items = Config.CanteenItems
		ShopItems.slots = #Config.CanteenItems
		TriggerServerEvent("inventory:server:OpenInventory", "shop", "Canteenshop_"..math.random(1, 99), ShopItems)
	else
		QBCore.Functions.Notify("You are not in Jail..", "error")
	end
end)

-- Slushy Machine
RegisterNetEvent('rs-prison:client:slushy', function()
	if inJail then
		Wait(1000)
		local ped = PlayerPedId()
		if Config.SlushyMiniGame.PSThermite.enabled then
			exports['ps-ui']:Thermite(function(success)
				if success then
					-- TriggerServerEvent("InteractSound_SV:PlayOnSource", "pour-drink", 0.1)
					TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
					QBCore.Functions.Progressbar("prison_slushy", "Making a Good Slushy...", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {}, {}, {}, function()
						SlushyTime(success)
						ClearPedTasks(PlayerPedId())
					end, function()
						QBCore.Functions.Notify("Canceled...", "error")
						ClearPedTasks(PlayerPedId())
					end, "slushy")
				else
					QBCore.Functions.Notify("You Failed making a Slushy..", "error")
					ClearPedTasks(PlayerPedId())
				end
			end, Config.SlushyMiniGame.PSThermite.time, Config.SlushyMiniGame.PSThermite.grid, Config.SlushyMiniGame.PSThermite.incorrect)
		elseif Config.SlushyMiniGame.PSCircle.enabled then
			exports['ps-ui']:Circle(function(success)
				if success then
					-- TriggerServerEvent("InteractSound_SV:PlayOnSource", "pour-drink", 0.1)
					TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
					QBCore.Functions.Progressbar("prison_slushy", "Making a Good Slushy...", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {}, {}, {}, function()
						SlushyTime(success)
						ClearPedTasks(PlayerPedId())
					end, function()
						QBCore.Functions.Notify("Canceled...", "error")
						ClearPedTasks(PlayerPedId())
					end, "slushy")
				else
					QBCore.Functions.Notify("You Failed making a Slushy..", "error")
					ClearPedTasks(PlayerPedId())
				end
			end, Config.SlushyMiniGame.PSCircle.circles, Config.SlushyMiniGame.PSCircle.time) -- NumberOfCircles, MS
		elseif Config.SlushyMiniGame.QBSkillbar.enabled then
			local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
			Skillbar.Start({
				duration = Config.SlushyMiniGame.QBSkillbar.duration, -- how long the skillbar runs for
				pos = Config.SlushyMiniGame.QBSkillbar.pos, -- how far to the right the static box is
				width = Config.SlushyMiniGame.QBSkillbar.width, -- how wide the static box is
			}, function()
				-- TriggerServerEvent("InteractSound_SV:PlayOnSource", "pour-drink", 0.1)
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
				QBCore.Functions.Progressbar("prison_slushy", "Making a Good Slushy...", 10000, false, true, {
					disableMovement = false,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					SlushyTime(Skillbar)
					ClearPedTasks(PlayerPedId())
				end, function() -- Cancel
					QBCore.Functions.Notify("Canceled...", "error")
					ClearPedTasks(PlayerPedId())
				end, "slushy")
			end, function()
				QBCore.Functions.Notify("You Failed making a Slushy..", "error")
				ClearPedTasks(PlayerPedId())
			end)
		elseif Config.SlushyMiniGame.QBLock.enabled then
			local success = exports['qb-lock']:StartLockPickCircle(Config.SlushyMiniGame.QBLock.circles, Config.SlushyMiniGame.QBLock.time, success)
			if success then
				-- TriggerServerEvent("InteractSound_SV:PlayOnSource", "pour-drink", 0.1)
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
				QBCore.Functions.Progressbar("prison_slushy", "Making a Good Slushy...", 10000, false, true, {
					disableMovement = false,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					SlushyTime(success)
					ClearPedTasks(PlayerPedId())
				end, function() -- Cancel
					QBCore.Functions.Notify("Canceled...", "error")
					ClearPedTasks(PlayerPedId())
				end, "slushy")
			else
				QBCore.Functions.Notify("You Failed making a Slushy..", "error")
				ClearPedTasks(PlayerPedId())
			end
		end
	else
		QBCore.Functions.Notify("You are not in Jail..", "error")
	end
end)

-- Slushy Success / Fail
function SlushyTime(success)
	if success then
		local SlushyItems = {}
			SlushyItems.label = "Prison Slushy"
			SlushyItems.items = Config.SlushyItems
			SlushyItems.slots = #Config.SlushyItems
		TriggerServerEvent("inventory:server:OpenInventory", "shop", "Slushyshop_"..math.random(1, 99), SlushyItems)
	else
		QBCore.Functions.Notify("Slushy Machine is Broken", "error")
	end
end

-- Soda Machine
RegisterNetEvent('rs-prison:client:soda', function()
	if inJail then
		Wait(1000)
		local ped = PlayerPedId()
		if Config.SodaMiniGame.PSThermite.enabled then
			exports['ps-ui']:Thermite(function(success)
				if success then
					-- TriggerServerEvent("InteractSound_SV:PlayOnSource", "pour-drink", 0.1)
					TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
					QBCore.Functions.Progressbar("prison_soda", "Making a Cup Of Soda...", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {}, {}, {}, function()
						SodaTime(success)
						ClearPedTasks(PlayerPedId())
					end, function()
						QBCore.Functions.Notify("Canceled...", "error")
						ClearPedTasks(PlayerPedId())
					end, "bscoke")
				else
					QBCore.Functions.Notify("You failed making a Soda..", "error")
					ClearPedTasks(PlayerPedId())
				end
			end, Config.SodaMiniGame.PSThermite.time, Config.SodaMiniGame.PSThermite.grid, Config.SodaMiniGame.PSThermite.incorrect)
		elseif Config.SodaMiniGame.PSCircle.enabled then
			exports['ps-ui']:Circle(function(success)
				if success then
					-- TriggerServerEvent("InteractSound_SV:PlayOnSource", "pour-drink", 0.1)
					TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
					QBCore.Functions.Progressbar("prison_soda", "Making a Cup Of Soda...", 10000, false, true, {
						disableMovement = false,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {}, {}, {}, function()
						SodaTime(success)
						ClearPedTasks(PlayerPedId())
					end, function()
						QBCore.Functions.Notify("Canceled...", "error")
						ClearPedTasks(PlayerPedId())
					end, "bscoke")
				else
					QBCore.Functions.Notify("You failed making a Soda..", "error")
					ClearPedTasks(PlayerPedId())
				end
			end, Config.SodaMiniGame.PSCircle.circles, Config.SodaMiniGame.PSCircle.time) -- NumberOfCircles, MS
		elseif Config.SodaMiniGame.QBSkillbar.enabled then
			local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
			Skillbar.Start({
				duration = Config.SodaMiniGame.QBSkillbar.duration, -- how long the skillbar runs for
				pos = Config.SodaMiniGame.QBSkillbar.pos, -- how far to the right the static box is
				width = Config.SodaMiniGame.QBSkillbar.width, -- how wide the static box is
			}, function()
				-- TriggerServerEvent("InteractSound_SV:PlayOnSource", "pour-drink", 0.1)
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
				QBCore.Functions.Progressbar("prison_soda", "Making a Cup Of Soda...", 10000, false, true, {
					disableMovement = false,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function()
					SodaTime(Skillbar)
					ClearPedTasks(PlayerPedId())
				end, function()
					QBCore.Functions.Notify("Canceled...", "error")
					ClearPedTasks(PlayerPedId())
				end, "bscoke")
			end, function()
				QBCore.Functions.Notify("You failed making a Soda..", "error")
				ClearPedTasks(PlayerPedId())
			end)
		elseif Config.SodaMiniGame.QBLock.enabled then
			local success = exports['qb-lock']:StartLockPickCircle(Config.SodaMiniGame.QBLock.circles, Config.SodaMiniGame.QBLock.time, success)
			if success then
				-- TriggerServerEvent("InteractSound_SV:PlayOnSource", "pour-drink", 0.1)
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
				QBCore.Functions.Progressbar("prison_soda", "Making a Cup Of Soda...", 10000, false, true, {
					disableMovement = false,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function()
					SodaTime(success)
					ClearPedTasks(PlayerPedId())
				end, function()
					QBCore.Functions.Notify("Canceled...", "error")
					ClearPedTasks(PlayerPedId())
				end, "bscoke")
			else
				QBCore.Functions.Notify("You failed making a Soda..", "error")
				ClearPedTasks(PlayerPedId())
			end
		end
	else
		QBCore.Functions.Notify("You are not in Jail..", "error")
	end
end)

-- Soda Success / Fail
function SodaTime(success)
	if success then
		local SodaItems = {}
			SodaItems.label = "Prison Soda"
			SodaItems.items = Config.SodaItems
			SodaItems.slots = #Config.SodaItems
		TriggerServerEvent("inventory:server:OpenInventory", "shop", "Sodashop_"..math.random(1, 99), SodaItems)
	else
		QBCore.Functions.Notify("Soda Machine is Broken", "error")
	end
end

RegisterNetEvent('rs-prison:client:coffee', function()
	if inJail then
		local CoffeeItems = {}
		CoffeeItems.label = "Prison Coffee"
		CoffeeItems.items = Config.CoffeeItems
		CoffeeItems.slots = #Config.CoffeeItems
		TriggerServerEvent("inventory:server:OpenInventory", "shop", "Coffeeshop_"..math.random(1, 99), CoffeeItems)
	else
		QBCore.Functions.Notify("You are not in Jail..", "error")
	end
end)


RegisterNetEvent('rs-prison:client:Slushy', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    QBCore.Functions.Progressbar("drink_something", "Drinking Slushy..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + math.random(35, 54))
    end)
end)

-------------------------------
-- CRAFTING MENU AND EVENTS --
-------------------------------

RegisterNetEvent('rs-prison:CraftingMenu', function()

	local craftingheader = {
	  {
		header = "Prison Crafting",
		isMenuHeader = true,
	  },
	}

	for k, v in pairs(Config.CraftingItems) do
		if Config.Debug then
	  		print(k, v)
		end
		local item = {}
		local text = ""

		item.header = sharedItems[v.receive].label
		for k, v in pairs(v.materials) do
			text = text .. "- " .. QBCore.Shared.Items[v.item].label .. ": " .. v.amount .. "x <br>"
		end
		item.text = text
		item.icon = v.receive
		item.params = {
			event = 'rs-prison:CraftItem',
			args = {
			item = k
			}
		}

		table.insert(craftingheader, item)
	end

	exports['qb-menu']:openMenu(craftingheader)
end)

local function CraftItem(item)
	local craftedItem = Config.CraftingItems[item].receive

	QBCore.Functions.Progressbar('crafting_item', 'Crafting '..sharedItems[craftedItem].label, 5000, false, false, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_ped",
		}, {}, {}, function()
		QBCore.Functions.Notify("Crafted "..item, 'success')
		TriggerServerEvent('rs-prison:server:GetCraftedItem', Config.CraftingItems[item].receive)
		TriggerServerEvent('rs-prison:server:RemoveCraftingItems', item)
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
		QBCore.Functions.Notify('Canceled...', 'error')
	end)

	if Config.Debug then
		print(item, Config.CraftingItems[item].receive)
	  end
end

-- Uses Callback to Check for Materials
RegisterNetEvent('rs-prison:CraftItem', function(data)
	QBCore.Functions.TriggerCallback("rs-prison:server:CraftingMaterials", function(hasMaterials)
		if (hasMaterials) then
			CraftItem(data.item)
		else
			QBCore.Functions.Notify("You do not have the correct items", "error")
			return
		end
	end, Config.CraftingItems[data.item].materials)

	if Config.Debug then
		print(data.item)
	end
end)

----------------------------------
-- JAIL ALARM -- PRISON BREAK --
----------------------------------

CreateThread(function()
    TriggerEvent('prison:client:JailAlarm', false)
	while true do
		local sleep = 1000
		if not LiferCheck() then
			if jailTime ~= nil and jailTime > 0 and inJail then
				Wait(1000 * 60)
				sleep = 0
				if jailTime > 0 and inJail then
					jailTime -= 1
					if jailTime <= 0 then
						jailTime = 0
						QBCore.Functions.Notify(Lang:t("success.timesup"), "success", 10000)
					end
					TriggerServerEvent("prison:server:SetJailStatus", jailTime)

					if Config.QB_PrisonJobs then
						GetJailTime()
					end

				end
			else
				Wait(sleep)
			end
		else
			jailTime = 999
			Wait(sleep)
		end
	end
end)

------------------------------
----- JAIL TIME COMMAND  -----
------------------------------
RegisterCommand('jailtime', function()
	if inJail then
		if not LiferCheck() then
			QBCore.Functions.Notify("You are in jail for "..jailTime.." months.","error")
		else
			QBCore.Functions.Notify("You are in jail for life! Criminal Scum!","error")
		end
	else
		QBCore.Functions.Notify("You're not in jail!","error")
	end
end)