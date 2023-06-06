local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("rodinium-weapons:attackedByCash")
AddEventHandler("rodinium-weapons:attackedByCash", function(pAttacker) 
    local victim = source
    TriggerClientEvent("rodinium-weapons:hitPlayerWithCash", pAttacker, victim)
end)
 
RegisterNetEvent("rodinium-weapons:processGiveCashAmount") 
AddEventHandler("rodinium-weapons:processGiveCashAmount", function(pTarget, pAmount)
    local attacker = source
    local victim = pTarget
    local victimUser = QBCore.Functions.GetPlayer(victim) 
    victimUser.Functions.AddMoney("cash", pAmount)
    
end)

RegisterNetEvent("cash:roll")
AddEventHandler("cash:roll", function(src, pAmount)
    local user = QBCore.Functions.GetPlayer(src) 
    local amount = tonumber(pAmount)
    if amount ~= nil then
        if user.PlayerData.money['cash'] >= amount then 
            user.Functions.RemoveMoney('cash', amount, 'Rolled Cash')
            user.Functions.AddItem('weapon_cash', amount)   
            print(amount)
            return 
        end
    end

    return
end)

RegisterCommand("rollcash", function(src, args)
    TriggerEvent('cash:roll', src, args[1])
end)