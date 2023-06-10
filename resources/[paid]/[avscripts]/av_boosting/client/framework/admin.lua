RegisterNetEvent('av_boosting:createContract', function()
    local options = {}
    for k, v in pairs(Config.Classes) do
        options[#options+1] = {label = k, value = k}
    end
    local input = lib.inputDialog(Lang['create_contract'], {
        { type = "number", label = Lang['playerId'], default = 1 },
        { type = 'select', label = Lang['vehicle_class'], options = options},
    })
    if not input then return end
    if tonumber(input[1]) <= 0 then return end
    if input[1] and input[2] then
        TriggerEvent('av_boosting:contract2', input[1], input[2])
    end
end)

RegisterNetEvent('av_boosting:contract2', function(playerId, class)
    local options = {}
    for i = 1, #Config.Vehicles[class] do
        options[#options+1] = {value = Config.Vehicles[class][i], label = Config.Vehicles[class][i]}
    end
    local input = lib.inputDialog(Lang['create_contract'], {
        { type = 'select', label = Lang['vehicle_list'], options = options},
    })
    if not input then return end
    TriggerServerEvent('av_boosting:createContract',playerId, class, input[1])
end)

RegisterCommand(Config.DebugCommand, function()
    for k, v in pairs(Config.Vehicles) do
        local class = k
        for i, j in pairs(Config.Vehicles[class]) do
            if not IsModelInCdimage(j) then
                print('^3[ERROR] Model:',j," doesn't exist in game.")
                break
            end
        end
        print(class, "Completed")
    end
    print("All vehicle models exists in game")
end)