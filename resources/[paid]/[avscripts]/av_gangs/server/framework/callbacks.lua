lib.callback.register('av_gangs:getPrices', function(source, gang)
    local sprayPrice = Gangs.SprayPrice
    local removerPrice = Gangs.SprayRemoverPrice
    local currentGraffitis = 0
    for k, v in pairs(gangs_names) do
        if v['name'] == gang['name'] then
            currentGraffitis = tonumber(v['graffitis'])
            break
        end
    end
    if currentGraffitis >= 1 then
        sprayPrice = (sprayPrice * Gangs.SprayMultiplier * currentGraffitis)
    end
    return {spray = Round(sprayPrice), remover = removerPrice}
end)

lib.callback.register('av_gangs:getOnlineMembers', function(source, gang, coords, msg)
    local online = 0
    local members = MySQL.query.await('SELECT * FROM av_gangs WHERE name = ?', {gang})
    if members and members[1] then
        for k, v in pairs(members) do
            local Player = exports['av_laptop']:getSourceByIdentifier(v['identifier'])
            if Player then 
                online = online + 1
                TriggerClientEvent('av_gangs:alertMember',Player, coords, msg)
            end
        end
    end
    return online
end)

function Round(value, numDecimalPlaces)
    if not numDecimalPlaces then return math.floor(value + 0.5) end
    local power = 10 ^ numDecimalPlaces
    return math.floor((value * power) + 0.5) / (power)
end