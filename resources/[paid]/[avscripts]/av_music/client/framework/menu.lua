AddEventHandler("av_music:openMenu", function(jobName)
    if Music.RecordLabels[jobName] then
        local job = GetJob()
        local options = {
            {
                title = Lang['add_song'],
                description = Lang['add_song_description'],
                event = 'av_music:addSong',
                args = {job = jobName}
            },
            {
                title = Lang['burn_cd'],
                description = Lang['burn_cd_description'],
                event = 'av_music:getSongs',
                args = {job = jobName}
            },
        }
        if job.isboss or job.grade_name == "boss" then
            options[#options+1] = {
                title = Lang['remove_songs'],
                description = Lang['remove_songs_description'],
                event = 'av_music:removeSongs',
                args = {job = jobName}
            }
        end
        lib.registerContext({
            id = 'main_music_menu',
            title = Music.RecordLabels[jobName].label,
            onExit = function()
                
            end,
            options = options,
        })
        lib.showContext('main_music_menu')
    end
end)

AddEventHandler("av_music:addSong", function(data)
    local jobName = data.job
    if Music.RecordLabels[jobName] then
        local input = lib.inputDialog(Music.RecordLabels[jobName].label, {Lang['artist_name'], Lang['song_name'], Lang['song_url']})
        if not input then return end
        local artist = input[1]
        local song = input[2]
        local url = input[3]
        if not artist or not song or not url then return end
        if string.match(url, "soundcloud.com") then
            TriggerServerEvent('av_music:registerSong', artist, song, url)
        else
            lib.defaultNotify({
                title = Music.RecordLabels[jobName].label,
                description = 'Only soundcloud is supported.',
                status = 'error'
            })
        end
    end
end)

AddEventHandler('av_music:getSongs', function(data)
    local jobName = data.job
    local songs = lib.callback.await('av_music:getCatalogue', false, jobName)
    if songs and songs[1] then
        local options = {}
        for k,v in pairs(songs) do
            options[#options+1] = {
                title = Lang['track']..''..v['title'],
                description = Lang['artist']..''..v['artist'].." | "..Lang['date_added']..v['date'],
                event = 'av_music:setCount',
                args = {title = Music.RecordLabels[jobName].label, data = v}
            }
            lib.registerContext({
                id = 'burn_cd_menu',
                title = Music.RecordLabels[jobName].label,
                options = options,
            })
            lib.showContext('burn_cd_menu')
        end
    else
        TriggerEvent("av_laptop:notification", Music.RecordLabels[jobName].label, Lang["no_songs"], 'error')
    end
end)

AddEventHandler('av_music:removeSongs', function(data)
    local job = data.job
    local catalogue = lib.callback.await('av_music:getCatalogue', false, job)
    local options = {}
    if catalogue and catalogue[1] then
        for k, v in pairs(catalogue) do
            options[#options+1] = {
                value = v['url'], label = v['artist']..' - '..v['title']
            }
        end
    end
    local input = lib.inputDialog(Lang['remove_songs'], {
        { type = 'select', label = Lang['choose_song'], options = options}
    })
    if not input then return end
    TriggerServerEvent('av_music:removeSong',job,input[1])
end)

AddEventHandler("av_music:setCount", function(args)
    local input = lib.inputDialog(args.title, {Lang['cd_count']..' '..Lang['cd_max']..'('..Music.MaxCDs..')'})
    if not input then return end
    if not tonumber(input[1]) then return end
    if tonumber(input[1]) > Music.MaxCDs then return end
    args.data['itemCount'] = input[1]
    TriggerServerEvent('av_music:burnCD', args.data)
end)