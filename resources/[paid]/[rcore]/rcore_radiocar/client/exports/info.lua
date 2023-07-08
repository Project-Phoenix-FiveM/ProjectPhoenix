soundInfo = {}

function getLink(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:getLink(name_)
    end
    return soundInfo[name_].url
end

function getPosition(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:getPosition(name_)
    end
    return soundInfo[name_].position
end

function isLooped(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:isLooped(name_)
    end
    return soundInfo[name_].loop
end

function getInfo(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:getInfo(name_)
    end
    return soundInfo[name_]
end

function soundExists(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:soundExists(name_)
    end
    return soundInfo[name_] ~= nil
end

function isPlaying(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:isPlaying(name_)
    end
    return soundInfo[name_].playing
end

function isPaused(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:isPaused(name_)
    end
    return soundInfo[name_].paused
end

function getDistance(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:getDistance(name_)
    end
    return soundInfo[name_].distance
end

function getVolume(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:getVolume(name_)
    end
    if not soundInfo[name_] then
        return 0
    end
    return soundInfo[name_].volume
end

function isDynamic(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:isDynamic(name_)
    end
    return soundInfo[name_].isDynamic
end

function getTimeStamp(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:getTimeStamp(name_)
    end
    return soundInfo[name_].timeStamp or -1
end

function getMaxDuration(name_)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:getMaxDuration(name_)
    end
    return soundInfo[name_].maxDuration or -1
end

function isPlayerInStreamerMode()
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:isPlayerInStreamerMode()
    end
    return disableMusic
end

function getAllAudioInfo()
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:getAllAudioInfo()
    end
    return soundInfo
end

function isPlayerCloseToAnySound()
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        return exports[Config.xSoundName]:isPlayerCloseToAnySound()
    end
    return isPlayerCloseToMusic
end