local bliptable = {}
ped1 = nil
local function pedasd()
    loadmodel('s_m_m_ups_02')
    loaddict("mini@strip_club@idles@bouncer@base")

    ped1 = CreatePed(1, 's_m_m_ups_02', 1197.04, -3253.67, 6.1, 91.42, false, true)
    FreezeEntityPosition(ped1, true)
    SetEntityInvincible(ped1, true)
    SetBlockingOfNonTemporaryEvents(ped1, true)
    TaskPlayAnim(ped1,"mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    exports[Shared['TargetScript']]:AddTargetEntity(ped1, {
        options = {
            {
                label = 'Get Task',
                icon = 'fas fa-tasks',
                action = function() 
                    TriggerEvent('jd-postop-startjob')
                end,
                canInteract = function()
                    if not jobstarted then
                        return true
                    end
                    return false
                end
            }
        },
        distance = 2.0
    })
end CreateThread(pedasd)

function loadmodel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(10)
    end
end
  
function loaddict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end
local QBCore = exports['qb-core']:GetCoreObject()
local jobstarted = false
local postopVehicle = nil
local selectedzone = nil

RegisterNetEvent('jd-postop-startjob', function()
    QBCore.Functions.TriggerCallback('jd-postop-check-group', function(cb)
        if cb then
            PlayPedAmbientSpeechNative(ped1, 'CHALLENGE_ACCEPTED_GENERIC', 'SPEECH_PARAMS_FORCE')
            exports[Shared['TargetScript']]:RemoveTargetEntity(ped1, 'Get Task')
            QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
                local veh = NetToVeh(netId)
                SetEntityHeading(veh, Shared['GoPostal']['vehicle']['heading'])
                exports['cdn-fuel']:SetFuel(veh, 100.0)
                SetVehicleFixed(veh)
                SetEntityAsMissionEntity(veh, true, true)
                postopVehicle = veh
                -- SetVehicleDoorsLocked(veh, 2)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                --TriggerServerEvent("garage:addKeys", QBCore.Functions.GetPlate(veh))
            end, Shared['GoPostal']['vehicle']['model'], Shared['GoPostal']['vehicle']['coords'], false) --carmodel, coords, warp into vehicle?
            local street = Shared['GoPostal']['Zones'][math.random(1, #Shared['GoPostal']['Zones'])]
            TriggerServerEvent('jd-postop-startjobforgroup', street)
        else
            QBCore.Functions.Notify('You need to create a group!', 'error', 5000)
        end
    end)
end)

local haspackage = false

function TakeAnim()
    TriggerServerEvent('jd-postop-grabbed')
    haspackage = true
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        Wait(0)
    end
    TaskPlayAnim(ped, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    pack = CreateObject(GetHashKey('prop_cs_cardbox_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(pack, ped, GetPedBoneIndex(ped, 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
end

RegisterNetEvent('jd-postop-jobstatus', function(bool, street)
    jobstarted = bool
    if not bool then return end
    selectedzone = street
    exports[Shared['TargetScript']]:AddBoxZone("postbox", vector3(1181.4, -3314.56, 6.03), 4.95, 4, { 
        name="postbox",
        heading=359,
        --debugPoly=true,
        minZ=5.03,
        maxZ=6.83
    }, {
        options = {
            {
                label = 'Take Package',
                icon = 'fas fa-pallet',
                action = function() 
                    QBCore.Functions.TriggerCallback('jd-postop-check-grab-package', function(cb)
                        if cb then
                            QBCore.Functions.Progressbar("take_package", "Taking Package.", 5000, false, false, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                anim = "machinic_loop_mechandplayer",
                                flags = 16,
                            }, {}, {}, function()
                                ClearPedTasksImmediately(PlayerPedId())
                                Wait(200)
                                FreezeEntityPosition(PlayerPedId(), false)
                                TakeAnim()
                            end)
                        else
                            QBCore.Functions.Notify('Car is full of package bro?', 'error', 2000)
                        end
                    end)
                end,
                canInteract = function()
                    if not haspackage then
                        return true
                    end
                    return false
                end
            }
        },
        distance = 2.0
    })
    exports[Shared['TargetScript']]:AddGlobalVehicle({
		options = {
            {
                label = 'Load Package',
                icon = 'fas fa-boxes',
                action = function()
                    QBCore.Functions.Progressbar("load_package", "Loading Package.", 5000, false, false, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                        anim = "machinic_loop_mechandplayer",
                        flags = 16,
                    }, {}, {}, function()
                        ClearPedTasksImmediately(PlayerPedId())
                        Wait(200)
                        FreezeEntityPosition(PlayerPedId(), false)
                        TriggerServerEvent('jd-postop-loadcar', selectedzone)
                        haspackage = false
                        ClearPedTasks(PlayerPedId())
                        TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0)
                        DeleteEntity(pack)
                        Citizen.Wait(500)
                    end)
                end,
                canInteract = function()
                    if haspackage then
                        return true
                    end
                    return false
                end
            }
		},
		distance = 2.5,
	})
    local function whilefunc() 
        while true do 
            Wait(10)
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            if veh then
                if GetHashKey(Shared['GoPostal']['vehicle']['model']) == GetHashKey(veh) then
                    local retval = GetPedInVehicleSeat(veh, -1)
                    if retval then
                        TriggerServerEvent('jd-postop-getted-intothecar')
                        return
                    end
                end
            end
        end
    end CreateThread(whilefunc)
end)

RegisterNetEvent('jd-postop-loaded', function()
    exports[Shared['TargetScript']]:RemoveGlobalType(2, 'Load Package')
    exports[Shared['TargetScript']]:RemoveZone('postbox')

    local function whilefunc2() 
        while true do 
            Wait(50)
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            if veh then
                local retval = GetPedInVehicleSeat(veh, -1)
                if retval then
                    local coords = GetEntityCoords(PlayerPedId())
                    local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
                    if zone == selectedzone then
                        TriggerServerEvent('jd-postop-correctzone', selectedzone)
                        return
                    end
                end
            end
        end
    end CreateThread(whilefunc2)
end)

RegisterNetEvent('jd-postop-clear', function()
    ClearAllBlipRoutes()
    for _,v in pairs(bliptable) do
        RemoveBlip(v)
    end
end)

local customerped = nil

RegisterNetEvent('jd-postop-postop-customer', function(coords1, coords2, ped_hash)
    ClearAllBlipRoutes()
    for _,v in pairs(bliptable) do
        RemoveBlip(v)
    end
    loadmodel(ped_hash)
    customerped = CreatePed(1, ped_hash, coords1.x, coords1.y, coords1.z-1, coords1.w, true, true)
    SetBlockingOfNonTemporaryEvents(customerped, true)
    SetPedDiesWhenInjured(customerped, false)
    SetPedCanPlayAmbientAnims(customerped, true)
    SetPedCanRagdollFromPlayerImpact(customerped, false)
    SetEntityInvincible(customerped, true)
    FreezeEntityPosition(customerped, true)
    CustomerBlip(coords1.x, coords1.y, 478, 56, 0.7, 'Customer')
    local handedpack = false
    exports[Shared['TargetScript']]:AddGlobalVehicle({
		options = {
            {
                label = 'Take Package',
                icon = 'fas fa-boxes',
                action = function() 
                    QBCore.Functions.Progressbar("take2_package", "Taking Package.", 5000, false, false, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                        anim = "machinic_loop_mechandplayer",
                        flags = 16,
                    }, {}, {}, function()
                        ClearPedTasksImmediately(PlayerPedId())
                        exports[Shared['TargetScript']]:RemoveGlobalType(2, 'Take Package')
                        handedpack = true
                        Wait(200)
                        FreezeEntityPosition(PlayerPedId(), false)
                        local ply = PlayerPedId()
                        local coords = GetEntityCoords(ply)
                        RequestAnimDict("anim@heists@box_carry@")
                        while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
                            Wait(0)
                        end
                        TaskPlayAnim(ply, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
                        pack2 = CreateObject(GetHashKey('prop_cs_cardbox_01'), coords.x, coords.y, coords.z,  true,  true, true)
                        AttachEntityToEntity(pack2, ply, GetPedBoneIndex(ply, 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
                    end)
                end,
                canInteract = function()
                    if not handedpack then
                        return true
                    end
                    return false
                end
            }
		},
		distance = 2.5,
	})
    exports[Shared['TargetScript']]:AddTargetEntity(customerped, {
        options = {
            {
                label = 'Give Package',
                icon = 'fas fa-boxes',
                action = function() 
                    QBCore.Functions.Progressbar("give2_package", "Giving Package.", 3500, false, false, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function()
                        ClearPedTasksImmediately(PlayerPedId())
                        Wait(200)
                        FreezeEntityPosition(PlayerPedId(), false)
                        exports[Shared['TargetScript']]:RemoveTargetEntity(customerped, 'Give Package')
                        handedpack = false
                        ClearPedTasks(PlayerPedId())
                        TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0)
                        DeleteEntity(pack2)
                        PlayPedAmbientSpeechNative(customerped, 'GENERIC_THANKS', 'SPEECH_PARAMS_FORCE')
                        FreezeEntityPosition(customerped, false)
                        TaskTurnPedToFaceEntity(customerped, PlayerPedId(), 0.2)
                        local coordsPED = GetEntityCoords(customerped)
                        CreateThread(function()
                            RequestAnimDict('anim@heists@box_carry@')
                            while not HasAnimDictLoaded('anim@heists@box_carry@') do
                            Wait(0)
                            end
                            TaskPlayAnim(customerped, 'anim@heists@box_carry@', 'idle' ,8.0, -8.0, -1, 50, 0, false, false, false)
                        end)
                        pack2 = CreateObject(GetHashKey('prop_cs_cardbox_01'), coordsPED.x, coordsPED.y, coordsPED.z,  true,  true, true)
                        AttachEntityToEntity(pack2, customerped, GetPedBoneIndex(customerped, 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
                        Wait(1000)
                        TaskGoStraightToCoord(customerped, coords2.x, coords2.y, coords2.z, 1.0, 1.0, coords2.w, 1)
                        Wait(5000)
                        ClearPedTasksImmediately(customerped)
                        DeleteEntity(pack2)
                        DeletePed(customerped)
                        customerped = nil
                        TriggerServerEvent('jd-postop-delivered', selectedzone)
                    end)
                end,
                canInteract = function()
                    if handedpack then
                        return true
                    end
                    return false
                end
            }
        },
        distance = 1.5
    })
end)

RegisterNetEvent('jd-postop-need-finish', function()
    exports[Shared['TargetScript']]:AddTargetEntity(ped1, {
        options = {
            {
                label = 'Get Rewards',
                icon = 'fas fa-tasks',
                action = function() 
                    exports[Shared['TargetScript']]:RemoveTargetEntity(ped1, 'Get Task')
                    exports[Shared['TargetScript']]:AddTargetEntity(ped1, {
                        options = {
                            {
                                label = 'Get Task',
                                icon = 'fas fa-tasks',
                                action = function() 
                                    TriggerServerEvent('jd-postop-startjob')
                                end,
                                canInteract = function()
                                    if not jobstarted then
                                        return true
                                    end
                                    return false
                                end
                            }
                        },
                        distance = 2.0
                    })
                    DeleteEntity(postopVehicle)
                    TriggerServerEvent('jd-postop-finished2', selectedzone)
                end,
                canInteract = function()
                    if jobstarted then
                        return true
                    end
                    return false
                end
            }
        },
        distance = 2.0
    })
end)

RegisterNetEvent('jd-postop-finish-for-group', function()
    jobstarted = false
    postopVehicle = nil
    selectedzone = nil
end)

function CustomerBlip(x, y, sprite, colour, scale, text)
    local blip = AddBlipForCoord(x, y)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    SetBlipRoute(blip, true)
    table.insert(bliptable, blip)
end