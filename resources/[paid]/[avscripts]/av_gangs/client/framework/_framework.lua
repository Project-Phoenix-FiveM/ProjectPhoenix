if Gangs.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Gangs.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
end

currentGang = {}

RegisterNetEvent('av_gangs:update', function(data)
    currentGang = data
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    currentGang = lib.callback.await('av_gangs:getData', 500)
    allGraffitis = lib.callback.await('av_gangs:getGraffitis', 1000)
    SetBlips()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    currentGang = {}
end)

AddEventHandler('esx:playerLoaded', function()
    currentGang = lib.callback.await('av_gangs:getData', 500)
    allGraffitis = lib.callback.await('av_gangs:getGraffitis', 1000)
    SetBlips()
end)

RegisterNetEvent('esx:onPlayerLogout',function()
	currentGang = {}
end)

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() == resourceName) then
    currentGang = lib.callback.await('av_gangs:getData', 500)
    allGraffitis = lib.callback.await('av_gangs:getGraffitis', 1000)
    SetBlips()
  end
end)

RegisterCommand(Gangs.CheckGang, function()
    if currentGang and currentGang['name'] then
        if currentGang['isBoss'] then
            TriggerEvent('av_laptop:notification', currentGang['label'], Lang['boss_status'])
        else
            TriggerEvent('av_laptop:notification', currentGang['label'], Lang['member_status'])
        end
    else
        TriggerEvent('av_laptop:notification', Lang['app_title'], Lang['not_gang_member'])
    end
end)

exports("getGang", function()
    return currentGang
end)

exports("getZone", function()
    return currentZone
end)

exports("myZone", function()
    if currentGang and currentGang.name then
        return (currentGang.name == currentZone)
    end
end)

