RegisterNUICallback("data_status", function(data, cb)
    if soundInfo[data.id] ~= nil then
        if data.type == "finished" then
            if not soundInfo[data.id].loop then
                soundInfo[data.id].playing = false
            end
        end
        if data.type == "maxDuration" then
            if not soundInfo[data.id].skipTimestamp then
                soundInfo[data.id].timeStamp = 0
            end

            soundInfo[data.id].maxDuration = data.time
            soundInfo[data.id].skipTimestamp = nil
        end
    end

    if cb then cb('ok') end
end)

RegisterNUICallback("events", function(data, cb)
    local id = data.id
    local type = data.type
    if type == "resetTimeStamp" then
        if soundInfo[id] then
            soundInfo[id].timeStamp = 0
            soundInfo[id].maxDuration = data.time
            soundInfo[id].playing = true
        end
    end
    if type == "onPlay" then
        if globalOptionsCache[id] then
            if globalOptionsCache[id].onPlayStart then
                globalOptionsCache[id].onPlayStart(getInfo(id))
            end
        end
    end
    if type == "onEnd" then
        if globalOptionsCache[id] then
            if globalOptionsCache[id].onPlayEnd then
                globalOptionsCache[id].onPlayEnd(getInfo(id))
            end
        end
        if soundInfo[id] then
            if soundInfo[id].loop then
                soundInfo[id].timeStamp = 0
            end
            if soundInfo[id].destroyOnFinish and not soundInfo[id].loop and not soundInfo[id].maxDuration ~= 0 then
                Destroy(id)
            end
        end
    end
    if type == "onLoading" then
        if globalOptionsCache[id] then
            if globalOptionsCache[id].onLoading then
                globalOptionsCache[id].onLoading(getInfo(id))
            end
        end
    end

    if cb then cb('ok') end
end)