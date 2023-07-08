QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-casinoheist:client:SetPowerPlant', function()
    Shared.PowerplantHit = state
end)

RegisterNetEvent('qb-casinoheist:client:OpenTunnelDoor', function()
    TriggerServerEvent('qb-doorlock:server:updateState', 'lh34casino-shower-wall', false, false, false, true, false, true, false)
end)

RegisterNetEvent('qb-casinoheist:client:SetTunnelHit', function(state)
    Shared.TunnelHit = state

    if state then
        local tunnel = GetInteriorAtCoords(931.27, -47.44, 21.53)
        ActivateInteriorEntitySet(tunnel, "set_xee_casino_tun_end_broken")
        DeactivateInteriorEntitySet(tunnel, "set_xee_casino_tun_end")
        RefreshInterior(tunnel)

        local utility = GetInteriorAtCoords(999.39, 16.48, 62.46)
        ActivateInteriorEntitySet(utility, "set_xee_casino_utility_broken")
        DeactivateInteriorEntitySet(utility, "set_xee_casino_utility")
        RefreshInterior(utility)
    else
        local tunnel = GetInteriorAtCoords(931.27, -47.44, 21.53)
        DeactivateInteriorEntitySet(tunnel, "set_xee_casino_tun_end_broken")
        ActivateInteriorEntitySet(tunnel, "set_xee_casino_tun_end")
        RefreshInterior(tunnel)

        local utility = GetInteriorAtCoords(999.39, 16.48, 62.46)
        DeactivateInteriorEntitySet(utility, "set_xee_casino_utility_broken")
        ActivateInteriorEntitySet(utility, "set_xee_casino_utility")
        RefreshInterior(utility)
    end
end)

RegisterNetEvent('qb-casinoheist:client:SetLadderActive', function(state)
    Shared.SetLadder = state

    if state then
        local elevator = GetInteriorAtCoords(1015.19, 20.33, 70.46)
        ActivateInteriorEntitySet(elevator, "set_casino_ladder")
        RefreshInterior(elevator)
    else
        local elevator = GetInteriorAtCoords(1015.19, 20.33, 70.46)
        DeactivateInteriorEntitySet(elevator, "set_casino_ladder")
        RefreshInterior(elevator)
    end
end)

--- IPL on server connect
CreateThread(function()
    QBCore.Functions.TriggerCallback('qb-casinoheist:server:GetConfig', function(result)
        Shared = result

        if Shared.TunnelHit then
            local tunnel = GetInteriorAtCoords(931.27, -47.44, 21.53)
            ActivateInteriorEntitySet(tunnel, "set_xee_casino_tun_end_broken")
            DeactivateInteriorEntitySet(tunnel, "set_xee_casino_tun_end")
            RefreshInterior(tunnel)

            local utility = GetInteriorAtCoords(999.39, 16.48, 62.46)
            ActivateInteriorEntitySet(utility, "set_xee_casino_utility_broken")
            DeactivateInteriorEntitySet(utility, "set_xee_casino_utility")
            RefreshInterior(utility)
        else
            local tunnel = GetInteriorAtCoords(931.27, -47.44, 21.53)
            DeactivateInteriorEntitySet(tunnel, "set_xee_casino_tun_end_broken")
            ActivateInteriorEntitySet(tunnel, "set_xee_casino_tun_end")
            RefreshInterior(tunnel)

            local utility = GetInteriorAtCoords(999.39, 16.48, 62.46)
            DeactivateInteriorEntitySet(utility, "set_xee_casino_utility_broken")
            ActivateInteriorEntitySet(utility, "set_xee_casino_utility")
            RefreshInterior(utility)
        end

        if Shared.SetLadder then
            local elevator = GetInteriorAtCoords(1015.19, 20.33, 70.46)
            ActivateInteriorEntitySet(elevator, "set_casino_ladder")
            RefreshInterior(elevator)
        else
            local elevator = GetInteriorAtCoords(1015.19, 20.33, 70.46)
            DeactivateInteriorEntitySet(elevator, "set_casino_ladder")
            RefreshInterior(elevator)
        end

        if Shared.USBSpawned then
            EnableUSB(true)
        end
    end)

    -- Vault
    local vaultRoom = GetInteriorAtCoords(1000.19, 10.54, -7.99)
    DeactivateInteriorEntitySet(vaultRoom, "np2_vault_broken")
    ActivateInteriorEntitySet(vaultRoom, "np2_vault_clean")
    RefreshInterior(vaultRoom)

    -- Elevator Hatch
    local hatchProp = "ch_prop_ch_casino_button_01a"
    local hatchCoords = vector3(1014.71, 30.08, -7.00)

    RequestModel(hatchProp)
	while not HasModelLoaded(hatchProp) do Wait(10) end
	if not HasModelLoaded(hatchProp) then
		SetModelAsNoLongerNeeded(hatchProp)
	else
		local created_object = CreateObjectNoOffset(hatchProp, hatchCoords, false, false, true)
        SetEntityHeading(created_object, 328.00)
		FreezeEntityPosition(created_object, true)
        SetEntityInvincible(created_object, true)
		SetModelAsNoLongerNeeded(hatchProp)
	end
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("casinoh_tunnelpad", vector3(936.83, -53.52, 21.86), 0.25, 0.25, {
        name = "casinoh_tunnelpad",
        heading = 244,
        debugPoly = false,
        minZ = 21.95,
        maxZ = 22.25,
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-casinoheist:client:OpenTunnelDoor',
                icon = 'fas fa-user-secret',
                label = 'Open Door'
            },
            {
                type = 'server',
                event = 'qb-casinoheist:server:GrabFlashlight',
                icon = 'fas fa-lightbulb',
                label = 'Grab Flashlight'
            }
        },
        distance = 1.5,
    })
end)

-- I use this thread to find usbLocations, just aim somewhere with a gun, shoot, grab the coordinate from the console and put it in the usbLocations table in sv_security
-- CreateThread(function()
--     while true do
--         if IsControlJustPressed(0, 24) then
--             local hit, dest, _, _ = RayCastCamera(10)
--             print(dest.x, dest.y, dest.z)
--         end
--         Wait(0)
--     end
-- end)