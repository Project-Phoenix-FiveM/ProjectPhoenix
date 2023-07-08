RegisterNetEvent('qb-humanelabsheist:server:SmallLabChemicalsHit', function(index)
    if Shared.SmallLab[index].hit then return end
    Shared.SmallLab[index].hit = true
    TriggerClientEvent('qb-humanelabsheist:client:SmallLabChemicalsHit', -1, index)
end)

RegisterNetEvent('qb-humanelabsheist:server:SmallLabReward', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if type(index) ~= 'number' then exports['qb-core']:ExploitBan(src, 'hlabsheist-smalllabreward') return end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.SmallLab[index].coords) > 15 then exports['qb-core']:ExploitBan(src, 'hlabsheist-smalllabreward') return end

    exports['qb-inventory']:AddItem(src, "hlabs_chemicals", 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['hlabs_chemicals'], "add", 1)
    TriggerEvent("qb-log:server:CreateLog", "humanelabs", "Small Lab", "green", "**".. Player.PlayerData.name .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*)"..' has received 1x '..QBCore.Shared.Items['hlabs_chemicals'].label)
end)

RegisterNetEvent('qb-humanelabsheist:server:CleanMoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local item = exports['qb-inventory']:GetItemByName(src, "markedbills")
    local chems = exports['qb-inventory']:GetItemByName(src, "hlabs_chemicals")
    if item and chems then
        local worth = item.info.worth

        exports['qb-inventory']:RemoveItem(src, 'markedbills', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["markedbills"], "remove", 1)
        Wait(250)

        exports['qb-inventory']:RemoveItem(src, 'hlabs_chemicals', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["hlabs_chemicals"], "remove", 1)
        Wait(250)

        Player.Functions.AddMoney('cash', worth)
        TriggerClientEvent('QBCore:Notify', src, "You removed the red dye from the bank notes!", "success", 2500)
    end
end)

QBCore.Functions.CreateUseableItem("hlabs_formula", function(source, item)
    TriggerClientEvent("qb-humanelabsheist:client:UseSecretFormula", source)
end)

QBCore.Functions.CreateUseableItem("hlabs_chemicals", function(source, item)
    TriggerClientEvent("qb-humanelabsheist:client:UseChemicals", source)
end)
