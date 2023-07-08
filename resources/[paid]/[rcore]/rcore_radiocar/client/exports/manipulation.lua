function Distance(name, distance_)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:Distance(name, distance_)
        return
    end
	if soundInfo[name] then
		SendNUIMessage({
			type = "distance",
			name = name,
			distance = distance_,
		})
		
		soundInfo[name].distance = distance_
	end
end

function Position(name, pos)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:Position(name, pos)
        return
    end

    SendNUIMessage({
        type = "soundPosition",
        name = name,
        x = pos.x,
        y = pos.y,
        z = pos.z,
    })
    soundInfo[name].position = pos
    soundInfo[name].id = name
end

function Destroy(name)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:Destroy(name)
        return
    end
    SendNUIMessage({
        type = "delete",
        name = name
    })
    soundInfo[name] = nil

    if globalOptionsCache[name] ~= nil and globalOptionsCache[name].onPlayEnd ~= nil then
        globalOptionsCache[name].onPlayEnd(getInfo(name))
    end

    globalOptionsCache[name] = nil
end

function DestroySilent(name)
    SendNUIMessage({
        type = "delete",
        name = name
    })
end

function Resume(name)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:Resume(name)
        return
    end
    SendNUIMessage({
        type = "resume",
        name = name
    })
    soundInfo[name].playing = true
    soundInfo[name].paused = false

    if globalOptionsCache[name] ~= nil and globalOptionsCache[name].onPlayResume ~= nil then
        globalOptionsCache[name].onPlayResume(getInfo(name))
    end
end

function Pause(name)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:Pause(name)
        return
    end
    SendNUIMessage({
        type = "pause",
        name = name
    })
    soundInfo[name].playing = false
    soundInfo[name].paused = true

    if globalOptionsCache[name] ~= nil and globalOptionsCache[name].onPlayPause ~= nil then
        globalOptionsCache[name].onPlayPause(getInfo(name))
    end
end

function setVolume(name, vol)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:setVolume(name, vol)
        return
    end
    SendNUIMessage({
        type = "volume",
        volume = vol,
        name = name,
    })
    soundInfo[name].volume = vol
end

function setVolumeMax(name, vol)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:setVolumeMax(name, vol)
        return
    end
    SendNUIMessage({
        type = "max_volume",
        volume = vol,
        name = name,
    })
    soundInfo[name].volume = vol
end

function setTimeStamp(name, timestamp)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:setTimeStamp(name, timestamp)
        return
    end
    getInfo(name).timeStamp = timestamp
    SendNUIMessage({
        name = name,
        type = "timestamp",
        timestamp = timestamp,
    })
end

function destroyOnFinish(id, bool)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:destroyOnFinish(id, bool)
        return
    end
    soundInfo[id].destroyOnFinish = bool
end

function setSoundLoop(name, value)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:setSoundLoop(name, value)
        return
    end
    SendNUIMessage({
        type = "loop",
        name = name,
        loop = value,
    })
    soundInfo[name].loop = value
end

function repeatSound(name)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:repeatSound(name)
        return
    end
    if soundExists(name) then
        SendNUIMessage({
            type = "repeat",
            name = name,
        })
    end
end

function setSoundDynamic(name, bool)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:setSoundDynamic(name, bool)
        return
    end
    if soundExists(name) then
        soundInfo[name].isDynamic = bool
        SendNUIMessage({
            type = "changedynamic",
            name = name,
            bool = bool,
        })
    end
end

function setSoundURL(name, url)
    if Config.UseHighSound then
        name = name:gsub("car_entity_", "")
        name = tonumber(name)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:setSoundURL(name, url)
        return
    end
    if soundExists(name) then
        soundInfo[name].url = url
        SendNUIMessage({
            type = "changeurl",
            name = name,
            url = url,
        })
    end
end