exports("hasItem", function(name,amount)
    return lib.callback.await('av_laptop:getItem', false, name, amount)
end)

exports("removeItem", function(name,amount)
    return lib.callback.await('av_laptop:removeItem', false, name, amount)
end)

exports("alertCops", function(message)
    local coords = GetEntityCoords(PlayerPedId())
    -- Add your own dispatch event here
    TriggerServerEvent("av_laptop:alertCops",message,coords)
end)

exports("getJob", function()
    return PlayerJob
end)