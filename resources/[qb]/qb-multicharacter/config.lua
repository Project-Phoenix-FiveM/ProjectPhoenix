Config = {}
Config.Interior = vector3(-264.1443, -951.5657, 75.8179) -- Interior to load where characters are previewed
Config.DefaultSpawn = vector3(-1035.71, -2731.87, 12.86) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(-256.3065, -941.7942, 75.8287, 156.7334) -- Create preview ped at these coordinates
Config.HiddenCoords = vector4(-261.8508, -949.5483, 75.8287, 142.5654) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(-258.5254, -943.3583, 76.1148, 309.1309) -- Camera coordinates for character preview screen
Config.EnableDeleteButton = true -- Define if the player can delete the character or not

Config.DefaultNumberOfCharacters = 4 -- Define maximum amount of default characters, Max 4 //ST4LTH
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}
