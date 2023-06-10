RegisterNetEvent('av_boosting:dongle', function()
    local input = lib.inputDialog(Lang['profile'], {Lang['username'], Lang['photo']})
    if not input then return end
    TriggerServerEvent('av_boosting:myProfile',input)
end)