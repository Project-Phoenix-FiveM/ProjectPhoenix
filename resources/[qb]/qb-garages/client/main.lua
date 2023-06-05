local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local PlayerGang = {}
local PlayerJob = {}

local Markers = false
local HouseMarkers = false
local InputIn = false
local InputOut = false
local currentGarage = nil
local currentGarageIndex = nil
local garageZones = {}
local lasthouse = nil
local blipsZonesLoaded = false


--Menus
local function MenuGarage(type, garage, indexgarage)
    local header
    local leave
    if type == "house" then
        header = Lang:t("menu.header." .. type .. "_car", { value = garage.label })
        leave = Lang:t("menu.leave.car")
    else
        header = Lang:t("menu.header." .. type .. "_" .. garage.vehicle, { value = garage.label })
        leave = Lang:t("menu.leave." .. garage.vehicle)
    end

    exports['qb-menu']:openMenu({
        {
            header = header,
            isMenuHeader = true
        },
        {
            header = Lang:t("menu.header.vehicles"),
            txt = Lang:t("menu.text.vehicles"),
            params = {
                event = "qb-garages:client:VehicleList",
                args = {
                    type = type,
                    garage = garage,
                    index = indexgarage,
                }
            }
        },
        {
            header = leave,
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

local function ClearMenu()
    TriggerEvent("qb-menu:closeMenu")
end

local function closeMenuFull()
    ClearMenu()
end

local function DestroyZone(type, index)
    if garageZones[type .. "_" .. index] then
        garageZones[type .. "_" .. index].zonecombo:destroy()
        garageZones[type .. "_" .. index].zone:destroy()
    end
end

local function CreateZone(type, garage, index)
    local size
    local coords
    local heading
    local minz
    local maxz

    if type == 'in' then
        size = 4
        coords = vector3(garage.putVehicle.x, garage.putVehicle.y, garage.putVehicle.z)
        heading = garage.spawnPoint.w
        minz = coords.z - 1.0
        maxz = coords.z + 2.0
    elseif type == 'out' then
        size = 2
        coords = vector3(garage.takeVehicle.x, garage.takeVehicle.y, garage.takeVehicle.z)
        heading = garage.spawnPoint.w
        minz = coords.z - 1.0
        maxz = coords.z + 2.0
    elseif type == 'marker' then
        size = 60
        coords = vector3(garage.takeVehicle.x, garage.takeVehicle.y, garage.takeVehicle.z)
        heading = garage.spawnPoint.w
        minz = coords.z - 7.5
        maxz = coords.z + 7.0
    elseif type == 'hmarker' then
        size = 20
        coords = vector3(garage.takeVehicle.x, garage.takeVehicle.y, garage.takeVehicle.z)
        heading = garage.takeVehicle.w
        minz = coords.z - 4.0
        maxz = coords.z + 2.0
    elseif type == 'house' then
        size = 2
        coords = vector3(garage.takeVehicle.x, garage.takeVehicle.y, garage.takeVehicle.z)
        heading = garage.takeVehicle.w
        minz = coords.z - 1.0
        maxz = coords.z + 2.0
    end
    garageZones[type .. "_" .. index] = {}
    garageZones[type .. "_" .. index].zone = BoxZone:Create(
        coords, size, size, {
        minZ = minz,
        maxZ = maxz,
        name = type,
        debugPoly = false,
        heading = heading
    })

    garageZones[type .. "_" .. index].zonecombo = ComboZone:Create({ garageZones[type .. "_" .. index].zone },
        { name = "box" .. type, debugPoly = false })
    garageZones[type .. "_" .. index].zonecombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            local text
            if type == "in" then
                if garage.type == "house" then
                    text = Lang:t("info.park_e")
                else
                    text = Lang:t("info.park_e") .. "<br>" .. garage.label
                end
                exports['qb-core']:DrawText(text, 'left')
                InputIn = true
            elseif type == "out" then
                if garage.type == "house" then
                    text = Lang:t("info.car_e")
                else
                    text = Lang:t("info." .. garage.vehicle .. "_e") .. "<br>" .. garage.label
                end

                exports['qb-core']:DrawText(text, 'left')
                InputOut = true
            elseif type == "marker" then
                currentGarage = garage
                currentGarageIndex = index
                CreateZone("out", garage, index)
                if garage.type ~= "depot" then
                    CreateZone("in", garage, index)
                    Markers = true
                else
                    HouseMarkers = true
                end
            elseif type == "hmarker" then
                currentGarage = garage
                currentGarage.type = "house"
                currentGarageIndex = index
                CreateZone("house", garage, index)
                HouseMarkers = true
            elseif type == "house" then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['qb-core']:DrawText(Lang:t("info.park_e"), 'left')
                    InputIn = true
                else
                    exports['qb-core']:DrawText(Lang:t("info.car_e"), 'left')
                    InputOut = true
                end
            end
        else
            if type == "marker" then
                if currentGarage == garage then
                    if garage.type ~= "depot" then
                        Markers = false
                    else
                        HouseMarkers = false
                    end
                    DestroyZone("in", index)
                    DestroyZone("out", index)
                    currentGarage = nil
                    currentGarageIndex = nil
                end
            elseif type == "hmarker" then
                HouseMarkers = false
                DestroyZone("house", index)
            elseif type == "house" then
                exports['qb-core']:HideText()
                InputIn = false
                InputOut = false
            elseif type == "in" then
                exports['qb-core']:HideText()
                InputIn = false
            elseif type == "out" then
                closeMenuFull()
                exports['qb-core']:HideText()
                InputOut = false
            end
        end
    end)
end

local function doCarDamage(currentVehicle, veh)
    local engine = veh.engine + 0.0
    local body = veh.body + 0.0

    if Config.VisuallyDamageCars then
        local data = json.decode(veh.mods)

        for k, v in pairs(data.doorStatus) do
            if v then
                SetVehicleDoorBroken(currentVehicle, tonumber(k), true)
            end
        end
        for k, v in pairs(data.tireBurstState) do
            if v then
                SetVehicleTyreBurst(currentVehicle, tonumber(k), true)
            end
        end
        for k, v in pairs(data.windowStatus) do
            if not v then
                SmashVehicleWindow(currentVehicle, tonumber(k))
            end
        end
    end
    SetVehicleEngineHealth(currentVehicle, engine)
    SetVehicleBodyHealth(currentVehicle, body)
end

local function CheckPlayers(vehicle, garage)
    for i = -1, 5, 1 do
        local seat = GetPedInVehicleSeat(vehicle, i)
        if seat then
            TaskLeaveVehicle(seat, vehicle, 0)
            if garage then
                SetEntityCoords(seat, garage.takeVehicle.x, garage.takeVehicle.y, garage.takeVehicle.z)
            end
        end
    end
    SetVehicleDoorsLocked(vehicle)
    Wait(1500)
    QBCore.Functions.DeleteVehicle(vehicle)
end

-- Functions
local function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

RegisterNetEvent("qb-garages:client:VehicleList", function(data)
    local type = data.type
    local garage = data.garage
    local indexgarage = data.index
    local header
    local leave
    if type == "house" then
        header = Lang:t("menu.header." .. type .. "_car", { value = garage.label })
        leave = Lang:t("menu.leave.car")
    else
        header = Lang:t("menu.header." .. type .. "_" .. garage.vehicle, { value = garage.label })
        leave = Lang:t("menu.leave." .. garage.vehicle)
    end

    QBCore.Functions.TriggerCallback("qb-garage:server:GetGarageVehicles", function(result)
        if result == nil then
            QBCore.Functions.Notify(Lang:t("error.no_vehicles"), "error", 5000)
        else
            local MenuGarageOptions = {
                {
                    header = header,
                    isMenuHeader = true
                },
            }
            for _, v in pairs(result) do
                local enginePercent = round(v.engine / 10, 0)
                local bodyPercent = round(v.body / 10, 0)
                local currentFuel = v.fuel
                local vname = nil
                pcall(function ()
                    vname = QBCore.Shared.Vehicles[v.vehicle].name
                end)
                if v.state == 0 then
                    v.state = Lang:t("status.out")
                elseif v.state == 1 then
                    v.state = Lang:t("status.garaged")
                elseif v.state == 2 then
                    v.state = Lang:t("status.impound")
                end
                if type == "depot" and vname ~= nil then
                    MenuGarageOptions[#MenuGarageOptions + 1] = {
                        header = Lang:t('menu.header.depot', { value = vname, value2 = v.depotprice }),
                        txt = Lang:t('menu.text.depot', { value = v.plate, value2 = currentFuel, value3 = enginePercent, value4 = bodyPercent }),
                        params = {
                            event = "qb-garages:client:TakeOutDepot",
                            args = {
                                vehicle = v,
                                type = type,
                                garage = garage,
                                index = indexgarage,
                            }
                        }
                    }
                else
                    -- 
                    local txt = Lang:t('menu.text.garage', { value = v.state, value2 = currentFuel, value3 = enginePercent, value4 = bodyPercent })
                    local menuHeader = Lang:t('menu.header.garage', { value = vname, value2 = v.plate })
                    if vname == nil then
                        menuHeader = Lang:t('menu.header.unavailable_vehicle_model', { vehicle = string.upper(v.vehicle) })
                    end
                    MenuGarageOptions[#MenuGarageOptions + 1] = {
                        header = menuHeader,
                        txt = txt,
                        disabled = vname == nil,
                        params = {
                            event = "qb-garages:client:takeOutGarage",
                            args = {
                                vehicle = v,
                                type = type,
                                garage = garage,
                                index = indexgarage,
                            }
                        }
                    }
                end
            end

            MenuGarageOptions[#MenuGarageOptions + 1] = {
                header = leave,
                txt = "",
                params = {
                    event = "qb-menu:closeMenu",
                }
            }
            exports['qb-menu']:openMenu(MenuGarageOptions)
        end
    end, indexgarage, type, garage.vehicle)
end)

RegisterNetEvent('qb-garages:client:takeOutGarage', function(data)
    local type = data.type
    local vehicle = data.vehicle
    local garage = data.garage
    local index = data.index
    QBCore.Functions.TriggerCallback('qb-garage:server:IsSpawnOk', function(spawn)
        if spawn then
            local location
            if type == "house" then
                if garage.takeVehicle.h then garage.takeVehicle.w = garage.takeVehicle.h end -- backward compatibility
                location = garage.takeVehicle
            else
                location = garage.spawnPoint
            end
            QBCore.Functions.TriggerCallback('qb-garage:server:spawnvehicle', function(netId, properties)
                local veh = NetToVeh(netId)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                exports['cdn-fuel']:SetFuel(veh, vehicle.fuel)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, index)
                closeMenuFull()
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
                if type == "house" then
                    exports['qb-core']:DrawText(Lang:t("info.park_e"), 'left')
                    InputOut = false
                    InputIn = true
                end
            end, vehicle, location, true)
        else
            QBCore.Functions.Notify(Lang:t("error.not_impound"), "error", 5000)
        end
    end, vehicle.plate, type)
end)

local function enterVehicle(veh, indexgarage, type, garage)
    local plate = QBCore.Functions.GetPlate(veh)
    if GetVehicleNumberOfPassengers(veh) == 0 then
        QBCore.Functions.TriggerCallback('qb-garage:server:checkOwnership', function(owned)
            if owned then
                local bodyDamage = math.ceil(GetVehicleBodyHealth(veh))
                local engineDamage = math.ceil(GetVehicleEngineHealth(veh))
                local totalFuel = exports['cdn-fuel']:GetFuel(veh)
                TriggerServerEvent("qb-vehicletuning:server:SaveVehicleProps", QBCore.Functions.GetVehicleProperties(veh))
                TriggerServerEvent('qb-garage:server:updateVehicle', 1, totalFuel, engineDamage, bodyDamage, plate, indexgarage, type, PlayerGang.name)
                CheckPlayers(veh, garage)
                if type == "house" then
                    exports['qb-core']:DrawText(Lang:t("info.car_e"), 'left')
                    InputOut = true
                    InputIn = false
                end

                if plate then
                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicle', plate, nil)
                end
                QBCore.Functions.Notify(Lang:t("success.vehicle_parked"), "primary", 4500)
            else
                QBCore.Functions.Notify(Lang:t("error.not_owned"), "error", 3500)
            end
        end, plate, type, indexgarage, PlayerGang.name)
    else
        QBCore.Functions.Notify(Lang:t("error.vehicle_occupied"), "error", 5000)
    end
end
local function CreateBlipsZones()
    if blipsZonesLoaded then return end
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerGang = PlayerData.gang
    PlayerJob = PlayerData.job
    local function blipZoneGen(setloc)
        local Garage = AddBlipForCoord(setloc.takeVehicle.x, setloc.takeVehicle.y, setloc.takeVehicle.z)
        SetBlipSprite(Garage, setloc.blipNumber)
        SetBlipDisplay(Garage, 4)
        SetBlipScale(Garage, 0.60)
        SetBlipAsShortRange(Garage, true)
        SetBlipColour(Garage, setloc.blipColor)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(setloc.blipName)
        EndTextCommandSetBlipName(Garage)
    end
    for index, garage in pairs(Config.Garages) do
        if garage.showBlip then
            blipZoneGen(garage);
        end
        if garage.type == "job" then
            if PlayerJob.name == garage.job or PlayerJob.type == garage.jobType then
                CreateZone("marker", garage, index)
            end
        elseif garage.type == "gang" then
            if PlayerGang.name == garage.job then
                CreateZone("marker", garage, index)
            end
        else
            CreateZone("marker", garage, index)
        end
    end
    blipsZonesLoaded = true
end

RegisterNetEvent('qb-garages:client:setHouseGarage', function(house, hasKey)
    if Config.HouseGarages[house] then
        if lasthouse ~= house then
            if lasthouse then
                DestroyZone("hmarker", lasthouse)
            end
            if hasKey and Config.HouseGarages[house].takeVehicle.x then
                CreateZone("hmarker", Config.HouseGarages[house], house)
                lasthouse = house
            end
        end
    end
end)

RegisterNetEvent('qb-garages:client:houseGarageConfig', function(garageConfig)
    Config.HouseGarages = garageConfig
end)

RegisterNetEvent('qb-garages:client:addHouseGarage', function(house, garageInfo)
    Config.HouseGarages[house] = garageInfo
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    CreateBlipsZones()
end)

AddEventHandler("onResourceStart", function(res)
    if res ~= GetCurrentResourceName() then return end
    CreateBlipsZones()
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    PlayerGang = gang
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job
end)

RegisterNetEvent('qb-garages:client:TakeOutDepot', function(data)
    local vehicle = data.vehicle

    if vehicle.depotprice ~= 0 then
        TriggerServerEvent("qb-garage:server:PayDepotPrice", data)
    else
        TriggerEvent("qb-garages:client:takeOutGarage", data)
    end
end)

-- Threads
CreateThread(function()
    local sleep
    while true do
        sleep = 2000
        if currentGarage ~= nil then
            if Markers then
                DrawMarker(2, currentGarage.putVehicle.x, currentGarage.putVehicle.y, currentGarage.putVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false, true, false, false, false)
                DrawMarker(2, currentGarage.takeVehicle.x, currentGarage.takeVehicle.y, currentGarage.takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                sleep = 0
            elseif HouseMarkers then
                DrawMarker(2, currentGarage.takeVehicle.x, currentGarage.takeVehicle.y, currentGarage.takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                sleep = 0
            end
            if InputIn or InputOut then
                if IsControlJustReleased(0, 38) then
                    if InputIn then
                        local ped = PlayerPedId()
                        local curVeh = GetVehiclePedIsIn(ped)
                        local vehClass = GetVehicleClass(curVeh)
                        --Check vehicle type for garage
                        if currentGarage.vehicle == "car" or not currentGarage.vehicle then
                            if vehClass ~= 10 and vehClass ~= 14 and vehClass ~= 15 and vehClass ~= 16 and vehClass ~= 20 then
                                if currentGarage.type == "job" then
                                    if PlayerJob.name == currentGarage.job or PlayerJob.type == currentGarage.jobType then
                                        enterVehicle(curVeh, currentGarageIndex, currentGarage.type)
                                    end
                                elseif currentGarage.type == "gang" then
                                    if PlayerGang.name == currentGarage.job or PlayerJob.type == currentGarage.jobType then
                                        enterVehicle(curVeh, currentGarageIndex, currentGarage.type)
                                    end
                                else
                                    enterVehicle(curVeh, currentGarageIndex, currentGarage.type)
                                end
                            else
                                QBCore.Functions.Notify(Lang:t("error.not_correct_type"), "error", 3500)
                            end
                        elseif currentGarage.vehicle == "air" then
                            if vehClass == 15 or vehClass == 16 then
                                if currentGarage.type == "job" then
                                    if PlayerJob.name == currentGarage.job or PlayerJob.type == currentGarage.jobType then
                                        enterVehicle(curVeh, currentGarageIndex, currentGarage.type)
                                    end
                                elseif currentGarage.type == "gang" then
                                    if PlayerGang.name == currentGarage.job or PlayerJob.type == currentGarage.jobType then
                                        enterVehicle(curVeh, currentGarageIndex, currentGarage.type)
                                    end
                                else
                                    enterVehicle(curVeh, currentGarageIndex, currentGarage.type)
                                end
                            else
                                QBCore.Functions.Notify(Lang:t("error.not_correct_type"), "error", 3500)
                            end
                        elseif currentGarage.vehicle == "sea" then
                            if vehClass == 14 then
                                if currentGarage.type == "job" then
                                    if PlayerJob.name == currentGarage.job then
                                        enterVehicle(curVeh, currentGarageIndex, currentGarage.type, currentGarage)
                                    end
                                elseif currentGarage.type == "gang" then
                                    if PlayerGang.name == currentGarage.job then
                                        enterVehicle(curVeh, currentGarageIndex, currentGarage.type, currentGarage)
                                    end
                                else
                                    enterVehicle(curVeh, currentGarageIndex, currentGarage.type, currentGarage)
                                end
                            else
                                QBCore.Functions.Notify(Lang:t("error.not_correct_type"), "error", 3500)
                            end
                        elseif currentGarage.vehicle == "rig" then
                            if vehClass == 10 or vehClass == 11 or vehClass == 12 or vehClass == 20 then
                                if currentGarage.type == "job" then
                                    if PlayerJob.name == currentGarage.job then
                                        enterVehicle(curVeh, currentGarageIndex, currentGarage.type, currentGarage)
                                    end
                                elseif currentGarage.type == "gang" then
                                    if PlayerGang.name == currentGarage.job then
                                        enterVehicle(curVeh, currentGarageIndex, currentGarage.type, currentGarage)
                                    end
                                else
                                    enterVehicle(curVeh, currentGarageIndex, currentGarage.type, currentGarage)
                                end
                            else
                                QBCore.Functions.Notify(Lang:t("error.not_correct_type"), "error", 3500)
                            end
                        end
                    elseif InputOut then
                        if currentGarage.type == "job" then
                            if PlayerJob.name == currentGarage.job then
                                MenuGarage(currentGarage.type, currentGarage, currentGarageIndex)
                            end
                        elseif currentGarage.type == "gang" then
                            if PlayerGang.name == currentGarage.job then
                                MenuGarage(currentGarage.type, currentGarage, currentGarageIndex)
                            end
                        else
                            MenuGarage(currentGarage.type, currentGarage, currentGarageIndex)
                        end
                    end
                end
                sleep = 0
            end
        end
        Wait(sleep)
    end
end)
