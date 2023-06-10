--- Loop for contracts
CreateThread(function()
    while true do
        for k, v in pairs(queue) do
            if not players[k]['busy'] then
                local lucky = math.random(1,10)
                if lucky == 4 then
                    GiveContract(k)
                end
            end
        end
        Wait(Config.QueueTime * 60 * 1000)
    end
end)

function GiveContract(identifier)
    contracts[identifier] = contracts[identifier] or {}
    if #contracts[identifier] >= Config.MaxContractsPerPlayer then
        return
    end
    local Player = exports['av_laptop']:getSourceByIdentifier(identifier)
    if Player then
        local plates = GeneratePlates()
        plates = string.upper(plates)
        local data = MySQL.single.await('SELECT * FROM av_boosting WHERE identifier = ?', {identifier})
        local myClass = GetMyClass(data.level)
        local available = getAvailableClasses(myClass)
        local lucky = math.random(1,#available)
        local currentClass = available[lucky]
        if currentClass == "S" then
            Config.MaxSContracts = Config.MaxSContracts - 1
        end
        if currentClass == "S+" then
            Config.MaxSPlusContracts = Config.MaxSPlusContracts - 1
        end
        local modelList = Config.Vehicles[currentClass]
        lucky = math.random(1,#modelList)
        local model = Config.Vehicles[currentClass][lucky]
        local index = #contracts[identifier] + 1
        local time = addHours(Config.Classes[currentClass]['ContractTime'])
        contracts[identifier][index] = {
            class = currentClass,
            name = model,
            plates = plates,
            deadline = time,
            serial = plates, 
            price = math.random(Config.Classes[currentClass]["Prices"]['normal']['min'],Config.Classes[currentClass]["Prices"]['normal']['max']),
            priceVin = math.random(Config.Classes[currentClass]["Prices"]['vinscratch']['min'],Config.Classes[currentClass]["Prices"]['vinscratch']['max']),
            started = false,
        }
        TriggerClientEvent('av_laptop:notification',tonumber(Player),Lang['app_title'],Lang['new_contract'],'success')
    else
        players[identifier] = nil
        queue[identifier] = nil
    end
end