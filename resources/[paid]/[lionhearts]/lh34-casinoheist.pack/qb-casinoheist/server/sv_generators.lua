RegisterNetEvent('qb-casinoheist:server:SetThermiteBusy', function(index, state)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(state) ~= 'boolean' or type(index) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-thermitebusy') return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Thermite[index].coords) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-thermitebusy') return end

    Shared.Thermite[index].busy = state
    TriggerClientEvent('qb-casinoheist:client:SetThermiteBusy', -1, index, state)
end)

RegisterNetEvent('qb-casinoheist:server:SetThermiteHit', function(index, state)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(state) ~= 'boolean' or type(index) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-thermitehit') return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Thermite[index].coords) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-thermitehit') return end

    Shared.Thermite[index].hit = state
    TriggerClientEvent('qb-casinoheist:client:SetThermiteHit', -1, index, state)

    if index == 1 then
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-generator1', false, false, false, true, false, true, src)
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-generator2', false, false, false, true, false, true, src)
    elseif index == 2 then
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door1', false, false, false, true, false, true, src)
    elseif index == 3 then
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door2', false, false, false, true, false, true, src)
    end
end)

RegisterNetEvent('qb-casinoheist:server:ThermitePtfx', function(coords)
    TriggerClientEvent('qb-casinoheist:client:ThermitePtfx', -1, coords)
end)

RegisterNetEvent('qb-casinoheist:server:SetGeneratorBusy', function(index, state)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(state) ~= 'boolean' or type(index) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-generatorbusy') return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Generators[index].coords) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-generatorbusy') return end

    Shared.Generators[index].busy = state
    if state then
        Shared.Generators[index].currentAttempt += 1 
    end
    TriggerClientEvent('qb-casinoheist:client:SetGeneratorBusy', -1, index, state)
end)

RegisterNetEvent('qb-casinoheist:server:SetGeneratorHit', function(index, state)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(state) ~= 'boolean' or type(index) ~= 'number' then exports['qb-core']:ExploitBan(src, 'casinoheist-generatorhit') return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Generators[index].coords) > 15 then exports['qb-core']:ExploitBan(src, 'casinoheist-generatorhit') return end

    Shared.Generators[index].hit = state
    TriggerClientEvent('qb-casinoheist:client:SetGeneratorHit', -1, index, state)

    if index == 1 then
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door3', false, false, false, true, false, true, src)
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door4', false, false, false, true, false, true, src)
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door5', false, false, false, true, false, true, src)
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door6', false, false, false, true, false, true, src)
    elseif index == 2 then
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door7', false, false, false, true, false, true, src)
    elseif index == 3 then
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door3', false, false, false, true, false, true, src)
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door4', false, false, false, true, false, true, src)
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door5', false, false, false, true, false, true, src)
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door6', false, false, false, true, false, true, src)
    elseif index == 4 then
        TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-security-door7', false, false, false, true, false, true, src)
    end
end)
