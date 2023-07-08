QBCore = exports['qb-core']:GetCoreObject()

local copsCalled = false

--- Functions

--- This function uses qb-dispatch functions by default to alert the police when doing a bank heist
--- @param bankType string - The type of bank, fleeca, paleto or pacific
--- @return nil
CallCops = function(bankType)
    if GetResourceState('ps-dispatch') ~= 'started' then return end
    if copsCalled then return end
    copsCalled = true
    if bankType == 'fleeca' then
        exports['ps-dispatch']:FleecaBankRobbery()
    elseif bankType == 'maze' then
        exports['ps-dispatch']:FleecaBankRobbery()
    elseif bankType == 'paleto' then
        exports['ps-dispatch']:PaletoBankRobbery()
    elseif bankType == 'pacific' then
        exports['ps-dispatch']:PacificBankRobbery()
    end

    CreateThread(function()
        Wait(5 * 60 * 1000)
        copsCalled = false
    end)
end

--- Handles what happens after completing a laptop hack
--- @param success bool - Whether the minigame was successfull
--- @param bank string - Name of the bank
--- @return nil
OnLaptopHackDone = function(success, bank)
    if not success then return end
    QBCore.Functions.Notify(_U('bank_hacked'), 'success', 2500)
    TriggerServerEvent('qb-bankrobbery:server:SetBankHacked', bank)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = _U('mail_sender'),
        subject = bank,
        message = _U('mail_message'),
        button = {}
    })
end

LaptopAnimation = function(bank)
    if not Shared.Banks[bank] then return end

    RequestAnimDict('anim@heists@ornate_bank@hack')
    RequestModel('hei_prop_hst_laptop')
    RequestModel('hei_p_m_bag_var22_arm_s')

    while 
        not HasAnimDictLoaded('anim@heists@ornate_bank@hack') or
        not HasModelLoaded('hei_prop_hst_laptop') or
        not HasModelLoaded('hei_p_m_bag_var22_arm_s') 
    do 
        Wait(0) 
    end
    
    local ped = PlayerPedId()
    local loc = Shared.Banks[bank].laptop
    LocalPlayer.state:set('inv_busy', true, true)
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    
    if not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent('evidence:server:CreateFingerDrop', targetPosition)
    end

    local animPos = GetAnimInitialOffsetPosition('anim@heists@ornate_bank@hack', 'hack_enter', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition('anim@heists@ornate_bank@hack', 'hack_loop', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition('anim@heists@ornate_bank@hack', 'hack_exit', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, loc.w)

    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)
    local laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)
    NetworkAddPedToSynchronisedScene(ped, netScene, 'anim@heists@ornate_bank@hack', 'hack_enter', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, 'anim@heists@ornate_bank@hack', 'hack_enter_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, 'anim@heists@ornate_bank@hack', 'hack_enter_laptop', 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, 'anim@heists@ornate_bank@hack', 'hack_loop', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, 'anim@heists@ornate_bank@hack', 'hack_loop_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, 'anim@heists@ornate_bank@hack', 'hack_loop_laptop', 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, 'anim@heists@ornate_bank@hack', 'hack_exit', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, 'anim@heists@ornate_bank@hack', 'hack_exit_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, 'anim@heists@ornate_bank@hack', 'hack_exit_laptop', 4.0, -8.0, 1)

    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)

    exports['hacking']:OpenHackingGame(Shared.MinigameSettings.laptop[Shared.Banks[bank].type].time, Shared.MinigameSettings.laptop[Shared.Banks[bank].type].blocks, Shared.MinigameSettings.laptop[Shared.Banks[bank].type].amount, function(Success)
        OnLaptopHackDone(Success, bank)
        LocalPlayer.state:set('inv_busy', false, true)
        NetworkStartSynchronisedScene(netScene3)
        Wait(4600)
        NetworkStopSynchronisedScene(netScene3)
        DeleteObject(bag)
        DeleteObject(laptop)
        FreezeEntityPosition(ped, false)
    end)
end

LootTrolly = function(trolly, bank, index)
    local ped = PlayerPedId()
    local moneyModel = `hei_prop_heist_cash_pile`
    if Shared.Banks[bank].trolly[index].type == 'gold' then moneyModel = `ch_prop_gold_bar_01a` end
    local CurrentTrolly = trolly
    local netId = NetworkGetNetworkIdFromEntity(CurrentTrolly)

    local MoneyObject = CreateObject(moneyModel, GetEntityCoords(ped), true)
    SetEntityVisible(MoneyObject, false, false)
    AttachEntityToEntity(MoneyObject, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    local GrabBag = CreateObject(`hei_p_m_bag_var22_arm_s`, GetEntityCoords(ped), true, false, false)
    
    local GrabOne = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, GrabOne, 'anim@heists@ornate_bank@grab_cash', 'intro', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, GrabOne, 'anim@heists@ornate_bank@grab_cash', 'bag_intro', 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(GrabOne)
    Wait(1500)
    SetEntityVisible(MoneyObject, true, true)
    
    local GrabTwo = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, GrabTwo, 'anim@heists@ornate_bank@grab_cash', 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, GrabTwo, 'anim@heists@ornate_bank@grab_cash', 'bag_grab', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(CurrentTrolly, GrabTwo, 'anim@heists@ornate_bank@grab_cash', 'cart_cash_dissapear', 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(GrabTwo)
    Wait(37000)
    SetEntityVisible(MoneyObject, false, false)
    
    local GrabThree = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, GrabThree, 'anim@heists@ornate_bank@grab_cash', 'exit', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, GrabThree, 'anim@heists@ornate_bank@grab_cash', 'bag_exit', 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(GrabThree)

    -- Evidence
    if not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent('evidence:server:CreateFingerDrop', GetEntityCoords(ped))
    end

    -- Reward
    TriggerServerEvent('qb-bankrobbery:server:TrollyReward', netId, bank, index)
    Wait(1800)
    DeleteEntity(GrabBag)
    DeleteObject(MoneyObject)
end

--- Performs the animation of planting thermite charge for a given bank and given index number
--- @param bank string - Name of the bank
--- @param index number - Index number of thermite spot
--- @return nil
local PlantThermite = function(bank, index)
    TriggerServerEvent('qb-bankrobbery:server:RemoveThermite')
    RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
    RequestModel('hei_p_m_bag_var22_arm_s')
    RequestNamedPtfxAsset('scr_ornate_heist')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') or not HasModelLoaded('hei_p_m_bag_var22_arm_s') or not HasNamedPtfxAssetLoaded('scr_ornate_heist') do Wait(50) end
    local ped = PlayerPedId()

    if not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent('evidence:server:CreateFingerDrop', GetEntityCoords(ped))
    end
    
    SetEntityHeading(ped, Shared.Banks[bank].thermite[index].coords.w)
    local pos = Shared.Banks[bank].thermite[index].coords.xyz
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, pos.x, pos.y, pos.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local charge = CreateObject(`hei_prop_heist_thermite`, x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(charge, false, true)
    AttachEntityToEntity(charge, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, 'anim@heists@ornate_bank@thermal_charge', 'thermal_charge', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, 'anim@heists@ornate_bank@thermal_charge', 'bag_thermal_charge', 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Wait(5000)
    DetachEntity(charge, 1, 1)
    FreezeEntityPosition(charge, true)
    DeleteObject(bag)
    NetworkStopSynchronisedScene(bagscene)
    CreateThread(function()
        Wait(15000)
        DeleteEntity(charge)
    end)
end

--- Performs the animation of covering eyes and starts a server synced ptfx for given bank and thermite index, sets door unlocked
--- @param bank string - Name of the bank
--- @param index number - Index number of thermite spot
--- @return nil
local ThermiteEffect = function(bank, index)
    local ped = PlayerPedId()
    RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') do Wait(50) end
    Wait(1500)
    TriggerServerEvent('qb-bankrobbery:server:ThermitePtfx', Shared.Banks[bank].thermite[index].ptfx)
    Wait(500)
    TaskPlayAnim(ped, 'anim@heists@ornate_bank@thermal_charge', 'cover_eyes_intro', 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, 'anim@heists@ornate_bank@thermal_charge', 'cover_eyes_loop', 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Wait(25000)
    ClearPedTasks(ped)
    Wait(2000)
    QBCore.Functions.Notify(_U('thermite_success'), 'success', 2500)
    TriggerServerEvent('qb-doorlock:server:updateState', Shared.Banks[bank].thermite[index].doorId, false, false, false, true, false, false)
end

--- Performs the PlantThermite function and starts the minigame for thermite
--- @param bank string - Name of the bank
--- @param index number - Index number of trolly in a bank
--- @return nil
local StartThermite = function(bank, index) -- Globally used
    if not Shared.Banks[bank].thermite[index].hit then
        local pos = GetEntityCoords(PlayerPedId())
        if #(pos - Shared.Banks[bank].thermite[index].coords.xyz) < 2 then
            PlantThermite(bank, index)
            local bankType = Shared.Banks[bank].type
            exports['memorygame']:thermiteminigame(Shared.MinigameSettings.thermite.correctBlocks, Shared.MinigameSettings.thermite.incorrectBlocks, Shared.MinigameSettings.thermite.timetoShow, Shared.MinigameSettings.thermite.timetoLose, function()
                TriggerServerEvent('qb-bankrobbery:server:SetThermiteHit', bank, index)
                ThermiteEffect(bank, index)
            end, function()
                QBCore.Functions.Notify(_U('thermite_failed'), 'error', 2500)
            end)
        end
    end
end

--- Events

RegisterNetEvent('qb-bankrobbery:client:SetBankHacked', function(bank)
    -- Open Door
    local object = GetClosestObjectOfType(Shared.Banks[bank].coords.x, Shared.Banks[bank].coords.y, Shared.Banks[bank].coords.z, 5.0, Shared.Banks[bank].vaultDoor.object, false, false, false)
    if object ~= 0 then
        local heading = Shared.Banks[bank].vaultDoor.closed
        while heading >= Shared.Banks[bank].vaultDoor.open do
            SetEntityHeading(object, heading - 0.5)
            heading -= 0.5
            Wait(10)
        end
    end

    -- Set state
    Shared.Banks[bank].hacked = true
end)

RegisterNetEvent('qb-bankrobbery:client:PDClose', function(bank)
    Shared.Banks[bank].policeClose = not Shared.Banks[bank].policeClose
    local object = GetClosestObjectOfType(Shared.Banks[bank].coords.x, Shared.Banks[bank].coords.y, Shared.Banks[bank].coords.z, 5.0, Shared.Banks[bank].vaultDoor.object, false, false, false)
    if object == 0 then return end

    if Shared.Banks[bank].policeClose then -- Close
        local heading = Shared.Banks[bank].vaultDoor.open
        while heading <= Shared.Banks[bank].vaultDoor.closed do
            SetEntityHeading(object, heading + 0.5)
            heading += 0.5
            Wait(10)
        end
    else -- Open
        local heading = Shared.Banks[bank].vaultDoor.closed
        while heading >= Shared.Banks[bank].vaultDoor.open do
            SetEntityHeading(object, heading - 0.5)
            heading -= 0.5
            Wait(10)
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:client:ResetBank', function(bank)
    -- Door
    Shared.Banks[bank].hacked = false
    Shared.Banks[bank].policeClose = false
    if Shared.Banks[bank].type == 'fleeca' then
        Shared.Banks[bank].keycardTaken = false
        Shared.Banks[bank].innerDoor.hacked = false
    end

    -- lockers
    for i=1, #Shared.Banks[bank].lockers, 1 do
        Shared.Banks[bank].lockers[i].busy = false
        Shared.Banks[bank].lockers[i].taken = false
    end

    -- Trollys
    for j=1, #Shared.Banks[bank].trolly, 1 do
        Shared.Banks[bank].trolly[j].taken = false
    end

    -- Thermite spots
    if Shared.Banks[bank].thermite then
        for k=1, #Shared.Banks[bank].thermite, 1 do
            Shared.Banks[bank].thermite[k].hit = false
        end
    end

    -- Big Banks
    if bank == 'Paleto' then
        Shared.Banks['Paleto'].securityEntrance.hacked = false
        Shared.Banks['Paleto'].sideEntrance.hacked = false
        Shared.Banks['Paleto'].sideHack.hacked = false
        Shared.Banks['Paleto'].officeHacks[1].hacked = false
        Shared.Banks['Paleto'].officeHacks[2].hacked = false
        Shared.Banks['Paleto'].officeHacks[3].hacked = false
    elseif bank == 'Pacific' then
        Shared.Banks['Pacific'].lockdown = false
        Shared.Banks['Pacific'].laserPanel = false
        Shared.Banks['Pacific'].sideEntrance.hacked = false
        Shared.Banks['Pacific'].computers['main'].hacked = false
        Shared.Banks['Pacific'].computers['office1'].hacked = false
        Shared.Banks['Pacific'].computers['office2'].hacked = false
        Shared.Banks['Pacific'].computers['office3'].hacked = false
        Shared.Banks['Pacific'].computers['office4'].hacked = false
        Shared.Banks['Pacific'].sideVaults[1].hacked = false
        Shared.Banks['Pacific'].sideVaults[2].hacked = false
    end

    -- Close Vault
    local object = GetClosestObjectOfType(Shared.Banks[bank].coords.x, Shared.Banks[bank].coords.y, Shared.Banks[bank].coords.z, 5.0, Shared.Banks[bank].vaultDoor.object, false, false, false)
    if object ~= 0 then
        local heading = Shared.Banks[bank].vaultDoor.open
        while heading <= Shared.Banks[bank].vaultDoor.closed do
            SetEntityHeading(object, heading + 0.5)
            heading += 0.5
            Wait(10)
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:client:LootTrolly', function(data)
    if not currentBank then return end
    local trolly = data.entity
    local pos = GetEntityCoords(trolly)
    for k, v in pairs(Shared.Banks[currentBank].trolly) do
        if #(pos - v.coords.xyz) < 1.0 then

            -- If taken or busy return
            if v.busy or v.taken then
                QBCore.Functions.Notify(_U('trolly_hit'), 'error', 2500)
                return 
            end
            
            -- Set Busy
            TriggerServerEvent('qb-bankrobbery:server:SetTrollyBusy', currentBank, k)
            LocalPlayer.state:set('inv_busy', true, true)

            -- Loot trolly animation
            LootTrolly(trolly, currentBank, k)
            LocalPlayer.state:set('inv_busy', false, true)

            -- Evidence
            if not QBCore.Functions.IsWearingGloves() then
                TriggerServerEvent('evidence:server:CreateFingerDrop', pos)
            end

            return
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:client:SetTrollyBusy', function(bank, index)
    Shared.Banks[bank].trolly[index].busy = true
end)

RegisterNetEvent('qb-bankrobbery:client:SetTrollyTaken', function(bank, index)
    Shared.Banks[bank].trolly[index].taken = true
end)

RegisterNetEvent('qb-bankrobbery:client:LootLocker', function(data)
    if not currentBank then return end
    
    -- Check drill
    if not QBCore.Functions.HasItem('drill') then
        QBCore.Functions.Notify(_U('locker_missing_drill'), 'error', 2500)
        return
    end
    
    -- If taken or busy return
    if Shared.Banks[data.bank].lockers[data.locker].busy or Shared.Banks[data.bank].lockers[data.locker].taken then
        QBCore.Functions.Notify(_U('locker_hit'), 'error', 2500)
        return
    end

    -- Evidence
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent('evidence:server:CreateFingerDrop', pos)
    end

    -- Lights out minigame
    local result = exports['lightsout']:StartLightsOut(Shared.MinigameSettings.lightsOut.grid, Shared.MinigameSettings.lightsOut.maxClicks)
    if not result then
        QBCore.Functions.Notify(_U('minigame_failed'), 'error', 2500)
        return
    end

    -- Set Busy
    TriggerServerEvent('qb-bankrobbery:server:SetLockerBusy', data.bank, data.locker)
    LocalPlayer.state:set('inv_busy', true, true)

    -- Loot trolly animation
    RequestAnimDict('anim@heists@fleeca_bank@drilling')
    while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do Wait(0) end
    TaskPlayAnim(ped, 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle' , 3.0, 3.0, -1, 1, 0, false, false, false)
    local DrillObject = CreateObject(`hei_prop_heist_drill`, pos.x, pos.y, pos.z, true, true, true)
    AttachEntityToEntity(DrillObject, ped, GetPedBoneIndex(ped, 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)

    -- STRESS
    local isDrilling = true
    CreateThread(function()
        while isDrilling do
            Wait(10000)
            TriggerServerEvent('hud:server:GainStress', math.random(4, 8))
        end
    end)

    TriggerEvent('Drilling:Start', function(success)
        if success then
            TriggerServerEvent('qb-bankrobbery:server:LockerReward', data.bank, data.locker)
        else
            QBCore.Functions.Notify(_U('locker_failed'), 'error', 2500)
        end
        StopAnimTask(ped, 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle', 1.0)
        DetachEntity(DrillObject, true, true)
        DeleteObject(DrillObject)
        isDrilling = false
        LocalPlayer.state:set('inv_busy', false, true)
        RemoveAnimDict('anim@heists@fleeca_bank@drilling')
    end)
end)

RegisterNetEvent('qb-bankrobbery:client:SetLockerBusy', function(bank, index)
    Shared.Banks[bank].lockers[index].busy = true
end)

RegisterNetEvent('qb-bankrobbery:client:SetLockerTaken', function(bank, index)
    Shared.Banks[bank].lockers[index].taken = true
end)

RegisterNetEvent('thermite:UseThermite', function()
    local pos = GetEntityCoords(PlayerPedId())
    if currentBank then
        if not Shared.Banks[currentBank].thermite then return end
        for i=1, #Shared.Banks[currentBank].thermite, 1 do
            if #(pos - Shared.Banks[currentBank].thermite[i].coords.xyz) < 2 then
                StartThermite(currentBank, i)
            end
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:client:ThermitePtfx', function(coords)
    RequestNamedPtfxAsset('scr_ornate_heist')
    while not HasNamedPtfxAssetLoaded('scr_ornate_heist') do Wait(0) end
    SetPtfxAssetNextCall('scr_ornate_heist')
    local effect = StartParticleFxLoopedAtCoord('scr_heist_ornate_thermal_burn', coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(27500)
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('qb-bankrobbery:client:SetThermiteHit', function(bank, index)
    Shared.Banks[bank].thermite[index].hit = true
end)

--- Threads

CreateThread(function()
    -- Get Config on startup
    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:GetConfig', function(result)
        Shared = result
    end)

    -- Target for trollys
    local trollyModels = { `hei_prop_hei_cash_trolly_01`, `ch_prop_gold_trolly_01a` }
    exports['qb-target']:AddTargetModel(trollyModels, {
        options = {
            {
                type = 'client',
                event = 'qb-bankrobbery:client:LootTrolly',
                icon = 'fas fa-hand-holding',
                label = _U('trolly_target_label'),
                canInteract = function(entity)
                    return currentBank and Shared.Banks[currentBank].hacked
                end,
            }
        },
        distance = 0.85, 
    })

    -- Target for lockers
    for k, v in pairs(Shared.Banks) do
        for i=1, #v.lockers do
            exports['qb-target']:AddBoxZone('bankrobbery_locker_' .. k .. i, v.lockers[i].coords.xyz, 0.5, 2.0, {
                name = 'bankrobbery_locker_' .. k .. i,
                heading = v.lockers[i].coords.w,
                debugPoly = Shared.Debug,
                minZ = v.lockers[i].coords.z - 1.0,
                maxZ = v.lockers[i].coords.z + 1.0
            }, {
                options = { 
                    {
                        type = 'client',
                        event = 'qb-bankrobbery:client:LootLocker',
                        icon = 'fas fa-hand-holding',
                        label = _U('locker_target_label'),
                        canInteract = function()
                            return Shared.Banks[k].hacked and not Shared.Banks[k].lockers[i].taken and not Shared.Banks[k].lockers[i].busy
                        end,
                        bank = k,
                        locker = i
                    }
                },
                distance = 1.0,
            })
        end
    end
end)
