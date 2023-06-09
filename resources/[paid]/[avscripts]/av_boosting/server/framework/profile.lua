RegisterServerEvent('av_boosting:myProfile', function(data)
    local src = source
    local username = data[1]
    local photo = data[2]
    local identifier = exports['av_laptop']:getIdentifier(src)
    local profile = MySQL.query.await('SELECT * FROM av_boosting WHERE identifier = ?', {identifier})
    local updated = false
    if username and string.len(username) > 1 then
        username = username:gsub('[%p%c]', '')
        if string.len(username) <= Config.MaxUsernameCharacters then
            local exist = MySQL.query.await('SELECT * FROM av_boosting WHERE name = ?', {username})
            if exist and exist[1] then
                TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['already_registered'],"error")
                return
            else
                if profile[1] and profile[1]['name'] then
                    MySQL.update.await('UPDATE av_boosting SET name = ? WHERE identifier = ?', {username, identifier})
                else
                    MySQL.insert.await('INSERT INTO av_boosting (identifier, name, photo, level, hacks, deliveries, time) VALUES (?, ?, ?, ?, ?, ?, ?)', {identifier, username, Config.DefaultPicture, 0, 0, 0, 9999990000})
                end
                updated = true
            end
        else
            TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['too_long'],"error")
        end
    end
    if photo and string.len(photo) > 1 then
        if profile[1] and profile[1]['photo'] then
            MySQL.update.await('UPDATE av_boosting SET photo = ? WHERE identifier = ?', {photo, identifier})
        else
            if not profile[1] then
                if username and string.len(username) < 1 then
                    username = "User-"..math.random(11,9999)
                end
                MySQL.insert.await('INSERT INTO av_boosting (identifier, name, photo, level, hacks, deliveries, time) VALUES (?, ?, ?, ?, ?, ?, ?)', {identifier, username, photo, 0, 0, 0, 9999990000})
            end
        end
        updated = true
    end
    if updated then
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['profile_updated'],"success")
    end
end)