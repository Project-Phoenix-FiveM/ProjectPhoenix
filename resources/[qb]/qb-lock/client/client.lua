local QBCore = exports['qb-core']:GetCoreObject()
local Result = nil
local NUI_status = false

RegisterNetEvent('kwk-lockpick:client:openLockpick', function(callback, circles)
    lockpickCallback = callback
    exports['qb-lock']:StartLockPickCircle(total,circles) 
end)

function StartLockPickCircle(circles, seconds, callback)
    Result = nil
	print(circles, "This be the lock")
    NUI_status = true
    SendNUIMessage({
        action = 'start',
        value = circles,
		time = seconds,
    })
    while NUI_status do
        Wait(5)
        SetNuiFocus(NUI_status, false)
    end
    Wait(100)
    SetNuiFocus(false, false)
    lockpickCallback = callback
    return Result
end

RegisterNUICallback('fail', function()
        ClearPedTasks(PlayerPedId())
        Result = false
        Wait(100)
        NUI_status = false
        --print('fail')
end)

RegisterNUICallback('success', function()
	Result = true
	Wait(100)
	NUI_status = false
    SetNuiFocus(false, false)
    print(Result)
    return Result
end)
