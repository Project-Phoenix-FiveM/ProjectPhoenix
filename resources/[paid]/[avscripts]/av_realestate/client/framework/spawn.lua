RegisterNetEvent('av_realestate:spawnInMotel', function(data,isOwner)
    DoScreenFadeOut(10)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    local entry = json.decode(data['entrance'])
    SetEntityCoords(PlayerPedId(), entry.x, entry.y, entry.z)
    Wait(2000)
    if isOwner then
        EnterMotel(data,isOwner)
    else
        SetEntityCoords(PlayerPedId(), entry.x, entry.y, entry.z)
        SetEntityHeading(PlayerPedId(), entry.h)
        Wait(500)
        DoScreenFadeIn(150)
    end
end)