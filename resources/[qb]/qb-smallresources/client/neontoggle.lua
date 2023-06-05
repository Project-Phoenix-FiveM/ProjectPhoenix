RegisterCommand("toggleNeon", function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local driver  = GetPedInVehicleSeat(vehicle, -1)
    local neonEnabled = IsVehicleNeonLightEnabled(vehicle, 0), IsVehicleNeonLightEnabled(vehicle, 1), IsVehicleNeonLightEnabled(vehicle, 2), IsVehicleNeonLightEnabled(vehicle, 3)

    if IsPedInVehicle(ped,vehicle, true) and driver == ped then
        if neonEnabled then 
            toggleNeon(false)
        else
            toggleNeon(true)
        end
    end
end)

function toggleNeon(bool)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local activeNeon = {}
    for i = 0,3 do
        activeNeon[i] = SetVehicleNeonLightEnabled(vehicle, i, bool)
    end
end

RegisterKeyMapping('toggleNeon', 'Toggle Neon', 'keyboard', 'Y')