CurrentMovementAnim = nil
CurrentMovementShouldSqeak = false
local CourtCenter = vector3(-773.1, 153.71000000001, 67.47)
local BlockControlUntil = 0

-- court activator/finder
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for _, courtData in pairs(TennisCourts) do
            if #(coords - courtData.courtCenter) < 50.0 then
                courtData.isActive = true
            else
                courtData.isActive = false
            end
            Wait(500)
        end

        Wait(1000)
    end
end)

function GetServeExtremePoints(courtCenter, courtHeading, courtLength, courtWidth, side)
    local sideOffsetHeading = 0.0

    if side == CONST_SIDE_A then
        sideOffsetHeading = 180.0
    end

    local sideMultiplier = 1

    if PlayerSettings.serveSide == 'left' then
        sideMultiplier = -1
    end

    local centerPoint1 = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading - 90.0 + sideOffsetHeading)) * (courtLength-2.0), 
        courtCenter.y + math.sin(math.rad(courtHeading - 90.0 + sideOffsetHeading)) * (courtLength-2.0),
        courtCenter.z
    )
    local centerPoint2 = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading - 90.0 + sideOffsetHeading)) * (courtLength+3.0), 
        courtCenter.y + math.sin(math.rad(courtHeading - 90.0 + sideOffsetHeading)) * (courtLength+3.0),
        courtCenter.z
    )

    local rightPoint1 = vector3(
        centerPoint1.x + math.cos(math.rad(courtHeading + sideOffsetHeading)) * (courtWidth/2 + 0.75) * sideMultiplier, 
        centerPoint1.y + math.sin(math.rad(courtHeading + sideOffsetHeading)) * (courtWidth/2 + 0.75) * sideMultiplier,
        centerPoint1.z
    )

    local rightPoint2 = vector3(
        centerPoint2.x + math.cos(math.rad(courtHeading + sideOffsetHeading)) * (courtWidth/2 + 0.75) * sideMultiplier, 
        centerPoint2.y + math.sin(math.rad(courtHeading + sideOffsetHeading)) * (courtWidth/2 + 0.75) * sideMultiplier,
        centerPoint2.z
    )

    local xxx = vector3(0.05, 0.05, 0.05)

    if PlayerSettings.serveSide == 'left' then
        return {rightPoint1, rightPoint2}, {centerPoint1, centerPoint2}
    else
        return {centerPoint1, centerPoint2}, {rightPoint1, rightPoint2}
    end
end

function HandleServingFuly(ped, courtPtr, side)
    TaskPlayAnim(ped, 'mini@tennis', 'serve_idle_01', 4.0, 4.0, -1, 1, 1.0, false, false, false)
    local scaleformData = SetupServingScaleformFully()
    WantedInstructionalState = INSTRUCT_SERVE
    while PlayerSettings do
        Wait(0)

        DisablePlayerFiring(PlayerId(), true)
        DisableAllControlActions(0)
        EnableControlAction(0, 249, true)
        EnableControlAction(0, 245, true)

        EnableControlAction(0, 0, true) -- mouse
        EnableControlAction(0, 1, true) -- mouse
        EnableControlAction(0, 2, true) -- mouse

        local finalHeading = courtPtr.courtHeading + (side == CONST_SIDE_A and 180.0 or 0.0)
        SetEntityHeading(ped, finalHeading)

        local isLeftClick = IsDisabledControlJustPressed(0, Config.Control.SHOT_SERVE.key)
        local isA = IsDisabledControlPressed(0, Config.Control.AIM_LEFT.key)
        local isD = IsDisabledControlPressed(0, Config.Control.AIM_RIGHT.key)
        local isF = IsDisabledControlJustPressed(0, Config.Control.SERVE_DROP_BALL.key)

        local leftmost, rightmost = GetServeExtremePoints(courtPtr.courtCenter, courtPtr.courtHeading, courtPtr.courtLength, courtPtr.courtWidth, side)
        
        DrawServeHint(courtPtr, side, PlayerSettings.serveSide)

        if GetGameTimer() > BlockControlUntil then
            if isLeftClick then
                PlayMovementAnim(ped, 'serve', true, true) -- strafe_lft
                local clickedStartAt = GetGameTimer()
                local isHitSubmitted = false

                while true do
                    Wait(0)

                    
                    DrawServeHint(courtPtr, side, PlayerSettings.serveSide)

                    local timePassed = (GetGameTimer() - clickedStartAt)

                    if timePassed <= 3550 then
                        if timePassed > 1000 then
                            HandleServingScaleformTick(scaleformData)
                        end

                        if not scaleformData.isServing and not scaleformData.finalStrength and timePassed > 2000 then
                            scaleformData.isServing = true
                        end

                        if scaleformData.isServing and IsDisabledControlJustPressed(0, Config.Control.SHOT_REGULAR.key) then
                            scaleformData.isServing = false
                            scaleformData.finalStrength = math.max(0.0, math.min(1.0, 1.0 - scaleformData.progress))
                        end
                    elseif not isHitSubmitted then
                        isHitSubmitted = true
                        
                        local hitVector = ComputeAfterHitVelocity(finalHeading, CONST_DIST_NORMAL, true)
                        local finalStrength = (scaleformData.finalStrength or 0.25) * 1.1

                        TriggerServerEvent(
                            'rcore_tennis:setBallData', 
                            PlayerSettings.courtName, CONST_HIT_NORMAL, GetEntityCoords(courtPtr.entity), hitVector * finalStrength, 'SERVE'
                        )
                    elseif timePassed > 5000 then
                        break
                    end
                end
                
                HideServingScaleform()
                return
            elseif isA and not IsEntityInAngledArea(ped, leftmost[1], leftmost[2], 1.0, false, false, false) then
                PlayMovementAnim(ped, 'serve_walk_l', true, true) -- strafe_lft
            elseif isD and not IsEntityInAngledArea(ped, rightmost[1], rightmost[2], 1.0, false, false, false) then
                PlayMovementAnim(ped, 'serve_walk_r', true, true) -- strafe_rt
            elseif isF then -- drop ball
                HideServingScaleform()
                TriggerServerEvent(
                    'rcore_tennis:setBallData', 
                    PlayerSettings.courtName, CONST_HIT_NORMAL, GetEntityCoords(courtPtr.entity), GetEntityForwardVector(ped), 'DROP'
                )
                ClearPedTasks(ped)
                CurrentMovementAnim = 'idle_fh'
                StopMovementAnimIfPlaying(ped, true, CurrentMovementAnim)
                return
            else
                StopMovementAnimIfPlaying(ped, true, 'serve_idle_01')
            end
        end
    end
end

function StartTennisWorker(ped, courtPtr, side)
    local coords = GetEntityCoords(ped)

    StartAudioScene("TENNIS_SCENE");

    RequestScriptAudioBank("SCRIPT\\Tennis", false, -1)
    RequestScriptAudioBank("SCRIPT\\TENNIS_VER2_A", false, -1)

    LoadAnimDict("mini@tennis")
    LoadAnimDict("weapons@tennis@male")

    TriggerServerEvent('rcore_tennis:requestRacket')

    TaskPlayAnim(ped, 'mini@tennis', 'idle_fh', 4.0, 4.0, -1, 1, 1.0, false, false, false)

    while PlayerSettings do
        Wait(0)
        coords = GetEntityCoords(ped)
        DisablePlayerFiring(PlayerId(), true)
        DisableAllControlActions(0)
        EnableControlAction(0, 249, true)
        EnableControlAction(0, 245, true)

        EnableControlAction(0, 0, true) -- mouse
        EnableControlAction(0, 1, true) -- mouse
        EnableControlAction(0, 2, true) -- mouse

        local isW = IsDisabledControlPressed(0, Config.Control.AIM_FAR.key)
        local isS = IsDisabledControlPressed(0, Config.Control.AIM_NEAR.key)
        local isA = IsDisabledControlPressed(0, Config.Control.AIM_LEFT.key)
        local isD = IsDisabledControlPressed(0, Config.Control.AIM_RIGHT.key)
        local isF = IsDisabledControlJustPressed(0, Config.Control.LEAVE_TENIS.key)
        local ped = PlayerPedId()

        local isSpaceClick = IsDisabledControlJustPressed(0, Config.Control.SHOT_BACK_SPIN.key)
        local isLeftClick = IsDisabledControlJustPressed(0, Config.Control.SHOT_REGULAR.key)
        local isRightClick = IsDisabledControlJustPressed(0, Config.Control.SHOT_TOP_SPIN.key)

        SetEntityHeading(ped, courtPtr.courtHeading + (side == CONST_SIDE_A and 180.0 or 0.0))

        if PlayerSettings.isServing then
            PlayerSettings.isServing = false
            HandleServingFuly(ped, courtPtr, side)
        end
        if GetGameTimer() > BlockControlUntil then
            WantedInstructionalState = INSTRUCT_PLAY
            if CanStartServing() then
                local aSideServePoint, bSideServePoint, aSideOppositeServePoint, bSideOppositeServePoint = ComputeSideServePoint(TennisCourts[PlayerSettings.courtName])
                -- DrawBox(aSideServePoint - 0.1, aSideServePoint + 0.1, 255, 0, 0, 200)
                -- DrawBox(bSideServePoint - 0.1, bSideServePoint + 0.1, 255, 0, 0, 200)
                -- DrawBox(aSideOppositeServePoint - 0.1, aSideOppositeServePoint + 0.1, 255, 0, 0, 200)
                -- DrawBox(bSideOppositeServePoint - 0.1, bSideOppositeServePoint + 0.1, 255, 0, 0, 200)

                local servePoint = nil

                if PlayerSettings.side == 'a' then
                    if PlayerSettings.serveSide == 'left' then
                        servePoint = aSideOppositeServePoint
                    else
                        servePoint = aSideServePoint
                    end
                else
                    if PlayerSettings.serveSide == 'left' then
                        servePoint = bSideOppositeServePoint
                    else
                        servePoint = bSideServePoint
                    end
                end

                HandleServePoint(ped, coords, PlayerSettings.courtName, PlayerSettings.side, servePoint)
            end

            if IsBallInPlay() and isLeftClick then
                HandleAttemptHitBall(ped, PlayerSettings.courtName, CONST_HIT_NORMAL)
            elseif IsBallInPlay() and isSpaceClick then
                HandleAttemptHitBall(ped, PlayerSettings.courtName, CONST_HIT_BACKSPIN)
            elseif IsBallInPlay() and isRightClick then
                HandleAttemptHitBall(ped, PlayerSettings.courtName, CONST_HIT_TOPSPIN)
            elseif isW and isA then
                PlayMovementAnim(ped, 'run_fwd_-45', false, true) -- walk_fwd_-45
            elseif isW and isD then
                PlayMovementAnim(ped, 'run_fwd_45', false, true) -- walk_fwd_45
            elseif isS and isA then
                PlayMovementAnim(ped, 'run_bwd_-135', false, true) -- walk_bwd_-135
            elseif isS and isD then
                PlayMovementAnim(ped, 'run_bwd_135', false, true) -- walk_bwd_135
            elseif isW then
                PlayMovementAnim(ped, 'run_fwd_0', false, true) -- strafe_fwd
            elseif isS then
                PlayMovementAnim(ped, 'strafe_bwd', false, true) -- strafe_bwd
            elseif isA then
                PlayMovementAnim(ped, 'run_bwd_-90_loop', true, true) -- strafe_lft
            elseif isD then
                PlayMovementAnim(ped, 'run_fwd_90_loop', true, true) -- strafe_rt
            elseif isF then
                StopPlayingTennis()
                return
            else
                if CurrentMovementShouldSqeak then
                    PlaySoundFromEntity(-1, "TENNIS_FOOT_SQUEAKS_MASTER", ped, 0, false, 0)
                    CurrentMovementShouldSqeak = false
                end

                StopMovementAnimIfPlaying(ped, true)
            end
        end

        if GetFrameCount() % 10 == 0 then
            local pointData = GetPointData(courtPtr.courtCenter, courtPtr.courtHeading, courtPtr.courtWidth, courtPtr.courtLength, courtPtr.centerConstant, GetEntityCoords(PlayerPedId()))

            local isOnWrongSide = (PlayerSettings.side == CONST_SIDE_A and pointData.isBSide) or (PlayerSettings.side == CONST_SIDE_B and pointData.isASide )

            if isOnWrongSide or not pointData.isInExtendedArea then
                StopPlayingTennis()
            end
        end
    end
end

function HandleServePoint(ped, coords, courtIdx, positionName, serverPointCoords)
    DrawMarker(
        1, 
        serverPointCoords.x, serverPointCoords.y, serverPointCoords.z, 
        0.0, 0.0, 0.0, 
        0.0, 0.0, 0.0, 
        1.5, 1.5, 1.0, 
        255, 0, 0, 150, 
        false, false, false, false, nil, nil, false
    )

    if #(coords - serverPointCoords) < 1.3 then
        DisplayHelpTextThisFrame('LS_TEN_STRT2', 0)
        if IsControlJustPressed(0, Config.Control.SERVE.key) or IsDisabledControlJustPressed(0, Config.Control.SERVE.key) then
            TriggerServerEvent('rcore_tennis:requestBallInHand')
        end
    end
end

function IsBallInPlay()
    local courtName = PlayerSettings.courtName

    if TennisCourts[courtName].server then
        return false
    end

    return TennisCourts[courtName].ballVelocity and #TennisCourts[courtName].ballVelocity >= 0.01
end

function CanStartServing()
    local courtName = PlayerSettings.courtName

    if not PlayerSettings.canServe then
        return false
    end

    if TennisCourts[courtName].server then
        return false
    end

    if not TennisCourts[courtName].players then
        return false
    end

    if not TennisCourts[courtName].players[CONST_SIDE_A] or not TennisCourts[courtName].players[CONST_SIDE_B] then
        return false
    end

    return true
end

function StopPlayingTennis()
    local ped = PlayerPedId()
    TriggerServerEvent('rcore_tennis:deleteRacket')
    ClearPedTasks(ped)
    PlayerSettings = nil
    TriggerServerEvent('rcore_tennis:releaseMyPosition')
    
    StopAudioScene("TENNIS_SCENE");

    ReleaseNamedScriptAudioBank("SCRIPT\\Tennis", false, -1)
    ReleaseNamedScriptAudioBank("SCRIPT\\TENNIS_VER2_A", false, -1)

end

function HandleAttemptHitBall(ped, courtName, hitType)
    local side, distName, ballPos, ballVel = PredictBallPosition(
        TennisCourts[courtName].spin, 
        TennisCourts[courtName].ballPos, 
        TennisCourts[courtName].ballVelocity, 
        TennisCourts[courtName].z
    )

    local groundDist = ComputeGroundHitDist(ped, ballPos)


    -- cant reuse "ped" as it could've changed in ComputegRoundHitDist (after wait)
    PlayHitBallAnim(PlayerPedId(), ANIM_TREE[side][distName][hitType][groundDist], side, distName, hitType, TennisCourts[courtName], ballPos)
end

function ComputeGroundHitDist(ped, ballPos)
    local pedCoords = GetEntityCoords(ped)

    local zDiff = (ballPos.z+Config.BallRadius) - pedCoords.z

    local loDist = math.abs(zDiff - ANIM_GND_DIST_OFFSET[CONST_GND_DIST_LO])
    local mdDist = math.abs(zDiff - ANIM_GND_DIST_OFFSET[CONST_GND_DIST_MD])
    local hiDist = math.abs(zDiff - ANIM_GND_DIST_OFFSET[CONST_GND_DIST_HI])

    if loDist < mdDist and loDist < hiDist then
        return CONST_GND_DIST_LO
    end

    if mdDist < loDist and mdDist < hiDist then
        return CONST_GND_DIST_MD
    end

    if hiDist < mdDist and hiDist < loDist then
        return CONST_GND_DIST_HI
    end

    return CONST_GND_DIST_MD
end

local AnimToIdle = {
    ['forehand_ts_md'] = 'idle_bh',
    ['run_fwd_-45'] = 'idle_bh',
    ['run_fwd_45'] = 'idle_fh',
    ['run_bwd_-135'] = 'idle_bh',
    ['run_bwd_135'] = 'idle_fh',
    ['run_fwd_0'] = 'idle_bh',
    ['strafe_bwd'] = 'idle_fh',
    ['run_bwd_-90_loop'] = 'idle_bh',
    ['run_fwd_90_loop'] = 'idle_fh',
}

local lastSidewaysAnim = nil

function StopMovementAnimIfPlaying(ped, setIdle, forcedIdleAnim)
    if CurrentMovementAnim then
        StopAnimTask(ped, 'mini@tennis', CurrentMovementAnim, 1.0)
        StopAnimTask(ped, 'mini@tennis', CurrentMovementAnim .. '_loop', 1.0)


        if setIdle then
            CurrentMovementAnim = forcedIdleAnim or AnimToIdle[lastSidewaysAnim] or AnimToIdle[CurrentMovementAnim] or 'idle_fh'
            TaskPlayAnim(ped, 'mini@tennis', CurrentMovementAnim, 4.0, 4.0, -1, 1, 1.0, false, false, false)
            lastSidewaysAnim = nil
        end

        CurrentMovementShouldSqeak = false
        CurrentMovementAnim = nil
    end
end

function PlayMovementAnim(ped, anim, skipIntro, shouldSqeak)
    if anim ~= CurrentMovementAnim then
        StopMovementAnimIfPlaying(ped)
        CurrentMovementAnim = anim
        
        local isFwdOrBwdMove = CurrentMovementAnim == 'strafe_bwd' or CurrentMovementAnim == 'run_fwd_0'

        if not isFwdOrBwdMove then
            lastSidewaysAnim = CurrentMovementAnim
        end

        CurrentMovementShouldSqeak = shouldSqeak

        if skipIntro then
            TaskPlayAnim(ped, 'mini@tennis', anim, 4.0, 4.0, -1, 1, 1.0, false, false, false)
        else
            TaskPlayAnim(ped, 'mini@tennis', anim .. '_intro', 4.0, 4.0, -1, 0, 1.0, false, false, false)
            TaskPlayAnim(ped, 'mini@tennis', anim .. '_loop', 4.0, 4.0, -1, 1, 1.0, false, false, false)
        end
    end
end

function PlayHitBallAnim(ped, name, side, distName, hitType, courtPtr, predictedBallPos)
    local animDuration = tonumber(math.floor(GetAnimDuration('mini@tennis', name)*1000))

    CurrentMovementAnim = nil
    TaskPlayAnim(ped, 'mini@tennis', name, 4.0, 4.0, animDuration-200, 1, 1.0, false, false, false)
    BlockControlUntil = GetGameTimer() + animDuration-200

    Citizen.SetTimeout(animDuration-200, function()
        CurrentMovementAnim = name
        if side == CONST_SIDE_BACKHAND then
            lastSidewaysAnim = 'run_fwd_0'
        else
            lastSidewaysAnim = 'strafe_bwd'
        end
    end)

    Citizen.SetTimeout(math.max(1, ANIM_HIT_DELAY[distName]-150), function()
        local racketCoords = GetOffsetFromEntityInWorldCoords(RacketEntity, 0.0, 0.0, 0.4)

        --- @@@ DEBUG VISUAL
        -- Citizen.CreateThread(function()
        --     local cachedPos = courtPtr.ballPos
        --     for i = 1, 60*10 do
        --         Wait(0)

        --         DrawBox(
        --             cachedPos - vector3(0.05, 0.05, 0.05),
        --             cachedPos + vector3(0.05, 0.05, 0.05),
        --             0.5,
        --             0, 255, 0, 150
        --         )

        --         DrawBox(
        --             predictedBallPos - vector3(0.05, 0.05, 0.05),
        --             predictedBallPos + vector3(0.05, 0.05, 0.05),
        --             0.5,
        --             255, 255, 255, 90
        --         )

        --         DrawBox(
        --             racketCoords - vector3(0.1, 0.1, 0.1),
        --             racketCoords + vector3(0.1, 0.1, 0.1),
        --             255, 0, 0, 150
        --         )

        --         DrawLine(
        --             cachedPos, 
        --             racketCoords, 
        --             0, 0, 255, 255
        --         )

        --         local textPos = (cachedPos+racketCoords)/2
        --         Draw3DText(textPos.x, textPos.y, textPos.z, #(racketCoords.xy - cachedPos.xy))
        --     end
        -- end)
        -- @@@END DEBUG VISUAL

        if #(racketCoords.xy - courtPtr.ballPos.xy) < 3.5 and IsBallInFrontOfPlayer(ped, courtPtr.ballPos) then
            local finalHeading = courtPtr.courtHeading + (PlayerSettings.side == CONST_SIDE_A and 180.0 or 0.0)
            local newVelocity = ComputeAfterHitVelocity(finalHeading, distName)

            TriggerServerEvent('rcore_tennis:setBallData', PlayerSettings.courtName, hitType, predictedBallPos, newVelocity, 'HIT')
        end
    end)
end

function Draw3DText(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

	local scale = (1/dist)*2
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov

	if onScreen then
		SetTextScale(0.0*scale, 0.40*scale)
		SetTextProportional(1)
		-- SetTextScale(0.0, 0.55)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

function LoadAnimDict(animDict)
	while (not HasAnimDictLoaded(animDict)) do
		RequestAnimDict(animDict)
		Citizen.Wait(0)
    end

    Wait(0)
end

function IsBallInFrontOfPlayer(ped, ballPos)
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, -0.5, 0.0)
    local fwdCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 5.0, 0.0)

    return IsPointInAngledArea(
        ballPos,
        coords,
        fwdCoords,
        5.0,
        0,
        false
    )
end


RegisterNetEvent('rcore_tennis:gameWon')
AddEventHandler('rcore_tennis:gameWon', function(wonByPosition)
    if PlayerSettings then
        PlaySoundFrontend(-1, "TENNIS_MATCH_POINT", "HUD_AWARDS", true)

        if PlayerSettings.side == wonByPosition then
            ShowFreemodeMessage(Config.Translation.YOU_WON_GAME, 5000)
        else
            ShowFreemodeMessage(Config.Translation.OPPONENT_WON_GAME, 5000)
        end
    end
end)

RegisterNetEvent('rcore_tennis:pointWon')
AddEventHandler('rcore_tennis:pointWon', function(wonByPosition)
    if PlayerSettings then
        PlaySoundFrontend(-1, "TENNIS_POINT_WON", "HUD_AWARDS", true)

        if PlayerSettings.side == wonByPosition then
            ShowFreemodeMessage(Config.Translation.YOU_WON_POINT, 5000)
        else
            ShowFreemodeMessage(Config.Translation.OPPONENT_WON_POINT, 5000)
        end
    end
end)

RegisterNetEvent('rcore_tennis:secondServe')
AddEventHandler('rcore_tennis:secondServe', function()
    if PlayerSettings then
        PlaySoundFrontend(-1, "LOSER", "HUD_AWARDS", true)
        ShowFreemodeMessage(Config.Translation.SECOND_SERVE, 5000)
    end
end)

function ShowFreemodeMessage(message, time)
    Citizen.CreateThread(function()
        local messageScaleform = RequestScaleformMovie("MIDSIZED_MESSAGE")

        while not HasScaleformMovieLoaded(messageScaleform) do
            Citizen.Wait(0)
        end
    
        BeginScaleformMovieMethod(messageScaleform, "SHOW_MIDSIZED_MESSAGE")
        PushScaleformMovieMethodParameterString(message)
        EndScaleformMovieMethod()
    
        while time > 0 do
            time = time - GetFrameTime() * 1000
            DrawScaleformMovieFullscreen(messageScaleform, 255, 255, 255, 255, 0)
            Wait(0)
        end

        SetScaleformMovieAsNoLongerNeeded(messageScaleform)
    end)
end

Citizen.CreateThread(function()
    AddTextEntry('TEN_SE_HINT', Config.Translation.SERVE_HINT or 'To correctly serve, aim with key ~y~~a~~s~ to hit ~g~highlighted~s~ rectangle.~n~Ball must ~y~hit ground~s~ first before opponent can return.~n~~y~LEFT CLICK~s~ to initiate serve.')
end)

local inversionMap = {
    a = 'b',
    b = 'a',
    left = 'right',
    right = 'left',
}
function DrawServeHint(courtData, side, lrSide)
    courtCenter = courtData.courtCenter
    courtHeading = courtData.courtHeading
    courtWidth = courtData.courtWidth
    courtLength = courtData.courtLength
    centerConstant = courtData.centerConstant

    local aSideCenter = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading + 90.0)) * courtLength, 
        courtCenter.y + math.sin(math.rad(courtHeading + 90.0)) * courtLength,
        courtCenter.z
    )

    local bSideCenter = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading - 90.0)) * courtLength, 
        courtCenter.y + math.sin(math.rad(courtHeading - 90.0)) * courtLength,
        courtCenter.z
    )

    local centerLeft = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading + 90.0)) * centerConstant + math.cos(math.rad(courtHeading)) * courtWidth/2, 
        courtCenter.y + math.sin(math.rad(courtHeading + 90.0)) * centerConstant + math.sin(math.rad(courtHeading)) * courtWidth/2,
        courtCenter.z
    )

    local centerRight = vector3(
        courtCenter.x - math.cos(math.rad(courtHeading + 270.0)) * centerConstant + math.cos(math.rad(courtHeading + 180.0)) * courtWidth/2, 
        courtCenter.y - math.sin(math.rad(courtHeading + 270.0)) * centerConstant + math.sin(math.rad(courtHeading + 180.0)) * courtWidth/2,
        courtCenter.z
    )

    
    local aSideLeft = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading + 90.0)) * courtLength  + math.cos(math.rad(courtHeading)) * courtWidth/2,
        courtCenter.y + math.sin(math.rad(courtHeading + 90.0)) * courtLength  + math.sin(math.rad(courtHeading)) * courtWidth/2,
        courtCenter.z
    )
    
    local aSideRight = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading + 90.0)) * courtLength + math.cos(math.rad(courtHeading + 180.0)) * courtWidth/2, 
        courtCenter.y + math.sin(math.rad(courtHeading + 90.0)) * courtLength + math.sin(math.rad(courtHeading + 180.0)) * courtWidth/2,
        courtCenter.z
    )

    
    local bSideRight = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading - 90.0)) * courtLength  + math.cos(math.rad(courtHeading)) * courtWidth/2,
        courtCenter.y + math.sin(math.rad(courtHeading - 90.0)) * courtLength  + math.sin(math.rad(courtHeading)) * courtWidth/2,
        courtCenter.z
    )
    
    local bSideLeft = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading - 90.0)) * courtLength + math.cos(math.rad(courtHeading + 180.0)) * courtWidth/2, 
        courtCenter.y + math.sin(math.rad(courtHeading - 90.0)) * courtLength + math.sin(math.rad(courtHeading + 180.0)) * courtWidth/2,
        courtCenter.z
    )

    -- DrawBox(aSideCenter - 0.05, aSideCenter + 0.05, 255, 0, 0, 200)
    -- DrawBox(bSideCenter - 0.05, bSideCenter + 0.05, 255, 0, 0, 200)
    -- DrawBox(centerLeft - 0.05, centerLeft + 0.05, 255, 0, 0, 200)
    -- DrawBox(centerRight - 0.05, centerRight + 0.05, 255, 0, 0, 200)
    
    -- DrawBox(aSideLeft - 0.05, aSideLeft + 0.05, 255, 0, 0, 200)
    -- DrawBox(aSideRight - 0.05, aSideRight + 0.05, 255, 0, 0, 200)
    
    -- DrawBox(bSideRight - 0.05, bSideRight + 0.05, 255, 0, 0, 200)
    -- DrawBox(bSideLeft - 0.05, bSideLeft + 0.05, 255, 0, 0, 200)
    
    -- DrawBox(courtCenter - 0.05, courtCenter + 0.05, 255, 0, 0, 200)

    -- invert side
    side = inversionMap[side]

    local alpha = (math.cos(GetGameTimer() / 300) + 1 ) / 2
    local alpha2 = (alpha * 0.2 + 0.1)

    local finalAlpha = tonumber(math.floor(alpha2 * 255))

    SetTextJustification(0)
    SetTextFont(0)
    SetTextScale(0.0, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 150)
    SetTextDropshadow()
    SetTextOutline()
    --SetTextCentre(1)
    SetTextEntry("TEN_SE_HINT")


    if lrSide == 'left' then
        AddTextComponentString(Config.Translation.SERVE_HINT_DW or 'D or DW')
    else
        AddTextComponentString(Config.Translation.SERVE_HINT_AW or 'A or AW')
    end
    
    DrawText( 0.5, 0.7 )

    if side == 'a' then
        if lrSide == 'left' then
            DrawPoly(courtCenter, aSideLeft, aSideCenter, 0, 255, 0, finalAlpha)
            DrawPoly(courtCenter, centerLeft, aSideLeft, 0, 255, 0, finalAlpha)
        else
            DrawPoly(courtCenter, aSideCenter, aSideRight, 0, 255, 0, finalAlpha)
            DrawPoly(courtCenter, aSideRight, centerRight, 0, 255, 0, finalAlpha)
        end
    else
        if lrSide == 'left' then
            DrawPoly(courtCenter, centerRight, bSideLeft, 0, 255, 0, finalAlpha)
            DrawPoly(courtCenter, bSideLeft, bSideCenter, 0, 255, 0, finalAlpha)
        else
            DrawPoly(courtCenter, bSideCenter, centerLeft, 0, 255, 0, finalAlpha)
            DrawPoly(centerLeft, bSideCenter, bSideRight, 0, 255, 0, finalAlpha)
        end
    end
end