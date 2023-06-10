Meth = {}
Meth.Framework = "QBCore" -- QBCore or ESX
Meth.TargetSystem = "qb-target" -- qb-target, bt-target, qtarget, for custom target edit client/framework/target.lua, for ox_target set qtarget (not qb-target)
Meth.Crypto = "gne" -- Account type used to buy table/methlab
Meth.UsindOldESX = false -- Or true if you are using the old and deprecated ESX.
Meth.TableItem = "meth_table" -- The item for the meth table, it has to match the field "name" from Meth.Products
Meth.CookItem = "ammonia" -- or false, require item to cook in table
Meth.RenewTablePrice = 100 -- Price for renewing a table
Meth.RenewLabPrice = 500 -- Price for renewing a lab
Meth.LabKeyItem = "lab_key" -- The item for the meth lab, it has to match the field "name" from Meth.Products
Meth.ProductItemName = "meth_batch" -- Item name the player will receive when cooking meth from a table/lab
Meth.AmmoniaItem = "ammonia" -- Used in lab for 1st step
Meth.MethTrayItem = "meth_tray" -- Used in lab for 2nd step
Meth.BagsName = "baggies" -- Item name for bags used to make 1g of meth
Meth.RequiredBags = 1 -- How many baggies you need for meth 1g
Meth.MethTotal = 20 -- How many 1g meth bags will player receive per meth_batch
Meth.FinalProductName = "meth1g" -- Item name the player will receive after combining Meth.ProductItemName and Meth.BagsName
Meth.TableCooldown = 120 -- Cooldown (in minutes) for a specific table, default 2 hours
Meth.PlayerCooldown = 60 -- Cooldown (in minutes) for a player before he can cook again in a table, default 1 hour.
Meth.Rep = math.random(3,5) -- Rep received everytime the player cooks with the table, 100 points needed for each level (from 0 to 5)
Meth.ExtraMethBagLevel = 2 -- After Level 2 the player will have a random chance to get an extra meth bag after cooking in a table, change to false or change the min level to a different number between 0 - 5
Meth.LabMaxUseBeforeCooldown = 5 -- Player will be able to craft up to 5 bags before the lab enters in cooldown
Meth.LabCooldown = 240 -- Cooldown (in minutes) for a lab, default 4 hours
Meth.Products = {
    -- Products available for purchase in the Humane Labs APP
    -- Table Index, item Name, label, item price, account used for payment (don't use different accounts), level required to buy the item (from 0 to 5)
    [1] = {name = Meth.TableItem, label = "Meth Table", buyPrice = 1500, account = Meth.Crypto, level = 0, available = true},
    [2] = {name = Meth.LabKeyItem, label = "Meth Lab Key", buyPrice = 5000, account = Meth.Crypto, level = 3, available = true},
}

-- Blip for pickup items
Meth.BlipCoords = {-1361.89, -758.84, 22.5}
Meth.BlipIcon = 306 -- https://docs.fivem.net/docs/game-references/blips/#blips
Meth.BlipColor = 3 -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
Meth.BlipScale = 0.8


-- Each lab key is linked to one of this locations
-- And each location corresponds to 1 meth lab (4 in total)
-- When you use the lab key for the first time it will ask you to go to one of this areas of the island
-- And when you are inside the area, use the key again to choose the location for the entry
-- You can't add more than this 4 labs.
-- To get the zone names:
-- I used: https://forums.gta5-mods.com/topic/5749/reference-map-zone-names-and-zone-labels
-- And this: https://www.igta5.com/images/gtav-map-neighborhoods.jpg
-- Make sure to change the zone names before you start the resource for the first time
-- If you already started the resource and wanna do changes go to the labs.json file
-- For modifying .json files the resource needs to be stopped while doing the changes
-- DO NOT CHANGE THE ENTRY COORDS OR KEY, ONLY ZONE.
Meth.LabsZones = {
    {zone = "MURRI", entry = {969.99, -147.13, -46.4, 272.74}, key = 284673}, -- Murrieta Heights
    {zone = "DESRT", entry = {1197.86, 1853.11, -46.4, 270.6}, key = 285441}, -- Grand Senora Desert
    {zone = "DELPE", entry = {1556.45, -2134.07, -46.4, 272.99}, key = 285185}, -- Del Perro
    {zone = "PALETO", entry = {826.55, 2172.01, -46.4, 273.84}, key = 284929}, -- Paleto
}
