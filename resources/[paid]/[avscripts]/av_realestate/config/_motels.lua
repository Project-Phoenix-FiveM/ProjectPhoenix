Config.ClothingScript = "illenium-appearance" -- supported: "illenium-appearance", "esx_skin", "qb-clothing", "fivem-appearance"
Config.EnableClothing = true -- true/false show clothing option | client/framework/clothing.lua add your own clothing event
Config.LogoutMotel = true -- Set true if you want players be able to logout inside room, add your own multicharacter event in server/framework/spawn.lua
Config.MotelInteriors = {
    ['standardmotel_shell'] = {
        label = "Standard", 
        shell = `standardmotel_shell`,
        exit = {x = -0.43, y = -2.51, z = 1.0, h = 271.29},
        stash = {x = 1.30, y = 2.70, z = 1.0},
    },
    ['modernhotel_shell'] = {
        label = "Modern", 
        shell = `modernhotel_shell`,
        exit = {x = 4.98, y = 4.35, z = 1.16, h = 179.79},
        stash = {x = 3.05, y = -3.66, z = 1.16, h = 179.79},
    },
}