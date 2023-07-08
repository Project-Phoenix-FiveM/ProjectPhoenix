ESX = nil
QBCore = nil

function HandleTransaction(source, amount, errorMsg, successEvent, customEvent, ...)
    local args = {...}

    if ESX ~= nil and Config.EnableESX then
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getMoney() >= amount then
            xPlayer.removeMoney(amount)

            if successEvent then
                TriggerEvent(successEvent, source, table.unpack(args))
            end
        else
            TriggerClientEvent('esx:showNotification', source, errorMsg)
        end
    elseif QBCore ~= nil and Config.EnableQBCore then
        local Player = QBCore.Functions.GetPlayer(source)

        if Player.PlayerData.money['cash'] >= amount then
            Player.Functions.RemoveMoney('cash', amount)

            if successEvent then
                TriggerEvent(successEvent, source, table.unpack(args))
            end
        else
            TriggerClientEvent('QBCore:Notify', source, errorMsg)
        end
    elseif Config.EnableCustomEvents then
        if customEvent then
            TriggerEvent(customEvent, source, amount, function(paid)
                if paid then
                    if successEvent then
                        TriggerEvent(successEvent or '', source, table.unpack(args))
                    end
                else
                    TriggerClientEvent('lsrp_lunapark:showNotification', source, errorMsg)
                end
            end)
        end
    else
        if successEvent then
            TriggerEvent(successEvent, source, table.unpack(args))
        end
    end
end

CreateThread(function()
    if Config.EnableESX then
        while ESX == nil do Wait(0); ESX = exports['es_extended']:getSharedObject() end
    end

    if Config.EnableQBCore then
        while QBCore == nil do Wait(0); QBCore = exports['qb-core']:GetCoreObject() end
    end
end)