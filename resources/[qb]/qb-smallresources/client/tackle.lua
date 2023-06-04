local QBCore = exports['qb-core']:GetCoreObject()

local function TackleAnim()
    local ped = PlayerPedId()
    if not QBCore.Functions.GetPlayerData().metadata["ishandcuffed"] and not IsPedRagdoll(ped) then
        if not HasAnimDictLoaded("swimming@first_person@diving") then
            RequestAnimDict("swimming@first_person@diving")
            while not HasAnimDictLoaded("swimming@first_person@diving") do
                Wait(10)
            end
        end
        if IsEntityPlayingAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
            ClearPedTasksImmediately(ped)
        else
            TaskPlayAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop" ,3.0, 3.0, -1, 49, 0, false, false, false)
            Wait(250)
            ClearPedTasksImmediately(ped)
            SetPedToRagdoll(ped, 150, 150, 0, false, false, false)
        end
    end
end

RegisterCommand('tackle', function()
    local closestPlayer, distance = QBCore.Functions.GetClosestPlayer()
    local ped = PlayerPedId()
    if distance ~= -1 and distance < 2 and GetEntitySpeed(ped) > 2.5 and not IsPedInAnyVehicle(ped, false) then
        TriggerServerEvent("tackle:server:TacklePlayer", GetPlayerServerId(closestPlayer))
        TackleAnim()
    end
end)

RegisterKeyMapping('tackle', 'Tackle Someone', 'KEYBOARD', 'LMENU')

RegisterNetEvent('tackle:client:GetTackled', function()
    SetPedToRagdoll(PlayerPedId(), math.random(1000, 6000), math.random(1000, 6000), 0, false, false, false)
    TimerEnabled = true
    Wait(1500)
    TimerEnabled = false
end)
