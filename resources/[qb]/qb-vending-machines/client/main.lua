local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

exports['qb-target']:AddTargetModel(Config.CoffeeMachineProp, {
    options = {
        {
            type = "client",
            event = "qb-vending:CoffeeShop",
            icon = "fas fa-coffee",
            label = "Use Coffee Machine",
        },
    },
    distance = 2.5
})

exports['qb-target']:AddTargetModel(Config.SnackMachineProp, {
    options = {
        {
            type = "client",
            event = "qb-vending:SnackShop",
            icon = "fas fa-cookie",
            label = "Buy Snacks",
        },
    },
    distance = 2.5
})

exports['qb-target']:AddTargetModel(Config.FizzyMachineProp, {
    options = {
        {
            type = "client",
            event = "qb-vending:FizzyShop",
            icon = "fas fa-bottle",
            label = "Buy Drinks",
        },
    },
    distance = 2.5
})

exports['qb-target']:AddTargetModel(Config.WaterMachineProp, {
    options = {
        {
            type = "client",
            event = "qb-vending:WaterShop",
            icon = "fas fa-water",
            label = "Buy Water",
        },
    },
    distance = 2.5
})

RegisterNetEvent("qb-vending:CoffeeShop")
AddEventHandler("qb-vending:CoffeeShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Coffee Machine", Config.CoffeeItems)
end)

RegisterNetEvent("qb-vending:SnackShop")
AddEventHandler("qb-vending:SnackShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Snack Machine", Config.SnackItems)
end)

RegisterNetEvent("qb-vending:FizzyShop")
AddEventHandler("qb-vending:FizzyShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Drinks Machine", Config.FizzyItems)
end)

RegisterNetEvent("qb-vending:WaterShop")
AddEventHandler("qb-vending:WaterShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Water Machine", Config.WaterItems)
end)


