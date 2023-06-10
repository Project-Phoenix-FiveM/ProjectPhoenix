Config = {}
Config.AVLaptop = true -- True if you are using AV_Laptop
Config.Framework = "QBCore" -- QBCore or ESX... For latest ESX versions make sure to uncomment the import in fxmanifest.lua
Config.UsingOldESX = false -- Set true if you still using the getSharedObject event from old ESX versions
Config.CashAccountName = "money" -- How the cash money account is named in your Framework
Config.UnemployedJobName = "unemployed" -- How your unemployed job is named
-- Add the item to your framework/inventory
Config.Ingredients = { -- You can use different name per type
    ["drink"] = "ingredients",
    ["food"] = "ingredients",
    ["joint"] = "ingredients",
    ["others"] = "ingredients",
    ["example"] = false, -- If you don't wanna use ingredients change the value to false like this example
}
Config.TargetSystem = "qb-target" -- qb-target, bt-target, qtarget
Config.Command = "restaurant" -- Used to create new zones
Config.AdminLevel = "admin" -- Permission level needed to use command
Config.DeleteZoneDistance = 15 -- Distance needed between you and the zone you want to delete
Config.itemsWhitelist = { -- If an item is already registered in your Framework it can't be added again, you can whitelist functions here to skip that limitation.
    ["water"] = true,
    ["bread"] = true,
}

Config.Events = { -- Used to create zones
    ['boss'] = {label = "Boss", event = "av_restaurant:boss", icon = "fas fa-laptop"},
    ['cashier'] = {label = {"Cashier", "Pay"}, event = {"av_restaurant:chargeCustomer", "av_restaurant:pay"}, icon = {"fas fa-cash-register", "fas fa-credit-card"}},
    ['drink'] = {label = "Drinks", event = "av_restaurant:drink", icon = "fas fa-glass-whiskey"},
    ['food'] = {label = "Food", event = "av_restaurant:food", icon = "fas fa-utensils"},
    ['joint'] = {label = "Joint", event = "av_restaurant:joint", icon = "fas fa-cannabis"},
    ['others'] = {label = "Others", event = "av_restaurant:others", icon = "fas fa-box"},
    ['washhands'] = {label = "Hand Wash", event = "av_restaurant:washhands", icon = "fas fa-droplet"},
    ['stash'] = {label = "Stash", event = "av_restaurant:stash", icon = "fas fa-box-open"},
    ['tray'] = {label = "Tray", event = "av_restaurant:tray", icon = "fas fa-box-open"},
    ['rate'] = {label = "Rate", event = "av_restaurant:rate", icon = "fas fa-star"},
    ['duty'] = {label = "Duty", event = "av_restaurant:duty", icon = "fa-solid fa-briefcase"},
}

-- Items, Stash and Tray Weights
Config.ItemsWeight = {
    ['drink'] = 1000, -- 1kg
    ['food'] = 1000, -- 1kg
    ['joint'] = 1000, -- 1kg
    ['others'] = 1000, -- 1kg
}
Config.StashWeight = 500000 -- Stash Weight (500kg)
Config.StashSlots = 50 -- Stash Item Slots
Config.TrayWeight = 50000 -- Tray Weight (50kg)
Config.TraySlots = 10 -- Tray Item Slots

-- Crafting Options
Config.CraftingTime = 5000 -- 5 seconds
Config.CraftingDict = "anim@amb@business@coc@coc_unpack_cut@" -- Animation dictionary
Config.CraftAnimation = "fullcut_cycle_v6_cokecutter" -- Animation

-- Eat, Drink and Smoke
Config.EatAnimDuration = 3000 -- 3 seconds, eating animation
Config.DrinkAnimDuration = 3000 -- 3 seconds, drinking animation
Config.JointAnimDuration = 10000 -- 10 seconds, smoking animation
Config.EatValue = 50 -- How many hunger points will the food add to player
Config.DrinkValue = 50 -- How many thirst points will the food add to player
Config.JointValue = 50 -- How many stress points will the joint remove from player

-- Inventory Config
Config.Inventory = 'qb-inventory'
--[[ 
    'qb-inventory' = QBCore inventory,
    'ox_inventory' = https://github.com/overextended/ox_inventory
	'mf-inventory' = https://modit.store/products/mf-inventory
    'qs-inventory' = https://www.quasar-store.com/package/4770732
]]--

Config.LaptopLogo = { -- Business logo for AV Laptop Business APP
    ['uwucafe'] = "https://i.imgur.com/kg1H4bV.jpg",
    ['police'] = "https://i.imgur.com/Awlq2ke.png",
    ['ambulance'] = "https://i.imgur.com/bmoiCs6.png",
    ['burgershot'] = "https://cdn.discordapp.com/attachments/819358910782898248/1103838207583473714/burgerlogo.png",
}

Config.NotRestaurant = { -- This jobs can't access the Register Product tab in Laptop
    ['police'] = true,
    ['ambulance'] = true,
    ['taxi'] = true,
    ['judge'] = true,
}