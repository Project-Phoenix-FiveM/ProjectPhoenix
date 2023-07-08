local function HandleControls()
    if Wheel.PedIsSitting then
        if Config.Enable3dText then
            local x, y, z = table.unpack(GetEntityCoords(Wheel.Cabins[Wheel.CurrentCabinIndex].Entity))

            Draw3dText(x, y, z - 1.0, Config.Text.WHEEL_GET_OFF)
        else
            DisplayHelpTextThisFrame('WHEEL_GET_OFF')
        end

        if IsControlJustPressed(0, 75) then
            TriggerServerEvent('rcore_lunapark:Wheel:getOff', Wheel.CurrentCabinIndex, Wheel.CurrentSeatIndex)
        end
    elseif Wheel.InPlatformRange then
        local playerPos = GetEntityCoords(PlayerPedId())

        if #(Wheel.PlatformCoords - playerPos) < 1.2 then
            local cabin = Wheel.Cabins[Wheel.CabinOnGround]
            local cabinFull = cabin.OccupiedSeats[1] ~= 0 and cabin.OccupiedSeats[2] ~= 0

            if cabinFull then
                if Config.Enable3dText then
                    local x, y, z = table.unpack(Wheel.PlatformCoords)

                    Draw3dText(x, y, z + 1.25, Config.Text.WHEEL_CABIN_FULL)
                else
                    DisplayHelpTextThisFrame('WHEEL_CABIN_FULL')
                end
            else
                if Config.Enable3dText then
                    local x, y, z = table.unpack(Wheel.PlatformCoords)

                    Draw3dText(x, y, z + 1.25, Config.Text.WHEEL_GET_ON)
                else
                    DisplayHelpTextThisFrame('WHEEL_GET_ON')
                end

                if IsControlJustPressed(0, 51) then
                    if Wheel.EnterCooldown - GetGameTimer() <= 0 and Wheel.CabinCooldown - GetGameTimer() >= 0 then
                        Wheel.EnterCooldown = GetGameTimer() + 2000
                        TriggerServerEvent('rcore_lunapark:Wheel:buyTicket', Wheel.CabinOnGround)
                    end
                end
            end
        end
    end
end

local function OnTick()
    if Wheel.CabinOnGround then
        HandleControls()
    end
end

CreateThread(function()
    while true do
        Wait(0)

        if Wheel.InSoundRange then
            OnTick()
        end
    end
end)