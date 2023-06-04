local QBCore = exports['qb-core']:GetCoreObject()
local tunedVehicles = {}
local Threshold = {
    ['boost'] = {min = 1, max = 5},
    ['acceleration'] = {min = 1, max = 5},
    ['gearchange'] = {min = 1, max = 5},
    ['breaking'] = {min = 1, max = 5},
    ['drivetrain'] = {min = 1, max = 3},
}

QBCore.Functions.CreateUseableItem("tunerlaptop", function(source)
    TriggerClientEvent('qb-tunerchip:client:openChip', source)
end)

RegisterNetEvent('qb-tunerchip:server:TuneStatus', function(plate, bool)
    if bool then
        tunedVehicles[plate] = bool
    else
        tunedVehicles[plate] = nil
    end
end)

QBCore.Functions.CreateCallback('qb-tunerchip:server:HasChip', function(source, cb, data)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local Chip = Ply.Functions.GetItemByName('tunerlaptop')
    if data then
        for k,v in pairs(data) do
            if Threshold[k].min > tonumber(v) or Threshold[k].max < tonumber(v) then Chip = nil end
        end
    end
    if Chip then cb(true) return end
    DropPlayer(src, Lang:t("text.this_is_not_the_idea_is_it"))
    cb(false)
end)

QBCore.Functions.CreateCallback('qb-tunerchip:server:GetStatus', function(_, cb, plate)
    cb(tunedVehicles[plate])
end)

QBCore.Functions.CreateUseableItem("nitrous", function(source)
    TriggerClientEvent('smallresource:client:LoadNitrous', source)
end)

RegisterNetEvent('nitrous:server:LoadNitrous', function(Plate)
    TriggerClientEvent('nitrous:client:LoadNitrous', -1, Plate)
end)

RegisterNetEvent('nitrous:server:SyncFlames', function(netId)
    TriggerClientEvent('nitrous:client:SyncFlames', -1, netId, source)
end)

RegisterNetEvent('nitrous:server:UnloadNitrous', function(Plate)
    TriggerClientEvent('nitrous:client:UnloadNitrous', -1, Plate)
end)

RegisterNetEvent('nitrous:server:UpdateNitroLevel', function(Plate, level)
    TriggerClientEvent('nitrous:client:UpdateNitroLevel', -1, Plate, level)
end)

RegisterNetEvent('nitrous:server:StopSync', function(plate)
    TriggerClientEvent('nitrous:client:StopSync', -1, plate)
end)

RegisterNetEvent('nitrous:server:removeItem', function()
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return end

    Player.Functions.RemoveItem('nitrous', 1)
end)
