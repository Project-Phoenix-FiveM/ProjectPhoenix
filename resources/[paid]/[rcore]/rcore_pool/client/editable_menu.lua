
if not Config.CustomMenu then
    Citizen.CreateThread(function()
        WarMenu.CreateMenu(
            'pool', 
            Config.Text.POOL,
            Config.Text.POOL_SUBMENU or 'Select ball configuration'
        )
        
        WarMenu.SetSubTitle('pool', Config.Text.POOL_SUBMENU or 'Select ball configuration')

        if Config.MenuColor then
            WarMenu.SetTitleBackgroundColor('pool', Config.MenuColor[1], Config.MenuColor[2], Config.MenuColor[3])
        end

        while true do
            if IsCloseToAnyTable then
                Wait(0)
            else
                Wait(2000)
            end

            if WarMenu.IsMenuOpened('pool') then
                if ClosestTableAddress then
                    if WarMenu.Button(Config.Text.TYPE_8_BALL) then
                        TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_8_BALL')
                        WarMenu.CloseMenu()
                    elseif WarMenu.Button(Config.Text.TYPE_STRAIGHT) then
                        TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_STRAIGHT_POOL')
                        WarMenu.CloseMenu()
                    end

                    WarMenu.Display()
                else
                    WarMenu.CloseMenu()
                end
            else
                Wait(200)
            end
        end
    end)
end

AddEventHandler('rcore_pool:openMenu', function()
    WarMenu.OpenMenu('pool')
end)

AddEventHandler('rcore_pool:closeMenu', function()
    -- triggered
end)

AddEventHandler('rcore_pool:setupTable', function(ballNumbers)
    local map = {
        ['BALL_SETUP_8_BALL'] = BALL_SETUP_8_BALL,
        ['BALL_SETUP_STRAIGHT_POOL'] = BALL_SETUP_STRAIGHT_POOL,
    }

    if ballNumbers == 'BALL_SETUP_8_BALL' or ballNumbers == 'BALL_SETUP_STRAIGHT_POOL' then
        local tableEntity = TableData[ClosestTableAddress].entity
        local data = setupBalls(tableEntity, map[ballNumbers])

        TriggerServerEvent('rcore_pool:setTableState', {
            serverIds = GetServerIdsNearTable(ClosestTableAddress),
            tablePosition = GetEntityCoords(tableEntity),
            data = data,
        })
    else
        print("ERROR: Unknown ball configuration name. Supported names: BALL_SETUP_8_BALL, BALL_SETUP_STRAIGHT_POOL")
    end
end)