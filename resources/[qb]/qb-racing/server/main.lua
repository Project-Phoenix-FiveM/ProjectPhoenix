local QBCore = exports['qb-core']:GetCoreObject()
local Races = {}
local AvailableRaces = {}
local LastRaces = {}
local NotFinished = {}

RegisterNetEvent("Pug:server:collisionOff")
AddEventHandler("Pug:server:collisionOff", function(RaceData)
    local src = source
    if Races[RaceData.RaceId].Phasing == 'true' then
        for k, v in pairs(Races[RaceData.RaceId].racerplates) do
            TriggerClientEvent("Pug:client:ToggleCollision", src, v)
        end
    end
    Wait(7000)
    Races[RaceData.RaceId].Phasing = {}
end)

Citizen.CreateThread(function()
    local races = exports.oxmysql:executeSync('SELECT * FROM lapraces', {})
    if races[1] ~= nil then
        for k, v in pairs(races) do
            local Records = {}
            if v.records ~= nil then
                Records = json.decode(v.records)
            end
            Races[v.raceid] = {
                RaceName = v.name,
                Checkpoints = json.decode(v.checkpoints),
                Records = Records,
                Creator = v.creator,
                RaceId = v.raceid,
                Started = false,
                Waiting = false,
                Distance = v.distance,
                LastLeaderboard = {},
                Racers = {},
                Phasing = {},
                racerplates = {},
                TotalCheckpoints = {},
            }
        end
    end
end)

QBCore.Functions.CreateCallback('qb-lapraces:server:GetRacingLeaderboards', function(source, cb)
    cb(Races)
end)

function SecondsToClock(seconds)
    local seconds = tonumber(seconds)
    local retval = 0
    if seconds <= 0 then
        retval = "00:00:00";
    else
        hours = string.format("%02.f", math.floor(seconds / 3600));
        mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)));
        secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60));
        retval = hours .. ":" .. mins .. ":" .. secs
    end
    return retval
end

RegisterServerEvent('qb-lapraces:server:FinishPlayer')
AddEventHandler('qb-lapraces:server:FinishPlayer', function(RaceData, TotalTime, TotalLaps, BestLap)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local AvailableKey = GetOpenedRaceKey(RaceData.RaceId)
    local PlayersFinished = 0
    local AmountOfRacers = 0
    for k, v in pairs(Races[RaceData.RaceId].Racers) do
        if QBCore.Functions.GetPlayerByCitizenId(k) then
            if v.Finished then
                PlayersFinished = PlayersFinished + 1
            end
            AmountOfRacers = AmountOfRacers + 1
        end
    end
    TriggerEvent("Pug:server:GetRacingRewards", src, TotalLaps, AmountOfRacers, PlayersFinished, RaceData.RaceId)
    local BLap = 0
    if TotalLaps < 2 then
        BLap = TotalTime
    else
        BLap = BestLap
    end
    if LastRaces[RaceData.RaceId] ~= nil then
        table.insert(LastRaces[RaceData.RaceId], {
            TotalTime = TotalTime,
            BestLap = BLap,
            Holder = {
                [1] = Player.PlayerData.charinfo.firstname,
                [2] = Player.PlayerData.metadata['alias']
            }
        })
    else
        LastRaces[RaceData.RaceId] = {}
        table.insert(LastRaces[RaceData.RaceId], {
            TotalTime = TotalTime,
            BestLap = BLap,
            Holder = {
                [1] = Player.PlayerData.charinfo.firstname,
                [2] = Player.PlayerData.metadata['alias']
            }
        })
    end
    if Races[RaceData.RaceId].Records ~= nil and next(Races[RaceData.RaceId].Records) ~= nil then
        if BLap < Races[RaceData.RaceId].Records.Time then
            Races[RaceData.RaceId].Records = {
                Time = BLap,
                Holder = {
                    [1] = Player.PlayerData.charinfo.firstname,
                    [2] = Player.PlayerData.metadata['alias']
                }
            }
            exports.oxmysql:execute('UPDATE lapraces SET records = ? WHERE raceid = ?',
                {json.encode(Races[RaceData.RaceId].Records), RaceData.RaceId})
            TriggerClientEvent('qb-phone:client:RaceNotify', src, 'You have won the WR from ' .. RaceData.RaceName ..
                ' disconnected with a time of: ' .. SecondsToClock(BLap) .. '!')
        end
    else
        Races[RaceData.RaceId].Records = {
            Time = BLap,
            Holder = {
                [1] = Player.PlayerData.charinfo.firstname,
                [2] = Player.PlayerData.metadata['alias']
            }
        }
        exports.oxmysql:execute('UPDATE lapraces SET records = ? WHERE raceid = ?',
            {json.encode(Races[RaceData.RaceId].Records), RaceData.RaceId})
        TriggerClientEvent('qb-phone:client:RaceNotify', src, 'You have won the WR from ' .. RaceData.RaceName ..
            ' put down with a time of: ' .. SecondsToClock(BLap) .. '!')
    end
    AvailableRaces[AvailableKey].RaceData = Races[RaceData.RaceId]
    TriggerClientEvent('qb-lapraces:client:PlayerFinishs', -1, RaceData.RaceId, PlayersFinished, Player)
    if PlayersFinished == AmountOfRacers then
        if NotFinished ~= nil and next(NotFinished) ~= nil and NotFinished[RaceData.RaceId] ~= nil and
            next(NotFinished[RaceData.RaceId]) ~= nil then
            for k, v in pairs(NotFinished[RaceData.RaceId]) do
                table.insert(LastRaces[RaceData.RaceId], {
                    TotalTime = v.TotalTime,
                    BestLap = v.BestLap,
                    Holder = {
                        [1] = v.Holder[1],
                        [2] = v.Holder[2]
                    }
                })
            end
        end
        Races[RaceData.RaceId].LastLeaderboard = LastRaces[RaceData.RaceId]
        Races[RaceData.RaceId].Racers = {}
        Races[RaceData.RaceId].Started = false
        Races[RaceData.RaceId].Waiting = false
        table.remove(AvailableRaces, AvailableKey)
        LastRaces[RaceData.RaceId] = nil
        NotFinished[RaceData.RaceId] = nil
    end
    TriggerClientEvent('qb-phone:client:UpdateLapraces', -1)
end)

function IsWhitelisted(CitizenId)
    if Config.AnyOneMakeRace then
        retval = true
    else
        local retval = false
        for _, cid in pairs(Config.WhitelistedCreators) do
            if cid == CitizenId then
                retval = true
                break
            end
        end
        local Player = QBCore.Functions.GetPlayerByCitizenId(CitizenId)
        local Perms = QBCore.Functions.GetPermission(Player.PlayerData.source)
        if Perms == "admin" or Perms == "god" then
            retval = true
        end
    end
    return retval
end

function IsNameAvailable(RaceName)
    local retval = true
    for RaceId, _ in pairs(Races) do
        if Races[RaceId].RaceName == RaceName then
            retval = false
            break
        end
    end
    return retval
end

RegisterNetEvent('Pug:server:AddUSB', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    --Player.Functions.AddItem('ausb2', 1)
end)

RegisterServerEvent('qb-lapraces:server:CreateLapRace')
AddEventHandler('qb-lapraces:server:CreateLapRace', function(RaceName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if IsWhitelisted(Player.PlayerData.citizenid) then
        if IsNameAvailable(RaceName) then
            TriggerClientEvent('qb-lapraces:client:StartRaceEditor', source, RaceName)
        else
            TriggerClientEvent('QBCore:Notify', source, 'There is already a race with this name.', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You have not been authorized to race\'s to create.', 'error')
    end
end)

QBCore.Functions.CreateCallback('qb-lapraces:server:GetRaces', function(source, cb)
    cb(AvailableRaces)
end)

QBCore.Functions.CreateCallback('qb-lapraces:server:GetListedRaces', function(source, cb)
    cb(Races)
end)

QBCore.Functions.CreateCallback('qb-lapraces:server:GetRacingData', function(source, cb, RaceId)
    cb(Races[RaceId])
end)

QBCore.Functions.CreateCallback('qb-lapraces:server:HasCreatedRace', function(source, cb)
    cb(HasOpenedRace(QBCore.Functions.GetPlayer(source).PlayerData.citizenid))
end)

QBCore.Functions.CreateCallback('qb-lapraces:server:IsAuthorizedToCreateRaces', function(source, cb, TrackName)
    cb(IsWhitelisted(QBCore.Functions.GetPlayer(source).PlayerData.citizenid), IsNameAvailable(TrackName))
end)

function HasOpenedRace(CitizenId)
    local retval = false
    for k, v in pairs(AvailableRaces) do
        if v.SetupCitizenId == CitizenId then
            retval = true
        end
    end
    return retval
end

QBCore.Functions.CreateCallback('qb-lapraces:server:GetTrackData', function(source, cb, RaceId)
    local result = exports.oxmysql:executeSync('SELECT * FROM players WHERE citizenid = ?', {Races[RaceId].Creator})
    if result[1] ~= nil then
        result[1].charinfo = json.decode(result[1].charinfo)
        cb(Races[RaceId], result[1])
    else
        cb(Races[RaceId], {
            charinfo = {
                firstname = "Unknown",
                lastname = "Unknown"
            }
        })
    end
end)

function GetOpenedRaceKey(RaceId)
    local retval = nil
    for k, v in pairs(AvailableRaces) do
        if v.RaceId == RaceId then
            retval = k
            break
        end
    end
    return retval
end

function GetCurrentRace(MyCitizenId)
    local retval = nil
    for RaceId, _ in pairs(Races) do
        for cid, _ in pairs(Races[RaceId].Racers) do
            if cid == MyCitizenId then
                retval = RaceId
                break
            end
        end
    end
    return retval
end

RegisterServerEvent('qb-lapraces:server:JoinRace')
AddEventHandler('qb-lapraces:server:JoinRace', function(RaceData, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RaceName = RaceData.RaceData.RaceName
    local RaceId = GetRaceId(RaceName)
    local AvailableKey = GetOpenedRaceKey(RaceData.RaceId)
    local isphasingon = Races[RaceId].Phasing
    local CurrentRace = GetCurrentRace(Player.PlayerData.citizenid)
    if Player.PlayerData.metadata['alias'] == 'NO ALIAS' then
        TriggerClientEvent('QBCore:Notify', src, 'You need an alias to race', 'error')
    else
        if isphasingon == 'true' then
            Races[RaceId].racerplates[#Races[RaceId].racerplates+1] = plate
        end
        if CurrentRace ~= nil then
            local AmountOfRacers = 0
            PreviousRaceKey = GetOpenedRaceKey(CurrentRace)
            for k, v in pairs(Races[CurrentRace].Racers) do
                if QBCore.Functions.GetPlayerByCitizenId(k) then
                    AmountOfRacers = AmountOfRacers + 1
                end
            end
            Races[CurrentRace].Racers[Player.PlayerData.citizenid] = nil
            if (AmountOfRacers - 1) == 0 then
                Races[CurrentRace].Racers = {}
                Races[CurrentRace].Started = false
                Races[CurrentRace].Waiting = false
                table.remove(AvailableRaces, PreviousRaceKey)
                TriggerClientEvent('QBCore:Notify', src, 'You were the only one in the race, the race had ended', 'error')
                TriggerClientEvent('qb-lapraces:client:LeaveRace', src, Races[CurrentRace])
            else
                AvailableRaces[PreviousRaceKey].RaceData = Races[CurrentRace]
                TriggerClientEvent('qb-lapraces:client:LeaveRace', src, Races[CurrentRace])
            end
            TriggerClientEvent('qb-phone:client:UpdateLapraces', -1)
        end
        Races[RaceId].Waiting = true
        Races[RaceId].Racers[Player.PlayerData.citizenid] = {
            Checkpoint = 0,
            Lap = 1,
            Finished = false,
            personalchp = 0,
            Position = 0,
        }
        AvailableRaces[AvailableKey].RaceData = Races[RaceId]
        TriggerClientEvent('qb-lapraces:client:JoinRace', src, Races[RaceId], RaceData.Laps)
        TriggerClientEvent('qb-phone:client:UpdateLapraces', -1)
        local creatorsource = QBCore.Functions.GetPlayerByCitizenId(AvailableRaces[AvailableKey].SetupCitizenId).PlayerData.source
        if creatorsource ~= Player.PlayerData.source then
            TriggerClientEvent('qb-phone:client:RaceNotify', creatorsource,
            Player.PlayerData.metadata['alias'] ..
                    ' the race has been joined!')
        end
    end
end)

-- AddEventHandler('playerDropped', function()
--     local src = source
--     local ped = GetPlayerPed(src)
--     if QBCore.Players[src] then
--         local Player = QBCore.Players[src]
--         for k, v in pairs(Races) do
--             for i, j in pairs(Races[k].Racers) do
--                 print(k, 'k')
--                 print(v, 'v')
--                 print(i, 'i')
--                 print(j, 'j')
--                 print(Player.PlayerData.citizenid)
--                 if i == Player.PlayerData.citizenid then
--                     print'removed'
--                     table.remove(j, i)
--                 end
--                 for k, v in pairs(Races) do
--                     for i, j in pairs(Races[k].Racers) do
--                         print'after i was removed this is racers'
--                         print(k, 'k')
--                         print(v, 'v')
--                         print(i, 'i')
--                         print(j, 'j')
--                     end
--                 end
--             end
--         end
--     end
-- end)

-- QBCore.Commands.Add("race", "testing", {}, false, function(source, args)
--     local src = source
--     local ped = GetPlayerPed(src)
--     local Player = QBCore.Functions.GetPlayer(src)
-- 	for k, v in pairs(Races) do
--         for i, j in pairs(Races[k].Racers) do
--             print(k, 'k')
--             print(v, 'v')
--             print(i, 'i')
--             print(j, 'j')
--             print(Player.PlayerData.citizenid)
--             if i == Player.PlayerData.citizenid then
--                 print'removed'
--                 table.remove(Races[k].Racers, i)
--             end
--             for k, v in pairs(Races) do
--                 for i, j in pairs(Races[k].Racers) do
--                     print'after i was removed this is racers'
--                     print(k, 'k')
--                     print(v, 'v')
--                     print(i, 'i')
--                     print(j, 'j')
--                 end
--             end
--         end
--     end
-- end)

RegisterServerEvent('qb-lapraces:server:LeaveRace')
AddEventHandler('qb-lapraces:server:LeaveRace', function(RaceData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RaceName
    if RaceData.RaceData ~= nil then
        RaceName = RaceData.RaceData.RaceName
    else
        RaceName = RaceData.RaceName
    end
    local RaceId = GetRaceId(RaceName)
    local AvailableKey = GetOpenedRaceKey(RaceData.RaceId)
    local creatorsource = QBCore.Functions.GetPlayerByCitizenId(AvailableRaces[AvailableKey].SetupCitizenId).PlayerData.source
    if creatorsource ~= Player.PlayerData.source then
        TriggerClientEvent('qb-phone:client:RaceNotify', creatorsource,
            Player.PlayerData.metadata['alias'] ..
                ' the race has been delivered!')
    end
    local AmountOfRacers = 0
    for k, v in pairs(Races[RaceData.RaceId].Racers) do
        if QBCore.Functions.GetPlayerByCitizenId(k) then
            AmountOfRacers = AmountOfRacers + 1
        end
    end
    if NotFinished[RaceData.RaceId] ~= nil then
        table.insert(NotFinished[RaceData.RaceId], {
            TotalTime = "DNF",
            BestLap = "DNF",
            Holder = {
                [1] = Player.PlayerData.charinfo.firstname,
                [2] = Player.PlayerData.metadata['alias']
            }
        })
    else
        NotFinished[RaceData.RaceId] = {}
        table.insert(NotFinished[RaceData.RaceId], {
            TotalTime = "DNF",
            BestLap = "DNF",
            Holder = {
                [1] = Player.PlayerData.charinfo.firstname,
                [2] = Player.PlayerData.metadata['alias']
            }
        })
    end
    Races[RaceId].Racers[Player.PlayerData.citizenid] = nil
    if (AmountOfRacers - 1) == 0 then
        if NotFinished ~= nil and next(NotFinished) ~= nil and NotFinished[RaceId] ~= nil and next(NotFinished[RaceId]) ~=
            nil then
            for k, v in pairs(NotFinished[RaceId]) do
                if LastRaces[RaceId] ~= nil then
                    table.insert(LastRaces[RaceId], {
                        TotalTime = v.TotalTime,
                        BestLap = v.BestLap,
                        Holder = {
                            [1] = v.Holder[1],
                            [2] = v.Holder[2]
                        }
                    })
                else
                    LastRaces[RaceId] = {}
                    table.insert(LastRaces[RaceId], {
                        TotalTime = v.TotalTime,
                        BestLap = v.BestLap,
                        Holder = {
                            [1] = v.Holder[1],
                            [2] = v.Holder[2]
                        }
                    })
                end
            end
        end
        Races[RaceId].LastLeaderboard = LastRaces[RaceId]
        Races[RaceId].Racers = {}
        Races[RaceId].Started = false
        Races[RaceId].Waiting = false
        Races[RaceId].Phasing = {}
        Races[RaceId].racerplates = {}
        Races[RaceId].TotalCheckpoints = {}
        table.remove(AvailableRaces, AvailableKey)
        TriggerClientEvent('QBCore:Notify', src, 'You were the only one in the race.The race had ended.', 'error')
        TriggerClientEvent('qb-lapraces:client:LeaveRace', src, Races[RaceId])
        LastRaces[RaceId] = nil
        NotFinished[RaceId] = nil
    else
        AvailableRaces[AvailableKey].RaceData = Races[RaceId]
        TriggerClientEvent('qb-lapraces:client:LeaveRace', src, Races[RaceId])
    end
    TriggerClientEvent('qb-phone:client:UpdateLapraces', -1)
end)

RegisterServerEvent('qb-lapraces:server:SetupRace')
AddEventHandler('qb-lapraces:server:SetupRace', function(RaceId, Laps, phasing)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.metadata['alias'] == 'NO ALIAS' then
        TriggerClientEvent('QBCore:Notify', src, 'You need an alias to race', 'error')
    else
        if Races[RaceId] ~= nil then
            if not Races[RaceId].Waiting then
                if not Races[RaceId].Started then
                    Races[RaceId].Waiting = true
                    Races[RaceId].Phasing = phasing
                    Races[RaceId].TotalCheckpoints = (#Races[RaceId].Checkpoints) * Laps
                    table.insert(AvailableRaces, {
                        RaceData = Races[RaceId],
                        Laps = Laps,
                        RaceId = RaceId,
                        SetupCitizenId = Player.PlayerData.citizenid
                    })
                    TriggerClientEvent('qb-phone:client:UpdateLapraces', -1)
                    SetTimeout(5 * 60 * 1000, function()
                        if Races[RaceId].Waiting then
                            local AvailableKey = GetOpenedRaceKey(RaceId)
                            for cid, _ in pairs(Races[RaceId].Racers) do
                                local RacerData = QBCore.Functions.GetPlayerByCitizenId(cid)
                                if RacerData ~= nil then
                                    TriggerClientEvent('qb-lapraces:client:LeaveRace', RacerData.PlayerData.source,
                                        Races[RaceId])
                                end
                            end
                            table.remove(AvailableRaces, AvailableKey)
                            Races[RaceId].LastLeaderboard = {}
                            Races[RaceId].Racers = {}
                            Races[RaceId].Started = false
                            Races[RaceId].Waiting = false
                            Races[RaceId].Phasing = {}
                            Races[RaceId].racerplates = {}
                            Races[RaceId].TotalCheckpoints = {}
                            LastRaces[RaceId] = nil
                            TriggerClientEvent('qb-phone:client:UpdateLapraces', -1)
                        end
                    end)
                else
                    TriggerClientEvent('QBCore:Notify', source, 'The race is already running', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'The race is already running', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'This race does not exist :(', 'error')
        end
    end
end)

RegisterServerEvent('qb-lapraces:server:UpdateRaceState')
AddEventHandler('qb-lapraces:server:UpdateRaceState', function(RaceId, Started, Waiting)
    Races[RaceId].Waiting = Waiting
    Races[RaceId].Started = Started
end)

function OpenRaceInfoServer()
    local info = {
        data = Races,
    }
    return info
end

RegisterServerEvent('qb-lapraces:server:StartRace')
AddEventHandler('qb-lapraces:server:StartRace', function(RaceId)
    local src = source
    local MyPlayer = QBCore.Functions.GetPlayer(src)
    local AvailableKey = GetOpenedRaceKey(RaceId)

    if RaceId ~= nil then
        if AvailableRaces[AvailableKey].SetupCitizenId == MyPlayer.PlayerData.citizenid then
            AvailableRaces[AvailableKey].RaceData.Started = true
            AvailableRaces[AvailableKey].RaceData.Waiting = false
            for CitizenId, _ in pairs(Races[RaceId].Racers) do
                local Player = QBCore.Functions.GetPlayerByCitizenId(CitizenId)
                if Player ~= nil then
                    TriggerClientEvent('qb-lapraces:client:RaceCountdown', Player.PlayerData.source)
                end
            end
            TriggerClientEvent('qb-phone:client:UpdateLapraces', -1)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You are not the creator of the race..', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You are not in a race..', 'error')
    end
end)

RegisterServerEvent('qb-lapraces:server:UpdateRacerData')
AddEventHandler('qb-lapraces:server:UpdateRacerData', function(RaceId, Checkpoint, Lap, Finished)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CitizenId = Player.PlayerData.citizenid
    local totalcars = 0
    local place = 0
    Races[RaceId].Racers[CitizenId].personalchp = Races[RaceId].Racers[CitizenId].personalchp + 1
    for k,v in pairs(Races[RaceId].Racers) do
        totalcars = totalcars + 1
    end
    place = totalcars
    for k,v in pairs(Races[RaceId].Racers) do
        if Races[RaceId].Racers[CitizenId].personalchp > Races[RaceId].Racers[k].personalchp then
            place = place - 1
        end
    end
    if place == 0 then
        place = totalcars
    end
    if (Checkpoint > 2 or Lap > 1) and place < Races[RaceId].Racers[CitizenId].Position then
        for k,v in pairs(Races[RaceId].Racers) do
            if place == Races[RaceId].Racers[k].Position or (place == Races[RaceId].Racers[k].Position and place == totalcars - 1) then
                if CitizenId == k then
                else
                    Races[RaceId].Racers[k].Position = Races[RaceId].Racers[k].Position + 1
                    local minusplace = Races[RaceId].Racers[k].Position 
                    local target = QBCore.Functions.GetPlayerByCitizenId(k)
                    TriggerClientEvent("Pug:Client:UpdatePosition", target.PlayerData.source, minusplace, totalcars)
                end
            end
        end
    end

    Races[RaceId].Racers[CitizenId].Position = place
    TriggerClientEvent("Pug:Client:UpdatePosition", src, place, totalcars)
    Races[RaceId].Racers[CitizenId].Checkpoint = Checkpoint
    Races[RaceId].Racers[CitizenId].Lap = Lap
    Races[RaceId].Racers[CitizenId].Finished = Finished

    TriggerClientEvent('qb-lapraces:client:UpdateRaceRacerData', -1, RaceId, Races[RaceId])
end)

RegisterServerEvent('qb-lapraces:server:SaveRace')
AddEventHandler('qb-lapraces:server:SaveRace', function(RaceData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RaceId = GenerateRaceId()
    local Checkpoints = {}
    for k, v in pairs(RaceData.Checkpoints) do
        Checkpoints[k] = {
            offset = v.offset,
            coords = v.coords
        }
    end
    Races[RaceId] = {
        RaceName = RaceData.RaceName,
        Checkpoints = Checkpoints,
        Records = {},
        Creator = Player.PlayerData.citizenid,
        RaceId = RaceId,
        Started = false,
        Waiting = false,
        Distance = math.ceil(RaceData.RaceDistance),
        Racers = {},
        LastLeaderboard = {}
    }
    exports.oxmysql:insert('INSERT INTO lapraces (name, checkpoints, creator, distance, raceid) VALUES (?, ?, ?, ?, ?)',
        {RaceData.RaceName, json.encode(Checkpoints), Player.PlayerData.citizenid, RaceData.RaceDistance,
         GenerateRaceId()})
end)

function GetRaceId(name)
    local retval = nil
    for k, v in pairs(Races) do
        if v.RaceName == name then
            retval = k
            break
        end
    end
    return retval
end

function GenerateRaceId()
    local RaceId = "LR-" .. math.random(1111, 9999)
    while Races[RaceId] ~= nil do
        RaceId = "LR-" .. math.random(1111, 9999)
    end
    return RaceId
end

QBCore.Commands.Add("togglesetup", "Turn on / off racing setup", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if IsWhitelisted(Player.PlayerData.citizenid) then
        Config.RaceSetupAllowed = not Config.RaceSetupAllowed
        if not Config.RaceSetupAllowed then
            TriggerClientEvent('QBCore:Notify', source, 'No more races can be created!', 'error')
        else
            TriggerClientEvent('QBCore:Notify', source, 'Races can be created again!', 'success')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You have not been authorized to do this.', 'error')
    end
end)

QBCore.Commands.Add("cancelrace", "Cancel going race..", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if IsWhitelisted(Player.PlayerData.citizenid) then
        local RaceName = table.concat(args, " ")
        if RaceName ~= nil then
            local RaceId = GetRaceId(RaceName)
            if Races[RaceId].Started then
                local AvailableKey = GetOpenedRaceKey(RaceId)
                for cid, _ in pairs(Races[RaceId].Racers) do
                    local RacerData = QBCore.Functions.GetPlayerByCitizenId(cid)
                    if RacerData ~= nil then
                        TriggerClientEvent('qb-lapraces:client:LeaveRace', RacerData.PlayerData.source, Races[RaceId])
                    end
                end
                table.remove(AvailableRaces, AvailableKey)
                Races[RaceId].LastLeaderboard = {}
                Races[RaceId].Racers = {}
                Races[RaceId].Started = false
                Races[RaceId].Waiting = false
                Races[RaceId].Phasing = {}
                Races[RaceId].racerplates = {}
                Races[RaceId].TotalCheckpoints = {}
                LastRaces[RaceId] = nil
                TriggerClientEvent('qb-phone:client:UpdateLapraces', -1)
            else
                TriggerClientEvent('QBCore:Notify', source, 'This race has not started yet.', 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You have not been authorized to do this.', 'error')
    end
end)

QBCore.Functions.CreateCallback('qb-lapraces:server:CanRaceSetup', function(source, cb)
    cb(Config.RaceSetupAllowed)
end)
