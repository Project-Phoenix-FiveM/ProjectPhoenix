-- Receive the racer src, identifier, position and the race ID
-- With raceId you can access allEvents[raceId] and retrieve all the info from the current race

local positions = {
    [1] = {prize = 6, accountName = "gne"},
    [2] = {prize = 4, accountName = "gne"},
    [3] = {prize = 2, accountName = "gne"},
}

function FinishedRace(src,identifier,position,raceId)
    -- This is just an EXAMPLE using the positions table to give a bonus
    if positions[tonumber(position)] and allEvents[raceId]['numRacers'] >= 6 then
        exports['av_laptop']:addMoney(tonumber(src), positions[tonumber(position)]['accountName'], positions[tonumber(position)]['prize'])
    end
end