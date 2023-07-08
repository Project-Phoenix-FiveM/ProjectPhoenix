Config = {
    Framework = 2, --[ 1 = ESX / 2 = QBCore / 3 = Other ] Choose your framework

	FrameworkTriggers = {
		notify = '', -- [ ESX = 'esx:showNotification' / QBCore = 'QBCore:Notify' ] Set the notification event, if left blank, default will be used
		object = '', --[ ESX = 'esx:getSharedObject' / QBCore = 'QBCore:GetObject' ] Set the shared object event, if left blank, default will be used (deprecated for QBCore)
		resourceName = '', -- [ ESX = 'es_extended' / QBCore = 'qb-core' ] Set the resource name, if left blank, automatic detection will be performed
	},
    
    NotificationDistance = 10.0,
    PropsToRemove = {
        vector3(1992.803, 3047.312, 46.22865),
    },

    -- qtarget
	UseQTarget = false,

	-- BT-Target
	UseBTTarget = false,

	-- QB-Target
	UseQBTarget = true,

    --[[
        Uses esx/qbcore notifications. Set to false for native GTA notifications
    ]]
    UseFrameworkNotification = true,

    --[[
        -- To use custom menu, implement following client handlers
        AddEventHandler('rcore_pool:openMenu', function()
            -- open menu with your system
        end)

        AddEventHandler('rcore_pool:closeMenu', function()
            -- close menu, player has walked far from table
        end)


        -- After selecting game type, trigger one of the following setupTable events
        TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_8_BALL')
        TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_STRAIGHT_POOL')
    ]]
    CustomMenu = false,

    --[[
        When you want your players to pay to play pool, set this to true and set BallSetupCost
    ]]
    PayForSettingBalls = true,
    BallSetupCost = 100, -- for example: 1 or 200 - MUST be number

    --[[
        You can integrate pool cue into your system with

        SERVERSIDE HANDLERS
            - rcore_pool:onReturnCue - called when player takes cue
            - rcore_pool:onTakeCue   - called when player returns cue
            - rcore_pool:requestPoolCue   - forces player to take cue in hand
            - rcore_pool:requestRemoveCue - removes cue from player's hand

        This prevents players from taking cue from cue rack if `false`
    ]]
    AllowTakePoolCueFromStand = true,

    --[[
        This option is for servers whose anticheats prevents
        this script from setting players invisible.

        When player's ped is blocking camera when aiming,
        set this to true
    ]]
    DoNotRotateAroundTableWhenAiming = false,
    
    AllowedPoolPlaces = nil, -- {vector3(-574.52, 288.8, 79.17)},

    Debug = false,

    MenuColor = {245, 127, 23},
    Keys = {
        BACK = {code = 200, label = 'INPUT_FRONTEND_PAUSE_ALTERNATE'},
        ENTER = {code = 38, label = 'INPUT_PICKUP'},
        SETUP_MODIFIER = {code = 21, label = 'INPUT_SPRINT'},
        CUE_HIT = {code = 179, label = 'INPUT_CELLPHONE_EXTRA_OPTION'},
        CUE_LEFT = {code = 174, label = 'INPUT_CELLPHONE_LEFT'},
        CUE_RIGHT = {code = 175, label = 'INPUT_CELLPHONE_RIGHT'},
        AIM_SLOWER = {code = 21, label = 'INPUT_SPRINT'},
        BALL_IN_HAND = {code = 29, label = 'INPUT_SPECIAL_ABILITY_SECONDARY'},

        BALL_IN_HAND_LEFT = {code = 174, label = 'INPUT_CELLPHONE_LEFT'},
        BALL_IN_HAND_RIGHT = {code = 175, label = 'INPUT_CELLPHONE_RIGHT'},
        BALL_IN_HAND_UP = {code = 172, label = 'INPUT_CELLPHONE_UP'},
        BALL_IN_HAND_DOWN = {code = 173, label = 'INPUT_CELLPHONE_DOWN'},
    },
    Text = {
        BACK = "Back",
        HIT = "Hit",
        BALL_IN_HAND = "Ball-in-Hand",
        BALL_IN_HAND_BACK = "Back",
        AIM_LEFT = "Aim left",
        AIM_RIGHT = "Aim right",
        AIM_SLOWER = "Aim slower",

        POOL = 'Pool',
        POOL_GAME = 'Pool game',
        POOL_SUBMENU = 'Select ball configuration',
        TYPE_8_BALL = '8-ball',
        TYPE_STRAIGHT = 'Straight pool',
        POOL_SETUP = 'Setup: ',

        HINT_SETUP = 'Set up table',
        HINT_TAKE_CUE = 'Take pool cue',
        HINT_RETURN_CUE = 'Return pool cue',
        HINT_HINT_TAKE_CUE = 'To play pool, take pool cue at the pool cue stand',
        HINT_PLAY = 'Play',

        NOT_ENOUGH_MONEY = 'You don\'t have $%s to setup this table.',

        BALL_IN_HAND_LEFT = 'Left',
        BALL_IN_HAND_RIGHT = 'Right',
        BALL_IN_HAND_UP = 'Up',
        BALL_IN_HAND_DOWN = 'Down',
        BALL_POCKETED = '%s ball was pocketed',
        BALL_IN_HAND_NOTIFY = 'Player has taken cue ball in hand',
        BALL_LABELS = {
            [-1] = 'Cue',
            [1] = '~y~Solid 1~s~',
            [2] = '~b~Solid 2~s~',
            [3] = '~r~Solid 3~s~',
            [4] = '~p~Solid 4~s~',
            [5] = '~o~Solid 5~s~',
            [6] = '~g~Solid 6~s~',
            [7] = '~r~Solid 7~s~',
            [8] = 'Black solid 8',
            [9] = '~y~Striped 9~s~',
            [10] = '~b~Striped 10~s~',
            [11] = '~r~Striped 11~s~',
            [12] = '~p~Striped 12~s~',
            [13] = '~o~Striped 13~s~',
            [14] = '~g~Striped 14~s~',
            [15] = '~r~Striped 15~s~',
         }
    },
}

if Config.UseFrameworkNotification then
    for idx, text in pairs(Config.Text.BALL_LABELS) do
        Config.Text.BALL_LABELS[idx] = text:gsub('~.~', '')
    end
end

if Config.UseQTarget then
	Config.TargetResourceName = 'qtarget'
end
if Config.UseBTTarget then
	Config.TargetResourceName = 'bt-target'
end
if Config.UseQBTarget then
	Config.TargetResourceName = 'qb-target'
end