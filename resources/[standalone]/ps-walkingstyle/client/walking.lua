local QBCore = exports['qb-core']:GetCoreObject()
local walkstyle = 'default'
local walktable = {}
local walkpause = false

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(2000)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local savedwalk = GetResourceKvpString('walkstyles')
    if savedwalk then walktable = json.decode(savedwalk) end

    if walktable[PlayerData.citizenid] then
        walkstyle = walktable[PlayerData.citizenid]
    end
end)

RegisterNetEvent('ps-walks:walkpause', function()
	walkpause = not walkpause
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Wait(2000)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local savedwalk = GetResourceKvpString('walkstyles')
    if savedwalk then walktable = json.decode(savedwalk) end

    if walktable[PlayerData.citizenid] then
        walkstyle = walktable[PlayerData.citizenid]
    end
end)

local function saveWalks()
    SetResourceKvp('walkstyles', json.encode(walktable))
end

local function SetWalks(anim)
	local ped = PlayerPedId()
	if anim == 'default' then
		ResetPedMovementClipset(ped)
		ResetPedWeaponMovementClipset(ped)
		ResetPedStrafeClipset(ped)
	else
		RequestAnimSet(anim)
		while not HasAnimSetLoaded(anim) do Wait(0) end
		SetPedMovementClipset(ped, anim)
		ResetPedWeaponMovementClipset(ped)
		ResetPedStrafeClipset(ped)
	end
end

RegisterNetEvent('ps-walks:set', function(data)
    local anim = Config.WalkingSyles[data.id]
	walkstyle = anim
	SetWalks(anim)
    local PlayerData = QBCore.Functions.GetPlayerData()
    walktable[PlayerData.citizenid] = anim
    saveWalks()
end)

CreateThread(function()
    while true do
        Wait(1000)
		if not walkpause then
			local ped = PlayerPedId()
			local walkstyleCurrent = GetPedMovementClipset(ped)
			if walkstyleCurrent ~= joaat(walkstyle) or walkstyle == "default" then
				SetWalks(walkstyle)
			end
		end
    end
end)