local disableShuffle = true

RegisterNetEvent('QBCore:Client:EnteredVehicle', function(data)
    local sleep
    local ped = PlayerPedId()
    while IsPedInAnyVehicle(ped, false) do
        sleep = 100
        if IsPedInAnyVehicle(ped, false) and disableShuffle then
            if GetPedInVehicleSeat(data.vehicle, 0) == ped then
                if GetIsTaskActive(ped, 165) then
                    sleep = 0
                    SetPedIntoVehicle(ped, data.vehicle, 0)
                    SetPedConfigFlag(ped, 184, true)
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('SeatShuffle', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        disableShuffle = false
        SetPedConfigFlag(ped, 184, false)
        Wait(3000)
        disableShuffle = true
    else
        CancelEvent()
    end
end)

RegisterCommand("shuff", function()
    TriggerEvent("SeatShuffle")
end, false)
