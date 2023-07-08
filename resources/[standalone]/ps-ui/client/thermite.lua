local open = false
local p = nil

RegisterNUICallback('thermite-callback', function(data, cb)
	SetNuiFocus(false, false)
    p:resolve(data.success)
    p = nil
    open = false
    cb('ok')
end)

local function Thermite(cb, time, gridsize, wrong)
    if not open then
        p = promise.new()
        if time == nil then time = 10 end
        if gridsize == nil then gridsize = 6 end
        if wrong == nil then wrong = 3 end
        open = true
        SendNUIMessage({
            action = "thermite-start",
            time = time,
            gridsize = gridsize,
            wrong = wrong,
        })
        SetNuiFocus(true, true)
        local result = Citizen.Await(p)
        cb(result)
    end
end

exports("Thermite", Thermite)