function RegisterTargetMotel(name, coords, isDoor, data, isOwner, isCop)
    local options = {}
    if isDoor then
        if isOwner or isCop then
            options[#options+1] = {
                type = "client",
                event = "av_realestate:motelDoor",
                icon = Config.Icons['door'],
                label = Lang['door'],
                property = data,
            }
        end
        options[#options+1] = {
            type = "client",
            event = "av_realestate:exit",
            icon = Config.Icons['exit'],
            label = Lang['exit'],
            property = data,
        }
        if Config.LogoutMotel and isOwner then
            options[#options+1] = {
                type = "client",
                event = "av_realestate:logout",
                icon = Config.Icons['logout'],
                label = Lang['logout']
            }
        end
    else
        options[#options+1] = {
            type = "client",
            event = "av_realestate:openInventory",
            icon = Config.Icons['inventory'],
            label = Lang['stash'],
            property = data
        }
        if Config.EnableClothing then
            options[#options+1] = {
                type = "client",
                event = "av_realestate:openClothing",
                icon = Config.Icons['clothing'],
                label = Lang['clothing'],
            }
        end
    end
    exports[Config.TargetSystem]:AddBoxZone(name, vector3(coords.x, coords.y, coords.z), 0.75, 1.25, {
        name = name,
        heading = coords.h,
        debugPoly = false,
        minZ = coords.z - 0.25,
        maxZ = coords.z + 0.5,
    }, {
        options = options,
        distance = 2.5
    })
end