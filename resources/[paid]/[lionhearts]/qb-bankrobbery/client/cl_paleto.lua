local paletoCameras = {
    [1] = { 'Security Hallway', vector4(-99.98, 6476.69, 32.8, 190.82), -1557675482 },
    [2] = { 'Main Lobby #1', vector4(-102.22, 6475.49, 32.8, 171.44), -712148387 },
    [3] = { 'Main Lobby #2', vector4(-107.87, 6461.35, 32.8, 3.29), -712148387 },
    [4] = { 'Office #1', vector4(-101.9, 6460.61, 32.8, 75.81), 595161168 },
    [5] = { 'Office #2', vector4(-97.53, 6465.04, 32.8, 1.67), 1122715848 },
    [6] = { 'Administration Office', vector4(-105.73, 6480.59, 32.8, 189.21), 1297762420 },
    [7] = { 'Front Exit', vector4(-103.24, 6451.46, 32.8, 86.55), 0 },
    [8] = { 'Back Exit', vector4(-88.88, 6467.08, 32.8, 337.9), 0 },
}

--- Functions

--- Events

RegisterNetEvent('qb-bankrobbery:client:PaletoSideHacks', function(data)
    if Shared.Banks['Paleto'][data.hack].hacked then return end
    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:CanAttemptPaletoHack', function(canAttempt)
        if canAttempt then
            local ped = PlayerPedId()
            TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
            QBCore.Functions.Progressbar('paleto_hack', _U('paleto_progressbar_sidehack'), math.random(5000, 10000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                CallCops(Shared.Banks['Paleto'].type)
                exports['varhack']:OpenHackingGame(function(success)
                    if success then 
                        PlaySound(-1, 'Lose_1st', 'GTAO_FM_Events_Soundset', 0, 0, 1)
                        TriggerServerEvent('qb-bankrobbery:server:SetPaletoSideHacked', data.hack)
                    else
                        QBCore.Functions.Notify(_U('paleto_sidehack_fail'), 'error', 2500)
                    end
                end, Shared.MinigameSettings.varHack.blocks, 7)
            end, function() -- Cancel
                StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
            end)
        end
    end, data.hack)
end)

RegisterNetEvent('qb-bankrobbery:client:SetPaletoSideHacked', function(hack)
    Shared.Banks['Paleto'][hack].hacked = true
end)

RegisterNetEvent('qb-bankrobbery:client:PaletoCameraControls', function()
    if not Shared.Banks['Paleto'].sideHack.hacked then return end
    local menu = {
        {
            header = _U('paleto_camera_header'),
            txt = _U('paleto_camera_txt'),
            icon = 'fas fa-angle-left',
            params = {
                event = 'qb-menu:closeMenu',
            }
        }
    }
    for k, v in ipairs(paletoCameras) do
        menu[#menu + 1] = {
            header = v[1],
            icon = 'fas fa-video',
            params = {
                event = 'qb-bankrobbery:client:PaletoCamera',
                args = k
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-bankrobbery:client:PaletoCamera', function(id)
    if not paletoCameras[id] then return end
    if not Shared.Banks['Paleto'].sideHack.hacked then return end

    local coords = paletoCameras[id][2]
    PaletoCamera(coords, paletoCameras[id][3])
end)

RegisterNetEvent('qb-bankrobbery:client:PaletoHacksMenu', function()
    if not Shared.Banks['Paleto'].sideHack.hacked then return end
    local menu = {
        {
            header = _U('paleto_hacks_header'),
            txt = _U('paleto_camera_txt'),
            icon = 'fas fa-angle-left',
            params = {
                event = 'qb-menu:closeMenu',
            }
        }
    }
    for k, v in ipairs(Shared.Banks['Paleto'].officeHacks) do
        menu[#menu + 1] = {
            header = v.label,
            isMenuHeader = v.hacked,
            icon = 'fas fa-user-secret',
            params = {
                event = 'qb-bankrobbery:client:PaletoHack',
                args = k
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-bankrobbery:client:PaletoHack', function(id)
    if Shared.Banks['Paleto'].officeHacks[id].hacked then return end

    local ped = PlayerPedId()
    RequestAnimDict('anim@heists@prison_heiststation@cop_reactions')
    while not HasAnimDictLoaded('anim@heists@prison_heiststation@cop_reactions') do Wait(0) end
    TaskPlayAnim(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0, 1.0, -1, 1, 0, 0, 0, 0)
    exports['casinohack']:OpenHackingGame(function(success)
        if success then 
            PlaySound(-1, 'Lose_1st', 'GTAO_FM_Events_Soundset', 0, 0, 1)
            TriggerServerEvent('qb-bankrobbery:server:SetPaletoOfficeHacked', id)
        else
            QBCore.Functions.Notify(_U('paleto_office_hack_fail'), 'error', 2500)
        end
        StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
    end, Shared.MinigameSettings.mazeHack.time)
end)

RegisterNetEvent('qb-bankrobbery:client:SetPaletoOfficeHacked', function(id)
    Shared.Banks['Paleto'].officeHacks[id].hacked = true
end)

RegisterNetEvent('qb-bankrobbery:client:OfficePassword', function(data)
    local ped = PlayerPedId()
    RequestAnimDict('anim@heists@prison_heiststation@cop_reactions')
    while not HasAnimDictLoaded('anim@heists@prison_heiststation@cop_reactions') do Wait(0) end
    TaskPlayAnim(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0, 1.0, -1, 1, 0, 0, 0, 0)
    local dialog = exports['qb-input']:ShowInput({
        header = _U('paleto_input_header'),
        submitText = _U('input_submit'),
        inputs = {
            {
                text = 'XXXXX',
                name = 'password',
                type = 'text',
                isRequired = true
            }
        }
    })
    if not dialog or not next(dialog) then return end
    local input = string.upper(dialog.password)
    TriggerServerEvent('qb-bankrobbery:server:EnterPaletoPassword', data.office, input)
    StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
end)

RegisterNetEvent('qb-bankrobbery:client:UseBlueLaptop', function(data)
    if QBCore.Functions.HasItem('laptop_blue') then
        QBCore.Functions.TriggerCallback('qb-bankrobbery:server:CanPaletoBankPanelHack', function(canAttempt)
            if canAttempt then
                local ped = PlayerPedId()
                TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
                QBCore.Functions.Progressbar('greenlaptop_hack', _U('progressbar_laptop'), math.random(5000, 10000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = 'anim@gangops@facility@servers@',
                    anim = 'hotwire',
                    flags = 16,
                }, {}, {}, function() -- Done
                    StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                    TriggerServerEvent('qb-bankrobbery:server:LaptopDamage', 'laptop_blue')
                    LaptopAnimation('Paleto')
                end, function() -- Cancel
                    StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                    QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
                end)
            else
                QBCore.Functions.Notify(_U('paleto_lockdown'), 'error', 4500)
                Wait(5000)
                QBCore.Functions.Notify(_U('paleto_lockdown2'), 'error', 4500)
            end
        end)
    else
        QBCore.Functions.Notify(_U('missing_items'), 'error', 2500)
    end
end)

--- Threads

CreateThread(function()
    -- Side Entrance Panel
    exports['qb-target']:AddBoxZone('bankrobbery_sidepanel_paleto', vector3(-115.55, 6480.31, 31.46), 0.4, 0.2, {
        name = 'bankrobbery_sidepanel_paleto',
        heading = 315,
        debugPoly = Shared.Debug,
        minZ = 31.80,
        maxZ = 32.10
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PaletoSideHacks',
                icon = 'fas fa-user-secret',
                label = _U('paleto_target_sidehack'),
                canInteract = function()
                    return not Shared.Banks['Paleto'].sideEntrance.hacked
                end,
                hack = 'sideEntrance'
            }
        },
        distance = 1.0,
    })

    -- Side Entrance Inside Hack
    exports['qb-target']:AddBoxZone('bankrobbery_sidehack_paleto', vector3(-118.04, 6470.28, 31.63), 1.4, 0.3, {
        name = 'bankrobbery_backpanel_paleto',
        heading = 225,
        debugPoly = Shared.Debug,
        minZ = 30.80,
        maxZ = 32.80
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PaletoSideHacks',
                icon = 'fas fa-user-secret',
                label = _U('paleto_target_sidehack'),
                canInteract = function()
                    return not Shared.Banks['Paleto'].sideHack.hacked
                end,
                hack = 'sideHack'
            }
        },
        distance = 1.0,
    })

    -- Security Entrance Panel
    exports['qb-target']:AddBoxZone('bankrobbery_backpanel_paleto', vector3(-95.52, 6473.04, 31.4), 0.4, 0.2, {
        name = 'bankrobbery_backpanel_paleto',
        heading = 225,
        debugPoly = Shared.Debug,
        minZ = 31.80,
        maxZ = 32.10
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PaletoSideHacks',
                icon = 'fas fa-user-secret',
                label = _U('paleto_target_sidehack'),
                canInteract = function()
                    return not Shared.Banks['Paleto'].securityEntrance.hacked
                end,
                hack = 'securityEntrance'
            }
        },
        distance = 1.0,
    })

    -- Security Room Camera Panel
    exports['qb-target']:AddBoxZone('bankrobbery_paleto_camera', vector3(-92.86, 6463.76, 31.63), 0.7, 0.4, {
        name = 'bankrobbery_paleto_camera',
        heading = 320,
        debugPoly = Shared.Debug,
        minZ = 31.40,
        maxZ = 31.70
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PaletoCameraControls',
                icon = 'fas fa-video',
                label = _U('paleto_camera_target'),
                canInteract = function()
                    return Shared.Banks['Paleto'].sideHack.hacked
                end
            }
        },
        distance = 1.0,
    })

    -- Security Room Hack Panel
    exports['qb-target']:AddBoxZone('bankrobbery_paleto_hacks', vector3(-91.76, 6464.88, 31.63), 0.6, 0.4, {
        name = 'bankrobbery_paleto_hacks',
        heading = 325,
        debugPoly = Shared.Debug,
        minZ = 31.40,
        maxZ = 31.70
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:PaletoHacksMenu',
                icon = 'fas fa-user-secret',
                label = _U('paleto_target_office_hack'),
                canInteract = function()
                    return Shared.Banks['Paleto'].sideHack.hacked
                end
            }
        },
        distance = 1.0,
    })
    
    -- Office 1 Hack
    exports['qb-target']:AddBoxZone('bankrobbery_paleto_office_1', vector3(-98.24, 6466.1, 31.63), 0.8, 0.6, {
        name = 'bankrobbery_paleto_office_1',
        heading = 315,
        debugPoly = Shared.Debug,
        minZ = 31.40,
        maxZ = 31.70
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:OfficePassword',
                icon = 'fas fa-terminal',
                label = _U('paleto_input_header'),
                canInteract = function()
                    return Shared.Banks['Paleto'].officeHacks[1].hacked
                end,
                office = 1,
            }
        },
        distance = 1.5,
    })

    -- Office 2 Hack
    exports['qb-target']:AddBoxZone('bankrobbery_paleto_office_2', vector3(-103.83, 6460.49, 31.63), 0.8, 0.6, {
        name = 'bankrobbery_paleto_office_2',
        heading = 315,
        debugPoly = Shared.Debug,
        minZ = 31.40,
        maxZ = 31.70
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:OfficePassword',
                icon = 'fas fa-terminal',
                label = _U('paleto_input_header'),
                canInteract = function()
                    return Shared.Banks['Paleto'].officeHacks[2].hacked
                end,
                office = 2,
            }
        },
        distance = 1.5,
    })

    -- Office 3 Hack
    exports['qb-target']:AddBoxZone('bankrobbery_paleto_office_3', vector3(-104.68, 6479.34, 31.63), 0.8, 0.6, {
        name = 'bankrobbery_paleto_office_3',
        heading = 315,
        debugPoly = Shared.Debug,
        minZ = 31.40,
        maxZ = 31.70
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:OfficePassword',
                icon = 'fas fa-terminal',
                label = _U('paleto_input_header'),
                canInteract = function()
                    return Shared.Banks['Paleto'].officeHacks[3].hacked
                end,
                office = 3,
            }
        },
        distance = 1.5,
    })

    -- Vault Panel
    exports['qb-target']:AddBoxZone('bankrobbery_panel_paleto', vector3(-101.86, 6462.81, 31.63), 0.6, 0.4, {
        name = 'bankrobbery_panel_paleto',
        heading = 135,
        debugPoly = Shared.Debug,
        minZ = 31.70,
        maxZ = 32.50
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:UseBlueLaptop',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Paleto'].hacked
                end
            },
            {
                type = 'server',
                event = 'qb-bankrobbery:server:PDClose',
                icon = 'fas fa-door-closed',
                label = _U('panel_target_pd'),
                canInteract = function()
                    return Shared.Banks['Paleto'].hacked
                end,
                bank = 'Paleto',
                job = 'police'
            }
        },
        distance = 1.5,
    })

end)