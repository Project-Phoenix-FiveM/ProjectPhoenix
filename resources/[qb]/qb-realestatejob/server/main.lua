local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("setestate", "Give Someone The Real Estate Job", {{
    name = "id",
    help = "ID Of The Player"
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = QBCore.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                TargetData.Functions.SetJob("realestate")
                TriggerClientEvent('QBCore:Notify', TargetData.PlayerData.source,
                    "You Were Hired As Real Estate Agent!")
                TriggerClientEvent('QBCore:Notify', source, "You have (" .. TargetData.PlayerData.charinfo.firstname ..
                    ") Hired As An Real Estate Agent!")
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "You Must Provide A Player ID!")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "You Cannot Do This!", "error")
    end
end)

QBCore.Commands.Add("firerealestate", "Fire A Real Estate", {{
    name = "id",
    help = "ID Of The Player"
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = QBCore.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                if TargetData.PlayerData.job.name == "realestate" then
                    TargetData.Functions.SetJob("unemployed")
                    TriggerClientEvent('QBCore:Notify', TargetData.PlayerData.source,
                        "You Were Fired As An Real Estate Agent!")
                    TriggerClientEvent('QBCore:Notify', source,
                        "You have (" .. TargetData.PlayerData.charinfo.firstname .. ") Fired As Real Estate Agent!")
                else
                    TriggerClientEvent('QBCore:Notify', source, "Youre Not An Real Estate Agent!", "error")
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "You Must Provide A Player ID!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "You Cannot Do This!", "error")
    end
end)