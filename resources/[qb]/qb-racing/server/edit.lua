local QBCore = exports['qb-core']:GetCoreObject()

-- racing rewards table
RegisterNetEvent("Pug:server:GetRacingRewards", function(src, TotalLaps, AmountOfRacers, PlayersFinished, RaceId)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        if TotalLaps == 2 then
            if AmountOfRacers >= 4 and AmountOfRacers < 6 then
                if PlayersFinished == 1 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(14, 17), "1st-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(14, 17))
                elseif PlayersFinished == 2 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(10, 13), "2nd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(10, 13))
                elseif PlayersFinished == 3 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(3, 8), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(3, 8))
                else
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(1, 2), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(1, 2))
                end
            elseif AmountOfRacers >= 6 and AmountOfRacers < 8 then
                if PlayersFinished == 1 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(16, 20), "1st-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(16, 20))
                elseif PlayersFinished == 2 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(12, 15), "2nd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(12, 15))
                elseif PlayersFinished == 3 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(7, 10), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(7, 10))
                else
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(4, 6), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(4, 6))
                end
            elseif AmountOfRacers >= 8 and AmountOfRacers < 10 then
                if PlayersFinished == 1 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(18, 22), "1st-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(18, 22))
                elseif PlayersFinished == 2 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(14, 17), "2nd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(14, 17))
                elseif PlayersFinished == 3 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(8, 12), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(8, 12))
                else
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(5, 7), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(5, 7))
                end
            elseif AmountOfRacers >= 10 then
                if PlayersFinished == 1 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(20, 25), "1st-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(20, 25))
                elseif PlayersFinished == 2 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(16, 19), "2nd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(16, 19))
                elseif PlayersFinished == 3 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(10, 15), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(10, 15))
                else
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(7, 10), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(7, 10))
                end
            end
        elseif TotalLaps >= 3 then
            --Player.Functions.SetMetaData("criminalrep", NewRep) -- this is for my server to recieve criminal rep
            TriggerClientEvent('QBCore:Notify', src, '+'..crimrep..' Criminal Rep', 'success')
            if AmountOfRacers >= 4 and AmountOfRacers < 6 then
                if PlayersFinished == 1 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(18, 21), "1st-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(18, 21))
                elseif PlayersFinished == 2 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(14, 17), "2nd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(14, 17))
                elseif PlayersFinished == 3 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(7, 12), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(7, 12))
                else
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(4, 6), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(4, 6))
                end
            elseif AmountOfRacers >= 6 and AmountOfRacers < 8 then
                if PlayersFinished == 1 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(20, 24), "1st-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(20, 24))
                elseif PlayersFinished == 2 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(16, 19), "2nd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(16, 19))
                elseif PlayersFinished == 3 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(11, 14), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(11, 14))
                else
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(7, 9), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(7, 9))
                end
            elseif AmountOfRacers >= 8 and AmountOfRacers < 10 then
                if PlayersFinished == 1 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(22, 26), "1st-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(22, 26))
                elseif PlayersFinished == 2 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(18, 21), "2nd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(18, 21))
                elseif PlayersFinished == 3 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(12, 16), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(12, 16))
                else
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(5, 9), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(5, 9))
                end
            elseif AmountOfRacers >= 10 then
                if PlayersFinished == 1 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(24, 29), "1st-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(24, 29))
                elseif PlayersFinished == 2 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(20, 23), "2nd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(20, 23))
                elseif PlayersFinished == 3 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(14, 19), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(14, 19))
                else
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(9, 13), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(9, 13))
                end
            end
        elseif RaceId == 'LR-3398' or RaceId == 'LR-4307' or RaceId == 'LR-7037' or RaceId == 'LR-6797' then -- sprint races go here [ids for them are found in the database]
            if AmountOfRacers >= 6 then
                if PlayersFinished == 1 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(20, 25), "1st-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(20, 25))
                elseif PlayersFinished == 2 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(16, 19), "2nd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(16, 19))
                elseif PlayersFinished == 3 then
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(10, 15), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(10, 15))
                else
                    --Player.Functions.AddMoney(Config.RaceCurrency, math.random(7, 10), "3rd-place")
                    exports['qb-phone']:AddCrypto(src, Config.RaceCurrency, math.random(7, 10))
                end
            end
        end
    end
end)

QBCore.Functions.CreateUseableItem("ausb2", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("Pug:client:CreateRacerAlias", source)
end)

QBCore.Commands.Add("racername", "View your racing name!", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local alias = Player.PlayerData.metadata['alias']
    TriggerClientEvent('QBCore:Notify', src, 'Your racing name is '..alias)
end)

RegisterServerEvent("Pug:server:GetRacingSimulator")
AddEventHandler("Pug:server:GetRacingSimulator", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local moneytype = Player.PlayerData.money['crypto']
    local cash = Player.PlayerData.money['cash']
    if Player.PlayerData.metadata['alias'] == 'NO ALIAS' then
        TriggerClientEvent('QBCore:Notify', src, 'You need to make an alias first ')
    else
        if cash >= 5000 then
            if exports['qb-phone']:RemoveCrypto(src, Config.RaceCurrency, 150) then
                Player.Functions.RemoveMoney('cash', 5000, "buy-item")
                Player.Functions.AddItem('racingusb2', 1, info)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['racingusb2'], "add")
            else
                TriggerClientEvent('QBCore:Notify', src, 'You are missing Ɍ'.. 150 - moneytype..' RhodanE', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You are missing $'.. 5000 - cash, 'error')
        end
    end
end)