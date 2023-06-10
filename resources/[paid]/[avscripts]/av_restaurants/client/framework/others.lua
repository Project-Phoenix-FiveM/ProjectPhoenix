AddEventHandler('av_restaurant:others', function(data)
    local job = data['job']
    local type = 'others'
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
            id = 'av_restaurants:others',
            title = Lang['others'],
            options = menu,
        })
        lib.showContext('av_restaurants:others')
    end,{job = job, type = type})
end)