QBCore = exports['qb-core']:GetCoreObject()
FullyLoaded = QBCore and LocalPlayer.state.isLoggedIn

AddStateBagChangeHandler('isLoggedIn', nil, function(_, _, value)
    FullyLoaded = value
end)

local function initalizeBanking()
    CreatePeds()
    local locales = lib.getLocales()
    SendNUIMessage({
        action = 'updateLocale',
        translations = locales,
        currency = Config.currency
    })
end
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Wait(100)
    initalizeBanking()
end)

AddEventHandler('onResourceStart', function(resourceName)
    Wait(100)
    if resourceName ~= GetCurrentResourceName() then return end
    if not FullyLoaded then return end
    initalizeBanking()
end)


AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    DeletePeds()
end)
