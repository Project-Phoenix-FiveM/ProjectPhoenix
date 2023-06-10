AddEventHandler('av_restaurant:food', function(data)
    local job = data['job']
    local type = 'food'
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
            id = 'av_restaurants:food',
            title = Lang['food'],
            options = menu,
        })
        lib.showContext('av_restaurants:food')
    end,{job = job, type = type})
end)