local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-grandma:revive', function()
    local _source = source

    local check = isNearGrandma(_source)

    local pData = QBCore.Functions.GetPlayer(source)
    if check then
        if pData.Functions.RemoveMoney("cash", Shared.GrandmaCost) then
            TriggerClientEvent("hospital:client:Revive", source)
            if Shared.HealInjuries then
                TriggerClientEvent("hospital:client:HealInjuries", source, "full")
            end
        end 
    end
end)

isNearGrandma = function(source)
    local ped = GetPlayerPed(source)
    local pos = GetEntityCoords(ped)

    for i = 1, #Shared.location do
        local grandma = Shared.location[i]
        local distance = #(pos - grandma.pos)
        if distance < 5 then
            return true
        end
    end

    return false
end
