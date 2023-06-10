AddEventHandler('av_restaurant:rate', function(data)
    local job = data.name
    local input = lib.inputDialog(Lang['rate_us'], {
        { type = 'input', label = Lang['leave_feedback']},
        { type = 'select', label = Lang['star'], options = {
            {label = "1 "..Lang['star'], value = 1},
            {label = "2 "..Lang['star'], value = 2},
            {label = "3 "..Lang['star'], value = 3},
            {label = "4 "..Lang['star'], value = 4},
            {label = "5 "..Lang['star'], value = 5},
            
        }},
    })
    if not input then return end
    if not input[1] then return end
    if not input[2] then return end
    if string.len(input[1]) > 100 then return end
    TriggerServerEvent("av_restaurants:addRating",job,input)
end)