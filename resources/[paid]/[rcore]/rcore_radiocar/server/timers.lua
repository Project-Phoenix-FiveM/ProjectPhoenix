function updateSecondsInQueMusic()
    SetTimeout(1000, updateSecondsInQueMusic)
    DebugFunction("Start - updateSecondsInQueMusic")

    for plate, data in pairs(QueMusicCache) do
        for k, v in pairs(data) do
            if v.active and not v.ended and not v.fake and v.netID then
                if not v.time then
                    if v.timeStamp ~= nil then
                        v.time = v.timeStamp
                    end
                end
                if v.time then
                    v.time = v.time - 1
                    if v.time <= -5 then
                        v.active = false
                        v.ended = true
                        v.time = v.timeStamp

                        local index, data = GetFirstNonActiveIndex(QueMusicCache[plate])
                        if index then

                            data.active = true
                            QueMusicCache[plate][index].active = true

                            TriggerClientEvent("rcore_radiocar:updateQueUI", -1, v.netID, index)

                            local entity = NetworkGetEntityFromNetworkId(v.netID)
                            local pos = GetEntityCoords(entity)

                            addToCacheMusic({
                                idMusic = soundId .. v.netID,
                                time = 0,
                                car = v.netID,
                                url = data.url or data.URL,
                                pos = pos,
                                volume = (CachedVolumeMusic[v.netID] or Config.defaultVolume),
                            }, true)
                        end
                    end
                end
            end
        end
    end

    DebugFunction("End - updateSecondsInQueMusic")
end

SetTimeout(1000, updateSecondsInQueMusic)

function entityRemoved()
    SetTimeout(3000, entityRemoved)
    DebugFunction("Start - entityRemoved")

    local entity
    local found = false
    local toDestroy = {}
    for k, v in pairs(cachedCars) do
        entity = NetworkGetEntityFromNetworkId(v.car)
        if not DoesEntityExist(entity) then
            CachedVolumeMusic[v.car] = nil
            table.insert(toDestroy, { car = v.car, idMusic = v.idMusic })
            table.remove(cachedCars, k)

            found = true
        end
    end

    if not Config.DisableLoadingOfPlayList and Config.MysqlType ~= 0 then
        for key, val in pairs(QueMusicCache) do
            local carMissing = false
            if type(val) == "table" then
                for k, v in pairs(val) do
                    if v.netID then
                        if type(v.netID) == "number" then
                            entity = NetworkGetEntityFromNetworkId(v.netID)
                            if not DoesEntityExist(entity) then
                                carMissing = true
                            end
                        end
                    end
                end
            end

            if carMissing then
                SavePlayListForPlate(key)

                QueMusicCache[key] = nil
            end
        end
    end

    if found then
        TriggerClientEvent("rcore_radiocar:updateCache", -1, toDestroy)
    end

    DebugFunction("End - entityRemoved")
end

SetTimeout(3000, entityRemoved)

function addSeconds()
    SetTimeout(1000, addSeconds)
    for k, v in pairs(cachedCars) do
        if v.time == nil then
            v.time = 0
        end
        v.time = 1 + v.time
    end
end

SetTimeout(1000, addSeconds)