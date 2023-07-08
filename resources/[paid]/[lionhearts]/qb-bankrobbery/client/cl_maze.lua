CreateThread(function()
    exports['qb-target']:AddBoxZone('bankrobbery_panel_maze', vector3(-1303.85, -815.63, 17.15), 0.24, 0.46, {
        name = 'bankrobbery_panel_maze',
        heading = 308,
        debugPoly = Shared.Debug,
        minZ = 17.35,
        maxZ = 18.05
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-bankrobbery:client:UseGreenLaptop',
                icon = 'fas fa-user-secret',
                label = _U('panel_target_hack'),
                canInteract = function()
                    return not Shared.Banks['Maze'].hacked
                end,
                bank = 'Maze',
            },
            {
                type = 'server',
                event = 'qb-bankrobbery:server:PDClose',
                icon = 'fas fa-door-closed',
                label = _U('panel_target_pd'),
                canInteract = function()
                    return Shared.Banks['Maze'].hacked
                end,
                bank = 'Maze',
                job = 'police'
            }
        },
        distance = 1.5,
    })
end)
