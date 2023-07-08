-- We will preload ESX module into local variable
if Config.FrameWork == "1" then
    ESX = GetEsxObject()
end

if Config.ox_inv then
    exports(Config.ItemRemover, function(event, item, inventory, slot, data)
        TriggerClientEvent("rcore_itemradio:fetchLicensePlate", inventory.id, false)
    end)

    exports(Config.ItemAdder, function(event, item, inventory, slot, data)
        TriggerClientEvent("rcore_itemradio:fetchLicensePlate", inventory.id, true)
    end)
else
    ESX.RegisterUsableItem(Config.ItemRemover, function(source)
        TriggerClientEvent("rcore_itemradio:fetchLicensePlate", source, false)
    end)

    ESX.RegisterUsableItem(Config.ItemAdder, function(source)
        TriggerClientEvent("rcore_itemradio:fetchLicensePlate", source, true)
    end)
end

function GetVehPlate(source)
    return GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(source)))
end

function IsPedInAnyVehicle(source)
    return GetVehiclePedIsIn(GetPlayerPed(source), false) ~= 0
end

RegisterNetEvent("rcore_itemradio:sendLicensePlate", function(install)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not IsPedInAnyVehicle(source) then
        return
    end

    local plate = GetVehPlate(source)

    if install then
        if xPlayer.getInventoryItem(Config.ItemAdder).count ~= 0 or Config.ox_inv then
            if not exports.rcore_radiocar:HasCarRadio(plate) then
                if not Config.ox_inv then
                    xPlayer.removeInventoryItem(Config.ItemAdder, 1)
                end

                exports.rcore_radiocar:GiveRadioToCar(plate)
                TriggerClientEvent("rcore_itemradio:showNotification", source, "Your vehicle has now a radio! Enjoy it!")
            else
                TriggerClientEvent("rcore_itemradio:showNotification", source, "Dont be silly, your vehicle already has a radio. :D")
            end
        end
    else
        if xPlayer.getInventoryItem(Config.ItemRemover).count ~= 0 or Config.ox_inv then
            if exports.rcore_radiocar:HasCarRadio(plate) then
                if not Config.ox_inv then
                    xPlayer.removeInventoryItem(Config.ItemRemover, 1)
                end

                xPlayer.addInventoryItem(Config.ItemAdder, 1)
                exports.rcore_radiocar:RemoveRadioFromCar(plate)
                TriggerClientEvent("rcore_itemradio:showNotification", source, "You removed the radio from this vehicle")
            else
                TriggerClientEvent("rcore_itemradio:showNotification", source, "Dude no no no, this vehicle does not have any radio!")
            end
        end
    end
end)