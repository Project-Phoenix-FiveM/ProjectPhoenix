QBCore.Commands.Add('reducesentence', 'Reduce Player Sentence', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Time in minutes'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local playerId = tonumber(args[1])
    local amount = tonumber(args[2])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player and OtherPlayer and amount and Player.PlayerData.job.type == 'leo' and Player.PlayerData.job.onduty then -- if Player and OtherPlayer and Player.PlayerData.job.name == 'police' and Player.PlayerData.job.onduty then
        if reducePlayerJailSentence(playerId, amount) then
            TriggerClientEvent('QBCore:Notify', src, 'Successfully reduced jail sentence.', 'success', 2500)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Could not reduce jail sentence.', 'error', 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'This command is only for on duty police.', 'error', 2500)
    end
end)

QBCore.Commands.Add('increasesentence', 'Increase Player Sentence', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Time in minutes'}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local playerId = tonumber(args[1])
    local amount = tonumber(args[2])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player and OtherPlayer and amount and Player.PlayerData.job.type == 'leo' and Player.PlayerData.job.onduty then -- if Player and OtherPlayer and Player.PlayerData.job.name == 'police' and Player.PlayerData.job.onduty then
        if increasePlayerJailSentence(playerId, amount) then
            TriggerClientEvent('QBCore:Notify', src, 'Successfully increased jail sentence.', 'success', 2500)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Could not increase jail sentence.', 'error', 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'This command is only for on duty police.', 'error', 2500)
    end
end)
