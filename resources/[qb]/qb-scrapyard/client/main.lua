local QBCore = exports['qb-core']:GetCoreObject()
local emailSend = false
local isBusy = false

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    TriggerServerEvent("qb-scrapyard:server:LoadVehicleList")
end)

CreateThread(function()
    for id in pairs(Config.Locations) do
        local blip = AddBlipForCoord(Config.Locations[id]["main"].x, Config.Locations[id]["main"].y, Config.Locations[id]["main"].z)
        SetBlipSprite(blip, 380)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 9)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Lang:t('text.scrapyard'))
        EndTextCommandSetBlipName(blip)
    end
end)

local listen = false
local function KeyListener(type)
    CreateThread(function()
        listen = true
        while listen do
            if IsControlPressed(0, 38) then
                exports['qb-core']:KeyPressed()
            if type == 'deliver' then
                ScrapVehicle()
            else
                if not IsPedInAnyVehicle(PlayerPedId()) and not emailSend then
                    CreateListEmail()
                end
            end
            break
            end
            Wait(0)
        end
    end)
end

CreateThread(function()
    local scrapPoly = {}
    for i = 1,#Config.Locations,1 do
        for k,v in pairs(Config.Locations[i]) do
            if k ~= 'main' then
                if Config.UseTarget then
                    if k == 'deliver' then
                        exports["qb-target"]:AddBoxZone("yard"..i, v.coords, v.length, v.width, {
                            name = "yard"..i,
                            heading = v.heading,
                            minZ = v.coords.z - 1,
                            maxZ = v.coords.z + 1,
                        }, {
                                options = {
                                    {
                                        action = function()
                                            ScrapVehicle()
                                        end,
                                        icon = "fa fa-wrench",
                                        label = Lang:t('text.disassemble_vehicle_target'),
                                    }
                                },
                            distance = 3
                        })
                    else
                        exports["qb-target"]:AddBoxZone("list"..i, v.coords, v.length, v.width, {
                            name = "list"..i,
                            heading = v.heading,
                            minZ = v.coords.z - 1,
                            maxZ = v.coords.z + 1,
                        }, {
                            options = {
                                {
                                    action = function()
                                        if not IsPedInAnyVehicle(PlayerPedId()) and not emailSend then
                                            CreateListEmail()
                                        end
                                    end,
                                    icon = "fa fa-envelop",
                                    label = Lang:t('text.email_list_target'),
                                }
                            },
                            distance = 1.5
                        })
                    end
                else
                    scrapPoly[#scrapPoly+1] = BoxZone:Create(vector3(v.coords.x, v.coords.y, v.coords.z), v.length, v.width, {
                        heading = v.heading,
                        name = k..i,
                        debugPoly = false,
                        minZ = v.coords.z - 1,
                        maxZ = v.coords.z + 1,
                    })
                    local scrapCombo = ComboZone:Create(scrapPoly, {name = "scrapPoly"})
                    scrapCombo:onPlayerInOut(function(isPointInside)
                        if isPointInside then
                            if not isBusy then
                                if k == 'deliver' then
                                    exports['qb-core']:DrawText(Lang:t('text.disassemble_vehicle'),'left')
                                else
                                    exports['qb-core']:DrawText(Lang:t('text.email_list'),'left')
                                end
                                KeyListener(k)
                            end
                        else
                            listen = false
                            exports['qb-core']:HideText()
                        end
                    end)
                end
            end
        end
    end
end)

RegisterNetEvent('qb-scapyard:client:setNewVehicles', function(vehicleList)
    Config.CurrentVehicles = vehicleList
end)

function CreateListEmail()
    if Config.CurrentVehicles ~= nil and next(Config.CurrentVehicles) ~= nil then
        emailSend = true
        local vehicleList = ""
        for k, v in pairs(Config.CurrentVehicles) do
            if Config.CurrentVehicles[k] ~= nil then
                local vehicleInfo = QBCore.Shared.Vehicles[v]
                if vehicleInfo ~= nil then
                    vehicleList = vehicleList  .. vehicleInfo["brand"] .. " " .. vehicleInfo["name"] .. "<br />"
                end
            end
        end
        SetTimeout(math.random(15000, 20000), function()
            emailSend = false
            TriggerServerEvent('qb-phone:server:sendNewMail', {
                sender = Lang:t('email.sender'),
                subject = Lang:t('email.subject'),
                message = Lang:t('email.message').. vehicleList,
                button = {}
            })
        end)
    else
        QBCore.Functions.Notify(Lang:t('error.demolish_vehicle'), "error")
    end
end

function ScrapVehicle()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    if vehicle ~= 0 and vehicle ~= nil then
        if not isBusy then
            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                if IsVehicleValid(GetEntityModel(vehicle)) then
                    local vehiclePlate = QBCore.Functions.GetPlate(vehicle)
                    QBCore.Functions.TriggerCallback('qb-scrapyard:checkOwnerVehicle',function(retval)
                        if retval then
                            isBusy = true
                            local scrapTime = math.random(28000, 37000)
                            ScrapVehicleAnim(scrapTime)
                            QBCore.Functions.Progressbar("scrap_vehicle", Lang:t('text.demolish_vehicle'), scrapTime, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                TriggerServerEvent("qb-scrapyard:server:ScrapVehicle", GetVehicleKey(GetEntityModel(vehicle)))
                                SetEntityAsMissionEntity(vehicle, true, true)
                                DeleteVehicle(vehicle)
                                isBusy = false
                            end, function() -- Cancel
                                isBusy = false
                                QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
                            end)
                        else
                            QBCore.Functions.Notify(Lang:t('error.smash_own'), "error")
                        end
                    end,vehiclePlate)
                else
                    QBCore.Functions.Notify(Lang:t('error.cannot_scrap'), "error")
                end
            else
                QBCore.Functions.Notify(Lang:t('error.not_driver'), "error")
            end
        end
    end
end

function IsVehicleValid(vehicleModel)
    local retval = false
    if Config.CurrentVehicles ~= nil and next(Config.CurrentVehicles) ~= nil then
        for k in pairs(Config.CurrentVehicles) do
            if Config.CurrentVehicles[k] ~= nil and GetHashKey(Config.CurrentVehicles[k]) == vehicleModel then
                retval = true
            end
        end
    end
    return retval
end

function GetVehicleKey(vehicleModel)
    local retval = 0
    if Config.CurrentVehicles ~= nil and next(Config.CurrentVehicles) ~= nil then
        for k in pairs(Config.CurrentVehicles) do
            if GetHashKey(Config.CurrentVehicles[k]) == vehicleModel then
                retval = k
            end
        end
    end
    return retval
end

function ScrapVehicleAnim(time)
    time = (time / 1000)
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    local openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            time = time - 2
            if time <= 0 or not isBusy then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end
