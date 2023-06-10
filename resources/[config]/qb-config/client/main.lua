-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()

function isPaidEnabled()
    return Config.enableAvScripts
end 
exports("isPaidEnabled", isPaidEnabled)
-- exports['qb-config']:isPaidEnabled()