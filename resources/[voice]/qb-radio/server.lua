local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("radio", function(source)
    TriggerClientEvent('qb-radio:use', source)
end)

QBCore.Functions.CreateCallback('qb-radio:radiocheck', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName("radio") ~= nil and not Player.PlayerData.metadata["isdead"] and not Player.PlayerData.metadata["inlaststand"] then
            cb(true)
        else
            cb(false)
        end
    end
end)

for channel, config in pairs(Config.RestrictedChannels) do
    exports['pma-voice']:addChannelCheck(channel, function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        return config[Player.PlayerData.job.name]
    end)
end
