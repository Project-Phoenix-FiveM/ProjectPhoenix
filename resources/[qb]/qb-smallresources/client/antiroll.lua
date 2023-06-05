local listening = false
local vehicleClassDisableControl = {
    [0] = true, --compacts
    [1] = true, --sedans
    [2] = true, --SUV's
    [3] = true, --coupes
    [4] = true, --muscle
    [5] = true, --sport classic
    [6] = true, --sport
    [7] = true, --super
    [8] = false, --motorcycle
    [9] = true, --offroad
    [10] = true, --industrial
    [11] = true, --utility
    [12] = true, --vans
    [13] = false, --bicycles
    [14] = false, --boats
    [15] = false, --helicopter
    [16] = false, --plane
    [17] = true, --service
    [18] = true, --emergency
    [19] = false --military
}

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    listening = false
end)

RegisterNetEvent('QBCore:Client:VehicleInfo', function(data)
    if data.event == "Entered" then
        listening = true
        local vehicle = data.vehicle
        local vehicleClass = GetVehicleClass(vehicle)
        if ((data.seat == -1) and (vehicleClassDisableControl[vehicleClass])) then
            CreateThread(function()
                while listening do
                    if IsEntityInAir(vehicle) then
                        DisableControlAction(2, 59)
                        DisableControlAction(2, 60)
                    end
                    Wait(10)
                end
            end)
        end
    else
        listening = false
    end
end)