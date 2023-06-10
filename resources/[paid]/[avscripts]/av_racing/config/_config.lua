--[[
    READ THE DOCS BEFORE USING THE SCRIPT FOR THE FIRST TIME
    READ THE DOCS BEFORE USING THE SCRIPT FOR THE FIRST TIME
    READ THE DOCS BEFORE USING THE SCRIPT FOR THE FIRST TIME
    https://docs.av-scripts.com/laptop-pack/av-racing
    https://docs.av-scripts.com/laptop-pack/av-racing
    https://docs.av-scripts.com/laptop-pack/av-racing
]]

Config = {}
Config.Framework = "QBCore" -- "QBCore" or "ESX", for ESX uncomment the import from fxmanifest.lua
Config.DefaultPicture = "https://i.imgur.com/a86BdrW.png" -- Used for APP avatar
Config.AVBoosting = true -- True if you are using av_boosting
Config.DongleItem = "dongle" -- Item used to customize player user and photo, ignore it if you have AVBoosting = true
Config.MaxUsernameCharacters = 20
Config.DistanceUnit = "miles" -- "KM" or "miles" (To modify the text in UI go to av_laptop/build/lang.json and search distance_unit)
Config.MoneyAccount = "cash" -- Account used to pay the race fee
Config.BlipColor = 50 -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
Config.Blips = { -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
    Route = {color = 6},
    Generic = { Size = 1.0, Color = 38 },
    Next = { Size = 1.3, Color = 47 },
    Passed = { Size = 0.6, Color = 62 }
}
Config.FlareTime = 10 -- In seconds
Config.StartAndFinishModel = `prop_offroad_tyres02`
Config.CheckpointPileModel = `xm_prop_base_tripod_lampa`
Config.MinimumCheckpoints = 5 -- Minimum Checkpoints required for a race
Config.MinTireDistance = 2.0 -- Min distance between checkpoint tire piles
Config.MaxTireDistance = 30.0 -- Max distance between checkpoint tire piles
Config.JoinDistance = 200 -- Distance between player and race to join
Config.MaxTimeDNF = 10 -- Max time (in minutes) players have to complete the race after the 1st place has finish it, all the racers who haven't completed it will be marked as DNF.
Config.EventExpirationTime = 10 -- Max time (in minutes) before removing an event that has reached it starting time and has not being started
Config.AdminLevel = "admin" -- Admin level, used for permissions in APP, check the docs to customize server/framework/permissions.lua
Config.ClassCommand = "class" -- Used to view the vehicle class, or change it to false to disable it
Config.AllowPassengers = true -- Allow passengers to join races and see checkpoints/UI, they don't have to pay any money and they won't receive anything if they are in the winning vehicle
Config.WinnersPrizes = { -- Divide the prize pot with the 1st, 2nd and 3rd place from a total of 100%
    [1] = {percentage = 70, moneyAccount = "cash", label = "cash"}, --% Percentage for 1st place - account where the winner will receive his prize 
    [2] = {percentage = 20, moneyAccount = "cash", label = "cash"}, --% Percentage for 2nd place - account where the winner will receive his prize 
    [3] = {percentage = 10, moneyAccount = "cash", label = "cash"}, --% Percentage for 3rd place - account where the winner will receive his prize 
    -- The total from all places can't be more than 100%, otherwise the script will ignore your values and give the 100% to 1st place and 0 to all other places
}

Config.EditorKeys = {
    ['add'] = {Label = "7 - Add Checkpoint  \n", key = 161},
    ['distance'] = {Label = "] [ - Light Distance  \n", key = {decrease = 39, increase = 40}},
    ['delete'] = {Label = "8 - Delete Checkpoint  \n", key = 162},
    ['cancel'] = {Label = "9 - Cancel Editor  \n", key = 163},
    ['save'] = {Label = "E - Save Race  \n", key = 38},
}