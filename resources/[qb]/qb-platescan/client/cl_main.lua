local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = nil
local lastVeh = nil
local lastPlate = nil
local PlayerData = {}

local class = {
    [0] = Lang:t('info.class.compact'),
    [1] = Lang:t('info.class.sedan'),
    [2] = Lang:t('info.class.suv'),
    [3] = Lang:t('info.class.coupe'),
    [4] = Lang:t('info.class.muscle'),
    [5] = Lang:t('info.class.sports_classic'),
    [6] = Lang:t('info.class.sports'),
    [7] = Lang:t('info.class.super'),
    [8] = Lang:t('info.class.motorcycle'),
    [9] = Lang:t('info.class.offroad'),
    [10] = Lang:t('info.class.industrial'),
    [11] = Lang:t('info.class.utility'),
    [12] = Lang:t('info.class.van'),
    [17] = Lang:t('info.class.service'),
    [19] = Lang:t('info.class.military'),
    [20] = Lang:t('info.class.truck'),
}

local function IsPhoneActive()
	local retval
	if Config.GKSPhone then
		retval = exports["gksphone"]:CheckOpenPhone()
	else
		retval = exports["qb-phone"]:IsPhoneOpen()
	end
	return retval
end

local function vehicleData(vehicle)
	local vData = {
		name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))),
		class = class[GetVehicleClass(vehicle)],
	}
	return vData
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
		local PlayerData = QBCore.Functions.GetPlayerData()
        PlayerJob = PlayerData.job
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerJob = nil
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    PlayerJob = PlayerData.job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    PlayerJob = PlayerData.job
end)

RegisterNetEvent("qb-platescan:client:AddStolenPlate", function(veh, plate)
    local vehicle = vehicleData(veh)
    local vData = {
        veh = veh,
        plate = plate,
        name = vehicle.name,
        class = vehicle.class, 
    }
    if Config.Debug then print("Plate marked as stolen") end
    TriggerServerEvent("qb-platescan:server:AddStolenPlate", vData)
end)

RegisterNetEvent("qb-platescan:client:ScanPlate", function(vData, locked)
    local pData, scanStatus, plateStatus
    local flagReason = {}
    if Config.Debug then print(json.encode(vData)) end
    if vData.warrant or vData.stolen or vData.bolo then
        scanStatus = "bad"
        plateStatus = Lang:t('info.status.flagged')
        if vData.warrant then table.insert(flagReason, Lang:t('info.status.warrant')) end
        if vData.stolen then table.insert(flagReason, Lang:t('info.status.stolen')) end
        if vData.bolo then table.insert(flagReason, Lang:t('info.status.bolo')) end
        if Config.LockOnFlag and not locked then
            TriggerEvent("wk:togglePlateLock", "front", true, true)
        end
    else
        scanStatus = "good"
        plateStatus = Lang:t('info.status.negative')
    end
    pData = {
        length = Config.NotifDuration,
        netId = vData.id,
        info = ('[%s]'):format(vData.plate),
        info2 = vData.owner,
        info3 = vData.name..", "..vData.class,
        plateStatus = plateStatus,
        flagReason = flagReason,
    }

    exports['ps-dispatch']:ScanPlate(pData, scanStatus)
end)

local function whitelistedVehicle()
    local ped = PlayerPedId()
    local veh = GetEntityModel(GetVehiclePedIsIn(ped))
    local retval = false

    for i = 1, #Config.AllowedVehicles, 1 do
        if veh == GetHashKey(Config.AllowedVehicles[i].model) then
            retval = true
        end
    end

    if veh == GetHashKey("dynasty") then
        retval = true
    end

    return retval
end

RegisterCommand('+platescan', function()
	if PlayerJob.name ~= "police" then return end
	if not IsPedInAnyPoliceVehicle(PlayerPedId()) then return end
	if IsPhoneActive() or IsPauseMenuActive() or IsAimCamActive() then return end
	local data, vData, vehicle = exports["wk_wars2x"]:GetFrontPlate(), {}
	if data.veh ~= nil and data.veh ~= 0 then
		lastVeh = data.veh
		lastPlate = data.plate
		vehicle = vehicleData(data.veh)
		vData = {
			locked = data.locked,
			veh = data.veh,
			plate = data.plate,
			name = vehicle.name,
			class = vehicle.class,
		}
	else
		vehicle = vehicleData(lastVeh)
		vData = {
			locked = data.locked,
			veh = lastVeh,
			plate = lastPlate,
			name = vehicle.name,
			class = vehicle.class,
		}
	end
	TriggerServerEvent("qb-platescan:server:ScanPlate", vData)
end)

RegisterKeyMapping('+platescan', 'Scan Plate (Police)', 'mouse_button', 'MOUSE_LEFT')

RegisterNetEvent('qb-platescan:client:qbTargetPlate', function(entity)
	local PlayerData = QBCore.Functions.GetPlayerData()
	local plate = QBCore.Functions.GetPlate(entity)
	local vehicle = vehicleData(entity)
	vData = {
		locked = GetVehicleDoorLockStatus(entity),
		veh = entity,
		plate = QBCore.Functions.GetPlate(entity),
		name = vehicle.name,
		class = vehicle.class,
	}
	TriggerServerEvent("qb-platescan:server:ScanPlate", vData)
end)

RegisterNetEvent('qb-platescan:client:oxTargetPlate', function(vData)
	local PlayerData = QBCore.Functions.GetPlayerData()
	local plate = QBCore.Functions.GetPlate(vData.entity)
	local vehicle = vehicleData(vData.entity)
	vData = {
		locked = GetVehicleDoorLockStatus(vData.entity),
		veh = vData.entity,
		plate = QBCore.Functions.GetPlate(vData.entity),
		name = vehicle.name,
		class = vehicle.class,
	}
	TriggerServerEvent("qb-platescan:server:ScanPlate", vData)
end)

CreateThread(function()
    if Config.OxTarget then
	    local options = {
	    	{
	    	name = 'Read Plate',
	    	icon = 'fa-solid fa-car',
	    	label = 'Scan Plate',
	    	bones = {'numberplate', 'exhaust'},
	    	groups = 'police',
	    	distance = 5.0,
	    	onSelect = function(data)
	    		TriggerEvent('qb-platescan:client:oxTargetPlate', data)
	    	end,
	    	}
	    }
	    exports.ox_target:addGlobalVehicle(options)
    else
        local bones = {
            'numberplate',
            'exhaust'
          }
        exports['qb-target']:AddTargetBone(bones, {
            options = {
              {
                num = 1,
                icon = 'fa-solid fa-car',
                label = 'Scan Plate',
                action = function(entity)
                  TriggerEvent('qb-platescan:client:qbTargetPlate', entity)
                end,
                job = 'police',
              },
              
            },
        distance = 4.0,
        })
    end
end)

CreateThread(function()
    if exports['qb-config']:isPaidEnabled("avScripts") then
        if Config.OxTarget then
            local options = {
                {
                name = 'Check Vin',
                icon = 'fa-solid fa-car',
                label = 'Check Vin',
                bones = {'bonnet'},
                groups = 'police',
                distance = 5.0,
                onSelect = function(data)
                local res = exports['av_boosting']:getVin()
                    if res then
                        QBCore.Functions.Notify("Vin Number Does Not Match", 'error')
                    else
                        QBCore.Functions.Notify("Vin Number Matches Vehicle", 'success')
                    end
                end,
                }
            }
            exports.ox_target:addGlobalVehicle(options)
        else
            local bones = {
                'bonnet'
            }
            exports['qb-target']:AddTargetBone(bones, {
                options = {
                {
                    num = 1,
                    icon = 'fa-solid fa-car',
                    label = 'Check Vin',
                    action = function(entity)
                        local res = exports['av_boosting']:getVin()
                        if res then
                            QBCore.Functions.Notify("Vin Number Does Not Match", 'error')
                        else
                            QBCore.Functions.Notify("Vin Number Matches Vehicle", 'success')
                        end
                    end,
                    job = 'police',
                },
                
                },
            distance = 4.0,
            })
        end
    end
end)