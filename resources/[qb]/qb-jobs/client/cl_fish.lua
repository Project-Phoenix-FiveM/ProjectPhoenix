local bussy = false
local jobstarted = false
local selectedzone = nil
local fisherped = nil
local alldone = false
local bliptable = {}

CreateThread(function()
    while not HasModelLoaded('cs_old_man1a') do
        RequestModel('cs_old_man1a')
        Wait(10)
    end
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        RequestAnimDict("mini@strip_club@idles@bouncer@base")
        Wait(10)
    end

    fisherped = CreatePed(1, 'cs_old_man1a', -335.08, 6105.36, 31.44-1, 228.0, false, false)
    FreezeEntityPosition(fisherped, true)
    SetEntityInvincible(fisherped, true)
    SetBlockingOfNonTemporaryEvents(fisherped, true)
    TaskPlayAnim(fisherped, "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

    exports[Shared['TargetScript']]:AddTargetEntity(fisherped, {
        options = {
            {
                label = 'Get Task',
                icon = 'fas fa-tasks',
                event = "fishing:clock",
                canInteract = function()
                    return not IsEntityDead(PlayerPedId()) and isNearFisher()
                end
            }
        },
        distance = 2.0
    })
end)

RegisterNetEvent('qb-fishing:clock-on', function()
    if not jobstarted then
        QBCore.Functions.TriggerCallback('qb-fish-check-group', function(cb, size)
            if cb then
                local needtocatch = 5
                if size == 2 then
                    needtocatch = 12
                elseif size >= 3 then
                    needtocatch = 15
                elseif size >= 5 then
                    needtocatch = 25
                end

                local i = math.random(1, #Shared['Fishing']['Zones'])
                local zone = Shared['Fishing']['Zones'][i]
                TriggerServerEvent('qb-fish-start-job', needtocatch, zone)
            else
                QBCore.Functions.Notify('You need to create a group!', 'error', 5000)
            end
        end)
    end
end)

RegisterNetEvent('qb-fishing-job-started', function(bool, zone, isLeader)
    jobstarted = bool
    if not bool then return end
    for _,v in pairs(bliptable) do
        RemoveBlip(v)
    end
    selectedzone = zone
    FishBlip(selectedzone.coords.x, selectedzone.coords.y, selectedzone.coords.z)
    exports[Shared['TargetScript']]:RemoveTargetEntity(fisherped, 'Get Task')
    print('isLeader =',isLeader)
    if not isLeader then return end
    CreateThread(function()
        while true do
            Wait(150)
            if #(GetEntityCoords(PlayerPedId()) - vector3(selectedzone.coords.x, selectedzone.coords.y, selectedzone.coords.z)) < 50 then
                TriggerServerEvent('qb-fishing-correct-zone', selectedzone)
                return
            end
        end
    end)
end)

RegisterNetEvent('qb-fishing-give-fishrod', function()
    if not exports["qb-inventory"]:hasEnoughOfItem("fishingrod", 1, false) then
        TriggerEvent("player:receiveItem", "fishingrod", 1)
    end
end)

RegisterNetEvent("fishing:clock", function()
    local data = {
        {
            header = "Fisher Man",
            icon = "fas fa-fish",
            isMenuHeader = true,
        },
        {
			header = "Get Task",
            icon = 'fas fa-tasks',
			txt = "Start a Fishing Run.",
            params = {
                event = "qb-fishing:clock-on",
            }
		},
    }
    exports['qb-menu']:openMenu(data)
end)

function isNearFisher()
    if #(vector3(-335.08, 6105.36, 31.44) - GetEntityCoords(PlayerPedId())) < 5.0 then
        return true
    end
    return false
end

RegisterNetEvent('qb-fishing:try-to-fish', function()
    if not jobstarted then QBCore.Functions.Notify('You are not in job!', 'error', 3000) return end
    if #(GetEntityCoords(PlayerPedId()) - vector3(selectedzone.coords.x, selectedzone.coords.y, selectedzone.coords.z)) < 50 then
        if not bussy then   
            if poleTimer == 0 then 
                if IsPedSwimming(PlayerPedId()) then return TriggerEvent("notify","You haven't quite learned how to multitask yet",2) end
                if IsPedInAnyVehicle(PlayerPedId()) then return TriggerEvent("notify","Exit your vehicle first to start fishing!",2) end
                local waterValidated, castLocation = IsInWater()

                if waterValidated then
                    bussy = true
                    local fishingRod = GenerateFishingRod(PlayerPedId())
                    poleTimer = 5
                    if baitTimer == 0 then
                        CastBait(fishingRod, castLocation)
                    end
                else
                    TriggerEvent("notify","You need to aim towards the fish!",2)
                end
            end
        end
    else
        QBCore.Functions.Notify('You are not in the correct zone!', 'error', 5000)
    end
end)

function GenerateFishingRod(ped)
    local pedPos = GetEntityCoords(ped)
    local fishingRodHash = `prop_fishing_rod_01`
    WaitForModel(fishingRodHash)
    rodHandle = CreateObject(fishingRodHash, pedPos, true)
    AttachEntityToEntity(rodHandle, ped, GetPedBoneIndex(ped, 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded(fishingRodHash)
    return rodHandle
end

function WaitForModel(model)
    if not IsModelValid(model) then
        return
    end
	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	while not HasModelLoaded(model) do
		Wait(0)
	end
end

function PlayAnimation(ped, dict, anim, settings)
	if dict then
        CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Wait(10)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0
                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end
                if settings["flag"] then
                    flag = settings["flag"]
                end
                if settings["playbackRate"] then

                    playbackRate = settings["playbackRate"]

                end
                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

function CastBait(rodHandle, castLocation)
    baitTimer = 5
    local startedCasting = GetGameTimer()
    Wait(5)
    DisableControlAction(0, 311, true)
    DisableControlAction(0, 157, true)
    DisableControlAction(0, 158, true)
    DisableControlAction(0, 160, true)
    DisableControlAction(0, 164, true)
    if GetGameTimer() - startedCasting > 5000 then
        TriggerEvent("notify","You need to cast the bait",2)
        if DoesEntityExist(rodHandle) then
            DeleteEntity(rodHandle)
        end
        bussy = false
        return 
    end
    PlayAnimation(PlayerPedId(), "mini@tennis", "forehand_ts_md_far", {
        ["flag"] = 48
    })
    while IsEntityPlayingAnim(PlayerPedId(), "mini@tennis", "forehand_ts_md_far", 3) do
        Wait(0)
    end
    PlayAnimation(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", {
        ["flag"] = 11
    })   
    local startedBaiting = GetGameTimer()
    local randomBait = math.random(10000, 17500)
    DisableControlAction(0, 311, true)
    DisableControlAction(0, 157, true)
    DisableControlAction(0, 158, true)
    DisableControlAction(0, 160, true)
    DisableControlAction(0, 164, true)
    local interupted = false
    Wait(1000)
    while GetGameTimer() - startedBaiting < randomBait do
        Wait(5)
        if not IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 3) then
            interupted = true
            break
        end

        if alldone then ClearPedTasks(PlayerPedId()) bussy = false alldone = false return end
    end
    RemoveLoadingPrompt()
    if interupted then
        ClearPedTasks(PlayerPedId())
        CastBait(rodHandle, castLocation)
        bussy = false
        return
    end

    local success = exports['qb-lock']:StartLockPickCircle(1, 20)
    if success then
        TriggerEvent('qb-fishing:caughtfish')
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('qb-fishing-catch', selectedzone)
        bussy = false
    else
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notify","The fish got loose",2)
        bussy=false
    end
	if DoesEntityExist(rodHandle) then
        DeleteEntity(rodHandle)
    end
end

RegisterNetEvent('qb-fishing-clear', function()
    alldone = true
    jobstarted = nil
    selectedzone = nil
    for _,v in pairs(bliptable) do
        RemoveBlip(v)
    end
end)

RegisterNetEvent('qb-fishing-need-finish', function()
    exports[Shared['TargetScript']]:AddTargetEntity(fisherped, {
        options = {
            {
                label = 'Get Rewards',
                icon = 'fas fa-tasks',
                action = function() 
                    exports[Shared['TargetScript']]:RemoveTargetEntity(fisherped, 'Get Rewards')
                    exports[Shared['TargetScript']]:AddTargetEntity(fisherped, {
                        options = {
                            {
                                label = 'Get Task',
                                icon = 'fas fa-tasks',
                                action = function() 
                                    TriggerEvent('fishing:clock')
                                end,
                                canInteract = function()
                                    return not IsEntityDead(PlayerPedId()) and isNearFisher()
                                end
                            }
                        },
                        distance = 2.0
                    })
                    TriggerServerEvent('qb-fish-finish')
                end,
                canInteract = function()
                    return not IsEntityDead(PlayerPedId()) and isNearFisher()
                end
            }
        },
        distance = 2.0
    })
end)

RegisterNetEvent("qb-fishing:caughtfish", function()
    TriggerEvent("player:receiveItem", "fishingcod", 1)
end)

function timerCount()
    if poleTimer ~= 0 then
        poleTimer = poleTimer - 1
    end
    if baitTimer ~= 0 then
        baitTimer = baitTimer - 1
    end
    SetTimeout(1000, timerCount)
end

poleTimer = 0
baitTimer = 0

local rodHandle = ""
timerCount()

function IsInWater()
    local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped)
    local forwardVector = GetEntityForwardVector(ped)
    local forwardPos = vector3(pedPos["x"] + forwardVector["x"] * 10, pedPos["y"] + forwardVector["y"] * 10, pedPos["z"])
    local fishHash = `a_c_fish`
    WaitForModel(fishHash)
    local waterHeight = GetWaterHeight(forwardPos["x"], forwardPos["y"], forwardPos["z"])
    local fishHandle = CreatePed(1, fishHash, forwardPos, 0.0, false)
    SetEntityAlpha(fishHandle, 0, true)
    RemoveLoadingPrompt()
    local fishInWater = true
    Wait(2500)
    DeleteEntity(fishHandle)
    SetModelAsNoLongerNeeded(fishHash)
    return fishInWater, fishInWater and vector3(forwardPos["x"], forwardPos["y"], waterHeight) or false
end

RegisterNetEvent("qb-fish:sellcod", function()
    local pAmont = exports['qb-inventory']:getQuantity('fishingcod')
	if pAmont ~= 0 and not bussy then
        bussy = true
        QBCore.Functions.Progressbar("finishedpacking2", "Selling the cod..", 10000, false, false, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function() -- Done
            local cod = math.random(35, 50)
            TriggerEvent("inventory:removeItem", "fishingcod", 1)
            TriggerServerEvent('qb-fish:sellcod', cod*pAmont)
            bussy =false
		end)
    else
        TriggerEvent('notify', 'You dont have any cod to sell', 2)
    end
end)

function FishBlip(x, y, z)
    local blip = AddBlipForRadius(x, y, z, 150.0)
    SetBlipColour(blip, 3)
    SetBlipAlpha(blip, 150)
    SetBlipAsShortRange(blip, true)
    table.insert(bliptable, blip)
end