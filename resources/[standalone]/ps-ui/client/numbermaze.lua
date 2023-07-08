local open = false

RegisterNUICallback('maze-callback', function(data, cb)
	SetNuiFocus(false, false)
    Callback(data.success)
    open = false
    cb('ok')
end)

local function Maze(callback, speed)
    if speed == nil then speed = 10 end
    if not open then
        Callback = callback
        open = true
        SendNUIMessage({
            action = "maze-start",
            speed = speed,
        })
        SetNuiFocus(true, true)
    end
end

exports("Maze", Maze)
