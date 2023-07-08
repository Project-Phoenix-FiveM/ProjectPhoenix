local Promise, KeyboardActive = nil, false

RegisterNUICallback("dataPost", function(data, cb)
    Promise:resolve(data.data)
    Promise = nil
    CloseKeyboard()
    cb("ok")
end)

RegisterNUICallback("cancel", function(data, cb)
    Promise:resolve(nil)
    Promise = nil
    CloseKeyboard()
    cb("ok")
end)

Keyboard = function(data)
    if not data or Promise then return end
    while KeyboardActive do Wait(0) end
    Promise = promise.new()
    OpenKeyboard(data)
    local keyboard = Citizen.Await(Promise)
    return keyboard and true or false, UnpackInput(keyboard)
end

UnpackInput = function(kb, i)
    if not kb then return end
    local index = i or 1
    
    if index <= #kb then
        return kb[index].input, UnpackInput(kb, index + 1)
    end
end

OpenKeyboard = function(data)
    KeyboardActive = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN",
        data = data
    })
end

CloseKeyboard = function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "CLOSE",
    })
    KeyboardActive = false
end

CancelKeyboard = function()
    SendNUIMessage({
        action = "CANCEL"
    })
end

exports("Keyboard", Keyboard)
exports("CancelKeyboard", CancelKeyboard)
