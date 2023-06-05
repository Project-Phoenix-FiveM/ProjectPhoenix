local function SetDisplay(bool, img)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "showImage",
        image = img,
        status = bool,
    })
end

local function ShowImage(img)
    SetDisplay(true, img)
end

RegisterNUICallback("showItemImage-callback", function(data, cb)
    SetDisplay(false)
    cb('ok')
end)

exports("ShowImage", ShowImage)