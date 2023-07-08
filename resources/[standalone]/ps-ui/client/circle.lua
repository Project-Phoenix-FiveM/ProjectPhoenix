local p = nil

local function Circle(cb, circles, seconds)
    if circles == nil or circles < 1 then circles = 1 end
    if seconds == nil or seconds < 1 then seconds = 10 end
    p = promise.new()
    SendNUIMessage({
        action = 'circle-start',
        circles = circles,
		time = seconds,
    })
    SetNuiFocus(true, true)
    local result = Citizen.Await(p)
    cb(result)
end
exports("Circle", Circle)

RegisterNUICallback('circle-fail', function(data, cb)
    p:resolve(false)
    p = nil
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('circle-success', function(data, cb)
    p:resolve(true)
    p = nil
    SetNuiFocus(false, false)
    cb('ok')
end)