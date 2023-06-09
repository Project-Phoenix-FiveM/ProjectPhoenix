AddEventHandler('av_restaurant:joint', function(data)
    local job = data['job']
    local type = 'joint'
    lib.callback('av_restaurant:getItems', false, function(items)
        local menu = {}
        for k, v in pairs(items) do
            menu[#menu+1] = {
                title = v['label'],
                description = v['description'],
                event = "av_restaurant:craft",
                args = {
                    item = v['name'],
                    job = job,
                    type = type
                }
            }
        end
        lib.registerContext({
            id = 'av_restaurants:joint',
            title = Lang['joint'],
            options = menu,
        })
        lib.showContext('av_restaurants:joint')
    end,{job = job, type = type})
end)