local isNearRack = false

local closestRack = nil

HasPoolCueInHand = false
IsCloseToPoolRack = false

Citizen.CreateThread(function()
    if Config.AllowTakePoolCueFromStand == nil then
        Config.AllowTakePoolCueFromStand = true
    end

    while not Config.TargetResourceName and Config.AllowTakePoolCueFromStand do
        Wait(500)

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        Wait(0)

        local newClosestCoords = nil
        local newClosestRack = nil

        for _, hash in pairs(POOL_RACKS) do
            local rackObj = GetClosestObjectOfType(
                coords.x, 
                coords.y, 
                coords.z, 
                30.0, 
                hash, false, false, false
            )

            if rackObj and rackObj > 0 then
                if IsPoolTableAllowed(GetEntityCoords(rackObj), 30.0) then
                    local rackCoords = GetEntityCoords(rackObj)

                    if not newClosestRack then
                        newClosestRack = rackObj
                        newClosestCoords = rackCoords
                    else
                        if #(coords - rackCoords) < #(coords - newClosestCoords) then
                            newClosestRack = rackObj
                            newClosestCoords = rackCoords
                        end
                    end
                end
            end

            Wait(500)
        end

        if newClosestRack then
            isNearRack = true
            closestRack = newClosestRack
        else
            isNearRack = false
            closestRack = nil
        end

        Wait(0)
    end
end)

local canInteractWithPoolCue = true

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if not Config.TargetResourceName and closestRack then
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            local rackCoords = GetEntityCoords(closestRack)

            local dist = #(pedCoords - rackCoords)
            
            local maxDist = 1.4

            if canInteractWithPoolCue then
                if dist < maxDist then
                    IsCloseToPoolRack = true
                    if HasPoolCueInHand then
                        CustomDisplayHelpTextThisFrame('TEB_POOL_RETURN_CUE', 0)
                    else
                        CustomDisplayHelpTextThisFrame('TEB_POOL_TAKE_CUE', 0)
                    end

                    local isEnterPressed = IsControlJustPressed(0, Config.Keys.ENTER.code) or IsDisabledControlJustPressed(0, Config.Keys.ENTER.code)

                    if isEnterPressed then
                        canInteractWithPoolCue = false
                        
                        SetTimeout(1000, function()
                            canInteractWithPoolCue = true
                        end)

                        if HasPoolCueInHand then
                            TriggerServerEvent('rcore_pool:requestRemoveCue')
                        else
                            TriggerServerEvent('rcore_pool:requestPoolCue')
                        end
                    end
                else
                    Wait(500)
                    IsCloseToPoolRack = false
                end
            end
        else
            Wait(5000)
        end
    end
end)