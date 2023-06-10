local blips = {}

RegisterNetEvent('av_boosting:getBlips', function(coords,plates)
    if not isCop() then return end
    if blips[plates] then
        if DoesBlipExist(blips[plates]) then
            RemoveBlip(blips[plates])
        end
    end
    blips[plates] = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blips[plates], 225)
    SetBlipHighDetail(blips[plates], true)
    SetBlipColour(blips[plates], 1)
    SetBlipAlpha(blips[plates], 200)
    SetBlipAsShortRange(blips[plates], true)
end)

RegisterNetEvent('av_boosting:deleteBlip', function(plates)
    if not isCop() then return end
    if not blips[plates] then return end
    if blips[plates] then
        if DoesBlipExist(blips[plates]) then
            RemoveBlip(blips[plates])
        end
    end
    blips[plates] = nil
end)