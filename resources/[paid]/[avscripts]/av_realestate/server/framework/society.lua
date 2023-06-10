function AddSociety(source, target, type, amount)
    local myJob = exports['av_laptop']:getJob(source).name
    if Config.Society == "av_society" then
        exports['av_restaurants']:UpdateSociety(myJob,amount)
        return
    end
    if Config.Society == "esx_society" then
        local exists = exports['esx_society']:GetSociety(myJob)
        if not exists then
            TriggerEvent('esx_society:registerSociety', myJob, myJob, 'society_'..myJob, 'society_'..myJob, 'society_'..myJob, {type = 'private'})
        end
        TriggerEvent('esx_society:depositMoney',myJob,amount)
        return
    end
    if Config.Society == "qb-management" then
        exports['qb-management']:AddMoney(myJob,amount)
        return
    end
end

lib.callback.register('av_restaurant:GetESXJobs', function(source)
    return ESX.GetJobs()
end)