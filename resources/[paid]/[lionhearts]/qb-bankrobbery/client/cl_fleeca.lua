RegisterNetEvent('qb-bankrobbery:client:UseGreenLaptop', function(data)
    if not currentBank or currentBank ~= data.bank then return end
    if QBCore.Functions.HasItem('laptop_green') then
        if not Shared.Banks[data.bank].hacked then
            QBCore.Functions.TriggerCallback('qb-bankrobbery:server:CanAttemptBankRobbery', function(canAttempt)
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
                        TriggerServerEvent('qb-bankrobbery:server:LaptopDamage', 'laptop_green')
                        CallCops(Shared.Banks[data.bank].type)
                        LaptopAnimation(data.bank)
                    end, function() -- Cancel
                        StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
                        QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
                    end)
                end
            end, data.bank)
        else
            QBCore.Functions.Notify(_U('laptop_hit'), 'normal', 2500)
        end
    else
        QBCore.Functions.Notify(_U('missing_items'), 'error', 2500)
    end
end)

RegisterNetEvent('qb-bankrobbery:client:SetFleecaCardTaken', function(bank)
    Shared.Banks[bank].keycardTaken = true
end)

RegisterNetEvent('qb-bankrobbery:client:HackInnerPanel', function(data)
    if not currentBank or currentBank ~= data.bank then return end
    local ped = PlayerPedId()
    TaskTurnPedToFaceEntity(ped, data.entity, 1.0)
    QBCore.Functions.Progressbar('bankrobbery_innerpanel', _U('progressbar_innerpanel'), 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@',
        anim = 'hotwire',
        flags = 16,
    }, {}, {}, function() -- Done
        local result = exports['simonsays']:StartSimonSays(Shared.MinigameSettings.simonSays.buttonGrid, Shared.MinigameSettings.simonSays.length)
        if result then
            TriggerServerEvent('qb-bankrobbery:server:HackInnerPanel', data.bank)
        else
            QBCore.Functions.Notify(_U('hack_failed'), 'error', 2500)
        end
        StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
    end, function() -- Cancel
        StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
        QBCore.Functions.Notify(_U('canceled'), 'error', 2500)
    end)
end)

RegisterNetEvent('qb-bankrobbery:client:SetInnerHacked', function(bank)
    Shared.Banks[bank].innerDoor.hacked = true
end)

--- Threads

CreateThread(function()
    -- Pink Cage Fleeca Panel
    exports['qb-target']:AddBoxZone('bankrobbery_panel_pinkcage', vector3(311.06, -284.67, 54.16), 0.4, 0.6, {
        name = 'bankrobbery_panel_pinkcage',
        heading = 340,
        debugPoly = Shared.Debug,
        minZ = 53.96,
        maxZ = 54.76
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:UseGreenLaptop',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['PinkCage'].hacked
                end,
                bank = 'PinkCage'
            },
            {
                type = 'server',
                event = 'qb-bankrobbery:server:PDClose',
                icon = 'fas fa-door-closed',
                label = _U('panel_target_pd'),
                canInteract = function()
                    return Shared.Banks['PinkCage'].hacked
                end,
                bank = 'PinkCage',
                job = 'police'
            }
        },
        distance = 1.5,
    })

    -- Pink Cage Keycard
    exports['qb-target']:AddBoxZone('bankrobbery_keycard_pinkcage', vector3(312.67, -281.73, 54.16), 2.0, 0.4, {
        name = 'bankrobbery_keycard_pinkcage',
        heading = 250,
        debugPoly = Shared.Debug,
        minZ = 53.16,
        maxZ = 55.16
     }, {
        options = { 
            {
                type = 'server',
                event = 'qb-bankrobbery:server:GrabFleecaKeycard',
                icon = 'fas fa-user-secret',
                label = _U('keycard_target'),
                canInteract = function()
                    return not Shared.Banks['PinkCage'].keycardTaken
                end,
                bank = 'PinkCage'
            }
        },
        distance = 1.0,
    })

    -- Pink Cage Second Panel
    exports['qb-target']:AddBoxZone('bankrobbery_secondpanel_pinkcage', vector3(312.81, -284.97, 54.16), 0.6, 0.2, {
        name = 'bankrobbery_secondpanel_pinkcage',
        heading = 250,
        debugPoly = Shared.Debug,
        minZ = 53.96,
        maxZ = 54.76
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:HackInnerPanel',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['PinkCage'].innerDoor.hacked
                end,
                bank = 'PinkCage'
            }
        },
        distance = 1.5,
    })
    
    -- Legion Square Fleeca Panel
    exports['qb-target']:AddBoxZone('bankrobbery_panel_legion', vector3(146.69, -1046.44, 29.37), 0.4, 0.6, {
        name = 'bankrobbery_panel_legion',
        heading = 340,
        debugPoly = Shared.Debug,
        minZ = 29.27,
        maxZ = 29.97
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:UseGreenLaptop',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Legion'].hacked
                end,
                bank = 'Legion'
            },
            {
                type = 'server',
                event = 'qb-bankrobbery:server:PDClose',
                icon = 'fas fa-door-closed',
                label = _U('panel_target_pd'),
                canInteract = function()
                    return Shared.Banks['Legion'].hacked
                end,
                bank = 'Legion',
                job = 'police'
            }
        },
        distance = 1.5,
    })

    -- Legion Square Keycard
    exports['qb-target']:AddBoxZone('bankrobbery_keycard_legion', vector3(148.37, -1043.37, 29.37), 2.0, 0.4, {
        name = 'bankrobbery_keycard_legion',
        heading = 250,
        debugPoly = Shared.Debug,
        minZ = 28.37,
        maxZ = 30.37
     }, {
        options = { 
            {
                type = 'server',
                event = 'qb-bankrobbery:server:GrabFleecaKeycard',
                icon = 'fas fa-user-secret',
                label = _U('keycard_target'),
                canInteract = function()
                    return not Shared.Banks['Legion'].keycardTaken
                end,
                bank = 'Legion'
            }
        },
        distance = 1.0,
    })

    -- Legion Square Second Panel
    exports['qb-target']:AddBoxZone('bankrobbery_secondpanel_legion', vector3(148.45, -1046.62, 29.37), 0.6, 0.2, {
        name = 'bankrobbery_secondpanel_legion',
        heading = 250,
        debugPoly = Shared.Debug,
        minZ = 29.27,
        maxZ = 29.97
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:HackInnerPanel',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Legion'].innerDoor.hacked
                end,
                bank = 'Legion'
            }
        },
        distance = 1.5,
    })

    -- Hawick Avenue Fleeca Panel
    exports['qb-target']:AddBoxZone('bankrobbery_panel_hawick', vector3(-354.02, -55.61, 49.04), 0.4, 0.6, {
        name = 'bankrobbery_panel_hawick',
        heading = 338,
        debugPoly = Shared.Debug,
        minZ = 48.84,
        maxZ = 49.64
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:UseGreenLaptop',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Hawick'].hacked
                end,
                bank = 'Hawick',
            },
            {
                type = 'server',
                event = 'qb-bankrobbery:server:PDClose',
                icon = 'fas fa-door-closed',
                label = _U('panel_target_pd'),
                canInteract = function()
                    return Shared.Banks['Hawick'].hacked
                end,
                bank = 'Hawick',
                job = 'police'
            }
        },
        distance = 1.5,
    })

    -- Hawick Avenue Keycard
    exports['qb-target']:AddBoxZone('bankrobbery_keycard_hawick', vector3(-352.42, -52.5, 49.04), 2.0, 0.4, {
        name = 'bankrobbery_keycard_hawick',
        heading = 250,
        debugPoly = Shared.Debug,
        minZ = 48.04,
        maxZ = 50.04
     }, {
        options = { 
            {
                type = 'server',
                event = 'qb-bankrobbery:server:GrabFleecaKeycard',
                icon = 'fas fa-user-secret',
                label = _U('keycard_target'),
                canInteract = function()
                    return not Shared.Banks['Hawick'].keycardTaken
                end,
                bank = 'Hawick'
            }
        },
        distance = 1.0,
    })

    -- Hawick Avenue Second Panel
    exports['qb-target']:AddBoxZone('bankrobbery_secondpanel_hawick', vector3(-352.29, -55.84, 49.04), 0.6, 0.2, {
        name = 'bankrobbery_secondpanel_hawick',
        heading = 250,
        debugPoly = Shared.Debug,
        minZ = 48.84,
        maxZ = 49.64
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:HackInnerPanel',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Hawick'].innerDoor.hacked
                end,
                bank = 'Hawick'
            }
        },
        distance = 1.5,
    })

    -- Del Perro Fleeca Panel
    exports['qb-target']:AddBoxZone('bankrobbery_panel_delperro', vector3(-1210.75, -336.77, 37.78), 0.4, 0.6, {
        name = 'bankrobbery_panel_delperro',
        heading = 26,
        debugPoly = Shared.Debug,
        minZ = 37.58,
        maxZ = 38.38
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:UseGreenLaptop',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['DelPerro'].hacked
                end,
                bank = 'DelPerro',
            },
            {
                type = 'server',
                event = 'qb-bankrobbery:server:PDClose',
                icon = 'fas fa-door-closed',
                label = _U('panel_target_pd'),
                canInteract = function()
                    return Shared.Banks['DelPerro'].hacked
                end,
                bank = 'DelPerro',
                job = 'police'
            }
        },
        distance = 1.5,
    })

    -- Del Perro Keycard
    exports['qb-target']:AddBoxZone('bankrobbery_keycard_delperro', vector3(-1211.75, -333.52, 37.78), 2.0, 0.4, {
        name = 'bankrobbery_keycard_delperro',
        heading = 296,
        debugPoly = Shared.Debug,
        minZ = 36.78,
        maxZ = 38.78
     }, {
        options = { 
            {
                type = 'server',
                event = 'qb-bankrobbery:server:GrabFleecaKeycard',
                icon = 'fas fa-user-secret',
                label = _U('keycard_target'),
                canInteract = function()
                    return not Shared.Banks['DelPerro'].keycardTaken
                end,
                bank = 'DelPerro'
            }
        },
        distance = 1.0,
    })

    -- Del Perro Second Panel
    exports['qb-target']:AddBoxZone('bankrobbery_secondpanel_delperro', vector3(-1209.3, -335.77, 37.78), 0.6, 0.2, {
        name = 'bankrobbery_secondpanel_delperro',
        heading = 296,
        debugPoly = Shared.Debug,
        minZ = 37.58,
        maxZ = 38.38
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:HackInnerPanel',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['DelPerro'].innerDoor.hacked
                end,
                bank = 'DelPerro'
            }
        },
        distance = 1.5,
    })

    -- Great Ocean Fleeca Panel
    exports['qb-target']:AddBoxZone('bankrobbery_panel_greatocean', vector3(-2956.33, 481.61, 15.7), 0.6, 0.4, {
        name = 'bankrobbery_panel_greatocean',
        heading = 358,
        debugPoly = Shared.Debug,
        minZ = 15.50,
        maxZ = 16.30
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:UseGreenLaptop',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['GreatOcean'].hacked
                end,
                bank = 'GreatOcean',
            },
            {
                type = 'server',
                event = 'qb-bankrobbery:server:PDClose',
                icon = 'fas fa-door-closed',
                label = _U('panel_target_pd'),
                canInteract = function()
                    return Shared.Banks['GreatOcean'].hacked
                end,
                bank = 'GreatOcean',
                job = 'police'
            }
        },
        distance = 1.5,
    })

    -- Great Ocean Keycard
    exports['qb-target']:AddBoxZone('bankrobbery_keycard_greatocean', vector3(-2959.61, 482.25, 15.7), 2.0, 0.4, {
        name = 'bankrobbery_keycard_greatocean',
        heading = 357,
        debugPoly = Shared.Debug,
        minZ = 14.70,
        maxZ = 16.70
     }, {
        options = { 
            {
                type = 'server',
                event = 'qb-bankrobbery:server:GrabFleecaKeycard',
                icon = 'fas fa-user-secret',
                label = _U('keycard_target'),
                canInteract = function()
                    return not Shared.Banks['GreatOcean'].keycardTaken
                end,
                bank = 'GreatOcean'
            }
        },
        distance = 1.0,
    })

    -- Great Ocean Second Panel
    exports['qb-target']:AddBoxZone('bankrobbery_secondpanel_greatocean', vector3(-2956.46, 483.38, 15.7), 0.6, 0.2, {
        name = 'bankrobbery_secondpanel_greatocean',
        heading = 358,
        debugPoly = Shared.Debug,
        minZ = 15.50,
        maxZ = 16.30
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:HackInnerPanel',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['GreatOcean'].innerDoor.hacked
                end,
                bank = 'GreatOcean'
            }
        },
        distance = 1.5,
    })

    -- Sandy Shores Fleeca Panel
    exports['qb-target']:AddBoxZone('bankrobbery_panel_sandy', vector3(1176.04, 2713.15, 38.09), 0.4, 0.6, {
        name = 'bankrobbery_panel_sandy',
        heading = 359,
        debugPoly = Shared.Debug,
        minZ = 37.89,
        maxZ = 38.69
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:UseGreenLaptop',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Sandy'].hacked
                end,
                bank = 'Sandy',
            },
            {
                type = 'server',
                event = 'qb-bankrobbery:server:PDClose',
                icon = 'fas fa-door-closed',
                label = _U('panel_target_pd'),
                canInteract = function()
                    return Shared.Banks['Sandy'].hacked
                end,
                bank = 'Sandy',
                job = 'police'
            }
        },
        distance = 1.5,
    })

    -- Sandy Shores Keycard
    exports['qb-target']:AddBoxZone('bankrobbery_keycard_sandy', vector3(1175.63, 2709.76, 38.09), 2.0, 0.4, {
        name = 'bankrobbery_panel_sandy',
        heading = 269,
        debugPoly = Shared.Debug,
        minZ = 37.09,
        maxZ = 39.09
     }, {
        options = { 
            {
                type = 'server',
                event = 'qb-bankrobbery:server:GrabFleecaKeycard',
                icon = 'fas fa-user-secret',
                label = _U('keycard_target'),
                canInteract = function()
                    return not Shared.Banks['Sandy'].keycardTaken
                end,
                bank = 'Sandy'
            }
        },
        distance = 1.0,
    })

    -- Sandy Shores Second Panel
    exports['qb-target']:AddBoxZone('bankrobbery_secondpanel_sandy', vector3(1174.35, 2712.85, 38.09), 0.6, 0.2, {
        name = 'bankrobbery_secondpanel_sandy',
        heading = 270,
        debugPoly = Shared.Debug,
        minZ = 37.89,
        maxZ = 38.69
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:HackInnerPanel',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Sandy'].innerDoor.hacked
                end,
                bank = 'Sandy'
            }
        },
        distance = 1.5,
    })

end)
