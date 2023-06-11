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
        [1] = {item = "water", minAmount = 1, maxAmount = 1},
        [2] = {item = "sandwich", minAmount = 1, maxAmount = 1},
        [3] = {item = "weedplant_seedm", minAmount = 1, maxAmount = 1},
        
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
    [15] = {['Model'] = -1096777189,  ['Name'] = 'Bin'},
    [16] = {['Model'] = -1437508529,  ['Name'] = 'Bin'},
    [17] = {['Model'] = -1426008804,  ['Name'] = 'Bin'},
    [18] = {['Model'] = -228596739,  ['Name'] = 'Bin'},
    [19] = {['Model'] = 161465839,  ['Name'] = 'Bin'},
    [20] = {['Model'] = 651101403,  ['Name'] = 'Bin'},


}