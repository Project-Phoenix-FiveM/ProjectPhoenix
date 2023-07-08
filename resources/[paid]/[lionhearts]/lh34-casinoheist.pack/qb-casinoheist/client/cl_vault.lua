local vaultDoor = -1520917551
local vaultCoords = vector3(1000.19, 10.54, -7.99)

local loginAttempt = 1
local hasBag = false

local minigameSettings = {
    bank = {
        [1] = {
            time = 9, -- Time in seconds per puzzle
            blocks = 3, -- Amount of blocks per puzzle
            amount = 4 -- Amount of puzzles the player has to solve consecutively
        },
        [2] = {time = 9, blocks = 4, amount = 4},
        [3] = {time = 7, blocks = 5, amount = 4},
        [4] = {time = 7, blocks = 6, amount = 4}
    },
    thermite = {
        [1] = {
            correctBlocks = 4, -- Number of correct blocks the player needs to click
            incorrectBlocks = 4, -- Number of incorrect blocks after which the game will fail
            timetoShow = 12, -- Time in secs for which the right blocks will be shown
            timetoLose = 30 -- Maximum time after timetoshow expires for player to select the right blocks
        },
        [2] = {correctBlocks = 9, incorrectBlocks = 4, timetoShow = 12, timetoLose = 30},
        [3] = {correctBlocks = 12, incorrectBlocks = 4, timetoShow = 12, timetoLose = 30},
        [4] = {correctBlocks = 16, incorrectBlocks = 4, timetoShow = 12, timetoLose = 30}
    },
    varhack = {
        [1] = {
            blocks = 6, -- Amount of coloured blocks
            speed = 9 -- Speed at which blocks travel
        },
        [2] = {blocks = 7, speed = 9},
        [3] = {blocks = 8, speed = 9},
        [4] = {blocks = 9, speed = 9}
    },
    casinohack = {
        [1] = {time = 17}, -- Time in seconds
        [2] = {time = 14},
        [3] = {time = 11},
        [4] = {time = 8}
    }
}

--- Method to grab bag and delete object
--- @param bag number - entity id of bag object
--- @return nil
local TakeBag = function(bag)
    if not Shared.VaultOpen then return end
    if not DoesEntityExist(bag) then return end

    if hasBag then
        QBCore.Functions.Notify('You already have a bag on you..', 'error', 2500)
        return
    end

    hasBag = true
    TriggerServerEvent('qb-casinoheist:server:GrabBag', NetworkGetNetworkIdFromEntity(bag))

    -- Enable Prop
    SetPedComponentVariation(PlayerPedId(), 5, 45, 0)
end

--- Method to check what type of casino heist laptop a player has to define the minigames
--- @return retval
local checkLaptop = function()
    if QBCore.Functions.HasItem('casino_green') then
        return 'green'
    elseif QBCore.Functions.HasItem('casino_blue') then
        return 'blue'
    elseif QBCore.Functions.HasItem('casino_red') then
        return 'red'
    elseif QBCore.Functions.HasItem('casino_gold') then
        return 'gold'
    else
        return false
    end
end

--- Method to perform hacking laptop animation
--- @param Locker number - entity id of locker object
--- @param laptopType string || boolean - laptop colour string
--- @param p promise - promise to resolve
--- @return nil
local vaultLaptopAnimation = function(Locker, laptopType, p)
    if not Locker then return end
    if not laptopType then return end

    local loc = GetEntityCoords(Locker)
    loc += vector(0, 0, 0.60)

    local animDict = "anim@heists@ornate_bank@hack"
    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")

    while 
        not HasAnimDictLoaded(animDict) or 
        not HasModelLoaded("hei_prop_hst_laptop") or 
        not HasModelLoaded("hei_p_m_bag_var22_arm_s") 
    do 
        Wait(10) 
    end

    local ped = PlayerPedId()
    TaskTurnPedToFaceEntity(ped, Locker, 1000)
    Wait(1000)
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    if math.random(1, 100) <= 65 and not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", targetPosition)
    end

    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    FreezeEntityPosition(ped, true)

    SetPedComponentVariation(ped, 5, 0, 0)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)
    local laptop = CreateObject(`hei_prop_hst_laptop`, targetPosition, 1, 1, 0)

    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    
    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)

    -- Do Hacks
    TriggerServerEvent('qb-casinoheist:server:ConsumeLaptopUse', laptopType)
    local successAmount = 0
    for i=1, 4 do
        local minigamePromise = promise:new()
        if laptopType == 'green' then
            -- Bank Hack
            exports['hacking']:OpenHackingGame(minigameSettings.bank[i].time, minigameSettings.bank[i].blocks, minigameSettings.bank[i].amount, function(result)
                minigamePromise:resolve(result)
            end)
        elseif laptopType == 'blue' then
            -- Thermite
            exports["memorygame"]:thermiteminigame(minigameSettings.thermite[i].correctBlocks, minigameSettings.thermite[i].incorrectBlocks, minigameSettings.thermite[i].timetoShow, minigameSettings.thermite[i].timetoLose, function()
                minigamePromise:resolve(true)
            end, function()
                minigamePromise:resolve(false)
            end)
        elseif laptopType == 'red' then
            -- VAR Hack
            exports['varhack']:OpenHackingGame(function(result)
                minigamePromise:resolve(result)
            end, minigameSettings.varhack[i].blocks, minigameSettings.varhack[i].speed)
        elseif laptopType == 'gold' then
            if Shared.VaultStage == 1 then
                -- Maze Hack
                exports['casinohack']:OpenHackingGame(function(result)
                    minigamePromise:resolve(result)
                end, minigameSettings.casinohack[i].time)
            else
                -- Chess Hack
                exports['chesshack']:OpenHackingGame(function(result)
                    minigamePromise:resolve(result)
                end, minigameSettings.casinohack[i].time)
            end
        end
        local minigameResult = Citizen.Await(minigamePromise)
        if minigameResult then
            successAmount += 1
        end
        Wait(500)
    end

    -- Exit animation
    NetworkStartSynchronisedScene(netScene3)
    Wait(4600)
    NetworkStopSynchronisedScene(netScene3)

    DeleteObject(bag)
    SetPedComponentVariation(ped, 45, 0, 0)
    DeleteObject(laptop)
    FreezeEntityPosition(ped, false)

    p:resolve(successAmount)
end

RegisterNetEvent('qb-casinoheist:client:AlertCops', function()
    -- Standard QBCore alert
    TriggerServerEvent('police:server:policeAlert', 'Casino Vault Alarm')
end)

RegisterNetEvent('qb-casinoheist:client:VaultControls', function()
    if not Shared.VaultLogin then
        QBCore.Functions.Notify("You need to login first..", "error", 2500)
        return
    end
    if Shared.VaultStage == 2 then return end
    
    QBCore.Functions.TriggerCallback('qb-casinoheist:server:GetVaultEquation', function(result)
        local keyboard, input = exports["var-password"]:Keyboard({header = result, rows = {""}})
        if keyboard then
            TriggerServerEvent('qb-casinoheist:server:EquationInput', tonumber(input))
        end
    end)
end)

RegisterNetEvent('qb-casinoheist:client:VaultKeypad', function(data)
    local input = exports['qb-input']:ShowInput({
        header = "Enter Code",
        submitText = "Submit",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'code',
                text = ''
            }
        }
    })
    if input then
        if not input.code then return end
        TriggerServerEvent('qb-casinoheist:server:VaultKeypadInput', data.keypad, tonumber(input.code))
    end
end)

RegisterNetEvent('qb-casinoheist:client:SetVaultStage', function(stage)
    Shared.VaultStage = stage
end)

RegisterNetEvent('qb-casinoheist:client:VaultLogin', function()
    if Shared.VaultLogin then return end
    QBCore.Functions.TriggerCallback('qb-casinoheist:server:GetLogin', function(result)
        if result == false then
            QBCore.Functions.Notify('Not enough cops on duty..', 'error', 2500)
        else
            local keyboard, input = exports["var-password"]:Keyboard({header = result, rows = {""}})
            if loginAttempt ~= 5 then
                QBCore.Functions.Notify('Incorrect Password '..loginAttempt..'/5 Attempts', 'error', 3500)
                TriggerServerEvent('qb-casinoheist:server:VaultLogin')
            else
                QBCore.Functions.Notify('Access granted.', 'success', 3500)
                TriggerServerEvent('qb-casinoheist:server:VaultLogin')
                PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            end
        end
    end)
end)

RegisterNetEvent('qb-casinoheist:client:LoginAttempt', function(amt)
    loginAttempt = amt
end)

RegisterNetEvent('qb-casinoheist:client:OpenVaultDoor', function()
    if Shared.VaultLogin then return end
    if Shared.VaultOpen then return end
    Shared.VaultLogin = true

    -- Ptfx
    local coords = vector3(1002.11, 9.154, -8.222)
    local particleDict = 'des_vaultdoor'
    local particleName = 'ent_ray_pro_door_steam'
    
    RequestNamedPtfxAsset(particleDict)
    while not HasNamedPtfxAssetLoaded(particleDict) do Wait(0) end

    local a = 0
    while a < 8 do
        UseParticleFxAssetNextCall(particleDict)
        StartParticleFxNonLoopedAtCoord(particleName, coords.x, coords.y, coords.z, -90.0, 25.0, 0.0, 7.0, false, false, false)
        a = a + 1
        Wait(1000)
    end

    Wait(1500)

    -- Open Door
    local object = GetClosestObjectOfType(vaultCoords.x, vaultCoords.y, vaultCoords.z, 5.0, vaultDoor, false, false, false)
    if object ~= 0 then
        local heading = GetEntityHeading(object)
        while heading <= 475.0 do
            SetEntityHeading(object, heading + 0.5)
            heading += 0.5
            Wait(10)
        end
    end

    -- Set state
    Shared.VaultOpen = true
    
    -- Bags
    exports['qb-target']:AddTargetModel('hei_p_m_bag_var22_arm_s', {
        options = {
            {
                action = function(entity) 
                    TakeBag(entity) 
                end,
                icon = 'fas fa-user-secret',
                label = 'Grab Bag',
                canInteract = function() 
                    return Shared.VaultOpen and not IsEntityAttachedToAnyPed(entity) 
                end
            },
        },
        distance = 1.5,
    })
end)

RegisterNetEvent('qb-casinoheist:client:OpenDuffelBag', function(id)
    if not id then return end
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "duffelbag_"..id, {maxweight = 1000000, slots = 5})
    TriggerEvent("inventory:client:SetCurrentStash", "duffelbag_"..id)
end)

RegisterNetEvent('qb-casinoheist:client:LootLaptopBox', function(data)
    if Shared.Lockers[data.box].hit then return end
    if Shared.VaultStage ~= data.box then
        QBCore.Functions.Notify("The Vault Controls don't allow this yet..", "error", 2500)
        return
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local Locker = GetClosestObjectOfType(Shared.Lockers[data.box].coords, 1.0, `ch_prop_ch_sec_cabinet_01j`, false, false, false)
    if Locker == 0 then return end

    TriggerServerEvent('qb-casinoheist:server:SetLockerHit', data.box)
    LocalPlayer.state:set("inv_busy", true, true) -- Busy

    local LockerPos = GetEntityCoords(Locker)
    local LockerHead = GetEntityHeading(Locker)
    local rot = GetEntityHeading(Locker)
    SetEntityVisible(Locker, false)
    SetEntityAsMissionEntity(Locker, true, true)
    DeleteEntity(Locker)
    DeleteObject(Locker)

    local obj = CreateObject(-2110344306, LockerPos, 1, 0, 0)
    SetEntityHeading(obj, LockerHead)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    SetEntityCollision(obj, true, true)

    local NewLockerPos = GetEntityCoords(obj)
    NetworkRequestControlOfEntity(obj)
    while not NetworkHasControlOfEntity(obj) do Wait(0) end

    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("ch_prop_vault_drill_01a")
    RequestModel("ch_prop_ch_moneybag_01a")

    local animDict = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@"
    local animDict2 = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_02@male@"
    local animDict3 = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@"
    local animDict4 = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_04@male@"

    RequestAnimDict(animDict)
    RequestAnimDict(animDict2)
    RequestAnimDict(animDict3)
    RequestAnimDict(animDict4)

    while 
        not HasAnimDictLoaded(animDict) or 
        not HasAnimDictLoaded(animDict2) or 
        not HasAnimDictLoaded(animDict3) or
        not HasAnimDictLoaded(animDict4) or
        not HasModelLoaded('hei_p_m_bag_var22_arm_s') or 
        not HasModelLoaded('ch_prop_ch_moneybag_01a') or 
        not HasModelLoaded('ch_prop_vault_drill_01a') 
    do
        Wait(10)
    end

    local targetPosition = GetEntityCoords(obj)
    local targetRotation = vector3(0.0, 0.0, rot)
    local animPos = GetAnimInitialOffsetPosition(animDict, "enter", targetPosition[1], targetPosition[2], targetPosition[3], targetRotation, 0, 2)
    local targetHeading = rot

    SetPedComponentVariation(ped, 5, 0, 0)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)
    local drill = CreateObject(`ch_prop_vault_drill_01a`, targetPosition, 1, 1, 0)
    local money = CreateObject(`ch_prop_ch_moneybag_01a`, targetPosition, 1, 1, 0)
    SetEntityVisible(money, false)

    local netScene1 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene1, animDict, "enter", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene1, animDict, "enter_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene1, animDict, "enter_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene1, animDict, "enter_ch_prop_ch_sec_cabinet_01abc", 1.0, -4.0, 157)

    local netScene2 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, false, true, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "action", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "action_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene2, animDict, "action_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene2, animDict, "action_ch_prop_ch_sec_cabinet_01abc", 1.0, -4.0, 157)

    local netScene3 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "reward", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "reward_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene3, animDict, "reward_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(money, netScene3, animDict, "reward_ch_prop_ch_moneybag_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene3, animDict, "reward_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)

    local netScene4 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, false, true, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene4, animDict2, "action", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene4, animDict2, "action_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene4, animDict2, "action_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene4, animDict2, "action_ch_prop_ch_sec_cabinet_01abc", 1.0, -4.0, 157)

    local netScene5 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene5, animDict2, "reward", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene5, animDict2, "reward_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene5, animDict2, "reward_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(money, netScene5, animDict2, "reward_ch_prop_ch_moneybag_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene5, animDict2, "reward_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)

    local netScene6 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene6, animDict3, "action", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene6, animDict3, "action_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene6, animDict3, "action_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene6, animDict3, "action_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)
    
    local netScene7 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, true, 1065353216, 0, 1065353216, 2.0)
    NetworkAddPedToSynchronisedScene(ped, netScene7, animDict3, "reward", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene7, animDict3, "reward_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene7, animDict3, "reward_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(money, netScene7, animDict3, "reward_ch_prop_ch_moneybag_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene7, animDict3, "reward_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)

    local netScene8 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, true, 1065353216, 0, 1065353216, 2.0)
    NetworkAddPedToSynchronisedScene(ped, netScene8, animDict4, "action", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene8, animDict4, "action_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene8, animDict4, "action_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene8, animDict4, "action_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)
    
    local netScene9 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, true, 1065353216, 0, 1065353216, 2.0)
    NetworkAddPedToSynchronisedScene(ped, netScene9, animDict4, "reward", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene9, animDict4, "reward_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene9, animDict4, "reward_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(money, netScene9, animDict4, "reward_ch_prop_ch_moneybag_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene9, animDict4, "reward_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)

    NetworkStartSynchronisedScene(netScene1)
    Wait(GetAnimDuration(animDict, 'enter') * 1000)

    NetworkStartSynchronisedScene(netScene2)
    Wait(GetAnimDuration(animDict, 'action') * 1000)

    SetEntityVisible(money, true)
    NetworkStartSynchronisedScene(netScene3)
    Wait(GetAnimDuration(animDict, 'reward') * 1000)
    SetEntityVisible(money, false)

    NetworkStartSynchronisedScene(netScene4)
    Wait(GetAnimDuration(animDict2, 'action') * 1000)

    SetEntityVisible(money, true)
    NetworkStartSynchronisedScene(netScene5)
    Wait(GetAnimDuration(animDict2, 'reward') * 1000)
    
    NetworkStartSynchronisedScene(netScene6)
    Wait(GetAnimDuration(animDict3, 'action') * 1000)

    SetEntityVisible(money, true)
    NetworkStartSynchronisedScene(netScene7)
    Wait(GetAnimDuration(animDict3, 'reward') * 1000)

    NetworkStartSynchronisedScene(netScene8)
    Wait(GetAnimDuration(animDict4, 'action') * 1000)

    SetEntityVisible(money, true)
    NetworkStartSynchronisedScene(netScene9)
    Wait(GetAnimDuration(animDict4, 'reward') * 1000)

    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0)
    DeleteObject(drill)
    DeleteObject(money)
    SetEntityVisible(Locker, true)
    FreezeEntityPosition(ped, false)

    LocalPlayer.state:set("inv_busy", false, true) -- Not Busy

    -- Reward in bag event
    TriggerServerEvent('qb-casinoheist:server:VaultLaptopReward', data.box)

    RemoveAnimDict(animDict)
    RemoveAnimDict(animDict2)
    RemoveAnimDict(animDict3)
    RemoveAnimDict(animDict4)

    SetModelAsNoLongerNeeded("hei_p_m_bag_var22_arm_s")
    SetModelAsNoLongerNeeded("ch_prop_vault_drill_01a")
    SetModelAsNoLongerNeeded("ch_prop_ch_moneybag_01a")
end)

RegisterNetEvent('qb-casinoheist:client:LootBox', function(data)
    if Shared.Lockers[data.box].hit then return end
    if not hasBag then
        QBCore.Functions.Notify('You are missing a duffel bag to put the loot in!', 'error', 2500)
        return
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local Locker = GetClosestObjectOfType(Shared.Lockers[data.box].coords, 1.0, `ch_prop_ch_sec_cabinet_01j`, false, false, false)
    if Locker == 0 then return end

    TriggerServerEvent('qb-casinoheist:server:SetLockerHit', data.box)
    LocalPlayer.state:set("inv_busy", true, true) -- Busy
    
    local laptopType = checkLaptop()
    local promise = promise:new()
    vaultLaptopAnimation(Locker, laptopType, promise)
    local correctMinigames = Citizen.Await(promise)

    local LockerPos = GetEntityCoords(Locker)
    local LockerHead = GetEntityHeading(Locker)
    local rot = GetEntityHeading(Locker)
    SetEntityVisible(Locker, false)
    SetEntityAsMissionEntity(Locker, true, true)
    DeleteEntity(Locker)
    DeleteObject(Locker)

    local obj = CreateObject(-2110344306, LockerPos, 1, 0, 0)
    SetEntityHeading(obj, LockerHead)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    SetEntityCollision(obj, true, true)

    local NewLockerPos = GetEntityCoords(obj)
    NetworkRequestControlOfEntity(obj)
    while not NetworkHasControlOfEntity(obj) do Wait(0) end

    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("ch_prop_vault_drill_01a")
    RequestModel("ch_prop_ch_moneybag_01a")

    local animDict = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_01@male@"
    local animDict2 = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_02@male@"
    local animDict3 = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_03@male@"
    local animDict4 = "anim_heist@hs3f@ig10_lockbox_drill@pattern_01@lockbox_04@male@"

    RequestAnimDict(animDict)
    RequestAnimDict(animDict2)
    RequestAnimDict(animDict3)
    RequestAnimDict(animDict4)

    while 
        not HasAnimDictLoaded(animDict) or 
        not HasAnimDictLoaded(animDict2) or 
        not HasAnimDictLoaded(animDict3) or
        not HasAnimDictLoaded(animDict4) or
        not HasModelLoaded('hei_p_m_bag_var22_arm_s') or 
        not HasModelLoaded('ch_prop_ch_moneybag_01a') or 
        not HasModelLoaded('ch_prop_vault_drill_01a') 
    do
        Wait(10)
    end

    local targetPosition = GetEntityCoords(obj)
    local targetRotation = vector3(0.0, 0.0, rot)
    local animPos = GetAnimInitialOffsetPosition(animDict, "enter", targetPosition[1], targetPosition[2], targetPosition[3], targetRotation, 0, 2)
    local targetHeading = rot

    SetPedComponentVariation(ped, 5, 0, 0)
    local bag = CreateObject(`hei_p_m_bag_var22_arm_s`, targetPosition, 1, 1, 0)
    local drill = CreateObject(`ch_prop_vault_drill_01a`, targetPosition, 1, 1, 0)
    local money = CreateObject(`ch_prop_ch_moneybag_01a`, targetPosition, 1, 1, 0)
    SetEntityVisible(money, false)

    local netScene1 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene1, animDict, "enter", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene1, animDict, "enter_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene1, animDict, "enter_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene1, animDict, "enter_ch_prop_ch_sec_cabinet_01abc", 1.0, -4.0, 157)

    local netScene2 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, false, true, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "action", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "action_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene2, animDict, "action_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene2, animDict, "action_ch_prop_ch_sec_cabinet_01abc", 1.0, -4.0, 157)

    local netScene3 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "reward", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "reward_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene3, animDict, "reward_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(money, netScene3, animDict, "reward_ch_prop_ch_moneybag_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene3, animDict, "reward_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)

    local netScene4 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, false, true, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene4, animDict2, "action", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene4, animDict2, "action_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene4, animDict2, "action_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene4, animDict2, "action_ch_prop_ch_sec_cabinet_01abc", 1.0, -4.0, 157)

    local netScene5 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene5, animDict2, "reward", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene5, animDict2, "reward_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene5, animDict2, "reward_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(money, netScene5, animDict2, "reward_ch_prop_ch_moneybag_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene5, animDict2, "reward_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)

    local netScene6 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, netScene6, animDict3, "action", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene6, animDict3, "action_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene6, animDict3, "action_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene6, animDict3, "action_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)
    
    local netScene7 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, true, 1065353216, 0, 1065353216, 2.0)
    NetworkAddPedToSynchronisedScene(ped, netScene7, animDict3, "reward", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene7, animDict3, "reward_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene7, animDict3, "reward_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(money, netScene7, animDict3, "reward_ch_prop_ch_moneybag_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene7, animDict3, "reward_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)

    local netScene8 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, true, 1065353216, 0, 1065353216, 2.0)
    NetworkAddPedToSynchronisedScene(ped, netScene8, animDict4, "action", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene8, animDict4, "action_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene8, animDict4, "action_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene8, animDict4, "action_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)
    
    local netScene9 = NetworkCreateSynchronisedScene(NewLockerPos[1], NewLockerPos[2], NewLockerPos[3], targetRotation, 2, true, true, 1065353216, 0, 1065353216, 2.0)
    NetworkAddPedToSynchronisedScene(ped, netScene9, animDict4, "reward", 1.0, -4.0, 157, 92, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene9, animDict4, "reward_p_m_bag_var22_arm_s", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(drill, netScene9, animDict4, "reward_ch_prop_vault_drill_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(money, netScene9, animDict4, "reward_ch_prop_ch_moneybag_01a", 1.0, -4.0, 157)
    NetworkAddEntityToSynchronisedScene(obj, netScene9, animDict4, "reward_ch_prop_ch_sec_cabinet_01abc", 4.0, -8.0, 157)

    NetworkStartSynchronisedScene(netScene1)
    Wait(GetAnimDuration(animDict, 'enter') * 1000)

    NetworkStartSynchronisedScene(netScene2)
    Wait(GetAnimDuration(animDict, 'action') * 1000)

    SetEntityVisible(money, true)
    NetworkStartSynchronisedScene(netScene3)
    Wait(GetAnimDuration(animDict, 'reward') * 1000)
    SetEntityVisible(money, false)

    NetworkStartSynchronisedScene(netScene4)
    Wait(GetAnimDuration(animDict2, 'action') * 1000)

    SetEntityVisible(money, true)
    NetworkStartSynchronisedScene(netScene5)
    Wait(GetAnimDuration(animDict2, 'reward') * 1000)
    
    NetworkStartSynchronisedScene(netScene6)
    Wait(GetAnimDuration(animDict3, 'action') * 1000)

    SetEntityVisible(money, true)
    NetworkStartSynchronisedScene(netScene7)
    Wait(GetAnimDuration(animDict3, 'reward') * 1000)

    NetworkStartSynchronisedScene(netScene8)
    Wait(GetAnimDuration(animDict4, 'action') * 1000)

    SetEntityVisible(money, true)
    NetworkStartSynchronisedScene(netScene9)
    Wait(GetAnimDuration(animDict4, 'reward') * 1000)

    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0)
    DeleteObject(drill)
    DeleteObject(money)
    SetEntityVisible(Locker, true)
    FreezeEntityPosition(ped, false)

    LocalPlayer.state:set("inv_busy", false, true) -- Not Busy

    -- Reward in bag event
    TriggerServerEvent('qb-casinoheist:server:VaultLockerReward', data.box, correctMinigames)

    RemoveAnimDict(animDict)
    RemoveAnimDict(animDict2)
    RemoveAnimDict(animDict3)
    RemoveAnimDict(animDict4)

    SetModelAsNoLongerNeeded("hei_p_m_bag_var22_arm_s")
    SetModelAsNoLongerNeeded("ch_prop_vault_drill_01a")
    SetModelAsNoLongerNeeded("ch_prop_ch_moneybag_01a")
end)

RegisterNetEvent('qb-casinoheist:client:SetLockerHit', function(index)
    Shared.Lockers[index].hit = true
end)

CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        if #(pos - vaultCoords) < 25 then
            local object = GetClosestObjectOfType(vaultCoords.x, vaultCoords.y, vaultCoords.z, 5.0, vaultDoor, false, false, false)
            if object ~= 0 then
                if Shared.VaultOpen then
                    SetEntityHeading(object, 115.0)
                    FreezeEntityPosition(object, true)
                else
                    SetEntityHeading(object, -32.0)
                    FreezeEntityPosition(object, true)
                end
            end
        end
        Wait(1000)
    end
end)

CreateThread(function()
    -- Vault Computer
    exports['qb-target']:AddBoxZone("casinoh_vaultcomputer", vector3(1008.03, 13.53, -8.55), 1.0, 0.4, {
        name = "casinoh_vaultcomputer",
        heading = 328,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:VaultControls',
                icon = 'fas fa-user-secret',
                label = 'Inner Vault Controls',
                item = 'casino_keycard',
                canInteract = function()
                    return Shared.VaultStage < 2
                end
            },
            {
                type = 'client',
                event = 'qb-casinoheist:client:VaultLogin',
                icon = 'fas fa-user',
                label = 'Login',
                item = 'casino_keycard',
                canInteract = function()
                    return not Shared.VaultLogin
                end
            }
        },
        distance = 1.5,
    })

    -- Key Pads
    exports['qb-target']:AddBoxZone("casinoh_vaultkeypad1", vector3(996.65, 8.85, -8.55), 0.2, 0.2, {
        name = "casinoh_vaultkeypad1",
        heading = 345,
        debugPoly = false,
        minZ = -8.15,
        maxZ = -7.75
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:VaultKeypad',
                icon = 'fas fa-user-secret',
                label = 'Enter Code',
                keypad = 1,
                canInteract = function()
                    return Shared.VaultLogin and Shared.VaultStage < 2
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_vaultkeypad2", vector3(998.44, 10.28, -8.55), 0.2, 0.2, {
        name = "casinoh_vaultkeypad2",
        heading = 238,
        debugPoly = false,
        minZ = -8.15,
        maxZ = -7.75
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:VaultKeypad',
                icon = 'fas fa-user-secret',
                label = 'Enter Code',
                keypad = 2,
                canInteract = function()
                    return Shared.VaultLogin and Shared.VaultStage < 2
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_vaultkeypad3", vector3(1003.71, 7.03, -8.55), 0.2, 0.2, {
        name = "casinoh_vaultkeypad3",
        heading = 329,
        debugPoly = false,
        minZ = -8.15,
        maxZ = -7.75
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:VaultKeypad',
                icon = 'fas fa-user-secret',
                label = 'Enter Code',
                keypad = 3,
                canInteract = function()
                    return Shared.VaultLogin and Shared.VaultStage < 2
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_vaultkeypad4", vector3(1003.17, 4.75, -8.55), 0.2, 0.2, {
        name = "casinoh_vaultkeypad4",
        heading = 311,
        debugPoly = false,
        minZ = -8.15,
        maxZ = -7.75
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:VaultKeypad',
                icon = 'fas fa-user-secret',
                label = 'Enter Code',
                keypad = 4,
                canInteract = function()
                    return Shared.VaultLogin and Shared.VaultStage < 2
                end
            }
        },
        distance = 1.5,
    })

    -- Vault Boxes
    exports['qb-target']:AddBoxZone("casinoh_box114", vector3(1013.35, -0.72, -8.55), 2.0, 0.4, {
        name = "casinoh_box114",
        heading = 10,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootLaptopBox',
                icon = 'fas fa-hammer',
                label = 'Rob!',
                box = 1,
                canInteract = function()
                    return not Shared.Lockers[1].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box115", vector3(1013.68, -3.41, -8.55), 2.0, 0.4, {
        name = "casinoh_box115",
        heading = 2,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootLaptopBox',
                icon = 'fas fa-hammer',
                label = 'Rob!',
                box = 2,
                canInteract = function()
                    return not Shared.Lockers[2].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box128", vector3(1012.4, -11.3, -8.55), 2.0, 0.4, {
        name = "casinoh_box128",
        heading = 339,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 3,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[3].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box1210", vector3(1009.86, -16.01, -8.55), 2.0, 0.4, {
        name = "casinoh_box1210",
        heading = 325,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 4,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[4].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box2316", vector3(996.5, -24.29, -8.55), 2.0, 0.4, {
        name = "casinoh_box2316",
        heading = 280,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 5,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[5].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box2317", vector3(993.81, -24.57, -8.55), 2.0, 0.4, {
        name = "casinoh_box2317",
        heading = 272,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 6,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[6].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box2419", vector3(988.49, -24.0, -8.55), 2.0, 0.4, {
        name = "casinoh_box2419",
        heading = 76,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 7,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[7].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box2422", vector3(981.18, -20.73, -8.55), 2.0, 0.4, {
        name = "casinoh_box2422",
        heading = 54,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 8,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[8].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box2525", vector3(975.73, -14.87, -8.55), 2.0, 0.4, {
        name = "casinoh_box2525",
        heading = 31,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 9,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[9].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box2527", vector3(973.52, -9.99, -8.55), 2.0, 0.4, {
        name = "casinoh_box2527",
        heading = 17,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 10,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[10].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box2529", vector3(972.66, -4.67, -8.55), 2.0, 0.4, {
        name = "casinoh_2529",
        heading = 3,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 11,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[11].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box2530", vector3(972.73, -2.01, -8.55), 2.0, 0.4, {
        name = "casinoh_2530",
        heading = 355,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 12,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[12].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box3631", vector3(973.2, 0.64, -8.55), 2.0, 0.4, {
        name = "casinoh_3631",
        heading = 346,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 13,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[13].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box3636", vector3(980.17, 11.84, -8.55), 2.0, 0.4, {
        name = "casinoh_box3636",
        heading = 310,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 14,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[14].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box3738", vector3(984.7, 14.71, -8.55), 2.0, 0.4, {
        name = "casinoh_3738",
        heading = 114,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 15,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[15].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box3740", vector3(989.85, 16.26, -8.55), 2.0, 0.4, {
        name = "casinoh_box3740",
        heading = 99,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 16,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[16].hit
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("casinoh_box3742", vector3(995.21, 16.42, -8.55), 2.0, 0.4, {
        name = "casinoh_box3742",
        heading = 85,
        debugPoly = false,
        minZ = -9.15,
        maxZ = -8.15
      }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:LootBox',
                icon = 'fas fa-laptop',
                label = 'Access LAN',
                box = 17,
                canInteract = function()
                    return checkLaptop() and not Shared.Lockers[17].hit
                end
            }
        },
        distance = 1.5,
    })
end)