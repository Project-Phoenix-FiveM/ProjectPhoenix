Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        if IsPedUsingActionMode(ped) then
            SetPedUsingActionMode(ped, false, -1, 'DEFAULT_ACTION')
        end
    end
  end)
  
  Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        if IsPedUsingActionMode(ped) then
            SetPedUsingActionMode(ped, false, -1, 'DEFAULT_ACTION')
        end
        if IsPedUsingActionMode(ped) then
            SetPedUsingActionMode(ped, -1, -1, 1)
        end
    end
  end) 