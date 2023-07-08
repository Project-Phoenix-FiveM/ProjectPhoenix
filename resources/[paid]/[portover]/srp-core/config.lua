SRPConfig = {}

SRPConfig.MaxPlayers = GetConvarInt('sv_maxclients', 128) -- Gets max players from config file, default 32
SRPConfig.IdentifierType = "steam" -- Set the identifier type (can be: steam, license)
SRPConfig.DefaultSpawn = {x=-1035.71,y=-2731.87,z=12.86,a=0.0}

SRPConfig.Money = {}
SRPConfig.Money.MoneyTypes = {['cash'] = 500, ['bank'] = 2500} -- {['cash'] = 500, ['bank'] = 5000, ['crypto'] = 0 } -- ['type']=startamount - Add or remove money types for your server (for ex. ['blackmoney']=0), remember once added it will not be removed from the database!
SRPConfig.Money.DontAllowMinus = {'cash'} -- {'cash', 'crypto'} -- Money that is not allowed going in minus

SRPConfig.Player = {}
SRPConfig.Player.MaxWeight = 120000 -- Max weight a player can carry (currently 120kg, written in grams)
SRPConfig.Player.MaxInvSlots = 40 -- Max inventory slots for a player
SRPConfig.Player.Bloodtypes = {
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
}

SRPConfig.Server = {} -- General server config
SRPConfig.Server.closed = false -- Set server closed (no one can join except people with ace permission 'rsadmin.join')
SRPConfig.Server.closedReason = "We\'re just testing." -- Reason message to display when people can't join the server
SRPConfig.Server.uptime = 0 -- Time the server has been up.
SRPConfig.Server.whitelist = false -- Enable or disable whitelist on the server
SRPConfig.Server.discord = "http://Discord.StoryRP.net" -- Discord invite link

SRPConfig.Server.PermissionList = {} -- permission list
SRPConfig.Server.PermissionLevels = {
    ["user"]            = {rank = "user",            label = "User",             power = 1},
    ["dv"]              = {rank = "dv",              label = "DV",               power = 2},
    ["trialhelper"]     = {rank = "trialhelper",     label = "Trial Helper",     power = 3},
    ["helper"]          = {rank = "helper",          label = "Helper",           power = 4},
    ["juniormoderator"] = {rank = "juniormoderator", label = "Junior Moderator", power = 5},
    ["moderator"]       = {rank = "moderator",       label = "Moderator",        power = 6},
    ["seniormoderator"] = {rank = "seniormoderator", label = "Senior Moderator", power = 7},
    ["junioradmin"]     = {rank = "junioradmin",     label = "Junior Admin",     power = 8},
    ["admin"]           = {rank = "admin",           label = "Administrator",    power = 9},
    ["headadmin"]       = {rank = "headadmin",       label = "Head Admin",       power = 10},
    ["god"]             = {rank = "god",             label = "God",              power = 11}
}