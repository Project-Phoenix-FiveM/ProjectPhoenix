RegisterNetEvent('var-ui:on', function(message)
    SetNuiFocus(true,false)
    SendNUIMessage({
        type = "ui",
        display = true,
        text = message
    })
end)

RegisterNetEvent('var-ui:off', function()
    SendNUIMessage({
        type = "ui",
        display = false,
    })
end)

RegisterNUICallback('esc', function(data, cb)
    SetNuiFocus(false, false)
end)