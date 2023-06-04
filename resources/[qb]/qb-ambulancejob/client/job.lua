local PlayerJob = {}
local onDuty = false
local currentGarage = 0
local currentHospital

-- Functions

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]
    QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
        local veh = NetToVeh(netId)
        SetVehicleNumberPlateText(veh, Lang:t('info.amb_plate') .. tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        if Config.VehicleSettings[vehicleInfo] ~= nil then
            QBCore.Shared.SetDefaultVehicleExtras(veh, Config.VehicleSettings[vehicleInfo].extras)
        end
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, vehicleInfo, coords, true)
end

function MenuGarage()
    local vehicleMenu = {
        {
            header = Lang:t('menu.amb_vehicles'),
            isMenuHeader = true
        }
    }

    local authorizedVehicles = Config.AuthorizedVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu + 1] = {
            header = label,
            txt = "",
            params = {
                event = "ambulance:client:TakeOutVehicle",
                args = {
                    vehicle = veh
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu + 1] = {
        header = Lang:t('menu.close'),
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

-- Events

RegisterNetEvent('ambulance:client:TakeOutVehicle', function(data)
    local vehicle = data.vehicle
    TakeOutVehicle(vehicle)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    if PlayerJob.name == 'ambulance' then
        onDuty = PlayerJob.onduty
        if PlayerJob.onduty then
            TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
        else
            TriggerServerEvent("hospital:server:RemoveDoctor", PlayerJob.name)
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    exports.spawnmanager:setAutoSpawn(false)
    local ped = PlayerPedId()
    local player = PlayerId()
    CreateThread(function()
        Wait(5000)
        SetEntityMaxHealth(ped, 200)
        SetEntityHealth(ped, 200)
        SetPlayerHealthRechargeMultiplier(player, 0.0)
        SetPlayerHealthRechargeLimit(player, 0.0)
    end)
    CreateThread(function()
        Wait(1000)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
            onDuty = PlayerData.job.onduty
            SetPedArmour(PlayerPedId(), PlayerData.metadata["armor"])
            if (not PlayerData.metadata["inlaststand"] and PlayerData.metadata["isdead"]) then
                deathTime = Config.ReviveInterval
                OnDeath()
                DeathTimer()
            elseif (PlayerData.metadata["inlaststand"] and not PlayerData.metadata["isdead"]) then
                SetLaststand(true)
            else
                TriggerServerEvent("hospital:server:SetDeathStatus", false)
                TriggerServerEvent("hospital:server:SetLaststandStatus", false)
            end
            if PlayerJob.name == 'ambulance' and onDuty then
                TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
            end
        end)
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    if PlayerJob.name == 'ambulance' and onDuty then
        TriggerServerEvent("hospital:server:RemoveDoctor", PlayerJob.name)
    end
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    if PlayerJob.name == 'ambulance' and duty ~= onDuty then
        if duty then
            TriggerServerEvent("hospital:server:AddDoctor", PlayerJob.name)
        else
            TriggerServerEvent("hospital:server:RemoveDoctor", PlayerJob.name)
        end
    end

    onDuty = duty
end)

function Status()
    if isStatusChecking then
        local statusMenu = {
            {
                header = Lang:t('menu.status'),
                isMenuHeader = true
            }
        }
        for _, v in pairs(statusChecks) do
            statusMenu[#statusMenu + 1] = {
                header = v.label,
                txt = "",
                params = {
                    event = "hospital:client:TreatWounds",
                }
            }
        end
        statusMenu[#statusMenu + 1] = {
            header = Lang:t('menu.close'),
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }
        }
        exports['qb-menu']:openMenu(statusMenu)
    end
end

RegisterNetEvent('hospital:client:CheckStatus', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 5.0 then
        local playerId = GetPlayerServerId(player)
        QBCore.Functions.TriggerCallback('hospital:GetPlayerStatus', function(result)
            if result then
                for k, v in pairs(result) do
                    if k ~= "BLEED" and k ~= "WEAPONWOUNDS" then
                        statusChecks[#statusChecks + 1] = { bone = Config.BoneIndexes[k],
                            label = v.label .. " (" .. Config.WoundStates[v.severity] .. ")" }
                    elseif result["WEAPONWOUNDS"] then
                        for _, v2 in pairs(result["WEAPONWOUNDS"]) do
                            TriggerEvent('chat:addMessage', {
                                color = { 255, 0, 0 },
                                multiline = false,
                                args = { Lang:t('info.status'), QBCore.Shared.Weapons[v2].damagereason }
                            })
                        end
                    elseif result["BLEED"] > 0 then
                        TriggerEvent('chat:addMessage', {
                            color = { 255, 0, 0 },
                            multiline = false,
                            args = { Lang:t('info.status'),
                                Lang:t('info.is_status', { status = Config.BleedingStates[v].label }) }
                        })
                    else
                        QBCore.Functions.Notify(Lang:t('success.healthy_player'), 'success')
                    end
                end
                isStatusChecking = true
                Status()
            end
        end, playerId)
    else
        QBCore.Functions.Notify(Lang:t('error.no_player'), 'error')
    end
end)

RegisterNetEvent('hospital:client:RevivePlayer', function()
    local hasItem = QBCore.Functions.HasItem('firstaid')
    if hasItem then
        local player, distance = GetClosestPlayer()
        if player ~= -1 and distance < 5.0 then
            local playerId = GetPlayerServerId(player)
            QBCore.Functions.Progressbar("hospital_revive", Lang:t('progress.revive'), 5000, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = healAnimDict,
                anim = healAnim,
                flags = 33,
            }, {}, {}, function() -- Done
                StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                QBCore.Functions.Notify(Lang:t('success.revived'), 'success')
                TriggerServerEvent("hospital:server:RevivePlayer", playerId)
            end, function() -- Cancel
                StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
            end)
        else
            QBCore.Functions.Notify(Lang:t('error.no_player'), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t('error.no_firstaid'), "error")
    end
end)

RegisterNetEvent('hospital:client:TreatWounds', function()
    local hasItem = QBCore.Functions.HasItem('bandage')
    if hasItem then
        local player, distance = GetClosestPlayer()
        if player ~= -1 and distance < 5.0 then
            local playerId = GetPlayerServerId(player)
            QBCore.Functions.Progressbar("hospital_healwounds", Lang:t('progress.healing'), 5000, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = healAnimDict,
                anim = healAnim,
                flags = 33,
            }, {}, {}, function() -- Done
                StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                QBCore.Functions.Notify(Lang:t('success.helped_player'), 'success')
                TriggerServerEvent("hospital:server:TreatWounds", playerId)
            end, function() -- Cancel
                StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
            end)
        else
            QBCore.Functions.Notify(Lang:t('error.no_player'), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t('error.no_bandage'), "error")
    end
end)

local check = false
local function EMSControls(variable)
    CreateThread(function()
        check = true
        while check do
            if IsControlJustPressed(0, 38) then
                exports['qb-core']:KeyPressed(38)
                if variable == "sign" then
                    TriggerEvent('EMSToggle:Duty')
                elseif variable == "stash" then
                    TriggerEvent('qb-ambulancejob:stash')
                elseif variable == "armory" then
                    TriggerEvent('qb-ambulancejob:armory')
                elseif variable == "storeheli" then
                    TriggerEvent('qb-ambulancejob:storeheli')
                elseif variable == "takeheli" then
                    TriggerEvent('qb-ambulancejob:pullheli')
                elseif variable == "roof" then
                    TriggerEvent('qb-ambulancejob:elevator_main')
                elseif variable == "main" then
                    TriggerEvent('qb-ambulancejob:elevator_roof')
                end
            end
            Wait(1)
        end
    end)
end

RegisterNetEvent('qb-ambulancejob:stash', function()
    if onDuty then
        TriggerServerEvent("inventory:server:OpenInventory", "stash",
            "ambulancestash_" .. QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "ambulancestash_" .. QBCore.Functions.GetPlayerData().citizenid)
    end
end)

RegisterNetEvent('qb-ambulancejob:armory', function()
    if onDuty then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", Config.Items)
    end
end)

local CheckVehicle = false
local function EMSVehicle(k)
    CheckVehicle = true
    CreateThread(function()
        while CheckVehicle do
            if IsControlJustPressed(0, 38) then
                exports['qb-core']:KeyPressed(38)
                CheckVehicle = false
                local ped = PlayerPedId()
                if IsPedInAnyVehicle(ped, false) then
                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
                else
                    local currentVehicle = k
                    MenuGarage(currentVehicle)
                    currentGarage = currentVehicle
                end
            end
            Wait(1)
        end
    end)
end

local CheckHeli = false
local function EMSHelicopter(k)
    CheckHeli = true
    CreateThread(function()
        while CheckHeli do
            if IsControlJustPressed(0, 38) then
                exports['qb-core']:KeyPressed(38)
                CheckHeli = false
                local ped = PlayerPedId()
                if IsPedInAnyVehicle(ped, false) then
                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
                else
                    local currentHelictoper = k
                    local coords = Config.Locations["helicopter"][currentHelictoper]
                    QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
                        local veh = NetToVeh(netId)
                        SetVehicleNumberPlateText(veh, Lang:t('info.heli_plate') .. tostring(math.random(1000, 9999)))
                        SetEntityHeading(veh, coords.w)
                        SetVehicleLivery(veh, 1) -- Ambulance Livery
                        exports['LegacyFuel']:SetFuel(veh, 100.0)
                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                        SetVehicleEngineOn(veh, true, true)
                    end, Config.Helicopter, coords, true)
                end
            end
            Wait(1)
        end
    end)
end

RegisterNetEvent('qb-ambulancejob:elevator_roof', function()
    local ped = PlayerPedId()
    for k, _ in pairs(Config.Locations["roof"]) do
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Wait(10)
        end

        currentHospital = k

        local coords = Config.Locations["main"][currentHospital]
        SetEntityCoords(ped, coords.x, coords.y, coords.z, 0, 0, 0, false)
        SetEntityHeading(ped, coords.w)

        Wait(100)

        DoScreenFadeIn(1000)
    end
end)

RegisterNetEvent('qb-ambulancejob:elevator_main', function()
    local ped = PlayerPedId()
    for k, _ in pairs(Config.Locations["main"]) do
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Wait(10)
        end

        currentHospital = k

        local coords = Config.Locations["roof"][currentHospital]
        SetEntityCoords(ped, coords.x, coords.y, coords.z, 0, 0, 0, false)
        SetEntityHeading(ped, coords.w)

        Wait(100)

        DoScreenFadeIn(1000)
    end
end)

RegisterNetEvent('EMSToggle:Duty', function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
    TriggerServerEvent("police:server:UpdateBlips")
end)

CreateThread(function()
    for k, v in pairs(Config.Locations["vehicle"]) do
        local boxZone = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 5, 5, {
            name = "vehicle" .. k,
            debugPoly = false,
            heading = 70,
            minZ = v.z - 2,
            maxZ = v.z + 2,
        })
        boxZone:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name == "ambulance" and onDuty then
                exports['qb-core']:DrawText(Lang:t('text.veh_button'), 'left')
                EMSVehicle(k)
            else
                CheckVehicle = false
                exports['qb-core']:HideText()
            end
        end)
    end

    for k, v in pairs(Config.Locations["helicopter"]) do
        local boxZone = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 5, 5, {
            name = "helicopter" .. k,
            debugPoly = false,
            heading = 70,
            minZ = v.z - 2,
            maxZ = v.z + 2,
        })
        boxZone:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name == "ambulance" and onDuty then
                exports['qb-core']:DrawText(Lang:t('text.heli_button'), 'left')
                EMSHelicopter(k)
            else
                CheckHeli = false
                exports['qb-core']:HideText()
            end
        end)
    end
end)

-- Convar turns into a boolean
if Config.UseTarget then
    CreateThread(function()
        for k, v in pairs(Config.Locations["duty"]) do
            exports['qb-target']:AddBoxZone("duty" .. k, vector3(v.x, v.y, v.z), 1.5, 1, {
                name = "duty" .. k,
                debugPoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "EMSToggle:Duty",
                        icon = "fa fa-clipboard",
                        label = "Sign In/Off duty",
                        job = "ambulance"
                    }
                },
                distance = 1.5
            })
        end
        for k, v in pairs(Config.Locations["stash"]) do
            exports['qb-target']:AddBoxZone("stash" .. k, vector3(v.x, v.y, v.z), 1, 1, {
                name = "stash" .. k,
                debugPoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-ambulancejob:stash",
                        icon = "fa fa-hand",
                        label = "Open Stash",
                        job = "ambulance"
                    }
                },
                distance = 1.5
            })
        end
        for k, v in pairs(Config.Locations["armory"]) do
            exports['qb-target']:AddBoxZone("armory" .. k, vector3(v.x, v.y, v.z), 1, 1, {
                name = "armory" .. k,
                debugPoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-ambulancejob:armory",
                        icon = "fa fa-hand",
                        label = "Open Armory",
                        job = "ambulance"
                    }
                },
                distance = 1.5
            })
        end
        for k, v in pairs(Config.Locations["roof"]) do
            exports['qb-target']:AddBoxZone("roof" .. k, vector3(v.x, v.y, v.z), 2, 2, {
                name = "roof" .. k,
                debugPoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-ambulancejob:elevator_roof",
                        icon = "fas fa-hand-point-up",
                        label = "Take Elevator",
                        job = "ambulance"
                    },
                },
                distance = 8
            })
        end
        for k, v in pairs(Config.Locations["main"]) do
            exports['qb-target']:AddBoxZone("main" .. k, vector3(v.x, v.y, v.z), 1.5, 1.5, {
                name = "main" .. k,
                debugPoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            }, {
                options = {
                    {
                        type = "client",
                        event = "qb-ambulancejob:elevator_main",
                        icon = "fas fa-hand-point-up",
                        label = "Take Elevator",
                        job = "ambulance"
                    },
                },
                distance = 8
            })
        end
    end)
else
    CreateThread(function()
        local signPoly = {}
        for k, v in pairs(Config.Locations["duty"]) do
            signPoly[#signPoly + 1] = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 1.5, 1, {
                name = "sign" .. k,
                debugPoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            })
        end

        local signCombo = ComboZone:Create(signPoly, { name = "signcombo", debugPoly = false })
        signCombo:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name == "ambulance" then
                if not onDuty then
                    exports['qb-core']:DrawText(Lang:t('text.onduty_button'), 'left')
                    EMSControls("sign")
                else
                    exports['qb-core']:DrawText(Lang:t('text.offduty_button'), 'left')
                    EMSControls("sign")
                end
            else
                check = false
                exports['qb-core']:HideText()
            end
        end)

        local stashPoly = {}
        for k, v in pairs(Config.Locations["stash"]) do
            stashPoly[#stashPoly + 1] = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 1, 1, {
                name = "stash" .. k,
                debugPoly = false,
                heading = -20,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            })
        end

        local stashCombo = ComboZone:Create(stashPoly, { name = "stashCombo", debugPoly = false })
        stashCombo:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name == "ambulance" then
                if onDuty then
                    exports['qb-core']:DrawText(Lang:t('text.pstash_button'), 'left')
                    EMSControls("stash")
                end
            else
                check = false
                exports['qb-core']:HideText()
            end
        end)

        local armoryPoly = {}
        for k, v in pairs(Config.Locations["armory"]) do
            armoryPoly[#armoryPoly + 1] = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 1, 1, {
                name = "armory" .. k,
                debugPoly = false,
                heading = 70,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            })
        end

        local armoryCombo = ComboZone:Create(armoryPoly, { name = "armoryCombo", debugPoly = false })
        armoryCombo:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name == "ambulance" then
                if onDuty then
                    exports['qb-core']:DrawText(Lang:t('text.armory_button'), 'left')
                    EMSControls("armory")
                end
            else
                check = false
                exports['qb-core']:HideText()
            end
        end)

        local roofPoly = {}
        for k, v in pairs(Config.Locations["roof"]) do
            roofPoly[#roofPoly + 1] = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 2, 2, {
                name = "roof" .. k,
                debugPoly = false,
                heading = 70,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            })
        end

        local roofCombo = ComboZone:Create(roofPoly, { name = "roofCombo", debugPoly = false })
        roofCombo:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name == "ambulance" then
                if onDuty then
                    exports['qb-core']:DrawText(Lang:t('text.elevator_main'), 'left')
                    EMSControls("main")
                else
                    exports['qb-core']:DrawText(Lang:t('error.not_ems'), 'left')
                end
            else
                check = false
                exports['qb-core']:HideText()
            end
        end)

        local mainPoly = {}
        for k, v in pairs(Config.Locations["main"]) do
            mainPoly[#mainPoly + 1] = BoxZone:Create(vector3(vector3(v.x, v.y, v.z)), 1.5, 1.5, {
                name = "main" .. k,
                debugPoly = false,
                heading = 70,
                minZ = v.z - 2,
                maxZ = v.z + 2,
            })
        end

        local mainCombo = ComboZone:Create(mainPoly, { name = "mainPoly", debugPoly = false })
        mainCombo:onPlayerInOut(function(isPointInside)
            if isPointInside and PlayerJob.name == "ambulance" then
                if onDuty then
                    exports['qb-core']:DrawText(Lang:t('text.elevator_roof'), 'left')
                    EMSControls("roof")
                else
                    exports['qb-core']:DrawText(Lang:t('error.not_ems'), 'left')
                end
            else
                check = false
                exports['qb-core']:HideText()
            end
        end)
    end)
end
