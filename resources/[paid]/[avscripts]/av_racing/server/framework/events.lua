RegisterServerEvent("av_racing:createCircuit", function(data)
    local src = source
    if not CanCreateTracks(src) then return end -- Just an extra check
    local createdby = exports['av_laptop']:getIdentifier(src)
    local identifier = string.lower(data.RaceName)
    identifier = string.gsub(identifier, "%s+", "")
    local checkpoints = json.encode(data['Checkpoints'])
    MySQL.insert('INSERT INTO av_racing (name, identifier, checkpoints, createdby, distance, description) VALUES (?, ?, ?, ?, ?, ?)', 
    {data.RaceName, identifier, checkpoints, createdby, data["RaceDistance"], data["RaceDescription"]}, function(saved)
        if saved then
            TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['saved'])
        end
    end)
end)

RegisterServerEvent('av_racing:myProfile', function(data)
    local src = source
    local username = data[1] or "User-"..math.random(11,9999)
    local photo = data[2]
    local identifier = exports['av_laptop']:getIdentifier(src)
    local profile = MySQL.query.await('SELECT * FROM av_boosting WHERE identifier = ?', {identifier})
    local updated = false
    if username then
        username = username:gsub('[%p%c]', '')
        if string.len(username) <= Config.MaxUsernameCharacters then
            local exist = MySQL.query.await('SELECT * FROM av_boosting WHERE name = ?', {username})
            if exist and exist[1] then
                TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['already_registered'],"error")
                return
            else
                if profile and profile[1] then
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
    if photo then
        if profile and profile[1] then
            MySQL.update.await('UPDATE av_boosting SET photo = ? WHERE identifier = ?', {photo, identifier})
        else
            MySQL.insert.await('INSERT INTO av_boosting (identifier, name, photo, level, hacks, deliveries, time) VALUES (?, ?, ?, ?, ?, ?, ?)', {identifier, username, photo, 0, 0, 0, 9999990000})
        end
        updated = true
    end
    if updated then
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['profile_updated'],"success")
    end
end)