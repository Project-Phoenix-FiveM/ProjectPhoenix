local Promise = nil
local open = false

RegisterNUICallback('callback', function(data, cb)
    SetNuiFocus(false, false)
    Promise:resolve(data.success)
    Promise = nil
    open = false
    cb('ok')
end)

local function OpenHackingGame(callback, speed)
    if Promise then return end
    while open do Wait(0) end
    Promise = promise.new()

    open = true
    SendNUIMessage({
        type = "open",
        speed = speed
    })
    SetNuiFocus(true, true)
    callback(Citizen.Await(Promise))
end

exports("OpenHackingGame", OpenHackingGame)