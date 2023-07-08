local SeatsCoords = {
    vector4(-1650.2490, -1110.7388, 14.45, 180.0), -- Seat 1
    vector4(-1649.8335, -1110.2613, 14.45, 180.0), -- Seat 2
    vector4(-1649.3943, -1109.7279, 14.45, 180.0), -- Seat 3
    vector4(-1648.9771, -1109.2416, 14.45, 180.0), -- Seat 4
    vector4(-1649.0903, -1107.8113, 14.45, 270.0), -- Seat 5
    vector4(-1649.5942, -1107.3750, 14.45, 270.0), -- Seat 6
    vector4(-1650.0772, -1106.9736, 14.45, 270.0), -- Seat 7
    vector4(-1650.5815, -1106.5417, 14.45, 270.0), -- Seat 8
    vector4(-1651.9698, -1106.6734, 14.45, 0.0), -- Seat 9
    vector4(-1652.4003, -1107.1831, 14.45, 0.0), -- Seat 10
    vector4(-1652.8317, -1107.6893, 14.45, 0.0), -- Seat 11
    vector4(-1653.2633, -1108.1915, 14.45, 0.0), -- Seat 12
    vector4(-1653.1900, -1109.5617, 14.45, 90.0), -- Seat 13
    vector4(-1652.6749, -1109.9887, 14.45, 90.0), -- Seat 14
    vector4(-1652.1770, -1110.4219, 14.45, 90.0), -- Seat 15
    vector4(-1651.6809, -1110.8481, 14.45, 90.0), -- Seat 16
}

local function HandleControls()
    if Freefall.PedIsSitting then
        if Freefall.InProgress then
            if Config.Enable3dText then
                local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

                Draw3dText(x, y, z + 0.85, Config.Text.FREEFALL_GET_OFF)
            else
                DisplayHelpTextThisFrame('FREEFALL_GET_OFF')
            end
        else
            if Config.Enable3dText then
                local x, y, z = table.unpack(SeatsCoords[Freefall.CurrentSeatIndex])

                Draw3dText(x, y, z + 0.85, Config.Text.FREEFALL_START)
            else
                DisplayHelpTextThisFrame('FREEFALL_START')
            end
        end

        if IsControlJustPressed(0, 75) then
            TriggerServerEvent('rcore_lunapark:Freefall:getOff', Freefall.CurrentSeatIndex)
        end

        if IsControlPressed(0, 21) and IsControlJustPressed(0, 71) then
            TriggerServerEvent('rcore_lunapark:Freefall:start')
        end
    else
        local playerPos = GetEntityCoords(PlayerPedId())

        if #(Freefall.PlatformCoords - playerPos) < 1.5 then
            local full = true

            for i = 1, #Freefall.OccupiedSeats do
                if Freefall.OccupiedSeats[i] == 0 then
                    full = false
                    break
                end
            end

            if full then
                if Config.Enable3dText then
                    local x, y, z = table.unpack(Freefall.PlatformCoords)

                    Draw3dText(x, y, z + 1.25, Config.Text.FREEFALL_FULL)
                else
                    DisplayHelpTextThisFrame('FREEFALL_FULL')
                end
            else
                if Config.Enable3dText then
                    local x, y, z = table.unpack(Freefall.PlatformCoords)

                    Draw3dText(x, y, z + 1.25, Config.Text.FREEFALL_GET_ON)
                else
                    DisplayHelpTextThisFrame('FREEFALL_GET_ON')
                end

                if IsControlJustPressed(0, 51) then
                    if Freefall.EnterCooldown - GetGameTimer() <= 0 then
                        Freefall.EnterCooldown = GetGameTimer() + 2000
                        TriggerServerEvent('rcore_lunapark:Freefall:buyTicket')
                    end
                end
            end
        end
    end
end

local function OnTick()
    if Freefall.Timer >= 1 then
        HandleControls()
    end
end

CreateThread(function()
    while true do
        Wait(0)

        if Freefall.InSoundRange then
            OnTick()
        end
    end
end)