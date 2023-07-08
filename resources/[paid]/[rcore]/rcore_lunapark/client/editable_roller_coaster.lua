local function HandleControls()
    if RollerCoaster.PedIsSitting then
        if RollerCoaster.RideInProgress then
            if Config.Enable3dText then
                local x, y, z = table.unpack(GetEntityCoords(RollerCoaster.Cars[RollerCoaster.CurrentCarIndex].Entity))

                Draw3dText(x + 0.5, y + 0.5, z + 1.25, Config.Text.COASTER_GET_OFF)
            else
                DisplayHelpTextThisFrame('COASTER_GET_OFF')
            end
        else
            if Config.Enable3dText then
                local x, y, z = table.unpack(GetEntityCoords(RollerCoaster.Cars[RollerCoaster.CurrentCarIndex].Entity))

                Draw3dText(x + 0.5, y + 0.5, z + 1.25, Config.Text.COASTER_START)
            else
                DisplayHelpTextThisFrame('COASTER_START')
            end
        end

        if IsControlJustPressed(0, 75) then
            TriggerServerEvent('rcore_lunapark:RollerCoaster:getOff', RollerCoaster.CurrentCarIndex, RollerCoaster.CurrentSeatIndex)
        end

        if IsControlPressed(0, 21) and IsControlJustPressed(0, 71) then
            TriggerServerEvent('rcore_lunapark:RollerCoaster:start')
        end
    else
        local playerPos = GetEntityCoords(PlayerPedId())

        for i = 1, #RollerCoaster.GetInPositions do
            if #(RollerCoaster.GetInPositions[i] - playerPos) < 1.2 then
                local isFrontRow = i % 2 ~= 0 and true or false
                local car = RollerCoaster.Cars[isFrontRow and i // 2 + 1 or i // 2]
                local isRowFull = isFrontRow and (car.OccupiedSeats[1] ~= 0 and car.OccupiedSeats[2] ~= 0) or (car.OccupiedSeats[3] ~= 0 and car.OccupiedSeats[4] ~= 0)

                if isRowFull then
                    if Config.Enable3dText then
                        local x, y, z = table.unpack(RollerCoaster.GetInPositions[i])

                        Draw3dText(x, y, z + 0.85, Config.Text.COASTER_ROW_FULL)
                    else
                        DisplayHelpTextThisFrame('COASTER_ROW_FULL')
                    end
                else
                    if RollerCoaster.EnterCooldown - GetGameTimer() <= 0 then
                        if Config.Enable3dText then
                            local x, y, z = table.unpack(RollerCoaster.GetInPositions[i])

                            Draw3dText(x, y, z + 0.85, Config.Text.COASTER_GET_ON)
                        else
                            DisplayHelpTextThisFrame('COASTER_GET_ON')
                        end
                    end

                    if IsControlJustPressed(0, 51) then
                        if RollerCoaster.EnterCooldown - GetGameTimer() <= 0 then
                            RollerCoaster.EnterCooldown = GetGameTimer() + 10000
                            TriggerServerEvent('rcore_lunapark:RollerCoaster:buyTicket')
                        end
                    end
                end
                break
            end
        end
    end
end

local function OnTick()
    if RollerCoaster.Active then
        if RollerCoaster.PedIsSitting then
            if not LoadStreamWithStartOffset('Player_Ride', 0, 'DLC_IND_ROLLERCOASTER_SOUNDS') then
                LoadStreamWithStartOffset('Player_Ride', 0, 'DLC_IND_ROLLERCOASTER_SOUNDS')
            end
        else
            if not LoadStreamWithStartOffset('Ambient_Ride', 1, 'DLC_IND_ROLLERCOASTER_SOUNDS') then
                LoadStreamWithStartOffset('Ambient_Ride', 1, 'DLC_IND_ROLLERCOASTER_SOUNDS')
            end
        end
    else
        if RollerCoaster.InPlatformRange and RollerCoaster.Timer > 10 then
            HandleControls()
        end
    end
end

CreateThread(function()
    while true do
        Wait(0)

        if RollerCoaster.InSoundRange then
            OnTick()
        end
    end
end)