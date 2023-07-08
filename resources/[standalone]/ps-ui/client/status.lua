local function StatusShow(title, values)
    SendNUIMessage({
        action = "status",
        show = true,
        title = title,
        values = values,
    })
end

local function StatusHide()
    SendNUIMessage({
        action = "status",
        show = false,
    })
end

local function StatusUpdate(title, values)
    SendNUIMessage({
        action = "status",
        update = true,
        title = title,
        values = values,
    })
end

exports("StatusShow", StatusShow)
exports("StatusHide", StatusHide)
exports("StatusUpdate", StatusUpdate)