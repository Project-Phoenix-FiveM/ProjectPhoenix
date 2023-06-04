local binoculars = false
local fov = (Config.Binoculars.fov_max+Config.Binoculars.fov_min)*0.5

--FUNCTIONS--

local function HideHUDThisFrame()
    HideHelpTextThisFrame()
    HideHudAndRadarThisFrame()
    HideHudComponentThisFrame(1) -- Wanted Stars
    HideHudComponentThisFrame(2) -- Weapon icon
    HideHudComponentThisFrame(3) -- Cash
    HideHudComponentThisFrame(4) -- MP CASH
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(8)
    HideHudComponentThisFrame(9)
    HideHudComponentThisFrame(13) -- Cash Change
    HideHudComponentThisFrame(11) -- Floating Help Text
    HideHudComponentThisFrame(12) -- more floating help text
    HideHudComponentThisFrame(15) -- Subtitle Text
    HideHudComponentThisFrame(18) -- Game Stream
    HideHudComponentThisFrame(19) -- weapon wheel
end

local function CheckInputRotation(cam, zoomvalue)
    local rightAxisX = GetDisabledControlNormal(0, 220)
    local rightAxisY = GetDisabledControlNormal(0, 221)
    local rotation = GetCamRot(cam, 2)
    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        local new_z = rotation.z + rightAxisX*-1.0*(Config.Binoculars.speed_ud)*(zoomvalue+0.1)
        local new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(Config.Binoculars.speed_lr)*(zoomvalue+0.1)), -89.5)
        SetCamRot(cam, new_x, 0.0, new_z, 2)
        SetEntityHeading(PlayerPedId(),new_z)
    end
end

local function HandleZoom(cam)
    local lPed = PlayerPedId()
    if not IsPedSittingInAnyVehicle(lPed) then
        if IsControlJustPressed(0,241) then -- Scrollup
            fov = math.max(fov - Config.Binoculars.zoomspeed, Config.Binoculars.fov_min)
        end
        if IsControlJustPressed(0,242) then
            fov = math.min(fov + Config.Binoculars.zoomspeed, Config.Binoculars.fov_max) -- ScrollDown
        end
        local current_fov = GetCamFov(cam)
        if math.abs(fov-current_fov) < 0.1 then
            fov = current_fov
        end
        SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
    else
        if IsControlJustPressed(0,17) then -- Scrollup
            fov = math.max(fov - Config.Binoculars.zoomspeed, Config.Binoculars.fov_min)
        end
        if IsControlJustPressed(0,16) then
            fov = math.min(fov + Config.Binoculars.zoomspeed, Config.Binoculars.fov_max) -- ScrollDown
        end
        local current_fov = GetCamFov(cam)
        if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
            fov = current_fov
        end
        SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
    end
end

--THREADS--

function BinocularLoop()
    CreateThread(function()
        local lPed = PlayerPedId()

        if not IsPedSittingInAnyVehicle(lPed) then
            TaskStartScenarioInPlace(lPed, "WORLD_HUMAN_BINOCULARS", 0, true)
            PlayPedAmbientSpeechNative(lPed, "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
        end

        Wait(2500)

        SetTimecycleModifier("default")
        SetTimecycleModifierStrength(0.3)
        local scaleform = RequestScaleformMovie("BINOCULARS")
        while not HasScaleformMovieLoaded(scaleform) do
            Wait(10)
        end

        local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
        AttachCamToEntity(cam, lPed, 0.0,0.0,1.0, true)
        SetCamRot(cam, 0.0,0.0,GetEntityHeading(lPed), 2)
        SetCamFov(cam, fov)
        RenderScriptCams(true, false, 0, true, false)
        PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
        PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
        PopScaleformMovieFunctionVoid()

        while binoculars and IsPedUsingScenario(lPed, "WORLD_HUMAN_BINOCULARS") do
            if IsControlJustPressed(0, Config.Binoculars.storeBinoclarKey) then -- Toggle binoculars
                binoculars = false
                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                ClearPedTasks(lPed)
            end

            local zoomvalue = (1.0/(Config.Binoculars.fov_max-Config.Binoculars.fov_min))*(fov-Config.Binoculars.fov_min)
            CheckInputRotation(cam, zoomvalue)
            HandleZoom(cam)
            HideHUDThisFrame()
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            Wait(0)
        end
        binoculars = false
        ClearTimecycleModifier()
        fov = (Config.Binoculars.fov_max+Config.Binoculars.fov_min)*0.5
        RenderScriptCams(false, false, 0, true, false)
        SetScaleformMovieAsNoLongerNeeded(scaleform)
        DestroyCam(cam, false)
        SetNightvision(false)
        SetSeethrough(false)
    end)
end

--EVENTS--

-- Activate binoculars
RegisterNetEvent('binoculars:Toggle', function()
    binoculars = not binoculars

    if binoculars then
        BinocularLoop()
        return
    end

    ClearPedTasks(PlayerPedId())
end)
