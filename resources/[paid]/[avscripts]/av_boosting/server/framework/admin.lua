RegisterCommand(Config.CreateContract, function(source,args)
    local src = source
    local permission = exports['av_laptop']:getPermission(src, Config.Admin)
    if permission then
        TriggerClientEvent('av_boosting:createContract',src)
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['no_access'],"error")
    end
end)

RegisterServerEvent('av_boosting:createContract', function(playerId, class, vehicle)
    local src = source
    local identifier = exports['av_laptop']:getIdentifier(tonumber(playerId))
    if identifier then
        contracts[identifier] = contracts[identifier] or {}
        local plates = GeneratePlates()
        plates = string.upper(plates)
        local model = vehicle
        local index = #contracts[identifier] + 1
        local time = addHours(Config.Classes[class]['ContractTime'])
        contracts[identifier][index] = {
            class = class,
            name = model,
            plates = plates,
            deadline = time,
            serial = plates, 
            price = math.random(Config.Classes[class]["Prices"]['normal']['min'],Config.Classes[class]["Prices"]['normal']['max']),
            priceVin = math.random(Config.Classes[class]["Prices"]['vinscratch']['min'],Config.Classes[class]["Prices"]['vinscratch']['max']),
            started = false,
        }
        TriggerClientEvent('av_laptop:notification',tonumber(playerId),Lang['app_title'],Lang['new_contract'],'success')
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['contract_sent'],'success')
        local admin = GetPlayerName(src)
        local target = GetPlayerName(tonumber(playerId))
        local discord = {
            {
                ['title'] = 'Admin Contract',
                ['footer'] = {
                    ['text'] = os.date('%c'),
                },
                ['description'] = "**Admin:** "..admin.."\n **User:** "..target.."\n **Class:** "..class.."\n **Model:** "..model.."\n **Plates:** "..plates,
            } 
        }
        exports['av_laptop']:Discord(webhook,discord)
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['not_online'],"error")
    end
end)