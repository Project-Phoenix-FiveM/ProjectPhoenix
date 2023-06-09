PlayerJob = {}

if Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerJob = {}
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerJob = xPlayer.job
end)

RegisterNetEvent('esx:onPlayerLogout',function()
    PlayerJob = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerJob = job
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    if Config.Framework == "QBCore" then
        local player = QBCore.Functions.GetPlayerData()
        PlayerJob = player.job
    elseif Config.Framework == "ESX" then
        PlayerJob = ESX.PlayerData.job
    end
end)