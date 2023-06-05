local Text = ""
local Color = "primary"

exports("DisplayText", function(text, color)
    if text == nil then Text = "" else Text = text end
    if color ==  nil then Color = "primary" else Color = color end
    SendNUIMessage({
        action = "display",
        text = Text,
        color = Color,
    })
end)

exports("HideText", function()
    Text = ""
    Color = "primary"
    SendNUIMessage({
        action = "hide",
    })
end)

exports("UpdateText", function(text)
    if text == nil then Text = "" else Text = text end
    SendNUIMessage({
        action = "update",
        text = Text,
    })
end)



