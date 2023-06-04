ObjectList = {}
local DecoMode = false
local MainCamera = nil
local curPos
local speeds = {0.01, 0.05, 0.1, 0.2, 0.4, 0.5}
local curSpeed = 1
local cursorEnabled = false
local SelectedObj = nil
local SelObjHash = {}
local SelObjPos = {}
local SelObjRot = {}
local SelObjId = 0
local isEdit = false
local rotateActive = false
local peanut = false
local previewObj = nil

-- Functions

local function openDecorateUI()
	SetNuiFocus(true, true)
	cursorEnabled = true
	SendNUIMessage({
		type = "openObjects",
		furniture = Config.Furniture,
	})
	SetCursorLocation(0.5, 0.5)
end

local function closeDecorateUI()
	SetNuiFocus(false, false)
	cursorEnabled = false
	SendNUIMessage({
		type = "closeUI",
	})
end

local function CreateEditCamera()
	local rot = GetEntityRotation(PlayerPedId())
	local pos = GetEntityCoords(PlayerPedId(), true)
	MainCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 60.00, false, 0)
	SetCamActive(MainCamera, true)
	RenderScriptCams(true, false, 1, true, true)
end

local function EnableEditMode()
	local pos = GetEntityCoords(PlayerPedId(), true)
	curPos = {x = pos.x, y = pos.y, z = pos.z}
	SetEntityVisible(PlayerPedId(), false)
	FreezeEntityPosition(PlayerPedId(), true)
	SetEntityCollision(PlayerPedId(), false, false)
	CreateEditCamera()
	DecoMode = true
	TriggerEvent('qb-anticheat:client:ToggleDecorate', true)
end

local function SaveDecorations()
	if ClosestHouse then
		if SelectedObj then
			if SelObjId ~= 0 then
				ObjectList[SelObjId] = {hashname = SelObjHash, x = SelObjPos.x, y = SelObjPos.y, z = SelObjPos.z, rotx = SelObjRot.x, roty = SelObjRot.y, rotz = SelObjRot.z, object = SelectedObj, objectId = SelObjId}
			else
				if ObjectList then
					ObjectList[#ObjectList+1] = {hashname = SelObjHash, x = SelObjPos.x, y = SelObjPos.y, z = SelObjPos.z, rotx = SelObjRot.x, roty = SelObjRot.y, rotz = SelObjRot.z, object = SelectedObj, objectId = #ObjectList+1}
				else
					ObjectList[1] = {hashname = SelObjHash, x = SelObjPos.x, y = SelObjPos.y, z = SelObjPos.z, rotx = SelObjRot.x, roty = SelObjRot.y, rotz = SelObjRot.z, object = SelectedObj, objectId = 1}
				end
			end

			for _, v in pairs(ObjectList) do
				DeleteObject(v.object)
			end
		end
		TriggerServerEvent("qb-houses:server:savedecorations", ClosestHouse, ObjectList)
	end
end

local function SetDefaultCamera()
	RenderScriptCams(false, true, 500, true, true)
	SetCamActive(MainCamera, false)
	DestroyCam(MainCamera, true)
	DestroyAllCams(true)
end

local function DisableEditMode()
	SaveDecorations()
	SetEntityVisible(PlayerPedId(), true)
	FreezeEntityPosition(PlayerPedId(), false)
	SetEntityCollision(PlayerPedId(), true, true)
	SetDefaultCamera()
	EnableAllControlActions(0)
	ObjectList = nil
	SelectedObj = nil
	peanut = false
	DecoMode = false
	TriggerEvent('qb-anticheat:client:ToggleDecorate', false)
end

local function CheckObjMovementInput()
	local xVect = speeds[curSpeed]
    local yVect = speeds[curSpeed]
    local zVect = speeds[curSpeed]

    if IsControlPressed( 1, 27) or IsDisabledControlPressed(1, 27) then -- Up Arrow
		SelObjPos = GetOffsetFromEntityInWorldCoords(SelectedObj, 0, -yVect, 0)
    end

    if IsControlPressed( 1, 173) or IsDisabledControlPressed(1, 173) then -- Down Arrow
		SelObjPos = GetOffsetFromEntityInWorldCoords(SelectedObj, 0, yVect, 0)
    end

    if IsControlPressed( 1, 174) or IsDisabledControlPressed(1, 174) then -- Left Arrow
		SelObjPos = GetOffsetFromEntityInWorldCoords(SelectedObj, xVect, 0, 0)
    end

    if IsControlPressed( 1, 175) or IsDisabledControlPressed(1, 175) then -- Right Arrow
		SelObjPos = GetOffsetFromEntityInWorldCoords(SelectedObj, -xVect, 0, 0)
    end

    if IsControlPressed( 1, 10) or IsDisabledControlPressed(1, 10) then -- Page Up
		SelObjPos = GetOffsetFromEntityInWorldCoords(SelectedObj, 0, 0, zVect)
    end

    if IsControlPressed( 1, 11) or IsDisabledControlPressed(1, 11) then -- Page Down
		SelObjPos = GetOffsetFromEntityInWorldCoords(SelectedObj, 0, 0, -zVect)
    end

	SetEntityCoords(SelectedObj, SelObjPos.x, SelObjPos.y, SelObjPos.z)
end

local function CheckObjRotationInput()
	local xVect = speeds[curSpeed] * 5.5
    local yVect = speeds[curSpeed] * 5.5
    local zVect = speeds[curSpeed] * 5.5

	if IsControlPressed( 1, 27) or IsDisabledControlPressed(1, 27) then -- Up Arrow
		SelObjRot.x = SelObjRot.x + xVect
    end

    if IsControlPressed( 1, 173) or IsDisabledControlPressed(1, 173) then -- Down Arrow
		SelObjRot.x = SelObjRot.x - xVect
    end

    if IsControlPressed( 1, 174) or IsDisabledControlPressed(1, 174) then -- Left Arrow
		SelObjRot.z = SelObjRot.z + zVect
    end

    if IsControlPressed( 1, 175) or IsDisabledControlPressed(1, 175) then -- Right Arrow
		SelObjRot.z = SelObjRot.z - zVect
    end

    if IsControlPressed( 1, 10) or IsDisabledControlPressed(1, 10) then -- Page Up
		SelObjRot.y = SelObjRot.y + yVect
    end

    if IsControlPressed( 1, 11) or IsDisabledControlPressed(1, 11) then -- Page Down
		SelObjRot.y = SelObjRot.y - yVect
    end

	SetEntityRotation(SelectedObj, SelObjRot.x, SelObjRot.y, SelObjRot.z)
end

local function CheckRotationInput()
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(MainCamera, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		local new_z = rotation.z + rightAxisX*-1.0*(2.0)*(4.0+0.1)
		local new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(2.0)*(4.0+0.1)), -20.5)
		SetCamRot(MainCamera, new_x, 0.0, new_z, 2)
	end
end

local function getTableLength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

local function degToRad( degs )
    return degs * 3.141592653589793 / 180
end

local function CheckMovementInput()
	local rotation = GetCamRot(MainCamera, 2)

	if IsControlJustReleased(0, 21) then -- Left Shift
		curSpeed = curSpeed + 1
		if curSpeed > getTableLength(speeds) then
			curSpeed = 1
		end
		QBCore.Functions.Notify(Lang:t("info.speed").. tostring(speeds[curSpeed]))
	end

	local xVect = speeds[curSpeed] * math.sin( degToRad( rotation.z ) ) * -1.0
    local yVect = speeds[curSpeed] * math.cos( degToRad( rotation.z ) )
    local zVect = speeds[curSpeed] * math.tan( degToRad( rotation.x ) - degToRad( rotation.y ))

    if IsControlPressed( 1, 32) or IsDisabledControlPressed(1, 32) then -- W
		curPos.x = curPos.x + xVect
		curPos.y = curPos.y + yVect
		curPos.z = curPos.z + zVect
    end

    if IsControlPressed( 1, 33) or IsDisabledControlPressed(1, 33) then -- S
		curPos.x = curPos.x - xVect
        curPos.y = curPos.y - yVect
        curPos.z = curPos.z - zVect
	end

	SetCamCoord(MainCamera, curPos.x, curPos.y, curPos.z)
end

-- Events

RegisterNetEvent('qb-houses:client:decorate', function()
	Wait(500)
	if IsInside then
		if HasHouseKey then
			if not DecoMode then
				EnableEditMode()
				openDecorateUI()
			end
		else
			QBCore.Functions.Notify(Lang:t("error.no_keys"), "error")
		end
	else
		QBCore.Functions.Notify(Lang:t("error.not_in_house"), "error")
	end
end)

-- NUI Callbacks

RegisterNUICallback("closedecorations", function(_, cb)
	if previewObj then
		DeleteObject(previewObj)
	end
	DisableEditMode()
    SetNuiFocus(false, false)
	cursorEnabled = false
	cb("ok")
end)

RegisterNUICallback("deleteSelectedObject", function(_, cb)
	DeleteObject(SelectedObj)
	SelectedObj = nil
	table.remove(ObjectList, SelObjId)
	Wait(100)
	SaveDecorations()
	SelObjId = 0
	peanut = false
	cb("ok")
end)

RegisterNUICallback("cancelSelectedObject", function(_, cb)
	DeleteObject(SelectedObj)
	SelectedObj = nil
	SelObjId = 0
	peanut = false
	cb("ok")
end)

RegisterNUICallback("buySelectedObject", function(data, cb)
    QBCore.Functions.TriggerCallback('qb-houses:server:buyFurniture', function(isSuccess)
        if isSuccess then
            SetNuiFocus(false, false)
            cursorEnabled = false
            SaveDecorations()
            SelectedObj = nil
            SelObjId = 0
            peanut = false
        else
            DeleteObject(SelectedObj)
            SelectedObj = nil
            SelObjId = 0
            peanut = false
        end
		cb('ok')
    end, data.price)
end)

RegisterNUICallback('setupMyObjects', function(_, cb)
	local Objects = {}
	for k, v in pairs(ObjectList) do
		if ObjectList[k] then
			Objects[#Objects+1] = {
				rotx = v.rotx,
				object = v.object,
				y = v.y,
				hashname = v.hashname,
				x = v.x,
				rotz = v.rotz,
				objectId = v.objectId,
				roty = v.roty,
				z = v.z,
			}
		end
	end
	Wait(100)

	cb(Objects)
end)

RegisterNUICallback('removeObject', function(_, cb)
	if previewObj then
		DeleteObject(previewObj)
	end
	cb("ok")
end)

RegisterNUICallback('toggleCursor', function(_, cb)
	cursorEnabled = not cursorEnabled
	SetNuiFocus(cursorEnabled, cursorEnabled)
	cb("ok")
end)

RegisterNUICallback('selectOwnedObject', function(data, cb)
	local objectData = data.objectData
	local ownedObject = GetClosestObjectOfType(objectData.x, objectData.y, objectData.z, 1.5, GetHashKey(objectData.hashname), false, 6, 7)
	local pos = GetEntityCoords(ownedObject, true)
    local rot = GetEntityRotation(ownedObject)
    SelObjRot = {x = rot.x, y = rot.y, z = rot.z}
	SelObjPos = {x = pos.x, y = pos.y, z = pos.z}
	SelObjHash = objectData.hashname
	SelObjId = objectData.objectId
	SelectedObj = ownedObject
	FreezeEntityPosition(SelectedObj, true)
	peanut = true
	cb("ok")
end)

RegisterNUICallback('editOwnedObject', function(data, cb)
	SetNuiFocus(false, false)
	cursorEnabled = false
	local objectData = data.objectData
	local ownedObject = GetClosestObjectOfType(objectData.x, objectData.y, objectData.z, 1.5, GetHashKey(objectData.hashname), false, 6, 7)
	local pos = GetEntityCoords(ownedObject, true)
	local rot = GetEntityRotation(ownedObject)
    SelObjRot = {x = rot.x, y = rot.y, z = rot.z}
	SelObjPos = {x = pos.x, y = pos.y, z = pos.z}
	SelObjHash = objectData.hashname
	SelObjId = objectData.objectId
	SelectedObj = ownedObject
	isEdit = true
	FreezeEntityPosition(SelectedObj, true)
	peanut = true
	cb("ok")
end)

RegisterNUICallback('deselectOwnedObject', function(_, cb)
	SelectedObj = nil
	peanut = false
	cb("ok")
end)

RegisterNUICallback('ResetSelectedProp', function(_, cb)
	SelectedObj = nil
	peanut = false
	cb("ok")
end)

RegisterNUICallback("spawnobject", function(data, cb)
	SetNuiFocus(false, false)
	cursorEnabled = false
	if previewObj then
		DeleteObject(previewObj)
	end
	local modelHash = GetHashKey(tostring(data.object))
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
	    Wait(1000)
	end
	local rotation = GetCamRot(MainCamera, 2)
	local xVect = 2.5 * math.sin( degToRad( rotation.z ) ) * -1.0
	local yVect = 2.5 * math.cos( degToRad( rotation.z ) )
    SelectedObj = CreateObject(modelHash, curPos.x + xVect, curPos.y + yVect, curPos.z, false, false, false)
    local pos = GetEntityCoords(SelectedObj, true)
    local rot = GetEntityRotation(SelectedObj)
    SelObjRot = {x = rot.x, y = rot.y, z = rot.z}
	SelObjPos = {x = pos.x, y = pos.y, z = pos.z}
	SelObjHash = data.object
	PlaceObjectOnGroundProperly(SelectedObj)
	SetEntityCompletelyDisableCollision(SelectedObj, true) -- Prevents crazy physics when collidin with other entitys
    peanut = true
	cb("ok")
end)

RegisterNUICallback("chooseobject", function(data, cb)
	if previewObj then
		DeleteObject(previewObj)
	end
    local modelHash = GetHashKey(tostring(data.object))
	RequestModel(modelHash)

	local count = 0
	while not HasModelLoaded(modelHash) do
		-- Counter to prevent infinite loading when object does not exist
		if count > 10 then
			break
		end
		count = count + 1
	    Wait(1000)
	end

	-- Make buttons selectable again
	SendNUIMessage({
		type = "objectLoaded",
	})

	local rotation = GetCamRot(MainCamera, 2)
	local xVect = 2.5 * math.sin( degToRad( rotation.z ) ) * -1.0
    local yVect = 2.5 * math.cos( degToRad( rotation.z ) )
    previewObj = CreateObject(modelHash, curPos.x + xVect, curPos.y + yVect, curPos.z, false, false, false)
    PlaceObjectOnGroundProperly(previewObj)
	cb("ok")
end)

-- Threads

CreateThread(function()
	while true do
		Wait(7)
		if DecoMode then
			DisableAllControlActions(0)
			EnableControlAction(0, 32, true) -- W
			EnableControlAction(0, 33, true) -- S
			EnableControlAction(0, 245, true) -- T
			EnableControlAction(0, 21, true) -- Left Shift
			EnableControlAction(0, 19, true) -- Left Alt
			EnableControlAction(0, 288, true) -- F1
            EnableControlAction(0, 289, true) -- F2
            EnableControlAction(0, 170, true) -- F3
			EnableControlAction(0, 191, true) -- Enter
			EnableControlAction(0, 174, true) -- Left Arrow
			EnableControlAction(0, 175, true) -- Right Arrow
			EnableControlAction(0, 27, true) -- Up Arrow
			EnableControlAction(0, 173, true) -- Down Arrow
			EnableControlAction(0, 10, true) -- Page Up
            EnableControlAction(0, 11, true) -- Page Down
            EnableControlAction(0, 194, true) -- Backspace

			DisplayRadar(false)

			CheckRotationInput()
            CheckMovementInput()

			if SelectedObj and peanut then
		SetEntityDrawOutline(SelectedObj)
		SetEntityDrawOutlineColor(116, 189, 252, 100)
                DrawMarker(21, SelObjPos.x, SelObjPos.y, SelObjPos.z + 1.28, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.6, 0.6, 0.6, 28, 149, 255, 100, true, true, 2, false, false, false, false)
                if rotateActive then
                    CheckObjRotationInput()
                else
                    CheckObjMovementInput()
                end
                if IsControlJustReleased(0, 170) then -- F3
                    rotateActive = not rotateActive
				end
				if IsControlJustReleased(0, 19) then -- Left Alt
					PlaceObjectOnGroundProperly(SelectedObj)
					local groundPos = GetEntityCoords(SelectedObj)
					SelObjPos = groundPos
                end
				if IsControlJustReleased(0, 191) then -- Enter
					SetNuiFocus(true, true)
					cursorEnabled = true
					if not isEdit then
						SendNUIMessage({
							type = "buyOption",
						})
					else
						SetNuiFocus(false, false)
						cursorEnabled = false
						SaveDecorations()
						SelectedObj = nil
						SelObjId = 0
						peanut = false
						isEdit = false
					end
				end
			else
				if IsControlJustPressed(0, 166) then -- F5
					if not cursorEnabled then
						SetNuiFocus(true, true)
						cursorEnabled = true
					end
				end
                        end
		end
	end
end)

-- Out of area
CreateThread(function()
	while true do
		Wait(7)
		if DecoMode then
			local camPos = GetCamCoord(MainCamera)
			local dist = #(vector3(camPos.x, camPos.y, camPos.z) - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
			if dist > 50.0 then
				DisableEditMode()
				closeDecorateUI()
				QBCore.Functions.Notify(Lang:t("error.out_range"), 'error')
			end
		end
	end
end)
