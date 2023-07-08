local usbItems = {
    'pacific_key1',
    'pacific_key2',
    'pacific_key3',
    'pacific_key4'
}

local vaultCodes = {
    [1] = generatePassword(4),
    [2] = generatePassword(4),
}

local checkingPacificPasscode = false
local pacificInputCorrect = false
local pacificInputCache = {
    [1] = false,
    [2] = false
}

--- Functions

ResetPacificValues = function()
    Shared.Banks['Pacific'].lockdown = false
    Shared.Banks['Pacific'].laserPanel = false
    Shared.Banks['Pacific'].sideEntrance.hacked = false
    Shared.Banks['Pacific'].computers['main'].hacked = false
    Shared.Banks['Pacific'].computers['office1'].hacked = false
    Shared.Banks['Pacific'].computers['office2'].hacked = false
    Shared.Banks['Pacific'].computers['office3'].hacked = false
    Shared.Banks['Pacific'].computers['office4'].hacked = false
    Shared.Banks['Pacific'].sideVaults[1].hacked = false
    Shared.Banks['Pacific'].sideVaults[2].hacked = false

    vaultCodes = {
        [1] = generatePassword(4),
        [2] = generatePassword(4),
    }

    checkingPacificPasscode = false
    pacificInputCorrect = false
    pacificInputCache = {
        [1] = false,
        [2] = false
    }
    
    for i = 1, 4, 1 do
        local drawer = math.random(#Shared.Banks['Pacific'].searchDrawers)
        while Shared.Banks['Pacific'].searchDrawers[drawer].usb do
            drawer = math.random(#Shared.Banks['Pacific'].searchDrawers)
        end
        Shared.Banks['Pacific'].searchDrawers[drawer].usb = true
        debugPrint('Pacific Drawer USB: ' .. drawer)
    end

    debugPrint('Pacific Code 1: ' .. vaultCodes[1])
    debugPrint('Pacific Code 2: ' .. vaultCodes[2])
end

--- Events

RegisterNetEvent('qb-bankrobbery:server:SetPacificSideHacked', function()
    local src = source
    if Shared.Banks['Pacific'].sideEntrance.hacked then return end
    Shared.Banks['Pacific'].sideEntrance.hacked = true
    TriggerClientEvent('qb-bankrobbery:client:SetPacificSideHacked', -1)
    TriggerEvent('qb-doorlock:server:updateState', Shared.Banks['Pacific'].sideEntrance.id, false, false, false, true, false, false, src)
end)

RegisterNetEvent('qb-bankrobbery:server:SetPacificComputerHacked', function(computer)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Shared.Banks['Pacific'].computers[computer] then return end
    if Shared.Banks['Pacific'].computers[computer].hacked then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Banks['Pacific'].computers[computer].coords) > 5 then return end

    Shared.Banks['Pacific'].computers[computer].hacked = true
    TriggerClientEvent('qb-bankrobbery:client:SetPacificComputerHacked', -1, computer)

    if computer == 'main' then
        TriggerClientEvent('var-ui:on', src, vaultCodes[1])

        -- Instruction Email
        exports['qb-phone']:sendNewMailToOffline(Player.PlayerData.citizenid, {
            sender = _U('pacific_mail_sender'),
            subject = _U('pacific_mail_subject'),
            message = _U('pacific_mail_text1') .. vaultCodes[1] .. _U('pacific_mail_text2')
        })

        -- Unlock Doors
        TriggerEvent('qb-doorlock:server:updateState', 'lh34banksgabz-pacific-door1', false, false, false, true, false, false, src)
        TriggerEvent('qb-doorlock:server:updateState', 'lh34banksgabz-pacific-door2', false, false, false, true, false, false, src)
        TriggerEvent('qb-doorlock:server:updateState', 'lh34banksgabz-pacific-door3', false, false, false, true, false, false, src)
        TriggerEvent('qb-doorlock:server:updateState', 'lh34banksgabz-pacific-door4', false, false, false, true, false, false, src)
    elseif computer == 'office1' then
        Player.Functions.RemoveItem(Shared.Banks['Pacific'].computers[computer].key, 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.Banks['Pacific'].computers[computer].key], 'remove', 1)
        TriggerClientEvent('var-ui:on', src, string.sub(vaultCodes[2], 1, 1) .. '...')
    elseif computer == 'office2' then
        Player.Functions.RemoveItem(Shared.Banks['Pacific'].computers[computer].key, 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.Banks['Pacific'].computers[computer].key], 'remove', 1)
        TriggerClientEvent('var-ui:on', src, '.' .. string.sub(vaultCodes[2], 2, 2) .. '..')
    elseif computer == 'office3' then
        Player.Functions.RemoveItem(Shared.Banks['Pacific'].computers[computer].key, 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.Banks['Pacific'].computers[computer].key], 'remove', 1)
        TriggerClientEvent('var-ui:on', src, '..' .. string.sub(vaultCodes[2], 3, 3) .. '.')
    elseif computer == 'office4' then
        Player.Functions.RemoveItem(Shared.Banks['Pacific'].computers[computer].key, 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Shared.Banks['Pacific'].computers[computer].key], 'remove', 1)
        TriggerClientEvent('var-ui:on', src, '...' .. string.sub(vaultCodes[2], 4, 4))
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SearchDrawer', function(drawer)
    if not Shared.Banks['Pacific'].searchDrawers[drawer] then return end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Banks['Pacific'].searchDrawers[drawer].coords.xyz) > 10 then return end

    if Shared.Banks['Pacific'].searchDrawers[drawer].usb then
        Shared.Banks['Pacific'].searchDrawers[drawer].usb = false
        local random = math.random(#usbItems)
        local item = usbItems[random]
        table.remove(usbItems, random)
        
        Player.Functions.AddItem(item, 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', 1)
        TriggerClientEvent('QBCore:Notify', src, _U('pacific_found_datakey'), 'success', 2500)
    else
        TriggerClientEvent('QBCore:Notify', src, _U('pacific_found_no_datakey'), 'error', 2500)
    end
end)

RegisterNetEvent('qb-bankrobbery:server:EnterPacificCode', function(panel, input)
    local src = source
    if not vaultCodes[panel] then return end
    if not Shared.Banks['Pacific'].computers['main'].hacked then return end

    if vaultCodes[panel] == input then
        pacificInputCache[panel] = true
        if not checkingPacificPasscode then
            checkingPacificPasscode = true
            SetTimeout(Shared.BankSettings.PacificInputTime, function()
                if pacificInputCache[1] and pacificInputCache[2] then
                    pacificInputCorrect = true
                    TriggerClientEvent('QBCore:Notify', src, _U('pacific_input_authorized'), 'success', 2500)
                    TriggerEvent('qb-doorlock:server:updateState', 'lh34banksgabz-vault-door1', false, false, false, true, false, false, src)
                    TriggerEvent('qb-doorlock:server:updateState', 'lh34banksgabz-vault-door2', false, false, false, true, false, false, src)

                    CreateTrollys('Pacific')
                else
                    TriggerClientEvent('QBCore:Notify', src, _U('pacific_input_timing'), 'error', 2500)
                    pacificInputCache[1] = false
                    pacificInputCache[2] = false
                    checkingPacificPasscode = false
                end
            end)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, _U('pacific_input_incorrect'), 'error', 2500)
    end
end)

RegisterNetEvent('qb-bankrobbery:server:HitByLaser', function()
    local src = source
    if Shared.Banks['Pacific'].lockdown then return end
    Shared.Banks['Pacific'].lockdown = true
    TriggerClientEvent('qb-bankrobbery:client:SetLockdownActive', -1)
    TriggerClientEvent('QBCore:Notify', src, _U('pacific_hitbylaser'), 'primary', 2500)
end)

RegisterNetEvent('qb-bankrobbery:server:LaserPowerSupplyDisabled', function()
    if Shared.Banks['Pacific'].lockdown then return end
    if Shared.Banks['Pacific'].laserPanel then return end
    Shared.Banks['Pacific'].laserPanel = true
    TriggerClientEvent('qb-bankrobbery:client:LaserPowerSupplyDisabled', -1)
end)

RegisterNetEvent('qb-bankrobbery:server:PacificSideVaultHacked', function(vault)
    local src = source
    if not Shared.Banks['Pacific'].sideVaults[vault] then return end
    if Shared.Banks['Pacific'].lockdown then return end
    if Shared.Banks['Pacific'].sideVaults[vault].hacked then return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Banks['Pacific'].sideVaults[vault].laptop.xyz) > 5 then return end

    Shared.Banks['Pacific'].sideVaults[vault].hacked = true
    TriggerClientEvent('qb-bankrobbery:client:PacificSideVaultHacked', -1, vault)
    TriggerEvent('qb-doorlock:server:updateState', Shared.Banks['Pacific'].sideVaults[vault].id, false, false, false, true, false, false, src)
end)

--- Callbacks

QBCore.Functions.CreateCallback('qb-bankrobbery:server:CanAttemptPacificHack', function(source, cb)
    local src = source
    if Shared.Banks['Pacific'].sideEntrance.hacked then
        TriggerClientEvent('QBCore:Notify', src, _U('pacific_sidehack_hit'), 'error', 4000)
        cb(false)
    elseif getCopCount() < Shared.MinCops['pacific'] then
        TriggerClientEvent('QBCore:Notify', src, _U('not_enough_cops') .. ' (' .. Shared.MinCops['pacific'] .. ') required', 'error', 4000)
        cb(false)
    else
        cb(true)
    end
end)

--- Threads

CreateThread(function()
    for i = 1, 4, 1 do
        local drawer = math.random(#Shared.Banks['Pacific'].searchDrawers)
        while Shared.Banks['Pacific'].searchDrawers[drawer].usb do
            drawer = math.random(#Shared.Banks['Pacific'].searchDrawers)
        end
        Shared.Banks['Pacific'].searchDrawers[drawer].usb = true
        debugPrint('Pacific Drawer USB: ' .. drawer)
    end

    debugPrint('Pacific Code 1: ' .. vaultCodes[1])
    debugPrint('Pacific Code 2: ' .. vaultCodes[2])
end)
