-- Please read the Docs before using the script or if you don't understand a config field, function, etc :D
-- https://docs.av-scripts.com/

-- Motel interiors (free) 
-- (don't download if you already have qb-interior latest update): 
-- https://www.k4mb1maps.com/package/5015840

Config = {}
Config.Framework = "QBCore" -- "QBCore" or "ESX" Frameworks.
Config.Weather = "qb-weathersync" -- "av_weather", "cd_easytime" or "qb-weathersync" / For other weather add your export in client/framework/weather.lua
Config.Account = "bank" -- Money account used to pay everything
Config.TargetSystem = "qb-target" -- "qtarget", "qb-target", if using ox_target leave it as qb-target.
Config.Inventory = "qb-inventory" -- "ox_inventory", "qs-inventory", "lj-inventory" and "qb-inventory" are supported.
Config.AdminRank = "admin" -- Admin rank needed to access all functions.
Config.AdminStorageCommand = "admin:storage" -- Create Storages, only admins can use it (server/framework/commands.lua).
Config.AdminMotelsCommand = "admin:motel" -- Create Motels, only admins can use it (server/framework/commands.lua).
Config.MaxExpiredDays = 2 -- After X days the script will remove the property owner if the payment is expired

Config.Icons = { -- For target system
    ['storages'] = "fa-solid fa-box-open",
    ['motels'] = "fa-solid fa-bed",
    ['door'] = "fa-solid fa-door-closed",
    ['exit'] = "fa-solid fa-right-from-bracket",
    ['logout'] = "fa-regular fa-circle-xmark",
    ['inventory'] = "fa-solid fa-box-open",
    ['clothing'] = "fa-solid fa-shirt",
}
Config.Stashes = { -- Stashes default slots and weight
    ['storages'] = {slots = 50, weight = 100000}, -- Most of inventories 100000 = 100kg
    ['motels'] = {slots = 50, weight = 100000},
}
Config.DateColors = { -- Colors for "Next Payment" field in laptop.
    [1] = "rgb(63,191,63)", -- Active (green)
    [2] = "rgb(188,0,31)", -- Expired (red)
    [3] = "rgb(198,195,0)", -- Almost Expired (yellow)
}

Config.Society = "qb-management" -- Available options: esx_society, av_society (the one from restaurants) or qb-management
Config.EmployeeComission = 10 -- Add x% commission directly to the employee account, the rest will be added to society
Config.AccountName = "bank" -- Where the employee will receive their commission

Config.LaptopCategories = {
    {name = "storages", label = "Storages"},
    {name = "motels", label = "Motels"},
    {name = "houses", label = "Houses"}, -- If you have a housing script you can promote the houses too
}