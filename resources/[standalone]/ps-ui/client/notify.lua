local function Notify(text, type, length)
    type = type or 'primary'
    length = length or 5000
    SendNUIMessage({
        notify = true,
		text = text,
        type = type,
		length = length
	})
end
exports('Notify', Notify)
RegisterNetEvent(("%s:Notify"):format(GetCurrentResourceName()), Notify)