globalOptionsCache = {}
isPlayerCloseToMusic = false
disableMusic = false

function getDefaultInfo()
    return {
        volume = 1.0,
        url = "",
        id = "",
        position = nil,
        distance = 0,
        playing = false,
        paused = false,
        loop = false,
        isDynamic = false,
        timeStamp = 0,
        maxDuration = 0,
        destroyOnFinish = true,
    }
end

function UpdatePlayerPositionInNUI()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    SendNUIMessage({
        type = "position",
        x = pos.x,
        y = pos.y,
        z = pos.z
    })
end

function GetDistanceForUpdateCoordsInNUI()
    return IsPedInAnyVehicle(PlayerPedId(), false) and 10.0 or 0.1
end

if not Config.UseExternalxSound then
    -- updating position on html side so we can count how much volume the sound needs.
    CreateThread(function()
        local refresh = Config.RefreshTime
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local lastPos = pos
        local changedPosition = false
        while true do
            Wait(refresh)
            if not disableMusic and isPlayerCloseToMusic then
                ped = PlayerPedId()
                pos = GetEntityCoords(ped)

                -- we will update position only when player have moved
                if #(lastPos - pos) >= GetDistanceForUpdateCoordsInNUI() then
                    lastPos = pos
                    UpdatePlayerPositionInNUI()
                end

                if changedPosition then
                    UpdatePlayerPositionInNUI()
                    SendNUIMessage({ type = "unmuteAll" })
                end
                changedPosition = false
            else
                if not changedPosition then
                    changedPosition = true
                    SendNUIMessage({ type = "position", x = -900000, y = -900000, z = -900000 })
                    SendNUIMessage({ type = "muteAll" })
                end
                Wait(1000)
            end
        end
    end)

    -- checking if player is close to sound so we can switch bool value to true.
    CreateThread(function()
        local ped = PlayerPedId()
        local playerPos = GetEntityCoords(ped)
        while true do
            Wait(500)
            ped = PlayerPedId()
            playerPos = GetEntityCoords(ped)
            isPlayerCloseToMusic = false
            for k, v in pairs(soundInfo) do
                if v.position ~= nil and v.isDynamic then
                    if #(v.position - playerPos) < v.distance + Config.distanceBeforeUpdatingPos then
                        isPlayerCloseToMusic = true
                        break
                    end
                end
            end
        end
    end)

    -- updating timeStamp
    CreateThread(function()
        Wait(1100)

        while true do
            Wait(1000)
            for k, v in pairs(soundInfo) do
                if v.playing or v.wasSilented then
                    if getInfo(v.id).timeStamp ~= nil and getInfo(v.id).maxDuration ~= nil then
                        if getInfo(v.id).timeStamp < getInfo(v.id).maxDuration then
                            getInfo(v.id).timeStamp = getInfo(v.id).timeStamp + 1
                        end
                    end
                end
            end
        end
    end)

    -- checking if player is close to sound so we can switch bool value to true.
    CreateThread(function()
        local ped = PlayerPedId()
        local playerPos = GetEntityCoords(ped)
        local brokenOne = {}
        while true do
            Wait(500)
            ped = PlayerPedId()
            playerPos = GetEntityCoords(ped)
            for k, v in pairs(soundInfo) do
                if v.position ~= nil and v.isDynamic then
                    if #(v.position - playerPos) < (v.distance + Config.distanceBeforeUpdatingPos) then
                        if brokenOne[v.id] then
                            brokenOne[v.id] = nil
                            v.wasSilented = false
                            v.skipTimestamp = true
                            PlayUrlPos(v.id, v.url, v.volume, v.position, v.loop)
                            onPlayStart(v.id, function()
                                if getInfo(v.id).maxDuration then
                                    print("v.time", v.timeStamp)
                                    setTimeStamp(v.id, v.timeStamp or 0)
                                end
                                Distance(v.id, v.distance)
                            end)
                        end
                    else
                        if not brokenOne[v.id] then
                            v.wasSilented = true
                            brokenOne[v.id] = true
                            DestroySilent(v.id)
                        end
                    end
                end
            end
        end
    end)

    CreateThread(function()
        Wait(5000)
        local disableMusic = false
        if GetResourceState(Config.xSoundName) == "missing" or GetResourceState(Config.xSoundName) == "unknown" then
            TriggerEvent('chat:addSuggestion', "/streamermode", "Will enable streamer mode")

            RegisterCommand("streamermode", function(source, args, rawCommand)
                disableMusic = not disableMusic

                if disableMusic then
                    TriggerEvent('chat:addMessage', { args = { "^1[xSound]", Config.Messages["streamer_on"] } })
                else
                    TriggerEvent('chat:addMessage', { args = { "^1[xSound]", Config.Messages["streamer_off"] } })
                end

                TriggerEvent("xsound:streamerMode", disableMusic)
            end, false)
        end
    end)
end