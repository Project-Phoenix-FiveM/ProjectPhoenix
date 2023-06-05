local isInVehControl = false
local windowState1 = true
local windowState2 = true
local windowState3 = true
local windowState4 = true

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		if LeaveRunning then
			local playerPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			if IsPedInAnyVehicle(playerPed, false) and IsControlPressed(2, 75) and not IsEntityDead(playerPed) then
                Citizen.Wait(150)
				if IsPedInAnyVehicle(playerPed, false) and IsControlPressed(2, 75) and not IsEntityDead(playerPed) then
					SetVehicleEngineOn(vehicle, true, true, false)
					TaskLeaveVehicle(playerPed, vehicle, 0)
				end
			end
		end
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and DisableSeatShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
    end
end)

-----------------------------------------------------------------------------
-- NUI OPEN EXPORT/EVENT
-----------------------------------------------------------------------------

RegisterCommand("vehcontrol", function(source, args, rawCommand)
	if IsPedInAnyVehicle(PlayerPedId(), false) and not IsPauseMenuActive() then
		openVehControl()
	end
end, false)

RegisterKeyMapping('vehcontrol', 'Open Vehicle Menu', 'keyboard', DefaultOpen)

function openExternal()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		openVehControl()
	end
end

RegisterNetEvent('vehcontrol:openExternal')
AddEventHandler('vehcontrol:openExternal', function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		openVehControl()
	end
end)

-----------------------------------------------------------------------------
-- NUI OPEN/CLOSE FUNCTIONS
-----------------------------------------------------------------------------

function openVehControl()
	isInVehControl = true
	SetNuiFocus(true, true)
	SendNUIMessage({
		type = "openGeneral"
	})
end

function closeVehControl()
	isInVehControl = false
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "closeAll"
	})
end

RegisterNUICallback('NUIFocusOff', function()
	isInVehControl = false
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "closeAll"
	})
end)

-----------------------------------------------------------------------------
-- NUI CALLBACKS
-----------------------------------------------------------------------------

RegisterNUICallback('ignition', function()
    EngineControl()
end)

RegisterNUICallback('interiorLight', function()
	InteriorLightControl()
end)

RegisterNUICallback('doors', function(data, cb)
	DoorControl(data.door)
end)

RegisterNUICallback('seatchange', function(data, cb)
	SeatControl(data.seat)
end)

RegisterNUICallback('windows', function(data, cb)
	WindowControl(data.window, data.door)
end)

RegisterNUICallback('bombbay', function()
	BombBayControl()
end)

-----------------------------------------------------------------------------
-- ACTION FUNCTIONS
-----------------------------------------------------------------------------

function EngineControl()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end

function InteriorLightControl()
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if IsVehicleInteriorLightOn(vehicle) then
			SetVehicleInteriorlight(vehicle, false)
		else
			SetVehicleInteriorlight(vehicle, true)
		end
	end
end

function DoorControl(door)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
			SetVehicleDoorShut(vehicle, door, false)
		else
			SetVehicleDoorOpen(vehicle, door, false)
		end
	end
end

function SeatControl(seat)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if IsVehicleSeatFree(vehicle, seat) then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicle, seat)
		end
	end
end

function WindowControl(window, door)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if window == 0 then
			if windowState1 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState1 = false
			else
				RollUpWindow(vehicle, window)
				windowState1 = true
			end
		elseif window == 1 then
			if windowState2 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState2 = false
			else
				RollUpWindow(vehicle, window)
				windowState2 = true
			end
		elseif window == 2 then
			if windowState3 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState3 = false
			else
				RollUpWindow(vehicle, window)
				windowState3 = true
			end
		elseif window == 3 then
			if windowState4 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState4 = false
			else
				RollUpWindow(vehicle, window)
				windowState4 = true
			end
		end
	end
end

function FrontWindowControl()
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if windowState1 == true or windowState2 == true then
			RollDownWindow(vehicle, 0)
			RollDownWindow(vehicle, 1)
			windowState1 = false
			windowState2 = false
		else
			RollUpWindow(vehicle, 0)
			RollUpWindow(vehicle, 1)
			windowState1 = true
			windowState2 = true
		end
	end
end

function BackWindowControl()
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if windowState3 == true or windowState4 == true then
			RollDownWindow(vehicle, 2)
			RollDownWindow(vehicle, 3)
			windowState3 = false
			windowState4 = false
		else
			RollUpWindow(vehicle, 2)
			RollUpWindow(vehicle, 3)
			windowState3 = true
			windowState4 = true
		end
	end
end

function AllWindowControl()
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if windowState1 == true or windowState2 == true or windowState3 == true or windowState4 == true then
			RollDownWindow(vehicle, 0)
			RollDownWindow(vehicle, 1)
			RollDownWindow(vehicle, 2)
			RollDownWindow(vehicle, 3)
			windowState1 = false
			windowState2 = false
			windowState3 = false
			windowState4 = false
		else
			RollUpWindow(vehicle, 0)
			RollUpWindow(vehicle, 1)
			RollUpWindow(vehicle, 2)
			RollUpWindow(vehicle, 3)
			windowState1 = true
			windowState2 = true
			windowState3 = true
			windowState4 = true
		end
	end
end

function BombBayControl()
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if AreBombBayDoorsOpen(vehicle) then
			CloseBombBayDoors(vehicle)
		else
			OpenBombBayDoors(vehicle)
		end
	end
end

-----------------------------------------------------------------------------
-- VEHICLE COMMANDS
-----------------------------------------------------------------------------
if UseCommands then
	-- ENGINE
	TriggerEvent('chat:addSuggestion', '/engine', 'Start/Stop Engine')

	RegisterCommand("engine", function(source, args, rawCommand)
		EngineControl()
	end, false)

	-- DOORS
	TriggerEvent('chat:addSuggestion', '/door', 'Open/Close Vehicle Door', {
		{ name="ID", help="1) Driver, 2) Passenger, 3) Driver Side Rear, 4) Passenger Side Rear" }
	})

	RegisterCommand("door", function(source, args, rawCommand)
		local doorID = tonumber(args[1])
		if doorID ~= nil then
			if doorID == 1 then
				DoorControl(0)
			elseif doorID == 2 then
				DoorControl(1)
			elseif doorID == 3 then
				DoorControl(2)
			elseif doorID == 4 then
				DoorControl(3)
			end
		else
			TriggerEvent("chatMessage", "Usage: ", {255, 0, 0}, "/door [door id]")
		end
	end, false)

	-- SEAT
	TriggerEvent('chat:addSuggestion', '/seat', 'Move to a seat', {
		{ name="ID", help="1) Driver, 2) Passenger, 3) Driver Side Rear, 4) Passenger Side Rear" }
	})

	RegisterCommand("seat", function(source, args, rawCommand)
		local seatID = tonumber(args[1])
		if seatID ~= nil then
			if seatID == 1 then
				SeatControl(-1)
			elseif seatID == 2 then
				SeatControl(0)
			elseif seatID == 3 then
				SeatControl(1)
			elseif seatID == 4 then
				SeatControl(2)
			end
		else
			TriggerEvent("chatMessage", "Usage: ", {255, 0, 0}, "/seat [seat id]")
		end
	end, false)

	-- WINDOWS
	TriggerEvent('chat:addSuggestion', '/window', 'Roll Up/Down Window', {
		{ name="ID", help="1) Driver, 2) Passenger, 3) Driver Side Rear, 4) Passenger Side Rear" }
	})

	RegisterCommand("window", function(source, args, rawCommand)
		local windowID = tonumber(args[1])
		
		if windowID ~= nil then
			if windowID == 1 then
				WindowControl(0, 0)
			elseif windowID == 2 then
				WindowControl(1, 1)
			elseif windowID == 3 then
				WindowControl(2, 2)
			elseif windowID == 4 then
				WindowControl(3, 3)
			end
		else
			TriggerEvent("chatMessage", "Usage: ", {255, 0, 0}, "/window [door id]")
		end
	end, false)

	-- HOOD
	TriggerEvent('chat:addSuggestion', '/hood', 'Open/Close Hood')

	RegisterCommand("hood", function(source, args, rawCommand)
		DoorControl(4)
	end, false)

	-- TRUNK
	TriggerEvent('chat:addSuggestion', '/trunk', 'Open/Close Trunk')

	RegisterCommand("trunk", function(source, args, rawCommand)
		DoorControl(5)
	end, false)

	-- FRONT WINDOWS
	TriggerEvent('chat:addSuggestion', '/windowfront', 'Roll Up/Down Front Windows')

	RegisterCommand("windowfront", function(source, args, rawCommand)
		FrontWindowControl()
	end, false)

	-- BACK WINDOWS
	TriggerEvent('chat:addSuggestion', '/windowback', 'Roll Up/Down Back Windows')

	RegisterCommand("windowback", function(source, args, rawCommand)
		BackWindowControl()
	end, false)

	-- ALL WINDOWS
	TriggerEvent('chat:addSuggestion', '/windowall', 'Roll Up/Down All Windows')

	RegisterCommand("windowall", function(source, args, rawCommand)
		AllWindowControl()
	end, false)
end

-- FORCE CLOSE
RegisterCommand("vehcontrolclose", function(source, args, rawCommand)
	closeVehControl()
end, false)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
