Config = {}

-- What mysql should be active?

-- What type of mysql you want?
-- 0 No mysql
-- 1 oxmysql (if you have older version where mysql-async bridge does not exists turn this on)
-- 2 Mysql async
-- 3 ghmattimysql
Config.MysqlType = 1

-- 0 standalone
-- 1 ESX
-- 2 QBCore
Config.FrameWork = 2

-- will force trim even on standalone
Config.ForceTrim = false

-- force vip
-- you will need this "add_ace" permission and "add_principal" -> you can find them in readme.md
-- you can view more what the ace is here: https://forum.cfx.re/t/basic-aces-principals-overview-guide/90917
Config.ForceVip = false

-- well.. Do i have to explain what this blacklist?
Config.BlacklistedURL = {
    -- I am not responsible for you wanting puppy after watching this video
    "https://www.youtube.com/watch?v=o-YBDTqX_ZU",
}

-- do you want to disable saving this stuff to the mysql?
-- when you create your own playlist it will be there even after restart
Config.DisableLoadingOfPlayList = false

-- save interval for the playlist
Config.AutoSaveInterval = 1000 * 60 * 15

-- esx object share
Config.ESX = "esx:getSharedObject"

-- es_extended resource name
Config.esx_resource_name = "es_extended"

-- qbcore object
Config.QBCore = "QBCore:GetObject"

-- es_extended resource name
Config.qbcore_resource_name = "qb-core"

-- Debug
Config.Debug = false

-- Thread Debug
Config.ThreadDebug = false

-- Function Debug
Config.FunctionDebug = false

-- this will disable radio for all vehicles no expection even police etc.
Config.DisableGTARadio = false

-- how much volume will adjust each +/- button
Config.VolumeAdjust = 0.05

-- Should this be opened only from command ?
Config.EnableCommand = false

-- Name for the command ?
Config.CommandLabel = "radiocar"

-- Key to open radio
Config.KeyForRadio = "G"

-- description of the key
Config.KeyDescription = "this will open a radio vehicle (can be rebinded)"

-- Distance playing from car
Config.DistancePlaying = 4.0

-- Distance playing from car if windows are closed / or if he has open any door
Config.DistancePlayingWindowsOpen  = 10.0

--  if the engine is off the music will be disabled until the engine is on
Config.DisableMusicAfterEngineIsOFF = false

-- Only owner of the car can play a music from the vehicle.
Config.OnlyOwnerOfTheCar = false

-- Radio in car can be used only for people who own the car
-- this can prevent from trolling streamers, i believe many kids
-- will try play some troll music and try to get streamer banned.
Config.OnlyOwnedCars = true

-- this will only let use cars that have installed radio as an item in the car
-- means no car without installed radio before can use it..
-- you have to implement it somewhere by yourself.
-- if you wish to know more about this, please read "readme.md"
Config.OnlyCarWhoHaveRadio = true

-- Default music volume
Config.defaultVolume = 0.3

-- who can touch the radio from what seat?
-- https://docs.fivem.net/natives/?_0xBB40DD2270B65366
Config.AllowedSeats = {
    [-1] = true,
    [0] = true,
}

-- if you have some car that has big speakers or something like that
-- you can increase/decrease distance of playing music
Config.CustomDistanceForVehicles = {
   --[GetHashKey("sultan")] = 100,
}

-- Blacklisted vehicles
Config.blacklistedCars = {
    -- bikes
    GetHashKey("bmx"),
    GetHashKey("cruiser"),
    GetHashKey("fixter"),
    GetHashKey("scorcher"),
    GetHashKey("tribike"),
    GetHashKey("tribike2"),
    GetHashKey("tribike3"),

    -- other
    GetHashKey("thruster"),
}

-- this whitelist isnt really a whitelist..
-- if you set for an example "anyBoat = false"
-- you can allow one boat from other many to use radio.
Config.whitelistedCars = {-- car
    --GetHashKey("car name here"),
}

-- true  = enabled
-- false = disabled
-- Blacklisted categories vehicles
Config.blackListedCategories = {
    anyVehicle = true,
    anyBoat = true,
    anyHeli = false,
    anyPlane = true,
    anyCopCar = true,
    anySub = false,
    anyTaxi = true,
    anyTrain = true,
}

-- List default station for radio
Config.defaultList = {
    {
        label = "Good life radio",
        url = "https://www.youtube.com/watch?v=36YnV9STBqc",
    },
    {
        label = "Lofi hip hop radio",
        url = "https://www.youtube.com/watch?v=jfKfPfyJRdk",
    },
    {
        label = "Helios deep radio",
        url = "https://www.youtube.com/watch?v=AEw7aAIPxMw",
    },
    {
        label = "90s live radio",
        url = "https://www.youtube.com/watch?v=mk73cXTBeLc",
    },
    {
        label = "80s live radio",
        url = "https://www.youtube.com/watch?v=R6_3OchvW_c",
    },
    {
        label = "Doom live radio",
        url = "https://www.youtube.com/watch?v=JEuAYnjtJP0",
    },
}

-- How much ofter the player position is updated ?
Config.RefreshTime = 300

-- how much close player has to be to the sound before starting updating position ?
Config.distanceBeforeUpdatingPos = 40

-- Message list
Config.Messages = {
    ["streamer_on"]  = "Streamer mode is on. From now you will not hear any music/sound.",
    ["streamer_off"] = "Streamer mode is off. From now you will be able to listen to music that players might play.",
}

-- if you want xsound separated from radiocar then turn this on.
Config.UseExternalxSound = false

-- if you want to use high_3dsounds
Config.UseHighSound = false

-- name of the lib
Config.xSoundName = "xsound"

if Config.UseHighSound then
    Config.UseExternalxSound = true
    Config.xSoundName = "high_3dsounds"

    Config.DistancePlaying = Config.DistancePlaying * 3
    Config.DistancePlayingWindowsOpen  = Config.DistancePlayingWindowsOpen * 3
end