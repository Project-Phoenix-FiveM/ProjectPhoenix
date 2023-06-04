local closestStation = 0
local currentStation = 0
local currentFires = {}
local currentGate = 0
local requiredItems = {[1] = {name = QBCore.Shared.Items["thermite"]["name"], image = QBCore.Shared.Items["thermite"]["image"]}}

-- Functions

--- This will create a fire at the given coords and for the given time
--- @param coords vector3
--- @param time number
--- @return nil
local function CreateFire(coords, time)
    for _ = 1, math.random(1, 7), 1 do
        TriggerServerEvent("thermite:StartServerFire", coords, 24, false)
    end
    Wait(time)
    TriggerServerEvent("thermite:StopFires")
end

--- This will load an animation dictionary so you can play an animation in that dictionary
--- @param dict string
--- @return nil
local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

-- Events

RegisterNetEvent('thermite:StartFire', function(coords, maxChildren, isGasFire)
    if #(vector3(coords.x, coords.y, coords.z) - GetEntityCoords(PlayerPedId())) < 100 then
        local pos = {
            x = coords.x,
            y = coords.y,
            z = coords.z,
        }
        pos.z = pos.z - 0.9
        local fire = StartScriptFire(pos.x, pos.y, pos.z, maxChildren, isGasFire)
        currentFires[#currentFires+1] = fire
    end
end)

RegisterNetEvent('thermite:StopFires', function()
    for i = 1, #currentFires do
        RemoveScriptFire(currentFires[i])
    end
end)

RegisterNetEvent('thermite:UseThermite', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if closestStation ~= 0 then
        Config.OnEvidence(pos, 85)
        local dist = #(pos - Config.PowerStations[closestStation].coords)
        if dist < 1.5 then
            if CurrentCops >= Config.MinimumThermitePolice then
                if not Config.PowerStations[closestStation].hit then
                    loadAnimDict("weapon@w_sp_jerrycan")
                    TaskPlayAnim(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 3.0, 3.9, 180, 49, 0, 0, 0, 0)
                    Config.ShowRequiredItems(requiredItems, false)
                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        action = "openThermite",
                        amount = math.random(5, 10),
                    })
                    currentStation = closestStation
                else
                    QBCore.Functions.Notify(Lang:t("error.fuses_already_blown"), "error")
                end
            else
                QBCore.Functions.Notify(Lang:t("error.minium_police_required", {police = Config.MinimumThermitePolice}), "error")
            end
        end
    elseif currentThermiteGate ~= 0 then
        Config.OnEvidence(pos, 85)
        if CurrentCops >= Config.MinimumThermitePolice then
            currentGate = currentThermiteGate
            loadAnimDict("weapon@w_sp_jerrycan")
            TaskPlayAnim(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 3.0, 3.9, -1, 49, 0, 0, 0, 0)
            Config.ShowRequiredItems(requiredItems, false)
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = "openThermite",
                amount = math.random(5, 10),
            })
        else
            QBCore.Functions.Notify(Lang:t("error.minium_police_required", {police = Config.MinimumThermitePolice}), "error")
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:client:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
end)

-- NUI Callbacks

RegisterNUICallback('thermiteclick', function(_, cb)
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
    cb('ok')
end)

RegisterNUICallback('thermitefailed', function(_, cb)
    QBCore.Functions.TriggerCallback("thermite:server:check", function(success)
        if success then
            PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
            ClearPedTasks(PlayerPedId())
            local coords = GetEntityCoords(PlayerPedId())
            local randTime = math.random(10000, 15000)
            CreateFire(coords, randTime)
        end
        cb('ok')
    end)
end)

RegisterNUICallback('thermitesuccess', function(_, cb)
    QBCore.Functions.TriggerCallback("thermite:server:check", function(success)
        if success then
            ClearPedTasks(PlayerPedId())
            local time = 3
            local coords = GetEntityCoords(PlayerPedId())
            while time > 0 do
                QBCore.Functions.Notify(Lang:t("general.thermite_detonating_in_seconds", {time = time}))
                Wait(1000)
                time -= 1
            end
            local randTime = math.random(10000, 15000)
            CreateFire(coords, randTime)
            if currentStation ~= 0 then
                QBCore.Functions.Notify(Lang:t("success.fuses_are_blown"), "success")
                TriggerServerEvent("qb-bankrobbery:server:SetStationStatus", currentStation, true)
            elseif currentGate ~= 0 then
                QBCore.Functions.Notify(Lang:t("success.door_has_opened"), "success")
                Config.DoorlockAction(currentGate, false)
                currentGate = 0
            end
        end
        cb('ok')
    end)
end)

RegisterNUICallback('closethermite', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Threads

CreateThread(function()
    for k = 1, #Config.PowerStations do
        local stationZone = BoxZone:Create(Config.PowerStations[k].coords, 1.0, 1.0, {
            name = 'powerstation_coords_'..k,
            heading = 90.0,
            minZ = Config.PowerStations[k].coords.z - 1,
            maxZ = Config.PowerStations[k].coords.z + 1,
            debugPoly = false
        })
        stationZone:onPlayerInOut(function(inside)
            if inside and not Config.PowerStations[k].hit then
                closestStation = k
                Config.ShowRequiredItems(requiredItems, true)
            else
                if closestStation == k then
                    closestStation = 0
                    Config.ShowRequiredItems(requiredItems, false)
                end
            end
        end)
    end
end)
