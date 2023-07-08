--- Method to get the vehicle that the player ped is looking at
--- @param coordFrom vector3 - start location
--- @param coordTo vector3 - end location
--- @return vehicle number - vehicle entity id
local getVehicleInDirection = function(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z,coordTo.x, coordTo.y,coordTo.z + offset, 10, PlayerPedId(), 0)
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        offset = offset - 1
        if vehicle ~= 0 then break end
    end

    local distance = #(coordFrom - GetEntityCoords(vehicle))
    if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

--- This function is called after checking the vehicle and performs a stealing animation and grabs loot
--- @param veh number - vehicle entity id
--- @return nil
local AllowHeist = function(veh)
    -- update robbed plate config
    local plate = GetVehicleNumberPlateText(veh)
    TriggerServerEvent('qb-humanelabsheist:server:UpdatePlates', plate)
    SetVehicleDoorOpen(veh, 2, 0, 0)
    SetVehicleDoorOpen(veh, 3, 0, 0)

    SetVehicleHandbrake(attempted, true)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do Wait(10) end

    local ped = PlayerPedId()
    if not IsEntityPlayingAnim(ped, "mini@repair", "fixing_a_player", 3) then
        TaskPlayAnim(ped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 49, 0, 0, 0, 0)
        FreezeEntityPosition(ped, true)
    end

    QBCore.Functions.Progressbar("humanelabsheist", "Collecting Items", 20000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        ClearPedTasks(ped)
        TriggerServerEvent('qb-humanelabsheist:server:BoxvilleReward')
        FreezeEntityPosition(ped, false)
    end, function() -- Cancel
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        QBCore.Functions.Notify("Cancelled..", "error")
    end)
end

--- Method to send an alert for humane labs van robbery
--- @return nil
local vanRobberyAlert = function()
    exports['qb-dispatch']:VanRobbery()
end

--- Method to check if the player is allowed to rob the truck
--- @param veh number - vehicle entity id
--- @return nil
local AttemptBoxville = function(veh)
    QBCore.Functions.TriggerCallback('qb-humanelabsheist:server:getCops', function(cops)
        local plate = GetVehicleNumberPlateText(veh)
        if not Shared.RobbedPlates[plate] then
            if cops >= Shared.MinTransportCops then
                --enough cops
                SetEntityAsMissionEntity(attempted, true, true)
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                -- call cops
                vanRobberyAlert()
                -- unlocking doors progressbar
                QBCore.Functions.Progressbar("unlockdoor_action", "Unlocking Door", 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true
                }, {
                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                    anim = "machinic_loop_mechandplayer",
                    flags = 49
                }, {}, {}, function(status)
                    if not status then
                        TriggerServerEvent('qb-humanelabsheist:server:RemoveSecurityCard')
                        AllowHeist(veh)
                    end
                end)
            else
                --not enough cops
                QBCore.Functions.Notify('Not enough cops',"error", 2500)
            end
        else
            QBCore.Functions.Notify('This truck has recently been robbed',"error", 2500)
        end
    end)
end

RegisterNetEvent('qb-humanelabsheist:client:UpdatePlates', function(plate)
    Shared.RobbedPlates[plate] = true
end)

RegisterNetEvent('qb-humanelabsheist:client:UseBlueCard', function()
    local ped = PlayerPedId()
    local coordA = GetEntityCoords(ped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)
    if targetVehicle ~= 0 and GetHashKey("boxville3") == GetEntityModel(targetVehicle) then
        local entityCreatePoint = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0, -4.0, 0.0)
        local coords = GetEntityCoords(ped)
        local distance = #(coords - entityCreatePoint)
        if distance < 2.0 then
            AttemptBoxville(targetVehicle)
        else
            QBCore.Functions.Notify('You need to do this from behind the vehicle.')
        end
    end
end)
