local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('kevin-buffconsumables:consume', function (item, data)
    TriggerEvent('animations:client:EmoteCommandStart', {data.animation})
    if data.useprogbar then
        QBCore.Functions.Progressbar('consume_buff', data.progbarlabel, data.progbartime, false, true, {
            disableMovement = data.movement,
            disableCarMovement = data.carmovement,
            disableMouse = data.mouse,
            disableCombat = data.combat,
        }, {}, {}, {}, function() -- Done
            TriggerEvent('animations:client:EmoteCommandStart', {'c'})
            AddPlayerProps(data)
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {'c'})
            QBCore.Functions.Notify('Cancelled', 'error')
        end)
    else
        Wait(5000)
        TriggerEvent('animations:client:EmoteCommandStart', {'c'})
        AddPlayerProps(data)
    end
end)

function AddPlayerProps(data)
    exports['ps-buffs']:AddBuff(data.buffname, (data.bufftime * 60000))
    if data.type == 'drink' then
        TriggerServerEvent('consumables:server:addThirst', QBCore.Functions.GetPlayerData().metadata['thirst'] + data.metadata)
    elseif data.type == 'eat' then
        TriggerServerEvent('consumables:server:addHunger', QBCore.Functions.GetPlayerData().metadata['hunger'] + data.metadata)
    else
        TriggerServerEvent('consumables:server:addHunger', QBCore.Functions.GetPlayerData().metadata['hunger'] + data.metadata)
        TriggerServerEvent('consumables:server:addThirst', QBCore.Functions.GetPlayerData().metadata['thirst'] + data.metadata)
    end
end
