local officeCodes = {
    [1] = generatePassword(5),
    [2] = generatePassword(5),
    [3] = generatePassword(5),
}

local checkingPasscode = false
local paletoInputCorrect = false
local paletoInputCache = {
    [1] = nil,
    [2] = nil,
    [3] = nil
}

--- Functions

ResetPaletoValues = function()
    Shared.Banks['Paleto'].securityEntrance.hacked = false
    Shared.Banks['Paleto'].sideEntrance.hacked = false
    Shared.Banks['Paleto'].sideHack.hacked = false
    Shared.Banks['Paleto'].officeHacks[1].hacked = false
    Shared.Banks['Paleto'].officeHacks[2].hacked = false
    Shared.Banks['Paleto'].officeHacks[3].hacked = false

    officeCodes = {
        [1] = generatePassword(5),
        [2] = generatePassword(5),
        [3] = generatePassword(5),
    }

    checkingPasscode = false
    paletoInputCorrect = false
    paletoInputCache = {
        [1] = nil,
        [2] = nil,
        [3] = nil
    }
    
    debugPrint('Paleto Office Code 1: ' .. officeCodes[1])
    debugPrint('Paleto Office Code 2: ' .. officeCodes[2])
    debugPrint('Paleto Office Code 3: ' .. officeCodes[3])
end

--- Events

RegisterNetEvent('qb-bankrobbery:server:SetPaletoSideHacked', function(hack)
    local src = source
    if not Shared.Banks['Paleto'][hack] then return end
    if Shared.Banks['Paleto'][hack].hacked then return end
    Shared.Banks['Paleto'][hack].hacked = true
    TriggerClientEvent('qb-bankrobbery:client:SetPaletoSideHacked', -1, hack)
    TriggerEvent('qb-doorlock:server:updateState', Shared.Banks['Paleto'][hack].id, false, false, false, true, false, false, src)
end)

RegisterNetEvent('qb-bankrobbery:server:SetPaletoOfficeHacked', function(id)
    local src = source
    if not Shared.Banks['Paleto'].officeHacks[id] then return end
    if Shared.Banks['Paleto'].officeHacks[id].hacked then return end
    Shared.Banks['Paleto'].officeHacks[id].hacked = true
    TriggerClientEvent('qb-bankrobbery:client:SetPaletoOfficeHacked', -1, id)
    TriggerClientEvent('var-ui:on', src, officeCodes[id])
    TriggerEvent('qb-doorlock:server:updateState', Shared.Banks['Paleto'].officeHacks[id].id, false, false, false, true, false, false, src)
end)

RegisterNetEvent('qb-bankrobbery:server:EnterPaletoPassword', function(id, input)
    local src = source
    if not Shared.Banks['Paleto'].officeHacks[id].hacked then return end
    if paletoInputCorrect then return end
    paletoInputCache[id] = input

    if not checkingPasscode then
        checkingPasscode = true
        SetTimeout(Shared.BankSettings.PaletoInputTime, function()
            if officeCodes[1] == paletoInputCache[1] and officeCodes[2] == paletoInputCache[2] and officeCodes[3] == paletoInputCache[3] then
                paletoInputCorrect = true
                TriggerClientEvent('QBCore:Notify', src, _U('paleto_inputs_success'), 'error', 4000)
            else
                checkingPasscode = false
                paletoInputCache[1] = nil
                paletoInputCache[2] = nil
                paletoInputCache[3] = nil
                TriggerClientEvent('QBCore:Notify', src, _U('paleto_inputs_fail'), 'error', 4000)
            end
        end)
    end
end)

--- Callbacks

QBCore.Functions.CreateCallback('qb-bankrobbery:server:CanAttemptPaletoHack', function(source, cb, hack)
    local src = source
    if Shared.Banks['Paleto'][hack].hacked then
        TriggerClientEvent('QBCore:Notify', src, _U('laptop_hit'), 'error', 4000)
        cb(false)
    elseif getCopCount() < Shared.MinCops['paleto'] then
        TriggerClientEvent('QBCore:Notify', src, _U('not_enough_cops') .. ' (' .. Shared.MinCops['paleto'] .. ') required', 'error', 4000)
        cb(false)
    else
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('qb-bankrobbery:server:CanPaletoBankPanelHack', function(source, cb)
    cb(paletoInputCorrect)
end)

--- Threads

CreateThread(function()
    debugPrint('Paleto Office Code 1: ' .. officeCodes[1])
    debugPrint('Paleto Office Code 2: ' .. officeCodes[2])
    debugPrint('Paleto Office Code 3: ' .. officeCodes[3])
end)
