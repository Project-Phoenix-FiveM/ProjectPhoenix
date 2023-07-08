Config = {}
Config.Night = {20, 4} -- Players can rob only from 20:00 to 04:00, interiors doesn't look good with day light.

Config.Ox_Target = false --If you use ox_target set true
Config.Debug = false

Config.StartPed = `a_m_m_soucent_03`

Config.PoliceCloseDoorCommand = 'closeDoor' -- Command por Police to raid the houses.
Config.PoliceJobType = "police" -- police type

Config.SpawnSafe = true -- Random chance to spawn a safe.
Config.SafeChance = 2 --you can change the chance to spawn the safe just put math.random(1, number_you_want), if you want 100% chance to spawn put Config.SafeChance = 2
Config.WaitTime = 0.1 --Time to get a job in minutes

Config.MinimumJobPolice = 1 --number of police to rob houses

Config.LockpickClickAmount = 5 --Number os times you need to do the lockpick minigame

Config.LockpickMinigameTime = 15 -- Time to do the minigame


Config.StartPedLoc = vector4(234.21, -1961.8, 21.96, 215.54) --Start mission ped

Config.LockpickItem = "lockpick" --Item to rob the house

Config.DestroyAdvancedLockpickFail = 80 -- 20% to break the lockpick when fail and call cops

Config.DestroyAdvancedLockpickSuccess = 90 -- 10% chance to destroy the advanced lockpick when success the minigame

Config.RandomChanceToCallCops = 90 -- 10% to call cops when success the minigame (silent alarm)

Config.ResetHouseTimer = math.random(3333333, 11111111) --after this timer the house will close

------------------------------Enter/Exit House Key------------------------------------

Config.HouseKey = 38 -- 38 is key "E" if you want to change the key search for what you want here: https://docs.fivem.net/docs/game-references/controls/

-------------------------------dispatch--------------------------

AlertCops = function() --you can edit your dispatch code inside that function

    exports['ps-dispatch']:HouseRobbery()
    
end

-------------------------------------------------------------------

Config.SafeRewards = { -- It will pick a random combination from this table. 
    [1] = {
        {name = "goldchain", amount = math.random(1,5), info = {}, type = "item", slot = 1},
    }, 
    [2] = {
        {name = "goldchain", amount = math.random(1,5), info = {}, type = "item", slot = 1},
    }, 
    [3] = {
        {name = "iphone", amount = math.random(1,5), info = {}, type = "item", slot = 1},
        {name = "goldchain", amount = math.random(1,5), info = {}, type = "item", slot = 2},
    },
    [4] = {
        {name = "iphone", amount = math.random(1,3), info = {}, type = "item", slot = 1},
        {name = "pistol_ammo", amount = math.random(100,200), info = {}, type = "item", slot = 2},
        {name = "rolex", amount = math.random(1,10), info = {}, type = "item", slot = 3},
        {name = "samsungphone", amount = math.random(1,3), info = {}, type = "item", slot = 4},
        {name = "goldchain", amount = math.random(1,10), info = {}, type = "item", slot = 5},
    },
    [5] = {
        {name = "pistol_ammo", amount = math.random(100,200), info = {}, type = "item", slot = 1},
        {name = "rolex", amount = math.random(1,10), info = {}, type = "item", slot = 2},
        {name = "samsungphone", amount = math.random(1,3), info = {}, type = "item", slot = 3},
        {name = "goldchain", amount = math.random(1,10), info = {}, type = "item", slot = 4},
        {name = "diamond_ring", amount = math.random(1,5), info = {}, type = "item", slot = 5},
    },
}

Config.ItemsReward = { -- It will pick a random combination from this table.
    [1] = {
        {type = 'cash', itemName = 'cash', itemQty = math.random(100, 200)},
        {type = 'item', itemName = 'sandwich', itemQty = math.random(2, 4)},
    
    },
    [2] = {{
        type = 'item',
        itemName = 'sandwich',
        itemQty = math.random(2, 4)
    }},
    [3] = {{
        type = 'item',
        itemName = 'water_bottle',
        itemQty = math.random(2, 4)
    }},
    [4] = {{
        type = 'item',
        itemName = 'pistol_ammo',
        itemQty = math.random(1, 2)
    }},
    [5] = {{
        type = 'item',
        itemName = 'pistol_ammo',
        itemQty = math.random(100, 200)
    }},
    [6] = {{
        type = 'item',
        itemName = 'rolex',
        itemQty = 1
    }},
    [7] = {{
        type = 'item',
        itemName = 'rolex',
        itemQty = 1
    }},
    [8] = {{
        type = 'item',
        itemName = 'goldchain',
        itemQty = math.random(1, 3)
    }},
    [9] = {{
        type = 'item',
        itemName = 'rolex',
        itemQty = math.random(1, 3)
    }},
    [10] = {{
        type = 'item',
        itemName = 'diamond_ring',
        itemQty = 1
    }},
    [11] = {{
        type = 'item',
        itemName = 'rolex',
        itemQty = 1
    }},
    [12] = {{
        type = 'item',
        itemName = 'samsungphone',
        itemQty = 1
    }},
}

Config.Lang = {
    ['money_found'] = 'You found $',
    ['failed'] = 'You failed! Try again',
    ['missing'] = 'You are missing something',
    ['enter'] = '[E] - To enter',
    ['leave'] = '[E] - To leave',
    ['carrying'] = 'You can\'t do this right now',
    ['bosswait'] = 'Wait until the boss finds you a house',
    ['nohouses'] = 'No houses available!',
    ['bosssearch'] = 'Chill, the boss is looking for a house!',
    ['nocops'] = 'You can\'t do that right now!',
    ['night'] = 'You only can rob at night!',
    ['job'] = 'Get a job!',
    ['novehicle'] = 'Cannot get in the car holding this.',
    ['progressbar'] = 'Searching..',
    ['target'] = 'Search',
    ['houseblip'] = 'Assigned House',

}

Config.Houses = { -- Houses entry and model
    [1] = {
        x = 31.492990493774,
        y = 6596.619140625,
        z = 32.81018447876,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
	},
    [2] = {
        x = 11.572845458984,
        y = 6578.3662109375,
        z = 33.060623168945,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
    [3] = {
        x = -15.09232711792,
        y = 6557.7416992188,
        z = 33.240436553955,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[4] = {
		x = -41.538372039795,
		y = 6637.4028320312,
		z = 31.08752822876,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
	},
	[5] = {
		x = -9.6467323303223,
		y = 6654.1987304688,
		z = 31.712518692017,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
	},
	[6] = {
        x = 1.7621871232986,
        y = 6612.5390625,
        z = 32.109931945801,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[7] = {
        x = -26.635080337524,
        y = 6597.27734375,
        z = 31.860597610474,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[8] = {
        x = 35.366596221924,
        y = 6662.84765625,
        z = 32.190341949463,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[9] = {
        x = -356.76190185547,
        y = 6207.3330078125,
        z = 31.91400718689,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[10] = {
        x = -374.45736694336,
        y = 6191.0849609375,
        z = 31.72954750061,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[11] = {
        x = -245.86965942383,
        y = 6414.3569335938,
        z = 31.460599899292,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[12] = {
        x = 495.17916870117,
        y = -1823.2989501953,
        z = 28.869707107544,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[13] = {
        x = 489.60406494141,
        y = -1714.0977783203,
        z = 29.706550598145,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[14] = {
        x = 500.58831787109,
        y = -1697.1359863281,
        z = 29.787733078003,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[15] = {
        x = 419.07574462891,
        y = -1735.4970703125,
        z = 29.607694625854,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[16] = {
        x = 431.14743041992,
        y = -1725.3588867188,
        z = 29.601457595825,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[17] = {
        x = 443.34533691406,
        y = -1707.3347167969,
        z = 29.70036315918,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[18] = {
        x = 368.80645751953,
        y = -1895.8767089844,
        z = 25.178525924683,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[19] = {
        x = 385.10110473633,
        y = -1881.580078125,
        z = 26.031482696533,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[20] = {
        x = 399.43417358398,
        y = -1865.1263427734,
        z = 26.715923309326,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[21] = {
        x = 412.32699584961,
        y = -1856.2395019531,
        z = 27.323152542114,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[22] = {
        x = 427.44403076172,
        y = -1842.3278808594,
        z = 28.462642669678,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[23] = {
        x = 312.01104736328,
        y = -1956.1602783203,
        z = 24.625070571899,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[24] = {
        x = 324.36328125,
        y = -1937.5997314453,
        z = 25.018976211548,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[25] = {
        x = 295.92004394531,
        y = -1971.8889160156,
        z = 22.80372428894,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[26] = {
        x = 291.58758544922,
        y = -1980.515625,
        z = 21.600521087646,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[27] = {
        x = 279.71060180664,
        y = -1993.9146728516,
        z = 20.805452346802,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[28] = {
        x = 256.4538269043,
        y = -2023.3701171875,
        z = 19.266801834106,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[29] = {
        x = 236.01176452637,
        y = -2046.3182373047,
        z = 18.379932403564,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[30] = {
        x = 148.76959228516,
        y = -1904.4891357422,
        z = 23.517498016357,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[31] = {
        x = 128.07450866699,
        y = -1897.0458984375,
        z = 23.674228668213,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[32] = {
        x = 115.33438110352,
        y = -1887.7604980469,
        z = 23.927993774414,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[33] = {
        x = 103.993019104,
        y = -1885.2415771484,
        z = 24.304039001465,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[34] = {
        x = 216.33517456055,
        y = 620.27862548828,
        z = 187.75686645508,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[35] = {
        x = -912.25305175781,
        y = 777.16571044922,
        z = 187.01055908203,
        houseModel = 'MidApt',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[36] = {
        x = -762.17169189453,
        y = 430.80480957031,
        z = 100.17984771729,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[37] = {
        x = -679.01800537109,
        y = 512.04656982422,
        z = 113.52597808838,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[38] = {
        x = -640.71325683594,
        y = 520.20758056641,
        z = 110.06629943848,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[39] = {
        x = -595.52197265625,
        y = 530.25726318359,
        z = 108.06629943848,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[40] = {
        x = -526.93499755859,
        y = 517.22058105469,
        z = 113.1662979126,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[41] = {
        x = -459.220703125,
        y = 536.86401367188,
        z = 121.36630249023,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[42] = {
        x = -417.94924926758,
        y = 569.06427001953,
        z = 125.1662979126,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[43] = {
        x = -311.78060913086,
        y = 474.95440673828,
        z = 111.96630096436,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[44] = {
        x = -304.98672485352,
        y = 431.05224609375,
        z = 110.6662979126,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[45] = {
        x = -72.793998718262,
        y = 428.53192138672,
        z = 113.36630249023,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[46] = {
        x = -66.838043212891,
        y = 490.05136108398,
        z = 144.86483764648,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[47] = {
        x = -110.07062530518,
        y = 501.92742919922,
        z = 143.45491027832,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[48] = {
        x = -174.52659606934,
        y = 502.4521484375,
        z = 137.42042541504,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[49] = {
        x = -230.21437072754,
        y = 487.83517456055,
        z = 128.76806640625,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[50] = {
        x = -907.65112304688,
        y = 544.91998291016,
        z = 100.36024475098,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[51] = {
        x = -904.60345458984,
        y = 588.14251708984,
        z = 101.12745666504,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[52] = {
        x = -974.55877685547,
        y = 581.84942626953,
        z = 103.14652252197,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[53] = {
        x = -1022.719909668,
        y = 586.90777587891,
        z = 103.4294052124,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[54] = {
        x = -1107.4542236328,
        y = 594.22204589844,
        z = 104.45043945312,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[55] = {
        x = -1125.4201660156,
        y = 548.62109375,
        z = 102.56945037842,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[56] = {
        x = -1146.5546875,
        y = 545.87408447266,
        z = 101.89562988281,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[57] = {
        x = -595.67047119141,
        y = 393.24130249023,
        z = 101.88217926025,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[58] = {
        x = 84.95435333252,
        y = 561.70123291016,
        z = 182.73361206055,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    },
	[59] = {
        x = 232.20700073242,
        y = 672.14221191406,
        z = 189.97434997559,
        houseModel = 'HighEnd',
        InteriorSpawned = false,
        NoiseLevel = 0,
        alarmTriggered = false,
        Robbed = false,
        Opened = false,
        InteriorCoords = nil,
        InteriorObjects = {},
        Items = {}
    }
}



-- PROPS ITEMS
Config.PropList = {
    ['stolentv'] = {
        ['name'] = 'A flatscreen',
        ['prop'] = 'prop_tv_flat_01',
        ['hash'] = `prop_tv_flat_01`,
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.15,
            ['Y'] = 0.10,
            ['Z'] = -0.20,
            ['XR'] = -50.00,
            ['YR'] = 250.00,
            ['ZR'] = 10.00,
        },
    },
    ['stolenmicro'] = {
        ['name'] = 'A microwave',
        ['prop'] = 'prop_micro_01',
        ['hash'] = `prop_micro_01`,
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.30,
            ['Y'] = 0.05,
            ['Z'] = -0.20,
            ['XR'] = -50.00,
            ['YR'] = 250.00,
            ['ZR'] = 15.00,
        },
    },
    ['stolenart'] = {
        ['name'] = 'A art',
        ['prop'] = 'ex_mp_h_acc_artwalll_02',
        ['hash'] = `ex_mp_h_acc_artwalll_02`,
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.15,
            ['Y'] = 0.10,
            ['Z'] = -0.20,
            ['XR'] = -50.00,
            ['YR'] = 250.00,
            ['ZR'] = 10.00,
        },
    },
    ['stolenlaptop'] = {
        ['name'] = 'A laptop',
        ['prop'] = 'prop_laptop_02_closed',
        ['hash'] = `prop_laptop_02_closed`,
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.30,
            ['Y'] = 0.05,
            ['Z'] = -0.20,
            ['XR'] = -50.00,
            ['YR'] = 250.00,
            ['ZR'] = 15.00,
        },
    },
    ['stolencoffee'] = {
        ['name'] = 'A coffeemaker',
        ['prop'] = 'prop_coffee_mac_02',
        ['hash'] = `prop_coffee_mac_02`,
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = 0.30,
            ['Y'] = 0.05,
            ['Z'] = -0.20,
            ['XR'] = -50.00,
            ['YR'] = 250.00,
            ['ZR'] = 15.00,
        },
    },
    ['stolenscope'] = {
        ['name'] = 'A telescope',
        ['prop'] = 'prop_t_telescope_01b',
        ['hash'] = `prop_t_telescope_01b`,
        ['bone-index'] = {
            ['bone'] = 57005,
            ['X'] = -0.06,
            ['Y'] = 0.0,
            ['Z'] = -0.31,
            ['XR'] = 0.0,
            ['YR'] = 20.00,
            ['ZR'] = 0.0,
        },
    },
}
