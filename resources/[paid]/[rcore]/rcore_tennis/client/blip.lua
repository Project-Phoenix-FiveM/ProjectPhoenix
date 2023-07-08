local blips = {}

CreateThread(function()
    AddTextEntry('R_TEN_BL', Config.Translation.BLIP or 'Tennis')
    for _, tennisCourt in pairs(TennisCourts) do
        if tennisCourt.showBlip then
            local blip = AddBlipForCoord(tennisCourt.courtCenter.x, tennisCourt.courtCenter.y, tennisCourt.courtCenter.z)

            SetBlipDisplay(blip, 4)
            SetBlipSprite(blip, 122)
            SetBlipColour(blip, 0)
            SetBlipScale(blip, 0.5)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('R_TEN_BL')
            EndTextCommandSetBlipName(blip)

            table.insert(blips, blip)
        end
    end
end)

AddEventHandler('onResourceStop', function(name)
    if GetCurrentResourceName() == name then
        for _, b in pairs(blips) do
            RemoveBlip(b)
        end
    end
end)
