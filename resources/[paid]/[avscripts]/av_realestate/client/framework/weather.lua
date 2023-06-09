function Weather(enter)
    if enter then -- Freeze Weather
        if Config.Weather == "av_weather" then
            TriggerEvent('av_weather:freeze', true, 23, 00, "CLEAR")
            return
        end
        if Config.Weather == "cd_easytime" then
            TriggerEvent('cd_easytime:PauseSync', true)
            return
        end
        if Config.Weather == "qb-weathersync" then
            TriggerEvent('qb-weathersync:client:DisableSync')
            return
        end
    else  -- Unfreeze Weather and sync time
        if Config.Weather == "av_weather" then
            TriggerEvent('av_weather:freeze', false)
            return
        end
        if Config.Weather == "cd_easytime" then
            TriggerEvent('cd_easytime:PauseSync', false)
            return
        end
        if Config.Weather == "qb-weathersync" then
            TriggerEvent('qb-weathersync:client:EnableSync')
            return
        end
    end
end