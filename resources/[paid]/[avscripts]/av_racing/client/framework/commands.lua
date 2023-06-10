if Config.ClassCommand then
    RegisterCommand(Config.ClassCommand, function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
        if vehicle and vehicle ~= 0 then
            local class = getClass(vehicle)
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['veh_class'].." "..class)
        end
    end)
end