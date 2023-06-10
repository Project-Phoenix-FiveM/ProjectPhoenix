function CanCreateTracks(src) -- Player can create new tracks
    local permission = false
    permission = exports['av_laptop']:getPermission(src,Config.AdminLevel)
    return permission
end

function CanCreateRaces(src) -- Player can create new events (races)
    local permission = false
    permission = exports['av_laptop']:getPermission(src,Config.AdminLevel)
    return permission
end

function CanDeleteTracks(src) -- Player can delete tracks
    local permission = false
    permission = exports['av_laptop']:getPermission(src,Config.AdminLevel)
    return permission
end