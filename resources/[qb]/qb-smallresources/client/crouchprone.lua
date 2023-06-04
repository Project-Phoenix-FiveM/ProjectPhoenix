local stage = 0
local movingForward = false
local walkSet = "default"

local function RequestWalking(set)
    if HasAnimSetLoaded(set) then return end
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Wait(10)
    end
end

local function ResetAnimSet()
    local ped = PlayerPedId()
    if walkSet == "default" then
        ResetPedMovementClipset(ped, 0)
        ResetPedWeaponMovementClipset(ped)
        ResetPedStrafeClipset(ped)
    else
        ResetPedMovementClipset(ped, 0)
        ResetPedWeaponMovementClipset(ped)
        ResetPedStrafeClipset(ped)
        Wait(100)
        RequestWalking(walkSet)
        SetPedMovementClipset(ped, walkSet, 1)
        RemoveAnimSet(walkSet)
    end
end

RegisterNetEvent('crouchprone:client:SetWalkSet', function(clipset)
    walkSet = clipset
end)

CreateThread(function()
    local sleep
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        if not IsPedSittingInAnyVehicle(ped) and not IsPedFalling(ped) and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
            sleep = 0
            if IsControlJustReleased(2, 36) then
                stage += 1
                if stage == 2 then
                    -- Crouch stuff
                    ClearPedTasks(ped)
                    RequestWalking("move_ped_crouched")
                    SetPedMovementClipset(ped, "move_ped_crouched",1.0)
                    SetPedWeaponMovementClipset(ped, "move_ped_crouched")
                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
                elseif stage == 3 then
                    ClearPedTasks(ped)
                    RequestWalking("move_crawl")
                elseif stage > 3 then
                    stage = 0
                    ClearPedTasksImmediately(ped)
                    ResetAnimSet()
                    SetPedStealthMovement(ped, false, "DEFAULT_ACTION")
                end
            end

            if stage == 2 then
                if GetEntitySpeed(ped) > 1.0 then
                    SetPedWeaponMovementClipset(ped, "move_ped_crouched")
                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
                elseif GetEntitySpeed(ped) < 1.0 and (GetFollowPedCamViewMode() == 4 or GetFollowVehicleCamViewMode() == 4) then
                    ResetPedWeaponMovementClipset(ped)
                    ResetPedStrafeClipset(ped)
                end
            elseif stage == 3 then
                DisableControlAction(0, 21, true ) -- sprint
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)

                if (IsControlPressed(0, 32) and not movingForward) and Config.EnableProne then
                    movingForward = true
                    SetPedMoveAnimsBlendOut(ped)
                    local pronepos = GetEntityCoords(ped)
                    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", pronepos.x, pronepos.y, pronepos.z+0.1, 0.0, 0.0, GetEntityHeading(ped), 100.0, 0.4, 1.0, 7, 2.0, 1, 1)
                    Wait(500)
                elseif not IsControlPressed(0, 32) and movingForward then
                    local pronepos = GetEntityCoords(ped)
                    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", pronepos.x, pronepos.y, pronepos.z+0.1, 0.0, 0.0, GetEntityHeading(ped), 100.0, 0.4, 1.0, 6, 2.0, 1, 1)
                    Wait(500)
                    movingForward = false
                end

                if IsControlPressed(0, 34) then
                    SetEntityHeading(ped,GetEntityHeading(ped) + 1)
                end

                if IsControlPressed(0, 9) then
                    SetEntityHeading(ped,GetEntityHeading(ped) - 1)
                end
            end
        else
            stage = 0
        end
        Wait(sleep)
    end
end)
