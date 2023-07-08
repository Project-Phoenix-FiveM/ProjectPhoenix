function PlayUrl(name_, url_, volume_, loop_, options)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:PlayUrl(name_, url_, volume_, loop_, options)
        return
    end
    if disableMusic then
        return
    end
    SendNUIMessage({
        type = "url",
        name = name_,
        url = url_,
        x = 0,
        y = 0,
        z = 0,
        dynamic = false,
        volume = volume_,
        loop = loop_ or false,
    })

    if soundInfo[name_] == nil then
        soundInfo[name_] = getDefaultInfo()
    end

    soundInfo[name_].volume = volume_
    soundInfo[name_].url = url_
    soundInfo[name_].id = name_
    soundInfo[name_].playing = true
    soundInfo[name_].loop = loop_ or false
    soundInfo[name_].isDynamic = false

    globalOptionsCache[name_] = options or {}
end

function PlayUrlPos(name_, url_, volume_, pos, loop_, options)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        local netEntity = tonumber(name_)

        if soundExists(name_) then
            Destroy(name_)
        end

        exports[Config.xSoundName]:Play3DEntity(
                netEntity,
                Config.DistancePlayingWindowsOpen,
                url_,
                volume_,
                false
        )
        return
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:PlayUrlPos(name_, url_, volume_, pos, loop_, options)
        return
    end
    if disableMusic then
        return
    end

    if soundInfo[name_] == nil then
        soundInfo[name_] = getDefaultInfo()
    end

    if #(pos - GetEntityCoords(PlayerPedId())) < ((soundInfo[name_].distance or 10) + Config.distanceBeforeUpdatingPos) then
        SendNUIMessage({
            type = "url",
            name = name_,
            url = url_,
            x = pos.x,
            y = pos.y,
            z = pos.z,
            dynamic = true,
            volume = volume_,
            loop = loop_ or false,
        })
    end

    soundInfo[name_].volume = volume_
    soundInfo[name_].url = url_
    soundInfo[name_].position = pos
    soundInfo[name_].id = name_
    soundInfo[name_].playing = true
    soundInfo[name_].loop = loop_ or false
    soundInfo[name_].isDynamic = true

    globalOptionsCache[name_] = options or {}

    local playerPos = GetEntityCoords(PlayerPedId())
    if #(pos - playerPos) < Config.distanceBeforeUpdatingPos then
        isPlayerCloseToMusic = true
    end

    UpdatePlayerPositionInNUI()
end

function TextToSpeech(name_, lang, text, volume_, loop_, options)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:TextToSpeech(name_, lang, text, volume_, loop_, options)
        return
    end
    if disableMusic then
        return
    end
    local url = string.format("https://translate.google.com/translate_tts?ie=UTF-8&q=%s&tl=%s&total=1&idx=0&client=tw-ob", text, lang)
    PlayUrl(name_, url, volume_, loop_, options)
end

function TextToSpeechPos(name_, lang, text, volume_, pos, loop_, options)
    if Config.UseHighSound then
        name_ = name_:gsub("car_entity_", "")
        name_ = tonumber(name_)
    end
    if Config.UseExternalxSound then
        exports[Config.xSoundName]:TextToSpeechPos(name_, lang, text, volume_, pos, loop_, options)
        return
    end
    if disableMusic then
        return
    end
    local url = string.format("https://translate.google.com/translate_tts?ie=UTF-8&q=%s&tl=%s&total=1&idx=0&client=tw-ob", text, lang)
    PlayUrlPos(name_, url, volume_, pos, loop_, options)
end