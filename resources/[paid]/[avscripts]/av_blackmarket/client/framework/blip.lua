RegisterNetEvent('av_blackmarket:setGPS', function()
    local delivery = AddBlipForCoord(Market.BlipCoords[1], Market.BlipCoords[2], Market.BlipCoords[3])
    SetBlipSprite(delivery, Market.BlipIcon)
    SetBlipScale(delivery, Market.BlipScale)
    SetBlipDisplay(delivery, 4)
    SetBlipColour(delivery, Market.BlipColor)
    SetBlipAsShortRange(delivery, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Lang['blip_text'])
    EndTextCommandSetBlipName(delivery)
end)