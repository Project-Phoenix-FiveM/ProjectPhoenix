Gangs = {}
Gangs.MaxMembers = 10 -- Max members per gang
Gangs.Framework = "QBCore" -- QBCore or ESX
Gangs.TargetSystem = "qb-target" -- qtarget or qb-target, if you are using ox_target leave it as qtarget
Gangs.CheckGang = "gang:check" -- Verify your current gang command
Gangs.RegisterGangCommand = "gang:register" -- Command to create gangs in game
Gangs.SetGangBossCommand = "gang:boss" -- Command for add a boss to a gang
Gangs.RemoveGangMember = "gang:remove" -- Command for removing a gang member/boss
Gangs.DeleteGang = "gang:wipe" -- Removes the full gang and members
Gangs.AdminLevel = "admin" -- Admin level required to access commands ^^^
Gangs.SprayItem = 'spray' -- Used to place graffiti
Gangs.SprayRemover = 'spray_remover' -- Used to remove graffitis
Gangs.PlaceSprayTime = 30 -- in seconds
Gangs.RemoveSprayTime = 30 -- in seconds
Gangs.ItemLimit = { -- How many of this item can a gang buy per server restart
    [Gangs.SprayItem] = 2,
    [Gangs.SprayRemover] = 1,
}
Gangs.NPC = {
    -- model = NPC model for spray and remover shop https://docs.fivem.net/docs/game-references/ped-models/
    -- coords = x, y, z, heading
    {model = `a_m_m_eastsa_01`, coords = {-297.21, -1332.04, 30.3, 317.49}},
}
Gangs.SprayPrice = 15000 -- Spray base price
Gangs.SprayMultiplier = 1.25 -- Multiplier for spray price (SprayPrice * SprayMultiplier * Graffitis Count)
Gangs.SprayRemoverPrice = 50000
Gangs.ShopAccount = "bank" -- Account used to buy spray/spray_remover
Gangs.SprayDistance = 7 -- How far from wall you can spray / remove a graffiti using remover item
Gangs.MinMembersForSpray = 1 -- Min members online to place a graffiti
Gangs.MinMembersForRemover = 0 -- Min members online to remove their graffiti
Gangs.ShowBlips = "gang:blips" -- Command to show/remove spray blips on map
Gangs.ZoneRadius = 109.0 -- Gang zone radius created around the spray, applies for both zone and blip.
Gangs.SprayGivesEXP = 5 -- Gang receives EXP when creating a graffiti or false, each 100 points is 1 level for Gangs, Max 5 levels (500 points)
Gangs.RemoveSprayGivesEXP = 15 -- Remove other Gang Spray will give you EXP or false
Gangs.RobAccount = "cash" -- Your money account, used when you rob a gang member
Gangs.RobMoney = {min = 25, max = 100} -- Amount of money you can rob from a rival gang NPC
Gangs.Sprays = { -- Only registered gangs will be able to use spray and spray remover + rob NPC members
    ["ballas"] = { -- Gang name
        Grafiti = "spray_ballas", -- Graffiti model name (without .ydr)
        blipColor = 27, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        ped = {"g_f_y_ballas_01", "g_m_y_ballaeast_01"} -- https://docs.fivem.net/docs/game-references/ped-models/
    },
}