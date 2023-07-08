local function SetWeaponSeries()
    for k, v in pairs(Config.Armory.items) do
        if v.type == 'weapon' then
            v.info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
        end
    end
end

RegisterNetEvent('qb-jail:client:Armory', function()
    if PlayerData.job.type ~= "police" then return end -- if PlayerData.job.name ~= "police" then return end
    SetWeaponSeries()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", Config.Armory)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('jail_lockerroom', vector3(1833.18, 2571.81, 46.01), 3.0, 0.6, {
        name = 'jail_lockerroom',
        heading = 0,
        debugPoly = false,
        minZ = 45.01,
        maxZ = 46.81
    }, {
        options = { 
            {
                type = 'client',
                event = 'qb-clothing:client:openOutfitMenu',
                icon = 'fas fa-shirt',
                label = 'Outfits',
                job = {
                    ["police"] = 0,
                    ["lspd"] = 0,
                    ["bcso"] = 0,
                    ["sapr"] = 0,
                    ["sasp"] = 0
                }
            },
            {
                type = 'client',
                event = 'qb-jail:client:Armory',
                icon = 'fas fa-hand-holding',
                label = 'Open Armory',
                job = {
                    ["police"] = 0,
                    ["lspd"] = 0,
                    ["bcso"] = 0,
                    ["sapr"] = 0,
                    ["sasp"] = 0
                }
            }
        },
        distance = 1.5,
    })
end)