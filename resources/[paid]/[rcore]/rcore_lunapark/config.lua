Config = {}

Config.BlipName = 'Lunapark'

Config.Enable3dText = false -- Will render 3D Text instead of the default GTA help text
Config.Scale3dText  = 0.5 -- Scale of the 3D Text, a number between 0.0 and 1.0
Config.Color3dText  = { 255, 255, 255, 196 } -- RGBA of the 3D Text

-- Distance from the pier at which the entities will spawn and start rendering
Config.RollerCoasterRenderDistance = 200.0
Config.WheelRenderDistance         = 200.0
Config.FreefallRenderDistance      = 200.0

-- Automatically detects and disables the wheel's IPL making it not spawn twice
Config.DisableWheelIPL = true

-- Please do note that enabling both frameworks will result in an unexpected behavior
Config.EnableESX          = false -- Enables support for ESX framework
Config.EnableQBCore       = true -- Enables support for QBCore framework
Config.EnableCustomEvents = false -- Enables support for custom events

--[[
    CUSTOM EVENTS (For Developers)

    In case you want to handle the payments yourself
    There is an event for each attraction which always passes 3 arguments:
        source - player's serverId
        price - price of the ticket which you specified down below
        callback - a function in which you pass true as a result of a successful payment or false
    
    The events:
        rcore_lunapark_rollercoaster
        rcore_lunapark_ferriswheel
        rcore_lunapark_freefall
]]

-- Sets the timer for each attraction (in seconds)
Config.RollerCoasterTimer = 30 -- Do not set the value lower than 10
Config.FreefallTimer = 10

Config.Prices = {}

Config.Prices.RollerCoaster = 5 -- Ticket price for the Roller Coaster
Config.Prices.FerrisWheel   = 3 -- Ticket price for the Ferris Wheel
Config.Prices.Freefall      = 3 -- Ticket price for the Freefall

Config.Text = {}

Config.Text.COASTER_NO_PLAYERS  = 'Not enough players on the Roller Coaster.'
Config.Text.COASTER_NO_MONEY    = 'You haven\'t got enough money, you need $5.'
Config.Text.COASTER_ROW_FULL    = 'Row full'
Config.Text.COASTER_GET_ON      = '~INPUT_CONTEXT~ Get on ~g~$5~s~'
Config.Text.COASTER_GET_OFF     = '~INPUT_VEH_EXIT~ Get off'
Config.Text.COASTER_START       = '~INPUT_SPRINT~ + ~INPUT_VEH_ACCELERATE~ Start the Roller Coaster' .. '~n~' .. Config.Text.COASTER_GET_OFF
Config.Text.COASTER_TIMER       = 'The Roller Coaster starts in %s second(s).'
Config.Text.COASTER_HANDS_UP    = 'Hands up'
Config.Text.COASTER_HANDS_DOWN  = 'Hands down'

Config.Text.WHEEL_NO_MONEY   = 'You haven\'t got enough money, you need $3.'
Config.Text.WHEEL_CABIN_FULL = 'Cabin full'
Config.Text.WHEEL_GET_ON     = '~INPUT_CONTEXT~ Get on ~g~$3~s~'
Config.Text.WHEEL_GET_OFF    = '~INPUT_VEH_EXIT~ Get off'

Config.Text.FREEFALL_NO_PLAYERS = 'Not enough players on the Attraction.'
Config.Text.FREEFALL_NO_MONEY   = 'You haven\'t got enough money, you need $3.'
Config.Text.FREEFALL_FULL       = 'Seats are full'
Config.Text.FREEFALL_GET_ON     = '~INPUT_CONTEXT~ Get on ~g~$3~s~'
Config.Text.FREEFALL_GET_OFF    = '~INPUT_VEH_EXIT~ Get off'
Config.Text.FREEFALL_START      = '~INPUT_SPRINT~ + ~INPUT_VEH_ACCELERATE~ Start the Freefall' .. '~n~' .. Config.Text.FREEFALL_GET_OFF
Config.Text.FREEFALL_TIMER      = 'The freefall starts in %s second(s).'