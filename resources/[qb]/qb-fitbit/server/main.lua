local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("fitbit", function(source)
    TriggerClientEvent('qb-fitbit:use', source)
end)

RegisterNetEvent('qb-fitbit:server:setValue', function(type, value)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not Player.Functions.GetItemByName("fitbit") then return end

    local currentMeta = Player.PlayerData.metadata["fitbit"]
    local fitbitData = {
        thirst = type == "thirst" and value or currentMeta.thirst,
        food = type == "food" and value or currentMeta.food
    }
    Player.Functions.SetMetaData('fitbit', fitbitData)
end)
