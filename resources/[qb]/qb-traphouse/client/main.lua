local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local ClosestTraphouse = nil
local InsideTraphouse = false
local CurrentTraphouse = nil
local TraphouseObj = {}
local POIOffsets = nil
local IsKeyHolder = false
local IsHouseOwner = false
local CanRob = true
local IsRobbingNPC = false
local RobbingTime = 3

-- zone check
local isInsideEntranceTarget = false
local isInsideExitTarget = false
local isInsideInteractionTarget = false

-- Functions

local function RegisterTraphouseEntranceTarget(traphouseID, traphouseData)
    local coords = traphouseData.coords['enter']
    local boxName = 'traphouseEntrance' .. traphouseID
    local boxData = traphouseData.polyzoneBoxData['enter']
    exports['qb-target']:AddBoxZone(boxName, coords, boxData.length, boxData.width, {
        name = boxName,
        heading = boxData.heading,
        debugPoly = boxData.debug,
        minZ = boxData.minZ,
        maxZ = boxData.maxZ,
    }, {
        options = {
            {
                type = 'client',
                event = 'qb-traphouse:client:EnterTraphouse',
                label = Lang:t('targetInfo.enter'),
            },
        },
        distance = boxData.distance
    })

    Config.TrapHouses[traphouseID].polyzoneBoxData['enter'].created = true
end

local function RegisterTraphouseEntranceZone(traphouseID, traphouseData)
    local coords = traphouseData.coords['enter']
    local boxName = 'traphouseEntrance' .. traphouseID
    local boxData = traphouseData.polyzoneBoxData['enter']

    local zone = BoxZone:Create(coords, boxData.length, boxData.width, {
        name = boxName,
        heading = boxData.heading,
        debugPoly = boxData.debug,
        minZ = boxData.minZ,
        maxZ = boxData.maxZ,
    })

    zone:onPlayerInOut(function (isPointInside)
        if isPointInside then
            exports['qb-core']:DrawText('[E] ' .. Lang:t('targetInfo.enter'), 'left')
        else
            exports['qb-core']:HideText()
        end

        isInsideEntranceTarget = isPointInside
    end)

    boxData.created = true
    boxData.zone = zone
end

local function SetTraphouseEntranceTargets()
    if Config.TrapHouses and next(Config.TrapHouses) then
        for id, traphouse in pairs(Config.TrapHouses) do
            if traphouse and traphouse.coords and traphouse.coords['enter'] then
                if Config.UseTarget then
                    RegisterTraphouseEntranceTarget(id, traphouse)
                else
                    RegisterTraphouseEntranceZone(id, traphouse)
                end
            end
        end
    end
end

local function RegisterTraphouseInteractionZone(traphouseID, traphouseData)
    local coords = traphouseData.coords['interaction']
    local boxName = 'traphouseInteraction' .. traphouseID
    local boxData = traphouseData.polyzoneBoxData['interaction']

    local zone = BoxZone:Create(coords, boxData.length, boxData.width, {
        name = boxName,
        heading = boxData.heading,
        debugPoly = boxData.debug,
        minZ = coords.z - 1.0,
        maxZ = coords.z + 1.0,
    })

    zone:onPlayerInOut(function (isPointInside)
        if isPointInside then
            exports['qb-core']:DrawText('[E] ' .. Lang:t('targetInfo.options'), 'left')
        else
            exports['qb-core']:HideText()
            TriggerEvent('qb-traphouse:client:target:CloseMenu')
        end

        isInsideInteractionTarget = isPointInside
    end)

    boxData.created = true
    boxData.zone = zone
end

local function RegisterTraphouseInteractionTarget(traphouseID, traphouseData)
    local coords = traphouseData.coords['interaction']
    local boxName = 'traphouseInteraction' .. traphouseID
    local boxData = traphouseData.polyzoneBoxData['interaction']

    local options = {
        {
            type = "client",
            event = "qb-traphouse:client:target:TakeOver",
            label = Lang:t("targetInfo.take_over"),
        },
    }
    if IsKeyHolder then
        options = {
            {
                type = "client",
                event = "qb-traphouse:client:target:ViewInventory",
                label = Lang:t("targetInfo.inventory"),
                traphouseData = traphouseData
            },
            {
                type = "client",
                event = "qb-traphouse:client:target:TakeMoney",
                label = Lang:t('targetInfo.take_cash', {value = traphouseData.money}),
            },
        }

        if IsHouseOwner then
            options[#options+1] = {
                type = "client",
                event = "qb-traphouse:client:target:SeePinCode",
                label = Lang:t("targetInfo.pin_code_see"),
                traphouseData = traphouseData
            }
        end
    end

    exports['qb-target']:AddBoxZone(boxName, coords, boxData.length, boxData.width, {
        name = boxName,
        heading = boxData.heading,
        debugPoly = boxData.debug,
        minZ = coords.z - 1.0,
        maxZ = coords.z + 1.0,
    }, {
        options = options,
        distance = boxData.distance
    })

    boxData.created = true
end

local function RegisterTraphouseExitZone(coords, traphouseID, traphouseData)
    local boxName = 'traphouseExit' .. traphouseID
    local boxData = traphouseData.polyzoneBoxData['exit']

    local zone = BoxZone:Create(coords, boxData.length, boxData.width, {
        name = boxName,
        heading = boxData.heading,
        debugPoly = boxData.debug,
        minZ = coords.z - 1.0,
        maxZ = coords.z + 1.0,
    })

    zone:onPlayerInOut(function (isPointInside)
        if isPointInside then
            exports['qb-core']:DrawText('[E] ' .. Lang:t("targetInfo.leave"), 'left')
        else
            exports['qb-core']:HideText()
        end

        isInsideExitTarget = isPointInside
    end)

    boxData.created = true
    boxData.zone = zone
end

local function RegisterTraphouseExitTarget(coords, traphouseID, traphouseData)
    local boxName = 'traphouseExit' .. traphouseID
    local boxData = traphouseData.polyzoneBoxData['exit']
    exports['qb-target']:AddBoxZone(boxName, coords, boxData.length, boxData.width, {
        name = boxName,
        heading = boxData.heading,
        debugPoly = boxData.debug,
        minZ = coords.z - 1.0,
        maxZ = coords.z + 1.0,
    }, {
        options = {
            {
                type = "client",
                event = "qb-traphouse:client:target:ExitTraphouse",
                label = Lang:t("targetInfo.leave"),
                traphouseID = traphouseID,
            },
        },
        distance = boxData.distance
    })

    boxData.created = true
end

local function OpenHeaderMenu(data)
    local headerMenu = {}

    headerMenu[#headerMenu+1] = {
        header = Lang:t("targetInfo.options"),
        isMenuHeader = true
    }

    if IsKeyHolder then
        headerMenu[#headerMenu+1] = {
            header = Lang:t("targetInfo.inventory"),
            params = {
                event = "qb-traphouse:client:target:ViewInventory",
                args = {
                    traphouseData = data
                }
            }
        }
        headerMenu[#headerMenu+1] = {
            header = Lang:t('targetInfo.take_cash', {value = data.money}),
            params = {
                event = "qb-traphouse:client:target:TakeMoney"
            }
        }

        if IsHouseOwner then
            headerMenu[#headerMenu+1] = {
                header = Lang:t("targetInfo.pin_code_see"),
                params = {
                    event = "qb-traphouse:client:target:SeePinCode",
                    args = {
                        traphouseData = data
                    }
                }
            }
        end
    else
        headerMenu[#headerMenu+1] = {
            header = Lang:t("targetInfo.take_over"),
            params = {
                event = "qb-traphouse:client:target:TakeOver",
            }
        }
    end

    headerMenu[#headerMenu+1] = {
        header = Lang:t("targetInfo.close_menu"),
        params = {
            event = "qb-traphouse:client:target:CloseMenu",
        }
    }

    exports['qb-menu']:openMenu(headerMenu)
end

local function HasKey(CitizenId)
    local haskey = false
    if ClosestTraphouse ~= nil then
        if Config.TrapHouses[ClosestTraphouse].keyholders ~= nil and next(Config.TrapHouses[ClosestTraphouse].keyholders) ~= nil then
            for _, data in pairs(Config.TrapHouses[ClosestTraphouse].keyholders) do
                if data.citizenid == CitizenId then
                    haskey = true
                end
            end
        end
    end
    return haskey
end

local function IsOwner(CitizenId)
    local retval = false
    if ClosestTraphouse ~= nil then
        if Config.TrapHouses[ClosestTraphouse].keyholders ~= nil and next(Config.TrapHouses[ClosestTraphouse].keyholders) ~= nil then
            for _, data in pairs(Config.TrapHouses[ClosestTraphouse].keyholders) do
                if data.citizenid == CitizenId then
                    if data.owner then
                        retval = true
                    else
                        retval = false
                    end
                end
            end
        end
    end
    return retval
end

local function SetClosestTraphouse()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for id, _ in pairs(Config.TrapHouses) do
        if current ~= nil then
            if #(pos - Config.TrapHouses[id].coords.enter) < dist then
                current = id
                dist = #(pos - Config.TrapHouses[id].coords.enter)
            end
        else
            dist = #(pos - Config.TrapHouses[id].coords.enter)
            current = id
        end
    end
    ClosestTraphouse = current
    IsKeyHolder = HasKey(PlayerData.citizenid)
    IsHouseOwner = IsOwner(PlayerData.citizenid)
end

local function EnterTraphouse(data)
    local coords = { x = data.coords["enter"].x, y = data.coords["enter"].y, z= data.coords["enter"].z - Config.MinZOffset}
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    data = exports['qb-interior']:CreateTrevorsShell(coords)
    TraphouseObj = data[1]
    POIOffsets = data[2]
    CurrentTraphouse = ClosestTraphouse
    InsideTraphouse = true
    TriggerEvent('qb-weathersync:client:DisableSync')
    FreezeEntityPosition(TraphouseObj, true)
end

local function LeaveTraphouse(k, data)
    local ped = PlayerPedId()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    DoScreenFadeOut(250)
    Wait(250)
    exports['qb-interior']:DespawnInterior(TraphouseObj, function()
        TriggerEvent('qb-weathersync:client:EnableSync')
        DoScreenFadeIn(250)
        SetEntityCoords(ped, data.coords["enter"].x, data.coords["enter"].y, data.coords["enter"].z + 0.5)
        SetEntityHeading(ped, 107.71)
        TraphouseObj = nil
        POIOffsets = nil
        CurrentTraphouse = nil
        InsideTraphouse = false
    end)

    if Config.UseTarget then
        exports['qb-target']:RemoveZone('traphouseInteraction' .. k)
        data.polyzoneBoxData['interaction'].created = false

        exports['qb-target']:RemoveZone('traphouseExit' .. k)
        data.polyzoneBoxData['exit'].created = false
    else
        if Config.TrapHouses[k] and Config.TrapHouses[k].polyzoneBoxData['interaction'] and Config.TrapHouses[k].polyzoneBoxData['interaction'].zone then
            Config.TrapHouses[k].polyzoneBoxData['interaction'].zone:destroy()
            Config.TrapHouses[k].polyzoneBoxData['interaction'].created = false
            Config.TrapHouses[k].polyzoneBoxData['interaction'].zone = nil
        end

        if Config.TrapHouses[k] and Config.TrapHouses[k].polyzoneBoxData['exit'] and Config.TrapHouses[k].polyzoneBoxData['exit'].zone then
            Config.TrapHouses[k].polyzoneBoxData['exit'].zone:destroy()
            Config.TrapHouses[k].polyzoneBoxData['exit'].created = false
            Config.TrapHouses[k].polyzoneBoxData['exit'].zone = nil
        end

        isInsideExitTarget = false
        isInsideInteractionTarget = false
    end
end

local function RobTimeout(timeout)
    SetTimeout(timeout, function()
        CanRob = true
    end)
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('qb-traphouse:client:EnterTraphouse', function()
    if ClosestTraphouse ~= nil then
        local data = Config.TrapHouses[ClosestTraphouse]
        if not IsKeyHolder then
            SendNUIMessage({
                action = "open"
            })
            SetNuiFocus(true, true)
        else
            EnterTraphouse(data)
        end
    end
end)

RegisterNetEvent('qb-traphouse:client:TakeoverHouse', function(TraphouseId)
    QBCore.Functions.Progressbar("takeover_traphouse", Lang:t("info.taking_over"), math.random(1000, 3000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-traphouse:server:AddHouseKeyHolder', PlayerData.citizenid, TraphouseId, true)
    end, function()
        QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
    end)
end)

RegisterNetEvent('qb-traphouse:client:target:ViewInventory', function (data)
    local TraphouseInventory = {}
    TraphouseInventory.label = "traphouse_"..CurrentTraphouse
    TraphouseInventory.items = data.traphouseData.inventory
    TraphouseInventory.slots = 2
    TriggerServerEvent("inventory:server:OpenInventory", "traphouse", TraphouseInventory.label, TraphouseInventory)
end)

RegisterNetEvent('qb-traphouse:client:target:TakeOver', function ()
    TriggerServerEvent('qb-traphouse:server:TakeoverHouse', CurrentTraphouse)
end)

RegisterNetEvent('qb-traphouse:client:target:TakeMoney', function ()
    TriggerServerEvent("qb-traphouse:server:TakeMoney", CurrentTraphouse)
end)

RegisterNetEvent('qb-traphouse:client:target:SeePinCode', function (data)
    QBCore.Functions.Notify(Lang:t('info.pin_code', { value = data.traphouseData.pincode }))
end)

RegisterNetEvent('qb-traphouse:client:target:ExitTraphouse', function (data)
    LeaveTraphouse(data.traphouseID, Config.TrapHouses[data.traphouseID])
end)

RegisterNetEvent('qb-traphouse:client:SyncData', function(k, data)
    Config.TrapHouses[k] = data
    IsKeyHolder = HasKey(PlayerData.citizenid)
    IsHouseOwner = IsOwner(PlayerData.citizenid)

    if Config.UseTarget then
        exports['qb-target']:RemoveZone('traphouseInteraction' .. k)
        Config.TrapHouses[k].polyzoneBoxData['interaction'].created = false
    else
        if Config.TrapHouses[k] and Config.TrapHouses[k].polyzoneBoxData['interaction'] and Config.TrapHouses[k].polyzoneBoxData['interaction'].zone then
            Config.TrapHouses[k].polyzoneBoxData['interaction'].zone:destroy()
            Config.TrapHouses[k].polyzoneBoxData['interaction'].created = false
            Config.TrapHouses[k].polyzoneBoxData['interaction'].zone = nil
        end

        isInsideInteractionTarget = false
    end
end)

RegisterNetEvent('qb-traphouse:client:target:CloseMenu', function ()
    TriggerEvent('qb-menu:client:closeMenu')
end)


-- NUI

RegisterNUICallback('PinpadClose', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('ErrorMessage', function(data, cb)
    QBCore.Functions.Notify(data.message, 'error')
    cb('ok')
end)

RegisterNUICallback('EnterPincode', function(d, cb)
    local data = Config.TrapHouses[ClosestTraphouse]
    if tonumber(d.pin) == data.pincode then
        EnterTraphouse(data)
    else
        QBCore.Functions.Notify(Lang:t("error.incorrect_code"), 'error')
    end
    cb('ok')
end)

-- Threads

CreateThread(function()
    while true do
        local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
        if targetPed ~= 0 and not IsPedAPlayer(targetPed) then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            if ClosestTraphouse ~= nil then
                local data = Config.TrapHouses[ClosestTraphouse]
                local dist = #(pos - data.coords["enter"])
                if dist < 200 then
                    if aiming then
                        local pcoords = GetEntityCoords(targetPed)
                        local peddist = #(pos - pcoords)
                        local InDistance = false
                        if peddist < 4 then
                            InDistance = true
                            if not IsRobbingNPC and CanRob then
                                if IsPedInAnyVehicle(targetPed) then
                                    TaskLeaveVehicle(targetPed, GetVehiclePedIsIn(targetPed), 1)
                                end
                                Wait(500)
                                InDistance = true

                                local dict = 'random@mugging3'
                                RequestAnimDict(dict)
                                while not HasAnimDictLoaded(dict) do
                                    Wait(10)
                                end

                                SetEveryoneIgnorePlayer(PlayerId(), true)
                                TaskStandStill(targetPed, RobbingTime * 1000)
                                FreezeEntityPosition(targetPed, true)
                                SetBlockingOfNonTemporaryEvents(targetPed, true)
                                TaskPlayAnim(targetPed, dict, 'handsup_standing_base', 2.0, -2, 15.0, 1, 0, 0, 0, 0)
                                for _ = 1, RobbingTime / 2, 1 do
                                    PlayPedAmbientSpeechNative(targetPed, "GUN_BEG", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                                    Wait(2000)
                                end
                                FreezeEntityPosition(targetPed, true)
                                IsRobbingNPC = true
                                SetTimeout(RobbingTime, function()
                                    IsRobbingNPC = false
                                    RobTimeout(math.random(30000, 60000))
                                    if not IsEntityDead(targetPed) then
                                        if CanRob then
                                            if InDistance then
                                                SetEveryoneIgnorePlayer(PlayerId(), false)
                                                SetBlockingOfNonTemporaryEvents(targetPed, false)
                                                FreezeEntityPosition(targetPed, false)
                                                ClearPedTasks(targetPed)
                                                AddShockingEventAtPosition(99, GetEntityCoords(targetPed), 0.5)
                                                TriggerServerEvent('qb-traphouse:server:RobNpc', ClosestTraphouse)
                                                CanRob = false
                                            end
                                        end
                                    end
                                end)
                            end
                        else
                            if InDistance then
                                InDistance = false
                            end
                        end
                    end
                end
            else
                Wait(1000)
            end
        end
        Wait(3)
    end
end)

CreateThread(function ()
    local wait = 500
    while not LocalPlayer.state.isLoggedIn do
        -- do nothing
        Wait(wait)
    end

    SetTraphouseEntranceTargets()

    if QBCore.Functions.GetPlayerData() ~= nil then
        PlayerData = QBCore.Functions.GetPlayerData()
    end

    while true do
        wait = 500
        SetClosestTraphouse()

        if ClosestTraphouse ~= nil then
            if not InsideTraphouse then
                if isInsideEntranceTarget then
                    wait = 0
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent("qb-traphouse:client:EnterTraphouse")
                        exports['qb-core']:HideText()
                    end
                end
            else
                local data = Config.TrapHouses[ClosestTraphouse]
                if not data.polyzoneBoxData['exit'].created then
                    local exitCoords = vector3(data.coords["enter"].x + POIOffsets.exit.x, data.coords["enter"].y + POIOffsets.exit.y, data.coords["enter"].z - Config.MinZOffset + POIOffsets.exit.z)
                    if Config.UseTarget then
                        RegisterTraphouseExitTarget(exitCoords, CurrentTraphouse, data)
                    else
                        RegisterTraphouseExitZone(exitCoords, CurrentTraphouse, data)
                    end
                end

                if not data.polyzoneBoxData['interaction'].created then
                    if Config.UseTarget then
                        RegisterTraphouseInteractionTarget(CurrentTraphouse, data)
                    else
                        RegisterTraphouseInteractionZone(CurrentTraphouse, data)
                    end
                end

                if isInsideExitTarget then
                    wait = 0
                    if IsControlJustPressed(0, 38) then
                        LeaveTraphouse(ClosestTraphouse, data)
                        exports['qb-core']:HideText()
                    end
                end

                if isInsideInteractionTarget then
                    wait = 0
                    if IsControlJustPressed(0, 38) then
                        OpenHeaderMenu(data)
                        exports['qb-core']:HideText()
                    end
                end
            end
        end
        Wait(wait)
    end

end)
