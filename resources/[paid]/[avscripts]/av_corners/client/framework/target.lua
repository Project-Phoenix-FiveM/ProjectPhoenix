local drugOptions = {}
CreateThread(function()
    for k, v in pairs(Corners.Drugs) do
        drugOptions[#drugOptions+1] = {
            name = k,
            type = "client",
            event = "av_corners:sell",
            icon = v['icon'],
            label = Lang['sell']..' '..v['label'],
            canInteract = function(entity)
                if canSell then return false end
                if IsEntityAVehicle(entity) and not Corners.BlacklistedClasses[GetVehicleClass(entity)] then
                    return exports['av_laptop']:hasItem(k)
                end
                return false
            end,
        }
    end
    exports[Corners.TargetSystem]:AddTargetBone('boot', {
        options = drugOptions,
        distance = 2.5,
    })
    exports[Corners.TargetSystem]:AddTargetBone('boot', {
        options = {
            {
                type = "client",
                event = "av_corners:stop",
                icon = 'fas fa-ban',
                label = Lang['stop'],
                canInteract = function(entity)
                    return canSell
                end,
            }
        },
        distance = 2.0,
    })
end)