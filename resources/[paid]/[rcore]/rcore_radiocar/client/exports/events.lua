function onPlayStart(name, delegate)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:onPlayStart(name, delegate)
        return
    end
    if globalOptionsCache[name] then
        globalOptionsCache[name].onPlayStart = delegate
    end
end

function onPlayEnd(name, delegate)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:onPlayEnd(name, delegate)
        return
    end
    globalOptionsCache[name].onPlayEnd = delegate
end

function onLoading(name, delegate)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:onLoading(name, delegate)
        return
    end
    globalOptionsCache[name].onLoading = delegate
end

function onPlayPause(name, delegate)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:onPlayPause(name, delegate)
        return
    end
    globalOptionsCache[name].onPlayPause = delegate
end

function onPlayResume(name, delegate)
    if Config.UseHighSound then
        name_ = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:onPlayResume(name, delegate)
        return
    end
    globalOptionsCache[name].onPlayResume = delegate
end