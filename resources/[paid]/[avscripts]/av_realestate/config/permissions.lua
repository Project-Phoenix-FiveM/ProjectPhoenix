-- boss is used in ESX
-- Manager is used in QBCore

Config.Permissions = {

-- Permissions for Laptop Ads:
    CreateAds = {
        ['realestate'] = {
            ranks = {"boss", "Manager"}, -- rank needed to create ads
        },
        ['another_job'] = {
            ranks = {"boss"}, -- rank needed to create ads
        },
    },
    DeleteAds = {
        ['realestate'] = {
            ranks = {"boss", "Manager"}, -- rank needed to remove ads
        },
        ['another_job'] = {
            ranks = {"boss"}, -- rank needed to remove ads
        },
    },
------------------------------------------------------------------------------------------------------------------------------------------------
-- Permissions for Storage Units:
    StorageJobName = { -- Jobs allowed to access the Storages Units tab in Real Estate APP
        ['realestate'] = true,
        ['another_job'] = true,
    },
    CreateStorage = { -- Job ranks needed to create new storages
        ["boss"] = true,
        ["Manager"] = true,
    }, 
    DeleteStorage = { -- Job ranks needed to delete storages and remove owners
        ["boss"] = true,
        ["Manager"] = true,
    }, 
    RaidStorage = { -- Jobs and ranks allowed to raid storages
        ["police"] = {
            ranks = {"boss", "Chief"}, -- rank needed to raid a storage unit (in ESX is boss, QBCore is Chief)
            item = false,
        },
    },
------------------------------------------------------------------------------------------------------------------------------------------------
-- Permissions for Motels:
    MotelsJobName = { -- Jobs allowed to access the Motels tab in Real Estate APP
        ['realestate'] = true,
        ['another_job'] = true,
    },
    DeleteMotels = { -- Job ranks allowed to delete motel groups/rooms and remove owners
        ["boss"] = true,
        ["Manager"] = true,
    },
    
    RaidMotels = { -- Jobs and ranks allowed to raid motels
        ['police'] = {
            ranks = {"boss", "Chief"}, -- rank needed to raid a motel room (in ESX is boss, QBCore is Chief)
            item = "lockpick" -- item name needed to raid a motel room or change it to false
        },
    }
}