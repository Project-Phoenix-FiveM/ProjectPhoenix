-- Usage: clearAreaOf everything 50.0
RegisterCommand('clearAreaOf', function(src, args)
    local clearType = args[1]
    local radius = args[2] and tonumber(args[2]) or 50.0

    local vectors

    -- TODO: authorization to restrict to admin use

    if not args[3] or not args[4] or not args[5] then
        if src == 0 then return print('Invalid Coords') end

        local playerPed = GetPlayerPed(src)

        vectors = GetEntityCoords(playerPed)
    else
        vectors = vector3(tonumber(args[3]), tonumber(args[4]), tonumber(args[5]))
    end

    if not vectors then return print('Invalid Coords') end

    if not radius then return print('Invalid Radius') end

    if clearType == nil or clearType == 'everything' then
        TriggerClientEvent('qb-cleanup:clearAreaOfEverything', -1, vectors, radius + 0.0)
    elseif clearType == 'objects' then
        TriggerClientEvent('qb-cleanup:clearAreaOfObjects', -1, vectors, radius + 0.0)
    elseif clearType == 'vehicles' then
        TriggerClientEvent('qb-cleanup:clearAreaOfVehicles', -1, vectors, radius + 0.0)
    elseif clearType == 'peds' then
        TriggerClientEvent('qb-cleanup:clearAreaOfPeds', -1, vectors, radius + 0.0)
    end
end)