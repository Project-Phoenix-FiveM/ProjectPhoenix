function equals(o1, o2, ignore_mt)
    if o1 == o2 then
        return true
    end
    local o1Type = type(o1)
    local o2Type = type(o2)
    if o1Type ~= o2Type then
        return false
    end
    if o1Type ~= 'table' then
        return false
    end

    if not ignore_mt then
        local mt1 = getmetatable(o1)
        if mt1 and mt1.__eq then
            --compare using built in method
            return o1 == o2
        end
    end

    local keySet = {}

    for key1, value1 in pairs(o1) do
        local value2 = o2[key1]
        if value2 == nil or equals(value1, value2, ignore_mt) == false then
            return false
        end
        keySet[key1] = true
    end

    for key2, _ in pairs(o2) do
        if not keySet[key2] then
            return false
        end
    end
    return true
end

function SavePlatePlayList(plate, existingPlates)
    local playlist = QueMusicCache[plate]

    if playlist then

        if existingPlates[plate] then
            if existingPlates[plate].table then
                for k, v in pairs(existingPlates[plate].table) do
                    v.netID = nil
                end
            end
        end

        for k, v in pairs(playlist) do
            v.netID = nil
        end

        if existingPlates[plate] then

            if not equals(existingPlates[plate].table, QueMusicCache[plate]) then
                MySQLSyncexecute('UPDATE radiocar_playlist SET playlist = @playlist WHERE plate = @plate',
                        {
                            ['@plate'] = plate,
                            ['@playlist'] = json.encode(playlist),
                        })
            end
        else
            MySQLSyncexecute("INSERT INTO radiocar_playlist (plate, playlist) VALUES (@plate, @playlist)",
                    {
                        ['@plate'] = plate,
                        ['@playlist'] = json.encode(playlist),
                    })
        end
    end
end

if not Config.DisableLoadingOfPlayList and Config.MysqlType ~= 0 then
    function SaveAllPlayListCached()
        SetTimeout(Config.AutoSaveInterval or 1000 * 60 * 15, SaveAllPlayListCached)
        local result = MySQLSyncfetchAll("SELECT * FROM `radiocar_playlist`", { })
        local existingPlates = {}

        for k, v in pairs(result) do
            existingPlates[v.plate] = {
                table = json.decode(v.playlist),
            }
        end

        for k, v in pairs(QueMusicCache) do
            SavePlatePlayList(k, existingPlates)
        end
    end

    SetTimeout(Config.AutoSaveInterval or 1000 * 60 * 15, SaveAllPlayListCached)
end

function SavePlayListForPlate(plate)
    local result = MySQLSyncfetchAll("SELECT * FROM radiocar_playlist", { })
    local existingPlates = {}

    for k, v in pairs(result) do
        existingPlates[v.plate] = {
            table = json.decode(v.playlist),
        }
    end

    SavePlatePlayList(plate, existingPlates)
end