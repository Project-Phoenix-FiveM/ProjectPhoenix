Config = Config or {}

Config.ItemTiers = 1

--33% on each to get money/an item or nothing
Config.RewardTypes = {
    [1] = {
        type = "item"
    },
    [2] = {
        type = "money",
    },
    [3] = {
        type = "nothing",
    }
}

--rewards for small trashcans
Config.RewardsSmall = {
        [1] = {item = "cokebaggy", minAmount = 1, maxAmount = 1},
        [2] = {item = "lockpick", minAmount = 1, maxAmount = 1},
        [3] = {item = "rubber", minAmount = 1, maxAmount = 3},
        [4] = {item = "rolling_paper", minAmount = 1, maxAmount = 4},
        [5] = {item = "plastic", minAmount = 1, maxAmount = 7},
        [6] = {item = "cigarette", minAmount = 1, maxAmount = 1},
        [7] = {item = "cloth", minAmount = 1, maxAmount = 6},
        [8] = {item = "bottle", minAmount = 2, maxAmount = 10},
        [9] = {item = "can", minAmount = 1, maxAmount = 7},
}

Config.Dumpsters = {
    [1] = {['Model'] = 666561306,    ['Name'] = 'Blauwe Bak'},
    [2] = {['Model'] = 218085040,    ['Name'] = 'Licht Blauwe Bak'},
    [3] = {['Model'] = -58485588,    ['Name'] = 'Grijze Bak'},
    [4] = {['Model'] = 682791951,    ['Name'] = 'Grote Blauwe Bak'},
    [5] = {['Model'] = -206690185,   ['Name'] = 'Grote Groene Bak'},
    [6] = {['Model'] = 364445978,    ['Name'] = 'Grote Groene Bak'},
    [7] = {['Model'] = 143369,       ['Name'] = 'Kleine Bak'},
    [8] = {['Model'] = -2140438327,  ['Name'] = 'Onbekende Bak'},
    [9] = {['Model'] = -1851120826,  ['Name'] = 'Onbekende Bak'},
    [10] = {['Model'] = -1543452585, ['Name'] = 'Onbekende Bak'},
    [11] = {['Model'] = -1207701511, ['Name'] = 'Onbekende Bak'},
    [12] = {['Model'] = -918089089,  ['Name'] = 'Onbekende Bak'},
    [13] = {['Model'] = 1511880420,  ['Name'] = 'Onbekende Bak'},
    [14] = {['Model'] = 1329570871,  ['Name'] = 'Onbekende Bak'},
}