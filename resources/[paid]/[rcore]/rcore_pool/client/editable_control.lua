poolCue = nil
DEFAULT_AIM_STRENGTH = -1.0

AimingHelpScaleform = nil

AimCam = nil
BallInHandCam = nil

-- cache
local SetEntityCoordsNoOffset = SetEntityCoordsNoOffset
local SetEntityRotation = SetEntityRotation
local SetCamCoord = SetCamCoord
local PointCamAtCoord = PointCamAtCoord
local GetGameTimer = GetGameTimer
local PlayerPedId = PlayerPedId
local GetEntityCoords = GetEntityCoords
local SetEntityCoordsNoOffset = SetEntityCoordsNoOffset
local IsControlPressed = IsControlPressed
local IsDisabledControlPressed = IsDisabledControlPressed

Citizen.CreateThread(function()

    local costSuffix = ''

    if Config.PayForSettingBalls and Config.BallSetupCost then
        costSuffix = ' ~g~$' .. Config.BallSetupCost .. '~s~'
    end

    AddTextEntry('TEB_POOL_SETUP', '~' .. Config.Keys.SETUP_MODIFIER.label .. '~ + ~' .. Config.Keys.ENTER.label .. '~' .. costSuffix .. ' ' .. Config.Text.HINT_SETUP)
    AddTextEntry('TEB_POOL_TAKE_CUE', '~' .. Config.Keys.ENTER.label .. '~ ' .. Config.Text.HINT_TAKE_CUE)
    AddTextEntry('TEB_POOL_RETURN_CUE', '~' .. Config.Keys.ENTER.label .. '~' .. Config.Text.HINT_RETURN_CUE)
    AddTextEntry('TEB_POOL_HINT_TAKE_CUE', Config.Text.HINT_HINT_TAKE_CUE)
    AddTextEntry('TEB_POOL_PLAY_SETUP', '~' .. Config.Keys.ENTER.label .. '~ ' .. Config.Text.HINT_PLAY .. '~n~~' .. Config.Keys.SETUP_MODIFIER.label .. '~ + ~' .. Config.Keys.ENTER.label .. '~' .. costSuffix .. ' ' .. Config.Text.HINT_SETUP)
end)

Citizen.CreateThread(function()
    local lastState = nil

    while true do
        if IsCloseToAnyTable then
            Wait(0)
        else
            Wait(1500)
        end

        if CurrentState == STATE_NONE then
            AimingHelpScaleform = nil
        elseif CurrentState == STATE_AIMING then
            if lastState ~= STATE_AIMING then
                AimingHelpScaleform = nil
                lastState = STATE_AIMING
            end
            if not AimingHelpScaleform then
                AimingHelpScaleform = setupInstructionalScaleform("instructional_buttons")
            end
            DrawScaleformMovieFullscreen(AimingHelpScaleform, 255, 255, 255, 255, 0)
        elseif CurrentState == STATE_BALL_IN_HAND then
            if lastState ~= STATE_BALL_IN_HAND then
                AimingHelpScaleform = nil
                lastState = STATE_BALL_IN_HAND
            end
            if not AimingHelpScaleform then
                AimingHelpScaleform = setupInstructionalBallInHandScaleform("instructional_buttons")
            end
            DrawScaleformMovieFullscreen(AimingHelpScaleform, 255, 255, 255, 255, 0)
        end
    end
end)

function RequestPlayTable(tableAddress)
    if not TableData[tableAddress].player then
        TriggerServerEvent('rcore_pool:requestTurn', tableAddress, GetServerIdsNearTable(ClosestTableAddress))
    end
end

RegisterNetEvent('rcore_pool:turnGranted')
AddEventHandler('rcore_pool:turnGranted', function(tableAddress)
    TableData[tableAddress].player = GetPlayerServerId(PlayerId())
    
    if not TableData[tableAddress].balls[TableData[tableAddress].cueBallIdx].disabled then -- cue ball in play
        CurrentState = STATE_AIMING
        SetupAiming(nil, tableAddress)
    else -- cue ball pocketed
        local tableOffset = TABLE_OFFSET[GetEntityModel(TableData[tableAddress].entity)]
        TableData[tableAddress].balls[TableData[tableAddress].cueBallIdx].disabled = nil
        TableData[tableAddress].balls[TableData[tableAddress].cueBallIdx].position = GetOffsetFromEntityInWorldCoords(
            TableData[tableAddress].entity, 
            -0.043 + tableOffset.x, 
            0.825 + tableOffset.y, 
            0.89
        ).xy
        TriggerServerEvent('rcore_pool:setBallInHandData', GetServerIdsNearTable(ClosestTableAddress), tableAddress, TableData[tableAddress].balls[TableData[tableAddress].cueBallIdx].position)
        ProcessBallCreationDeletion()
        CurrentState = STATE_BALL_IN_HAND
        SetupBallInHand(0.0, tableAddress)
    end
end)

function SetupBallInHand(heading, tableAddress)
    local tableEntity = TableData[tableAddress].entity
    local cueBall = TableData[tableAddress].balls[TableData[tableAddress].cueBallIdx]

    local cueBallCoords = GetEntityCoords(cueBall.entity)
    local tableHeading = GetEntityHeading(tableEntity)
    local camZoomOut = 1.0

    BallInHandCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    
    SetCamCoord(BallInHandCam, cueBallCoords.x, cueBallCoords.y, cueBallCoords.z + camZoomOut)

    SetCamRot(BallInHandCam, -90.0, -0.0, heading)
    
    TriggerServerEvent('rcore_pool:ballInHandNotify', GetServerIdsNearTable(tableAddress), tableAddress)

    if IsCamActive(AimCam) then
        SetCamActiveWithInterp(BallInHandCam, AimCam, 1000, 500, 500)

        Wait(1000)

        DestroyCam(AimCam)
    else
        SetCamActive(BallInHandCam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
    
    local padding = 0.013
    local min = vector2(-0.84283 + padding, -1.225585 + padding)
    local max = vector2(0.697048 - padding, 1.482726 - padding)

    local tableOffset = TABLE_OFFSET[GetEntityModel(tableEntity)]

    local bottomLeftPosition = GetOffsetFromEntityInWorldCoords(tableEntity, min.x + tableOffset.x, min.y + tableOffset.y, 0.89+0.01)
    local bottomRightPosition = GetOffsetFromEntityInWorldCoords(tableEntity, max.x + tableOffset.x, min.y + tableOffset.y, 0.89+0.01)
    local topRightPosition = GetOffsetFromEntityInWorldCoords(tableEntity, max.x + tableOffset.x, max.y + tableOffset.y, 0.89+0.01)
    local topLeftPosition = GetOffsetFromEntityInWorldCoords(tableEntity, min.x + tableOffset.x, max.y + tableOffset.y, 0.89+0.01)

    local ballInHandColliders = {
        {bottomLeftPosition, bottomRightPosition},
        {bottomRightPosition, topRightPosition},
        {topRightPosition, topLeftPosition},
        {topLeftPosition, bottomLeftPosition}
    }

    Citizen.CreateThread(function()
        local lastBallInHandSync = GetGameTimer()
        while CurrentState == STATE_BALL_IN_HAND do
            Wait(0)

            DisableAllControlActions(0)
            EnableControlAction(0, 249, true)

            cueBallCoords = GetEntityCoords(cueBall.entity)
            SetCamCoord(BallInHandCam, cueBallCoords.x, cueBallCoords.y, cueBallCoords.z + camZoomOut)

            local moveSpeed = 1.0

            if IsControlPressed(0, Config.Keys.AIM_SLOWER.code) or IsDisabledControlPressed(0, Config.Keys.AIM_SLOWER.code) then
                moveSpeed = 0.2
            end

            if IsControlPressed(0, Config.Keys.BALL_IN_HAND_LEFT.code) or IsDisabledControlPressed(0, Config.Keys.BALL_IN_HAND_LEFT.code) then
                local moveOffset = vector2(
                    math.cos(math.rad(heading + 180.0)),
                    math.sin(math.rad(heading + 180.0))
                ) * moveSpeed
                local newPos = cueBall.position + moveOffset * GetFrameTime()

                if not isPositionCollidingWithWall(ballInHandColliders, newPos) and not isPositionCollidingWithAnyBall(cueBall.entity, newPos, TableData[tableAddress].balls) then
                    cueBall.position = newPos
                end
            end
            
            if IsControlPressed(0, Config.Keys.BALL_IN_HAND_RIGHT.code) or IsDisabledControlPressed(0, Config.Keys.BALL_IN_HAND_RIGHT.code) then
                local moveOffset = vector2(
                    math.cos(math.rad(heading + 180.0)),
                    math.sin(math.rad(heading + 180.0))
                ) * moveSpeed
                local newPos = cueBall.position - moveOffset * GetFrameTime()

                if not isPositionCollidingWithWall(ballInHandColliders, newPos) and not isPositionCollidingWithAnyBall(cueBall.entity, newPos, TableData[tableAddress].balls) then
                    cueBall.position = newPos
                end
            end

            if IsControlPressed(0, Config.Keys.BALL_IN_HAND_UP.code) or IsDisabledControlPressed(0, Config.Keys.BALL_IN_HAND_UP.code) then
                local moveOffset = vector2(
                    math.cos(math.rad(heading + 180.0 + 90.0)),
                    math.sin(math.rad(heading + 180.0 + 90.0))
                ) * moveSpeed
                local newPos = cueBall.position - moveOffset * GetFrameTime()

                if not isPositionCollidingWithWall(ballInHandColliders, newPos) and not isPositionCollidingWithAnyBall(cueBall.entity, newPos, TableData[tableAddress].balls) then
                    cueBall.position = newPos
                end
            end
            
            if IsControlPressed(0, Config.Keys.BALL_IN_HAND_DOWN.code) or IsDisabledControlPressed(0, Config.Keys.BALL_IN_HAND_DOWN.code) then
                local moveOffset = vector2(
                    math.cos(math.rad(heading + 180.0 + 90.0)),
                    math.sin(math.rad(heading + 180.0 + 90.0))
                ) * moveSpeed
                local newPos = cueBall.position + moveOffset * GetFrameTime()

                if not isPositionCollidingWithWall(ballInHandColliders, newPos) and not isPositionCollidingWithAnyBall(cueBall.entity, newPos, TableData[tableAddress].balls) then
                    cueBall.position = newPos
                end
            end

            local nowTime = GetGameTimer()
            
            if (nowTime - lastBallInHandSync) > 500 then
                TriggerServerEvent('rcore_pool:setBallInHandData', tableAddress, cueBall.position)
                lastBallInHandSync = nowTime
            end

            if IsControlPressed(0, Config.Keys.BACK.code) or IsDisabledControlPressed(0, Config.Keys.BACK.code) or IsControlJustPressed(0, Config.Keys.BALL_IN_HAND.code) or IsDisabledControlJustPressed(0, Config.Keys.BALL_IN_HAND.code) then
                CurrentState = STATE_AIMING
                PreventPauseMenu()
                SetupAiming(BallInHandCam, tableAddress)
                DestroyCam(BallInHandCam)
                BallInHandCam = nil
            end
        end
    end)
end

NOT_NETWORKED = false
function SetupAiming(fromCam, tableAddress)
    local cueModel = GetHashKey('prop_pool_cue')

    poolCue = CreateObject(
        cueModel, 
        vector3(0.0, 0.0, 0.0), 
        NOT_NETWORKED, false, false
    )
    SetEntityCollision(poolCue, false, false)

    if Config.Debug then
        print("Setting up aiming at", tableAddress)
        print("Table", TableData[tableAddress])
        print("Entity", TableData[tableAddress].entity)
    end

    local tableEntity = TableData[tableAddress].entity
    local strength = DEFAULT_AIM_STRENGTH
    local isSettingStrength = false

    local lastPedPositionUpdate = GetGameTimer()
    PoolCueAnimAim()

    local currentTableCueBall = TableData[tableAddress].balls[TableData[tableAddress].cueBallIdx]

    local cueBallPos = GetEntityCoords(currentTableCueBall.entity)
    local poolTableHeading = GetPoolCueHeadingToCueBall(cueBallPos) --GetEntityHeading(tableEntity) + 90.0

    AimCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)

    local camOffset = vector3(math.cos(math.rad(poolTableHeading)), math.sin(math.rad(poolTableHeading)), 0.02)
    local camPos = cueBallPos + camOffset * 0.8

    SetCamCoord(AimCam, camPos.x, camPos.y, camPos.z + 0.5)
    PointCamAtCoord(AimCam, cueBallPos.x, cueBallPos.y, cueBallPos.z)

    if fromCam then
        SetCamActiveWithInterp(AimCam, fromCam, 1000, 500, 500)
        Wait(1000)
    else
        SetCamActive(AimCam, true)
        RenderScriptCams(true, false, 0, true, false)
    end

    local selectedStrikeStrength = nil
    local selectedStrikeVelocity = nil
    local selectedCueVector = nil
    local selectedVisualStrength = nil

    Citizen.CreateThread(function()
        while CurrentState == STATE_AIMING do
            Wait(0)
            
            DisableAllControlActions(0)
            EnableControlAction(0, 249, true)

            local computedVisualStrength = (math.sin(strength) + 1.0)/2

            local offset = vector3(math.cos(math.rad(poolTableHeading)), math.sin(math.rad(poolTableHeading)), 0.02)
            local offsetPos = cueBallPos + offset * 0.8 * (1.0 + 0.3 * computedVisualStrength)
            local camPos = cueBallPos + offset * 0.8

            local cuePos = GetEntityCoords(poolCue)

            if #(cuePos - offsetPos) > 0.0001 then
                SetEntityCoordsNoOffset(poolCue, offsetPos.x, offsetPos.y, offsetPos.z, false, false, false)
                SetEntityRotation(poolCue, 90.0, poolTableHeading - 90.0, 0.0, 2, true)

                SetCamCoord(AimCam, camPos.x, camPos.y, camPos.z + 0.5)
                PointCamAtCoord(AimCam, cueBallPos.x, cueBallPos.y, cueBallPos.z)
            end
            
            if IsControlJustPressed(0, Config.Keys.BALL_IN_HAND.code) or IsDisabledControlJustPressed(0, Config.Keys.BALL_IN_HAND.code) then
                CurrentState = STATE_BALL_IN_HAND
                SetupBallInHand(poolTableHeading + 90.0, tableAddress)
                break
            end

            local nowTime = GetGameTimer()
            
            if not Config.DoNotRotateAroundTableWhenAiming and (nowTime - lastPedPositionUpdate) > 500.0 then
                lastPedPositionUpdate = nowTime

                local strikeDirection = (cueBallPos.xy - offsetPos.xy)
                
                local angle = math.atan2(strikeDirection.y, strikeDirection.x)
                local angleDeg = math.deg(angle) - 180.0

                local tableBorderPos = GetTableBorderPosition(tableEntity, currentTableCueBall.entity, angleDeg)
                
                local playerPed = PlayerPedId()
                local pedCoords = GetEntityCoords(playerPed)

                if(#(pedCoords - tableBorderPos) > 0.2) then
                    SetEntityCoordsNoOffset(
                        playerPed, 
                        tableBorderPos.x, tableBorderPos.y, tableBorderPos.z,
                        false, false, false 
                    )
                    SetEntityHeading(playerPed, angleDeg + 90.0)
                    PoolCueAnimAim()
                end
            end

            if not isSettingStrength then
                local step = 1.0

                if IsControlPressed(0, Config.Keys.AIM_SLOWER.code) or IsDisabledControlPressed(0, Config.Keys.AIM_SLOWER.code) then
                    step = 0.13
                end

                if IsControlPressed(0, Config.Keys.CUE_LEFT.code) or IsDisabledControlPressed(0, Config.Keys.CUE_LEFT.code) then
                    poolTableHeading = poolTableHeading - step
                elseif IsControlPressed(0, Config.Keys.CUE_RIGHT.code) or IsDisabledControlPressed(0, Config.Keys.CUE_RIGHT.code) then
                    poolTableHeading = poolTableHeading + step
                elseif IsControlJustPressed(0, Config.Keys.CUE_HIT.code) or IsDisabledControlJustPressed(0, Config.Keys.CUE_HIT.code) then
                    isSettingStrength = true
                elseif IsControlJustPressed(0, Config.Keys.BACK.code) or IsDisabledControlJustPressed(0, Config.Keys.BACK.code) then
                    CurrentState = STATE_NONE
                    TriggerServerEvent('rcore_pool:releaseControl', tableAddress, GetServerIdsNearTable(tableAddress))
                    PreventPauseMenu()
                end
            elseif isSettingStrength then
                if IsControlJustPressed(0, Config.Keys.CUE_HIT.code) or IsDisabledControlJustPressed(0, Config.Keys.CUE_HIT.code) then
                    isSettingStrength = false

                    local clampedStrength = math.min(1.0, math.max(0.0, math.tan(computedVisualStrength)/1.5))

                    selectedStrikeStrength = clampedStrength
                    selectedStrikeVelocity = (cueBallPos.xy - offsetPos.xy) * 15 * clampedStrength
                    selectedCueVector = offset * 0.8
                    selectedVisualStrength = computedVisualStrength

                    strength = DEFAULT_AIM_STRENGTH
                    break
                elseif IsControlJustPressed(0, Config.Keys.BACK.code) or IsDisabledControlJustPressed(0, Config.Keys.BACK.code) then
                    isSettingStrength = false
                    strength = DEFAULT_AIM_STRENGTH
                    PreventPauseMenu()
                end

                strength = strength + 0.03
            end
        end

        --- CLEANUP

        if not BallInHandCam then
            SetGameplayCoordHint(GetEntityCoords(tableEntity) + vector3(0.0, 0.0, 0.5), 0, 1, 1, 0)
            Wait(300)
            RenderScriptCams(false, false, 0, true, false)
            DestroyCam(AimCam, false)
        end

        if selectedStrikeStrength then
            Wait(600)
            while selectedVisualStrength > 0 do
                Wait(0)
                selectedVisualStrength = selectedVisualStrength - 10.0 * GetFrameTime()
                local newOffset = cueBallPos + selectedCueVector * (1.0 + 0.3 * selectedVisualStrength)
                
                SetEntityCoordsNoOffset(poolCue, newOffset.x, newOffset.y, newOffset.z, false, false, false)
            end

            TriggerServerEvent('rcore_pool:syncCueBallVelocity', GetServerIdsNearTable(tableAddress), tableAddress, currentTableCueBall.position, selectedStrikeVelocity, selectedStrikeStrength)

            Wait(500)
        end

        DeleteObject(poolCue)
        poolCue = nil

        Wait(1000) -- wait just a bit until reseting anim/alpha after hit
        PoolCueAnimReset()

    end)
end

function GetPoolCueHeadingToCueBall(cueBallPos)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local direction = pedCoords - cueBallPos

    local angle = math.atan2(direction.y, direction.x)
    local angleDeg = math.deg(angle)

    return angleDeg
end

function PreventPauseMenu()
    -- prevent pause menu from popping up
    local isEscPressed = true

    Citizen.CreateThreadNow(function()
        while IsControlPressed(0, 200) do -- ESC key
            Wait(0)
        end
        Wait(500)
        isEscPressed = false
    end)

    
    Citizen.CreateThreadNow(function()
        while isEscPressed do
            SetPauseMenuActive(false)
            Wait(0)
        end
    end)
end

RegisterNetEvent('lsrp_pool:forceStopControl')
AddEventHandler('lsrp_pool:forceStopControl', function()
    if CurrentState == STATE_AIMING or CurrentState == STATE_BALL_IN_HAND then
        CurrentState = STATE_NONE
        TriggerServerEvent('rcore_pool:releaseControl', ClosestTableAddress)
    end
end)