RegisterNetEvent("rcore_itemradio:fetchLicensePlate", function(install)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if DoesEntityExist(vehicle) then
        TriggerServerEvent("rcore_itemradio:sendLicensePlate", install)
    end
end)

function showHelpNotification(text)
    BeginTextCommandDisplayHelp("THREESTRINGS")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, 5000)
end

RegisterNetEvent("rcore_itemradio:showNotification", showHelpNotification)