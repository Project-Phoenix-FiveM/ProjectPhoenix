QBCore = exports['qb-core']:GetCoreObject()
PlayerData = QBCore.Functions.GetPlayerData()

insidePrisonZone = false

PrisonPoly = PolyZone:Create({
    vector2(1824.3231201172, 2475.5888671875),
    vector2(1851.6300000000, 2521.7500000000),
    vector2(1852.4400000000, 2613.2500000000),
    vector2(1848.9357910156, 2699.5246582031),
    vector2(1773.1700439453, 2762.8784179688),
    vector2(1649.5809326172, 2757.9831542969),
    vector2(1569.7268066406, 2680.3728027344),
    vector2(1534.6618652344, 2585.3244628906),
    vector2(1540.4670410156, 2469.5517578125),
    vector2(1658.9318847656, 2394.6047363281),
    vector2(1761.5501708984, 2410.2292480469)
  }, {
    name = 'prisonpoly',
    minZ = 34.584411621094,
    maxZ = 120.905479431152,
    debugPoly = false
})

PrisonPoly:onPlayerInOut(function(isPointInside, point)
    insidePrisonZone = isPointInside
    if isPointInside and Config.AntiHelicopter and not (PlayerData.job.type == 'leo' or PlayerData.job.name == 'ambulance') then
        triggerAntiHeli()
    elseif not isPointInside and PlayerData.metadata and PlayerData.metadata.injail ~= 0 then
        if Config.JailBreak.JailBreakActive then
            TriggerServerEvent('qb-jail:server:RequestJailBreakRelease')
        else
            local ped = PlayerPedId()
            if not DoesEntityExist(ped) then return end
            QBCore.Functions.Notify('The guards found you escaping..', 'primary', 4000)
            DoScreenFadeOut(1000)
            while not IsScreenFadedOut() do Wait(10) end
            local cell = math.random(#Config.Locations['cells'])
            SetEntityCoords(ped, Config.Locations['cells'][cell].xyz)
            SetEntityHeading(ped, Config.Locations['cells'][cell].w)
            TriggerServerEvent('InteractSound_SV:PlayOnSource', 'jail', 0.5)
            Wait(100)
            DoScreenFadeIn(1000)
        end
        
    end
end)

--- Startup Events

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() ~= resource then return end
    destroyJobBlips()
    for i=1, #jobSelectionBoards do DeleteEntity(jobSelectionBoards[i]) end
    for i=1, #jobObjects do DeleteEntity(jobObjects[i]) end
end)

--- Player Load / UnLoad Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback('qb-jail:server:GetJailBreakConfig', function(result)
        Config.JailBreak = result
        if result.JailBreakActive then
            local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")
            RefreshInterior(alarmIpl)
            EnableInteriorProp(alarmIpl, "prison_alarm")
            CreateThread(function()
                while not PrepareAlarm("PRISON_ALARMS") do
                    Wait(100)
                end
                StartAlarm("PRISON_ALARMS", true)
            end)
        else
            local alarmIpl = GetInteriorAtCoordsWithType(1787.004, 2593.1984, 45.7978, "int_prison_main")
            RefreshInterior(alarmIpl)
            DisableInteriorProp(alarmIpl, "prison_alarm")
            CreateThread(function()
                while not PrepareAlarm("PRISON_ALARMS") do
                    Wait(100)
                end
                StopAllAlarms(true)
            end)
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    currentJob = nil
    destroyJobBlips()
end)

--- Events

RegisterNetEvent('qb-prison:client:SendPlayerToPrison', function(takeMugshot, time)
    Wait(1000)
    local ped = PlayerPedId()
    if not DoesEntityExist(ped) then return end

    if time > 0 then
        QBCore.Functions.Notify('You have been sentenced to jail for ' .. time .. ' months', 'primary', 4000)
    else
        QBCore.Functions.Notify('Your sentence is up. You have been released.', 'primary', 4000)
    end

    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do Wait(10) end

    if takeMugshot then
        -- Mugshot
        Wait(100)
        DoScreenFadeIn(1000)
        FreezeEntityPosition(ped, true)
        SetEntityCoords(ped, Config.Locations['mugshot'].xyz)
        SetEntityHeading(ped, Config.Locations['mugshot'].w)

        local animDict = 'mp_character_creation@customise@male_a'
        local anim = 'loop'
        local prop = `prop_police_id_board`
        
        if not HasAnimDictLoaded(animDict) then
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do Wait(0) end
        end

        if not HasModelLoaded(prop) then
            RequestModel(prop)
            while not HasModelLoaded(prop) do Wait(0) end
        end

        Wait(1000)

        local created_object = CreateObject(prop, Config.Locations['mugshot'].x, Config.Locations['mugshot'].y, Config.Locations['mugshot'].z + 0.2,  true,  true, true)
        AttachEntityToEntity(created_object, ped, GetPedBoneIndex(ped, 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, true, 1, true)
        TaskPlayAnim(ped, animDict, anim, 2.0, 2.0, -1, 1, 0, false, false, false)

        Wait(1500)
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'photo', 0.5)

        Wait(1500)
        SetEntityHeading(ped, Config.Locations['mugshot'].w - 90.0)
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'photo', 0.5)

        Wait(1500)
        SetEntityHeading(ped, Config.Locations['mugshot'].w + 90.0)
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'photo', 0.5)

        Wait(1500)
        SetEntityHeading(ped, Config.Locations['mugshot'].w)

        Wait(2000)
        
        StopAnimTask(ped, animDict, anim, 1.0)
        FreezeEntityPosition(ped, false)
        DeleteEntity(created_object)
        SetModelAsNoLongerNeeded(prop)
        RemoveAnimDict(animDict)
    end

    -- Send to prison
    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do Wait(10) end
    local cell = math.random(#Config.Locations['cells'])
    SetEntityCoords(ped, Config.Locations['cells'][cell].xyz)
    SetEntityHeading(ped, Config.Locations['cells'][cell].w)
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'jail', 0.5)
    Wait(100)

    -- Apply Clothing
    if Config.PrisonOutfit.Enable then
        local gender = PlayerData.charinfo.gender
        if gender == 0 then
            TriggerEvent('qb-clothing:client:loadOutfit', Config.PrisonOutfit.Outfits.male)
        else
            TriggerEvent('qb-clothing:client:loadOutfit', Config.PrisonOutfit.Outfits.female)
        end
    end

    DoScreenFadeIn(1000)
    TriggerEvent('qb-jail:client:ChangeJob', 'lockup')
    Wait(1000)
    createPrisonPed()
end)

RegisterNetEvent('qb-jail:client:PrisonServices', function()
    local menu = {
        {
            header = 'Prison Services',
            txt = 'ESC or click to close',
            icon = 'fas fa-angle-left',
            params = {
                event = 'qb-menu:closeMenu',
            }
        },
        {
            header = 'Time Remaining',
            txt = 'Check your remaining time in jail',
            icon = 'fas fa-stopwatch',
            params = {
                event = 'qb-jail:client:CheckTimeRemaining',
            }
        },
        {
            header = 'Log Out',
            txt = 'Character selection menu',
            icon = 'fas fa-users',
            params = {
                isServer = true,
                event = 'qb-houses:server:LogoutLocation'
            }
        }
    }
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-jail:client:CheckTimeRemaining', function()
    if PlayerData.metadata.injail < 0 then
        local menu = {
            {
                header = "You've been released!",
                txt = 'Return to previous',
                icon = 'fas fa-angle-left',
                params = {
                    event = 'qb-jail:client:PrisonServices',
                }
            },
            {
                header = 'Exit Prison',
                txt = 'Your belongings will be taken when you leave',
                icon = 'fas fa-stopwatch',
                params = {
                    isServer = true,
                    event = 'qb-jail:server:RequestPrisonExit',
                }
            }
        }
        exports['qb-menu']:openMenu(menu)
    elseif PlayerData.metadata.injail > 0 then
        QBCore.Functions.Notify('You still have ' .. PlayerData.metadata.injail .. ' month(s) left in prison...', 'primary', 4000)
    else
        -- You're not supposed to be here
    end
end)

RegisterNetEvent('qb-jail:client:PhoneCall', function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Enter Phone Number',
        submitText = 'Submit',
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'number',
                text = '#'
            }
        }
    })
    if not dialog or not next(dialog) then return end

    if Config.Phone == 'GKS' then
        local number = tonumber(dialog.number)
        exports["gksphone"]:StartingCall(number)
    elseif Config.Phone == 'QBCore' then
        local calldata = {
            number = dialog.number,
            name = dialog.number
        }
        exports['qb-phone']:CallContact(calldata , true) -- You need to create this export in qb-phone, see readme
    end
end)

RegisterNetEvent('qb-jail:client:PrisonRevive', function()
    if PlayerData.metadata.injail ~= 0 or PlayerData.job.type == 'leo' then
        if exports['qb-policejob']:IsHandcuffed() then
            TriggerEvent('police:client:GetCuffed', -1)
        end
        TriggerEvent('police:client:DeEscort')

        DoScreenFadeOut(1000)
        while not IsScreenFadedOut() do Wait(10) end
        local bedCoords = vector4(1761.80, 2594.74, 45.66, 270.41)
        local ped = PlayerPedId()
        SetEntityCoords(ped, bedCoords.xyz)
        ClearPedTasks(ped)

        RequestAnimDict('anim@gangops@morgue@table@')
        while not HasAnimDictLoaded('anim@gangops@morgue@table@') do Wait(10) end
        TaskPlayAnim(ped, 'anim@gangops@morgue@table@' , 'body_search', 8.0, 1.0, -1, 1, 0, 0, 0, 0)
        SetEntityHeading(ped, bedCoords.w)
        FreezeEntityPosition(ped, true)
        local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', 1)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
        AttachCamToPedBone(cam, ped, 31085, 0, 1.0, 1.0 , true)
        SetCamFov(cam, 90.0)
        local heading = GetEntityHeading(ped)
        heading = (heading > 180) and heading - 180 or heading + 180
        SetCamRot(cam, -45.0, 0.0, heading, 2)

        DoScreenFadeIn(1000)
        while not IsScreenFadedIn() do Wait(10) end

        QBCore.Functions.Notify('You are being helped..', 'error', 2500)
        Wait(4000)
        RequestAnimDict('switch@franklin@bed')
        while not HasAnimDictLoaded('switch@franklin@bed') do Wait(10) end
        FreezeEntityPosition(ped, false)
        SetEntityInvincible(ped, false)
        SetEntityHeading(ped, 90)
        TaskPlayAnim(ped, 'switch@franklin@bed' , 'sleep_getup_rubeyes', 100.0, 1.0, -1, 8, -1, 0, 0, 0)
        Wait(4000)
        ClearPedTasks(ped)
        RenderScriptCams(0, true, 200, true, true)
        DestroyCam(cam, false)
        FreezeEntityPosition(ped, false)
        TriggerEvent('hospital:client:Revive')
    end
end)

RegisterNetEvent('qb-jail:client:CheckInmates', function()
    local menu = {
        {
            header = 'Prison Inmates',
            txt = 'ESC or Click to close',
            icon = 'fas fa-angle-left',
            params = {
                event = 'qb-menu:closeMenu',
            }
        }
    }

    QBCore.Functions.TriggerCallback('qb-jail:server:GetAllPrisoners', function(prisoners)
        if not prisoners then
            exports['qb-menu']:openMenu(menu)
            return
        end
        for i=1, #prisoners do
            local timeleft = prisoners[i].time
            if timeleft < 0 then timeleft = 'Released' end
            menu[#menu + 1] = {
                header = '[' .. i .. '] - ' .. prisoners[i].name,
                txt = 'Time Remaining: ' .. timeleft,
                icon = 'fas fa-angle-left',
                params = {
                    event = 'qb-jail:client:CheckInmate',
                    args = prisoners[i]
                }
            }
        end
        exports['qb-menu']:openMenu(menu)
    end)
end)

RegisterNetEvent('qb-jail:client:CheckInmate', function(prisoner)
    if not prisoner then return end
    exports['qb-menu']:openMenu({
        {
            header = prisoner.name,
            txt = 'Return to previous',
            icon = 'fas fa-angle-left',
            params = {
                event = 'qb-jail:client:CheckInmates',
            }
        },
        {
            header = 'Visit',
            txt = 'Alert the prisoner to visitation.',
            icon = 'fas fa-user-clock',
            params = {
                isServer = true,
                event = 'qb-jail:server:RequestPrisoner',
                args = prisoner.id
            }
        }
    })
end)

RegisterNetEvent('qb-jail:client:PostPrisonExit', function()
    exports['qb-core']:HideText()
    if Config.PrisonOutfit.Enable then
        TriggerServerEvent('qb-clothes:loadPlayerSkin')
    end
end)

CreateThread(function()
    -- Prison Blip
    local blip = AddBlipForCoord(Config.BlipCoords.x, Config.BlipCoords.y, Config.BlipCoords.z)
    SetBlipSprite(blip, 188)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 38)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Bolingbroke Penitentiary')
    EndTextCommandSetBlipName(blip)

    -- Prison Phone
    exports['qb-target']:AddBoxZone('prison_services', vector3(1828.75, 2579.79, 46.01), 0.6, 0.5, {
        name = 'prison_services',
        heading = 270,
        debugPoly = false,
        minZ = 46.00,
        maxZ = 47.00
    }, {
        options = { 
            {
                type = 'client',
                event = 'qb-jail:client:PrisonServices',
                icon = 'fas fa-circle-chevron-right',
                label = 'Prison Services'
            },
            {
                type = 'client',
                event = 'qb-jail:client:PhoneCall',
                icon = 'fas fa-phone-flip',
                label = 'Phone Call'
            },
            {
                type = 'client',
                event = 'qb-phone:client:CancelCall',
                icon = 'fas fa-phone-slash',
                label = 'Hang up call'
            }
        },
        distance = 1.5,
    })

    -- Infirmary ped
    exports['qb-target']:SpawnPed({
        model = 's_f_y_scrubs_01',
        coords = Config.InfirmaryPed,
        minusOne = true,
        freeze = true,
        invincible = true,
        blockevents = true,
        scenario = 'WORLD_HUMAN_CLIPBOARD',
        target = {
            options = {
                {
                    type = 'client',
                    icon = 'fa fa-clipboard',
                    event = 'qb-jail:client:PrisonRevive',
                    label = 'Check In',
                }
            },
            distance = 2.5
        },
    })

    -- Reception ped
    exports['qb-target']:SpawnPed({
        model = 's_m_m_prisguard_01',
        coords = Config.ReceptionPedCoords,
        minusOne = true,
        freeze = true,
        invincible = true,
        blockevents = true,
        scenario = 'WORLD_HUMAN_CLIPBOARD',
        target = {
            options = {
                {
                    type = 'client',
                    icon = 'fa fa-clipboard',
                    event = 'qb-jail:client:CheckInmates',
                    label = 'Check Inmates',
                }
            },
            distance = 2.5
        },
    })
    
end)
