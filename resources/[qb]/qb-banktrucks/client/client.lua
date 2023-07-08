local QBCore = exports['qb-core']:GetCoreObject()
---
local CurrentCops = 0
local InHouse = false
local NeedAccess1 = false
local NeedAccess2 = false
local SystemHacked = false
local GuardSpawned = false
local BodySearched = false
local GotTruck = false
local KeyPressed2 = false
local GuardsSpawned = false
local CanLoot = false
local CanThermite = false
local alerted = false
local alerted2 = false
---
local truckSpawn = false
local TruckZone
local notdelivered = false
local DropZone
local GotLocation = false


RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

local Zone = BoxZone:Create(vector3(1271.02, -1714.98, 59.24), 13.0, 13.2, {
    heading = 25,
    name="Lester",
    debugPoly = false,
    minZ = 53.64,
    maxZ = 56.24
})
Zone:onPlayerInOut(function(isPointInside)
    if isPointInside then
        if not InHouse then
            EnterHouse()
        end
    else
        InHouse = false
    end
end)

function EnterHouse()
    QBCore.Functions.Notify("Looks like Lester isn't home...", 'primary')
    InHouse = true
    exports['qb-target']:AddBoxZone('lester-computer', vector3(1276.24, -1710.27, 54.77), 1.2, 1, {
        name='lester-computer',
        heading=28,
        debugPoly=false,
        minZ=54.47,
        maxZ=55.27,
        }, {
            options = {
                {
                    icon = 'fas fa-laptop-code',
                    label = 'Access Computer',
                    canInteract = function()
                        if InHouse and not NeedAccess1 then return true end
                        return false
                    end,
                    action = function()
                        Access()
                    end,
                },
                {
                    icon = 'fas fa-laptop-code',
                    label = 'Connect Laptop',
                    canInteract = function()
                        if NeedAccess2 then return true end
                        return false
                    end,
                    action = function()
                        Connect()
                    end,
                },
                {
                    icon = 'fas fa-laptop-code',
                    label = 'Browse Computer',
                    canInteract = function()
                        if SystemHacked then return true end
                        return false
                    end,
                    action = function()
                        Browse()
                    end,
                },
            },
        distance = 2.0
    })
end

function Access()
    QBCore.Functions.TriggerCallback("qb-banktrucks:server:coolc",function(isCooldown)
        if not isCooldown then
            TriggerEvent('animations:client:EmoteCommandStart', {"type"})
            NeedAccess1 = true
            QBCore.Functions.Progressbar("start_job", "Accessing", 6000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
            }, {}, {}, function() -- Done
                QBCore.Functions.Notify("Security lock to difficult, need brute force!", 'primary')
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                TriggerServerEvent("qb-banktrucks:server:coolout")
                NeedAccess1 = true
                NeedAccess2 = true
            end, function() -- Cancel
                NeedAccess1 = false
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.Notify("Cancelled?", 'error')
            end, "fas fa-laptop-code")
        else
            QBCore.Functions.Notify("System seems to be on a cooldown", 'error')
        end
    end)
end

function Connect()
    NeedAccess2 = false
    TriggerEvent('animations:client:EmoteCommandStart', {"type"})
    QBCore.Functions.Progressbar("search_body", "Connecting Laptop", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        QBCore.Functions.TriggerCallback('qb-banktrucks:server:hasItem', function(item) 
            if item then
                Wait(500)
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.Progressbar("search_body", "Accessing", 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "anim@heists@ornate_bank@hack",
                    anim = "hack_loop",
                    flags = 1,
                }, {
                    model = "hei_prop_hst_laptop",
                    coords = { x = 0.18, y = 0.053, z = 0.02 },
                    rotation = { x = 190.0, y = 0.0, z = 80.0 },
                }, {}, function() -- Done
                    exports["memorygame"]:thermiteminigame(Config.Blocks, Config.Attempts, Config.Show, Config.Time,
                    function() -- Success
                        ClearPedTasksImmediately(PlayerPedId())
                        Wait(1000)
                        QBCore.Functions.Notify("Security bypassed, you can now browse the computer", 'success')
                        SystemHacked = true
                        NeedAccess2 = false
                    end,
                    function() -- Failure
                        ClearPedTasksImmediately(PlayerPedId())
                        QBCore.Functions.Notify("Failed to brute force.. Alarms triggered", 'error')
                    end)
                end, function() -- Cancel
                    QBCore.Functions.Notify("Cancelled?", 'error')
                    ClearPedTasks(ped)
                end, "fas fa-code")
            else
                NeedAccess2 = true
                ClearPedTasksImmediately(PlayerPedId())
                QBCore.Functions.Notify("You dont have a laptop to hack this computer", 'error')
            end
        end)
    end, function() -- Cancel
        NeedAccess2 = true
        QBCore.Functions.Notify("Cancelled?", 'error')
        ClearPedTasks(ped)
    end, "fas fa-code")
end

function Browse()
    if SystemHacked then
        local header = {
            {
                isMenuHeader = true,
                icon = "fas fa-bars",
                header = "Available Bank Trucks",
                txt = "Lester's Desktop Application",
            }
        }
        for k, v in pairs(Config.JobsList) do
            if CurrentCops >= v.minCops then
                header[#header+1] = {
                    header = v.Header,
                    txt = "Available",
                    icon = v.icon,
                    params = {
                        event = v.event,
                    }
                }
            else
                header[#header+1] = {
                    header = v.Header,
                    txt = "Not Available",
                    icon = v.busyicon,
                    isMenuHeader = true,
                }
            end
        end
        header[#header+1] = {
            header = "Close App",
            icon = "fas fa-xmark",
            params = {
                event = "qb-menu:closeMenu",
            }
        }
        exports['qb-menu']:openMenu(header)
    else
        QBCore.Functions.Notify("Security system still online..", 'error')
    end
end

RegisterNetEvent('qb-banktrucks:client:GotAccess', function ()
    SystemHacked = false
    Wait(1000)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = "Lester's Computer",
        subject = 'Job Info',
        message = 'Anonymous: Hey I got that cooking recipe you wanted, meet me at the location I sent you on the gps. I will be in uniform, see you in 2 minutes',
    })
    Wait(2000)
    QBCore.Functions.Notify("You need to hurry to the location before lester gets there", 'success')
    SetGps()
end)

function SetGps()
    Wait(2000)
    TriggerEvent('qb-phone:client:CustomNotification', 'CURRENT TASK', "Meet up at the location with lesters connect", 'fas fa-location-arrow', '#00ffd5', 5500)
    local pedloc = Config.PedLocations[math.random(#Config.PedLocations)]
    if not GuardSpawned then
        meetlocblip = AddBlipForCoord(pedloc)
        SetBlipSprite(meetlocblip, 1)
        SetBlipColour(meetlocblip, 2)
        SetBlipRoute(meetlocblip, true)
        SetBlipRouteColour(meetlocblip, 2)
        SetBlipAsShortRange(meetlocblip, false)
        SetBlipScale(meetlocblip, 0.75)

        local GuardZone = CircleZone:Create(pedloc, 50.0, {
            name = "guard",
            debugPoly = false
        })
        GuardZone:onPlayerInOut(function(isPointInside)
            if isPointInside and not alerted then
                RemoveBlip(meetlocblip)
                QBCore.Functions.LoadModel(Config.SecurityPed)
                guard = CreatePed(0,Config.SecurityPed, pedloc.x, pedloc.y, pedloc.z, 0.0, true, true)
                guardblip = AddBlipForEntity(guard)
                SetBlipSprite(guardblip, 304)
                SetBlipColour(guardblip, 2)
                SetBlipScale(guardblip, 0.75)
                GuardSpawned = true
                SetEntityAsMissionEntity(guard)
                TaskWanderInArea(guard, pedloc.x, pedloc.y, pedloc.z, 1.0, 2, 0.2)

                alerted = true
                TriggerEvent('qb-phone:client:CustomNotification', 'TASK COMPLETED', "Meet up at the location with Lester's connect", 'fas fa-location-arrow', '#00ffd5', 5500)
                Wait(5500)
                TriggerEvent('qb-phone:client:CustomNotification', 'CURRENT TASK', "Kill the guard", 'fas fa-user', '#00ffd5', 5500)
                TaskSmartFleePed(guard, PlayerPedId(), 500.0, -1, true, true)
                QBCore.Functions.Notify("You spooked the guard...Kill him before he alerts the cops", 'primary')

                CreateThread( function ()
                    while DoesEntityExist(guard) do
                        if IsPedDeadOrDying(guard) and not alerted2 then
                            alerted2 = true
                            TriggerEvent('qb-phone:client:CustomNotification', 'TASK COMPLETED', "Kill the guard", 'fas fa-user', '#00ffd5', 5500)
                            RemoveBlip(guardblip)
                            exports['qb-target']:AddTargetEntity(guard, {
                                options = {
                                    {
                                        icon = 'fas fa-circle',
                                        label = 'Search Body',
                                        canInteract = function()
                                            if not BodySearched then return true end
                                            return false
                                        end,
                                        action = function()
                                            TakePackage()
                                        end,
                                    }
                                },
                                distance = 2.0
                            })
                        end
                        Wait(1000)
                    end
                end)
            end
        end)
    end
end

function TakePackage()
    SearchAnim()
    QBCore.Functions.Progressbar("search_body", "Searching", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
        BodySearched = true
        ClearPedTasksImmediately(PlayerPedId())
        TriggerServerEvent('qb-banktrucks:server:giveitem')
    end, function() -- Cancel
        ClearPedTasksImmediately(PlayerPedId())
        QBCore.Functions.Notify("Cancelled?", 'error')
    end, "fas fa-magnifying-glass")
end

RegisterNetEvent('qb-banktrucks:client:gettruck', function ()
    TriggerEvent('animations:client:EmoteCommandStart', {"tablet2"})
    if BodySearched then
        QBCore.Functions.Progressbar("search_body", "Booting Up", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
        }, {}, {}, function() -- Done
            BodySearched = false
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerEvent('qb-phone:client:CustomNotification', 'CURRENT TASK', "Intercept the truck", 'fas fa-truck-moving', '#00ffd5', 5500)
            SpawnStuff()
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            QBCore.Functions.Notify("Cancelled?", 'error')
        end, "fas fa-location-arrow")
    else
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("No Shortcuts Punk.", 'error')
        TriggerServerEvent("qb-smallresources:server:RemoveItem", "gps-device", "1")
        --QBCore.Functions.RemoveItem('gps-device')
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["gps-device"], "remove")
    end
end)

function SpawnStuff()
    local Truckloc = Config.Locations[math.random(#Config.Locations)]
    zoneblip = AddBlipForCoord(Truckloc)
    SetBlipSprite(zoneblip, 67)
    SetBlipScale(zoneblip, 0.75)
    SetBlipColour(zoneblip, 2)
    SetBlipRoute(zoneblip, true)
    SetBlipRouteColour(zoneblip, 2)
    TruckZone = CircleZone:Create(Truckloc, 300.0, {
		name = "Truck-Zone",
		debugPoly = false
	})
	TruckZone:onPlayerInOut(function(isPointInside)
		if isPointInside then
            RemoveBlip(zoneblip)
            TruckZone:destroy()
            QBCore.Functions.LoadModel("stockade")
            Truck = CreateVehicle("stockade", Truckloc.x, Truckloc.y, Truckloc.z, 52.0, true, true)
            SetEntityAsMissionEntity(Truck)

            TruckBlip = AddBlipForEntity(Truck)
            SetBlipSprite(TruckBlip, 67)
            SetBlipScale(TruckBlip, 0.75)
            SetBlipColour(TruckBlip, 2)
            SetBlipFlashes(TruckBlip, true)


            QBCore.Functions.LoadModel(Config.SecurityPed)
            Driver = CreatePed(26, Config.SecurityPed, Truckloc.x, Truckloc.y, Truckloc.z, 268.9422, true, false)
            CoPilot = CreatePed(26, Config.SecurityPed, Truckloc.x, Truckloc.y, Truckloc.z, 268.9422, true, false)
            SetPedIntoVehicle(Driver, Truck, -1)
            SetPedIntoVehicle(CoPilot, Truck, 0)
            SetPedRelationshipGroupHash(CoPilot, `HATES_PLAYER`)
            GiveWeaponToPed(CoPilot, `WEAPON_SMG`, 250, false, true)
            SetPedSuffersCriticalHits(CoPilot, false)
            TaskVehicleDriveWander(Driver, Truck, 70.0, 262144)
            GotTruck = true

            CreateThread( function ()
                while GotTruck do
                    if IsVehicleStopped(Truck) then
                        if IsVehicleSeatFree(Truck, -1) and IsVehicleSeatFree(Truck, 0) and IsVehicleSeatFree(Truck, 1) then
                            if IsPedDeadOrDying(Driver) and IsPedDeadOrDying(CoPilot) then
                                local PedPos = GetEntityCoords(PlayerPedId())
                                local TruckPos = GetOffsetFromEntityInWorldCoords(Truck, 0.0, -3.5, 0.5)
                                local TruckDist = GetDistanceBetweenCoords(PedPos.x, PedPos.y, PedPos.z, TruckPos.x, TruckPos.y, TruckPos.z, true)
                                if TruckDist <= 1.0 then
                                    CanThermite = true
                                end
                            end
                        end
                    end
                    Wait(1000)
                end
            end)
        end
	end)
end

RegisterNetEvent('qb-banktrucks:client:usethermite', function ()
    if CanThermite then
        AccessDoors()
    else
        QBCore.Functions.Notify("Cannot use this right now", 'error', 3000)
    end
end)

function AccessDoors()
    CanThermite = false
    local ped = PlayerPedId()
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    Wait(1500)
    RequestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge_heels') do
        Wait(50)
    end
    local x, y, z = table.unpack(GetEntityCoords(ped))
    prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z + 0.2, true, true, true)
    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 60309), 0.06, 0.0, 0.06, 90.0,0.0, 0.0, true, true, false, true, 1, true)
    TaskPlayAnim(ped, 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8,-1, 63, 0, 0, 0, 0)
    QBCore.Functions.Progressbar("search_body", "Setting Timer", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        Dispatch()
        exports["memorygame"]:thermiteminigame(Config.Blocks2, Config.Attempts2, Config.Show2, Config.Time2,
        function() -- Success
            TriggerServerEvent("qb-smallresources:server:RemoveItem", "kthermite", 1)
            --QBCore.Functions.RemoveItem('kthermite')
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["kthermite"], "remove")
            ClearPedTasks(ped)
            DetachEntity(prop)
            AttachEntityToEntity(prop, Truck, GetEntityBoneIndexByName(Truck, 'door_pside_r'), -0.7, 0.0,0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
            QBCore.Functions.Notify("Wait for the the door to blow", 'primary', 3000)
            Wait(Config.Timer)
            local transCoords = GetEntityCoords(Truck)
            SetVehicleDoorBroken(Truck, 2, false)
            SetVehicleDoorBroken(Truck, 3, false)
            AddExplosion(transCoords.x, transCoords.y, transCoords.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
            ApplyForceToEntity(Truck, 0, transCoords.x, transCoords.y, transCoords.z, 0.0, 0.0, 0.0, 1, false,true, true, true, true)
            SetVehicleUndriveable(Truck, true)
            SpawnGuards()
        end,
        function() -- Failure
            ClearPedTasksImmediately(ped)
            QBCore.Functions.Notify("Failed to brute force.. Alarms triggered", 'error')
        end)
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled?", 'error')
        ClearPedTasks(ped)
    end, "fas fa-code")
end

function SpawnGuards()
    QBCore.Functions.LoadModel(Config.SecurityPed)
    Wait(10)
    local Guard1 = CreatePedInsideVehicle(Truck, 5, Config.SecurityPed, 1, 1, 1)
    local Guard2 = CreatePedInsideVehicle(Truck, 5, Config.SecurityPed, 2, 1, 1)
    TaskLeaveVehicle(Guard1, Truck, 0)
    SetEntityAsMissionEntity(Guard1)
    SetEntityVisible(Guard1, true)
    SetPedRelationshipGroupHash(Guard1, `HATES_PLAYER`)
    SetPedAccuracy(Guard1, Config.GuardAccuracy)
    SetPedArmour(Guard1, Config.GuardArmor)
    SetPedMaxHealth(Guard1, Config.GuardsHealth)
    SetPedCanSwitchWeapon(Guard1, true)
    SetPedDropsWeaponsWhenDead(Guard1, false)
    SetPedFleeAttributes(Guard1, 0, false)
    GiveWeaponToPed(Guard1, `WEAPON_SMG`, Config.GuardWeapon, false, true)
    SetPedSuffersCriticalHits(Guard1, false)
    SetPedCanRagdoll(Guard1, false)

    TaskLeaveVehicle(Guard2, Truck, 0)
    SetEntityAsMissionEntity(Guard2)
    SetEntityVisible(Guard2, true)
    SetPedRelationshipGroupHash(Guard2, `HATES_PLAYER`)
    SetPedAccuracy(Guard2, Config.GuardAccuracy)
    SetPedArmour(Guard2, Config.GuardArmor)
    SetPedMaxHealth(Guard2, Config.GuardsHealth)
    SetPedCanSwitchWeapon(Guard2, true)
    SetPedDropsWeaponsWhenDead(Guard2, false)
    SetPedFleeAttributes(Guard2, 0, false)
    GiveWeaponToPed(Guard2, `WEAPON_SMG`, Config.GuardWeapon, false, true)
    SetPedSuffersCriticalHits(Guard2, false)
    SetPedCanRagdoll(Guard2, false)
    GuardsSpawned = true
    SetVehicleDoorOpen(Truck, 3, false, true)
    SetVehicleDoorOpen(Truck, 4, false, true)
    CreateThread( function ()
        while GuardsSpawned do
            local PedPos = GetEntityCoords(PlayerPedId())
            local TruckPos = GetOffsetFromEntityInWorldCoords(Truck, 0.0, -3.5, 0.5)
            local TruckDist = GetDistanceBetweenCoords(PedPos.x, PedPos.y, PedPos.z, TruckPos.x, TruckPos.y, TruckPos.z, true)
            if TruckDist <= 2.5 and not CanLoot then
                exports['qb-core']:DrawText("[E] Grab Loot", "left")
                PressedKey2()
            else
                exports['qb-core']:HideText()
            end
            Wait(1000)
        end
    end)
end

function PressedKey2()
    CreateThread(function ()
        while not KeyPressed2 do
            if IsControlJustReleased(0, 38) then
                CanLoot = true
                KeyPressed2 = true
                exports["qb-core"]:KeyPressed()
                Loot()
            end
            Wait(1)
        end
    end)
end

function Loot()
    SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    ClearPedTasks(PlayerPedId())
    Wait(1500)
    QBCore.Functions.Progressbar("start_looting", 'Looting', 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@heists@ornate_bank@grab_cash_heels",
        anim = "grab",
        flags = 49,
    }, {
        model = "prop_cs_heist_bag_02",
        bone = 57005,
        coords = { x = -0.004, y = 0.00, z = -0.14 },
        rotation = { x = 235.0, y = -25.0, z = 0.0 },
    }, {}, function() -- Done
        RemoveBlip(TruckBlip)
        TriggerServerEvent('qb-banktrucks:server:Payouts')
        TriggerEvent('qb-banktrucks:client:Clean')
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled", 'error')
    end,"fas fa-boxes-stacked")
end
function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

RegisterNetEvent('qb-banktrucks:client:Clean', function ()
    NeedAccess1 = false
    NeedAccess2 = false
    SystemHacked = false
    GuardSpawned = false
    BodySearched = false
    GotTruck = false
    NearTruck = false
    KeyPressed = false
    KeyPressed2 = false
    GuardsSpawned = false
    CanLoot = false
    alerted2 = false
    alerted = false
end)

function SearchAnim()
    local ped = PlayerPedId()
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    Wait(2500)
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(ped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 49, 0, false, false, false )
end

----------DELIVERY PART STARTS HERE

RegisterNetEvent('qb-banktrucks:client:StartDelivery', function ()
    TriggerServerEvent("qb-banktrucks:server:coolout")
    TruckPos = Config.DeliverTruckLocations[math.random(#Config.DeliverTruckLocations)]
    Text()
    TruckZone = CircleZone:Create(TruckPos, 150.0, {
		name = "Truck-Zone",
		debugPoly = false
	})
	TruckZone:onPlayerInOut(function(isPointInside)
		if isPointInside then
			if not truckSpawn then
				spawnTruck()
			end
		end
	end)
end)

function Text()
    SystemHacked = false
    Wait(1000)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = "Lester's Computer",
        subject = 'Job Info',
        message = 'Anonymous: Hey there was a messup on that job and we had to stash the truck. Unfortunately we cannot remember where exactly it all went down so fast but we have a general idea of the area I will send you the gps ping',
    })
    Wait(15000)
    TruckArea = AddBlipForRadius(TruckPos.x, TruckPos.y + 175, TruckPos.z, 450.0)
    SetBlipColour(TruckArea, 72)
end

function spawnTruck()
    QBCore.Functions.LoadModel("stockade")
    Truck = CreateVehicle("stockade", TruckPos.x, TruckPos.y, TruckPos.z, TruckPos.w, true, true)
    SetEntityAsMissionEntity(Truck)
    truckSpawn = true
end

CreateThread( function ()
    while true do
        if truckSpawn then
            if IsPedInVehicle(PlayerPedId(), Truck) and not GotMsg then
                Dispatch()
                TruckZone:destroy()
                RemoveBlip(TruckArea)
                SetDrop()
            end
        end
        Wait(1000)
    end
end)

RegisterNetEvent('banktrucks:policegps', function (x,y,z)
    local Player = QBCore.Functions.GetPlayerData()
    if Player.job.name == 'police' then
        RemoveBlip(TruckGps)
        TruckPos = GetEntityCoords(Truck)
        TruckGps =  AddBlipForCoord(x,y,z)
        SetBlipSprite(TruckGps, 161)
        SetBlipAsShortRange(TruckGps, true)
        SetBlipColour(TruckGps, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Bank Truck Gps')
        EndTextCommandSetBlipName(TruckGps)
    end
end)

function SetDrop()
    TriggerEvent('qb-phone:client:CustomNotification', 'NOTIFICATION', 'Drive until you get a drop location', 'fas fa-bars', '#00ffd5', 5500)
    CreateThread(function ()
        while DoesEntityExist(Truck) do
            if not GotLocation then
                TriggerServerEvent('banktrucks:policegps',TruckPos)
            end
            Wait(3000)
        end
    end)
    Wait(Config.GpsTimer)
    GotLocation = true
    RemoveBlip(TruckGps)
    truckSpawn = false
    local droploc = Config.RandomDropLocation[math.random(#Config.RandomDropLocation)]
    DropBlip = AddBlipForCoord(droploc)
    SetBlipSprite(DropBlip, 440)
    SetBlipColour(DropBlip, 64)
    SetBlipScale(DropBlip, 0.70)
    TriggerEvent('qb-phone:client:CustomNotification', 'NOTIFICATION', 'Deliver vehicle to drop point', 'fas fa-location-arrow', '#00ffd5', 5500)
    GotMsg = true

    DropZone = CircleZone:Create(droploc, 10.0, {
		name = "Drop-Zone",
		debugPoly = false
	})
	DropZone:onPlayerInOut(function(isPointInside)
		if isPointInside then
            Finish()
		end
	end)
end

function Finish()
    CreateThread( function ()
        while not notdelivered do
            if IsVehicleStopped(Truck) then
                if IsPedInVehicle(PlayerPedId(), Truck) then
                    FreezeEntityPosition(Truck, true)
                    RemoveBlip(DropBlip)
                    TriggerServerEvent('qb-banktrucks:server:DeliveryPayouts')
                    DropZone:destroy()
                    notdelivered = true
                    QBCore.Functions.DeleteVehicle(Truck)
                    truckSpawn = false
                    notdelivered = false
                    SystemHacked = false
                    NeedAccess1 = false
                    NeedAccess2 = false
                    GotLocation = false
                end
            end
            Wait(1000)
        end
    end)
end


----- ALERTS PORTION
function Dispatch()
    if Config.Dispatch == 'ps-dispatch' then
        exports['ps-dispatch']:BankTruckRobbery()
    elseif Config.Dispatch == 'cd-dispatch' then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'police'},
            coords = data.coords,
            title = '10-90 - Fleeca Truck Robbery',
            message = 'A '..data.sex..' robbing a bank truck at '..data.street,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 67,
                scale = 1.5,
                colour = 2,
                flashes = false,
                text = '911 - Fleeca Truck Robbery',
                time = (5*60*1000),
                sound = 1,
            }
        })
    end
end
