local isBusy = false

--- Method to send an alert to the cops if one has not been sent yet
--- @return nil
AlertCops = function()
    QBCore.Functions.TriggerCallback('qb-humanelabsheist:server:IsCopsCalled', function(copsCalled)
        if not copsCalled then
            TriggerServerEvent('qb-humanelabsheist:server:CopsCalled')
            --TriggerServerEvent('qb-scoreboard:server:SetActivityBusy', "humanelabs", true)
            exports['qb-dispatch']:HumaneRobbery()
        end
    end)
end

--- Method to steal a barrel of chemicals from the loading dock
--- @param item string - Methylamine or Ecgonine
--- @return nil
local Steal = function(item)
    if isBusy then return end
    isBusy = true
    local ped = PlayerPedId()

    -- Evidence
    if not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(ped))
    end

    -- Alert Cops
    AlertCops()

    -- Animation
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
    QBCore.Functions.Progressbar("pickup_reycle_package", "Stealing "..item, 3500, false, true, {}, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-humanelabsheist:server:GrabBarrel', item)
        ClearPedTasks(ped)
        isBusy = false
    end, function() -- cancel
        ClearPedTasks(ped)
        isBusy = false
    end)
end

RegisterNetEvent('qb-humanelabsheist:client:LockGates', function()
    TriggerServerEvent("doors:change-lock-state", 380)
    TriggerServerEvent("doors:change-lock-state", 381)
    --TriggerServerEvent('qb-doorlock:server:updateState', Shared.Gates.gate1, true, false, false, true, false, false)
    --TriggerServerEvent('qb-doorlock:server:updateState', Shared.Gates.gate2, true, false, false, true, false, false)
    TriggerServerEvent('qb-humanelabsheist:server:PDLock')
end)

RegisterNetEvent('qb-humanelabsheist:client:GateHack', function()
    Shared.Gates.hit = true
end)

RegisterNetEvent('qb-humanelabsheist:client:PDLock', function()
    Shared.Explosive.hit = false
end)

RegisterNetEvent('qb-humanelabsheist:client:UseLaptop', function()
    local hasItem = QBCore.Functions.HasItem('laptop_purple')
    if hasItem then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        if #(pos - Shared.Gates.coords) < 1 then
            if not Shared.Gates.hit then
                -- EVIDENCE
                if math.random(1, 100) <= 85 and not QBCore.Functions.IsWearingGloves() then
                    TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                end
                QBCore.Functions.Progressbar("hack_gate", "Connecting Laptop..", math.random(4000, 8000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "anim@gangops@facility@servers@",
                    anim = "hotwire",
                    flags = 16,
                }, {}, {}, function() -- Done
                    StopAnimTask(ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
                    -- ANIMATION
                    RequestAnimDict("anim@heists@ornate_bank@hack")
                    RequestModel("hei_prop_hst_laptop")
                    RequestModel("hei_p_m_bag_var22_arm_s")
                    while not HasAnimDictLoaded("anim@heists@ornate_bank@hack") or not HasModelLoaded("hei_prop_hst_laptop") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") do Wait(10) end
                    local loc = Shared.Gates.animation
    
                    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
                    SetEntityHeading(ped, loc.w)
    
                    local animPos = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack", "hack_enter", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
                    local animPos2 = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack", "hack_loop", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
                    local animPos3 = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack", "hack_exit", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
                    FreezeEntityPosition(ped, true)
    
                    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
                    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)
                    local laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)
                    NetworkAddPedToSynchronisedScene(ped, netScene, "anim@heists@ornate_bank@hack", "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, netScene, "anim@heists@ornate_bank@hack", "hack_enter_bag", 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(laptop, netScene, "anim@heists@ornate_bank@hack", "hack_enter_laptop", 4.0, -8.0, 1)
    
                    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, netScene2, "anim@heists@ornate_bank@hack", "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, netScene2, "anim@heists@ornate_bank@hack", "hack_loop_bag", 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(laptop, netScene2, "anim@heists@ornate_bank@hack", "hack_loop_laptop", 4.0, -8.0, 1)
    
                    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, netScene3, "anim@heists@ornate_bank@hack", "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, netScene3, "anim@heists@ornate_bank@hack", "hack_exit_bag", 4.0, -8.0, 1)
                    NetworkAddEntityToSynchronisedScene(laptop, netScene3, "anim@heists@ornate_bank@hack", "hack_exit_laptop", 4.0, -8.0, 1)
    
                    Wait(200)
                    NetworkStartSynchronisedScene(netScene)
                    Wait(6300)
                    NetworkStartSynchronisedScene(netScene2)
                    Wait(2000)
    
                    -- 8 Seconds
                    -- 5 Blocks
                    -- 4 Consecutive games
                    exports['hacking']:OpenHackingGame(8, 5, 4, function(Success)
                        if Success then
                            TriggerServerEvent("doors:change-lock-state", 380)
                            TriggerServerEvent("doors:change-lock-state", 381)
                            --TriggerServerEvent('qb-doorlock:server:updateState', Shared.Gates.gate1, false, false, false, true, false, false)
                            --TriggerServerEvent('qb-doorlock:server:updateState', Shared.Gates.gate2, false, false, false, true, false, false)
                            TriggerServerEvent('qb-humanelabsheist:server:GateHack')
                        end
                        -- Remove Use
                        TriggerServerEvent('qb-humanelabsheist:server:LaptopDamage')
                        NetworkStartSynchronisedScene(netScene3)
                        Wait(4600)
                        NetworkStopSynchronisedScene(netScene3)
                        DeleteObject(bag)
                        DeleteObject(laptop)
                        FreezeEntityPosition(ped, false)
                    end)
                end, function() -- Cancel
                    StopAnimTask(ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
                    QBCore.Functions.Notify("Canceled..", "error")
                end)
            else
                QBCore.Functions.Notify("This has already been hacked..", "error")
            end
        end
    else
        QBCore.Functions.Notify('You are missing some item(s)..', 'error', 2500)
    end
end)

CreateThread(function()
    -- PD Close
    exports['qb-target']:AddBoxZone("hlabspolice", vector3(3637.57, 3746.99, 29.22), 0.4, 0.6, {
        name = "hlabspolice",
        heading = 154.46,
        debugPoly = false,
        minZ = 28.82,
        maxZ = 29.62,
     }, {
        options = { 
            {
                type = "client",
                event = "qb-humanelabsheist:client:LockGates",
                icon = 'fas fa-lock',
                label = 'Lock Gates',
                job = "police"
            }
        },
        distance = 1.5,
    })

    -- Laptop
    exports['qb-target']:AddBoxZone("hlabslaptop", vector3(3620.85, 3744.03, 29.69), 0.5, 0.6, {
        name = "hlabslaptop",
        heading = 324.00,
        debugPoly = false,
        minZ = 29.17,
        maxZ = 30.17,
     }, {
        options = { 
            {
                type = "client",
                event = "qb-humanelabsheist:client:UseLaptop",
                icon = 'fas fa-lock',
                label = 'Unlock Garage'
            }
        },
        distance = 1.5,
    })

    -- Barrels
    exports['qb-target']:AddBoxZone("hlabbarrels", vector3(3628.1, 3736.73, 28.69), 0.9, 0.9, {
        name = "hlabbarrels",
        heading = 233.66,
        debugPoly = false,
        minZ = 27.42,
        maxZ = 28.82,
     }, {
        options = { 
            {
                action = function()
                    Steal("methylamine")
                end,
                icon = 'fas fa-flask',
                label = 'Steal Methylamine',
                canInteract = function()
                    return Shared.Explosive.hit
                end
            },
            {
                action = function()
                    Steal("ecgonine")
                end,
                icon = 'fas fa-flask',
                label = 'Steal Ecgonine',
                canInteract = function()
                    return Shared.Explosive.hit
                end
            }
        },
        distance = 2.5,
    })
end)
