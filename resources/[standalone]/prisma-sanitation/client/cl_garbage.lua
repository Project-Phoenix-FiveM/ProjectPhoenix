local jobstarted = false
local selectedzone = nil
local garbageped = nil
local bliptable = {}
local garbageVehicle = nil
local hasBag = false
local garbageObject = nil

local function isNearGarbage()
    if #(vector3(-354.41, -1545.97, 26.72) - GetEntityCoords(PlayerPedId())) < 5.0 then
        return true
    end
    return false
end

CreateThread(function()
    while not HasModelLoaded('s_m_y_garbage') do
        RequestModel('s_m_y_garbage')
        Wait(10)
    end
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        RequestAnimDict("mini@strip_club@idles@bouncer@base")
        Wait(10)
    end

    garbageped = CreatePed(1, 's_m_y_garbage', -354.41, -1545.97, 26.72, 269.37, false, false)
    FreezeEntityPosition(garbageped, true)
    SetEntityInvincible(garbageped, true)
    SetBlockingOfNonTemporaryEvents(garbageped, true)
    TaskPlayAnim(garbageped, "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

    exports[Shared['TargetScript']]:AddTargetEntity(garbageped, {
        options = {
            {
                label = 'Get Task',
                icon = 'fas fa-tasks',
                action = function()
                    TriggerEvent('prisma-sanitation-startjob')
                end,
                canInteract = function()
                    return not IsEntityDead(PlayerPedId()) and isNearGarbage()
                end
            }
        },
        distance = 2.0
    })
end)

RegisterNetEvent('prisma-sanitation-startjob', function()
    QBCore.Functions.TriggerCallback('prisma-sanitation-check-group', function(cb)
        if cb then
            exports[Shared['TargetScript']]:RemoveTargetEntity(garbageped, 'Get Task')
            QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
                local veh = NetToVeh(netId)
                SetEntityHeading(veh, Shared['Garbage']['vehicle']['heading'])
                exports['cdn-fuel']:SetFuel(veh, 100.0)
                SetVehicleFixed(veh)
                SetEntityAsMissionEntity(veh, true, true)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                --TriggerServerEvent("garage:addKeys", QBCore.Functions.GetPlate(veh))
                local street = Shared['Garbage']['Zones'][math.random(1, #Shared['Garbage']['Zones'])]
                TriggerServerEvent('prisma-sanitation-startjobforgroup', street, veh)
            end, Shared['Garbage']['vehicle']['model'], Shared['Garbage']['vehicle']['coords'], false)
        else
            QBCore.Functions.Notify('You need to create a group!', 'error', 5000)
        end
    end)
end)

RegisterNetEvent('prisma-sanitation-jobstatus', function(bool, street, veh)
    jobstarted = bool
    for _,v in pairs(bliptable) do
        RemoveBlip(v)
    end
    if not bool then return end
    selectedzone = street
    local c = Shared['Garbage']['ZoneCoords'][selectedzone]
    -- GarbageBlip(c.x, c.y, c.z)
    garbageVehicle = veh
    print('YARRAK- ', garbageVehicle)
    local function whilefunc() 
        while true do 
            Wait(10)
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            if IsPedInAnyVehicle(PlayerPedId(), false) and veh then
                local retval = GetPedInVehicleSeat(veh, -1)
                if retval then
                    TriggerServerEvent('prisma-sanitation-getted-intothecar', selectedzone, garbageVehicle)
                    return
                end
            end
        end
    end CreateThread(whilefunc)
end)

RegisterNetEvent('prisma-sanitation-gotothezone', function()
    local function whilefunc2() 
        while true do 
            Wait(50)
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            if IsPedInAnyVehicle(PlayerPedId(), false) and veh then
                local retval = GetPedInVehicleSeat(veh, -1)
                if retval then
                    local coords = GetEntityCoords(PlayerPedId())
                    local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
                    if zone == selectedzone then
                        TriggerServerEvent('prisma-sanitation-correctzone', selectedzone)
                        return
                    end
                end
            end
        end
    end CreateThread(whilefunc2)
end)

function checkCan()
    for i = 1, #Shared['Garbage']['Trashes'][selectedzone] do
        local a = Shared['Garbage']['Trashes'][selectedzone][i]
        if #(a['Coords'] - GetEntityCoords(PlayerPedId())) < 1.4 and not a['isDone'] then
            return i
        end
    end
    return false
end

local function LoadAnimation(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
end

local function AnimCheck()
    CreateThread(function()
        local ped = PlayerPedId()
        while hasBag and not IsEntityPlayingAnim(ped, 'missfbi4prepp1', '_bag_throw_garbage_man',3) do
            if not IsEntityPlayingAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 3) then
                ClearPedTasksImmediately(ped)
                LoadAnimation('missfbi4prepp1')
                TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
            end
            Wait(1000)
        end
    end)
end

exports('garbageTarget', function()
    if hasBag then
        return true
    end
    return false
end)

local function DeliverAnim()
    exports[Shared['TargetScript']]:RemoveTargetEntity(garbageVehicle, 'Dispose Garbage Bag')
    hasBag = false
    local ped = PlayerPedId()
    LoadAnimation('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_throw_garbage_man', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, GetEntityHeading(garbageVehicle))
    SetTimeout(1250, function()
        DetachEntity(garbageObject, 1, false)
        DeleteObject(garbageObject)
        TaskPlayAnim(ped, 'missfbi4prepp1', 'exit', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
        FreezeEntityPosition(ped, false)
        garbageObject = nil
        TriggerServerEvent('prisma-sanitation-disposed-bag', selectedzone)
    end)
end

RegisterNetEvent('prisma-sanitation-asd', function()
    DeliverAnim()
end)

local function TakeAnim()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("bag_pickup", 'Taking Trash Bag..', math.random(3000, 5000), false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 16,
    }, {}, {}, function()
        LoadAnimation('missfbi4prepp1')
        TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
        garbageObject = CreateObject(`prop_cs_rub_binbag_01`, 0, 0, 0, true, true, true)
        AttachEntityToEntity(garbageObject, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)
        StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
        AnimCheck()
        if not hasBag then
            hasBag = true
            print('bu ne - ', garbageVehicle)
            exports[Shared['TargetScript']]:AddTargetEntity(garbageVehicle, {
                options = {
                    {
                        label = 'Dispose Garbage Bag',
                        icon = 'fa-solid fa-truck',
                        action = function() 
                            DeliverAnim() 
                        end,
                        canInteract = function() 
                            if hasBag then 
                                return true 
                            end 
                            return false 
                        end
                    }
                },
                distance = 1.2
            })
        end
    end)
end

RegisterNetEvent('prisma-sanitation-start-zone', function()
    for i = 1, #Shared['Garbage']['Trashes'][selectedzone] do
        local a = Shared['Garbage']['Trashes'][selectedzone][i]
        exports[Shared['TargetScript']]:AddBoxZone('trashcan'..i, a['Coords'], a['Length'], a['Width'], {
            name = 'trashcan'..i,
            debugPoly = false,
			heading = a['Heading'],
            minZ = a['Coords'].z - 1,
            maxZ = a['Coords'].z + 0.5,
        }, {
            options = {
                {
                    icon = 'fa-solid fa-trash',
                    label = 'Grab garbage bag',
                    canInteract = function()
                        if checkCan() and not hasBag then
                            return true
                        end
                        return false
                    end,
                    action = function()
                        TriggerServerEvent('prisma-sanitation-trigger-target', checkCan())
                        TakeAnim()
                    end
                },
            },
            distance = 1.5
        })
    end
end)

RegisterNetEvent('prisma-sanitation-remove-target', function(i)
    Shared['Garbage']['Trashes'][selectedzone][i]['isDone'] = true
    exports[Shared['TargetScript']]:RemoveZone('trashcan'..i)
end)

RegisterNetEvent('prisma-sanitation-need-finish', function()
    exports[Shared['TargetScript']]:AddTargetEntity(garbageped, {
        options = {
            {
                label = 'Get Rewards',
                icon = 'fas fa-tasks',
                action = function()
                    DeleteEntity(garbageVehicle)
                    TriggerServerEvent('prisma-sanitation-job-finished')
                    exports[Shared['TargetScript']]:RemoveTargetEntity(garbageped, 'Get Rewards')
                end,
                canInteract = function()
                    return not IsEntityDead(PlayerPedId()) and isNearGarbage()
                end
            }
        },
        distance = 2.0
    })
end)

RegisterNetEvent('prisma-sanitation-finish-for-group', function()
    for i = 1, #Shared['Garbage']['Trashes'][selectedzone] do
        local a = Shared['Garbage']['Trashes'][selectedzone][i]
        if a['isDone'] then
            a['isDone'] = false
        end
    end
    for _,v in pairs(bliptable) do
        RemoveBlip(v)
    end
    jobstarted = false
    selectedzone = nil
    garbageped = nil
    garbageVehicle = nil
    hasBag = false
    garbageObject = nil

    exports[Shared['TargetScript']]:AddTargetEntity(garbageped, {
        options = {
            {
                label = 'Get Task',
                icon = 'fas fa-tasks',
                action = function()
                    TriggerEvent('prisma-sanitation-startjob')
                end,
                canInteract = function()
                    return not IsEntityDead(PlayerPedId()) and isNearGarbage()
                end
            }
        },
        distance = 2.0
    })
end)

function GarbageBlip(x, y, z)
    local blip = AddBlipForRadius(x, y, z, 250.0)
    SetBlipColour(blip, 3)
    SetBlipAlpha(blip, 130)
    SetBlipAsShortRange(blip, true)
    table.insert(bliptable, blip)
end