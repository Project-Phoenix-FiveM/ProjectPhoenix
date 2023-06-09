Market = {}
Market.Account = "gne" -- Account used to buy items
Market.TargetSystem = "qb-target" -- qb-target or qtarget, if using ox_target it will automatically convert it
Market.BlipCoords = {2168.10, 3330.53, 46.81}
Market.BlipIcon = 306
Market.BlipScale = 0.8
Market.BlipColor = 3
Market.Categories = {
    { name = "hacker", label = "Hacker", job = false }, 
    { name = "drugs", label = "Drugs", job = "police" }, -- it will restrict the category to X job, or set false
    { name = "weapons", label = "Weapons", job = false },
}
-- Job = false or "jobName" will make the category restricted
Market.Items = {
    {name = "dongle", label = "Dongle", category = "hacker", stock = 20, price = 25},
    {name = "hacking_device", label = "Hacking Device", category = "hacker", stock = 99, price = 50},
    {name = "transponder", label = "Transponder", category = "hacker", stock = 99, price = 50}, 
    
}