-- This file is for people who have addon vehicles and haven't registered them in Fivem client side, check the docs for more info
-- If you don't register your addon vehicles, they will be displayed as NULL in leaderboards
local myAddonVehicles = {
    -- spawnName = is the code that you use to spawn the code (example: sultan)
    -- label = the vehicle model that will be displayed in game
    {spawnName = "example", label = "Vehicle Example"}, -- This is an example. copy/paste it and replace the values for every of your addon vehicles
}

CreateThread(function()
    for k, v in pairs(myAddonVehicles) do
	    AddTextEntry(v['spawnName'], v['label'])
    end
end)