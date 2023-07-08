Shared = Shared or {}

--[[
    Correct order by default:
    {1, 3, 2, 4, 2, 5, 4, 2, 5, 4}
    
    List of doors:
    'lh34hlabs-upperelevator',
    'lh34hlabs-lowerelevator',
    'lh34hlabs-door1',
    'lh34hlabs-door2',
    'lh34hlabs-door3',
    'lh34hlabs-door4',
    'lh34hlabs-door5',
    'lh34hlabs-door6',
    'lh34hlabs-smalllab',
    'lh34hlabs-door7',
    'lh34hlabs-door8',
    'lh34hlabs-door9',
    'lh34hlabs-door10',
    'lh34hlabs-door11',
]]

Shared.Laptop = vector4(991.63, -1660.44, 29.5, 35.61)
Shared.LaptopPrice = 295 -- Price in crypto
Shared.PedName = "Rhodo"

Shared.RobbedPlates = {}

Shared.MinimumPolice = 4
Shared.MinTransportCops = 0

Shared.Explosive = {
    doorId = 356,
    coords = vector3(3525.19, 3702.89, 20.99),
    hit = false
}

Shared.Keypad = {
    hit = false,
    doorId = 'lh34hlabs-labdoor',
    formulaTaken = false,
    difficulty = 7 -- amount of blocks for the hack
}

Shared.Gates = {
    gate1 = 'lh34hlabs-garage1',
    gate2 = 'lh34hlabs-garage2',
    coords = vector3(3620.42, 3743.72, 28.69),
    animation = vector4(3620.22, 3744.92, 28.99, 324.61),
    hit = false
}

Shared.Wiring = {
    [1] = {
        coords = vector4(3543.42, 3670.80, 21.19, 260.91),
        width = 0.6,
        length = 0.2,
        thermiteAnimation = vector4(3543.36, 3671.00, 21.09, 260.00),
        thermitePtfx = vector3(3543.37, 3672.0, 21.09),
        thermited = false,
        unlockDoors = { -- list of doors to be unlocked
            --'lh34hlabs-upperelevator',
            357

        },
        lockDoors = {  -- list of doors to be locked
            --'lh34hlabs-lowerelevator',
            --'lh34hlabs-door1',
            --'lh34hlabs-door2',
            --'lh34hlabs-door3',
            --'lh34hlabs-door4',
            --'lh34hlabs-door5',
            --'lh34hlabs-door6',
            --'lh34hlabs-smalllab',
            --'lh34hlabs-door7',
            --'lh34hlabs-door8',
            --'lh34hlabs-door9',
            --'lh34hlabs-door10',
            --'lh34hlabs-door11'
            357,
            358,
            359,
            360,
            361,
            362,
            363,
            364,
            365,
            367,
            368,
            369,
            370,
            371,
            372,
            373,
            374,
            375,
            376,
            377,
            378,
            379
        }
    },
    [2] = {
        coords = vector4(3537.08, 3670.39, 21.19, 170.1),
        width = 0.6,
        length = 0.2,
        thermiteAnimation = vector4(3537.20, 3670.42, 21.09, 170.00),
        thermitePtfx = vector3(3537.2, 3671.47, 21.09),
        thermited = false,
        unlockDoors = {
            --'lh34hlabs-door1',
            --'lh34hlabs-door3',
            --'lh34hlabs-door7',
            --'lh34hlabs-door8'
            359,
            360,
            363,
            364,
            370,
            371,
            372,
            373
        },
        lockDoors = {
           -- 'lh34hlabs-upperelevator',
            --'lh34hlabs-lowerelevator',
           -- 'lh34hlabs-door2',
           -- 'lh34hlabs-door4',
           -- 'lh34hlabs-door5',
           -- 'lh34hlabs-door6',
           -- 'lh34hlabs-smalllab',
           -- 'lh34hlabs-door9',
           -- 'lh34hlabs-door10',
           -- 'lh34hlabs-door11',
           357,
           358,
           361,
           362,
           365,
           366,
           367,
           368,
           369,
           382,
           383,
           374, 
           375,
           376,
           377,
           378,
           379
        }
    },
    [3] = {
        coords = vector4(3522.55, 3677.39, 21.19, 260.25),
        width = 0.6,
        length = 0.2,
        thermiteAnimation = vector4(3522.52, 3677.45, 21.09, 260.00),
        thermitePtfx = vector3(3522.52, 3678.48, 21.09),
        thermited = false,
        unlockDoors = {
            --'lh34hlabs-lowerelevator',
            358
        },
        lockDoors = {
           -- 'lh34hlabs-upperelevator',
            --'lh34hlabs-door1',
            --'lh34hlabs-door2',
           -- 'lh34hlabs-door3',
           -- 'lh34hlabs-door4',
           -- 'lh34hlabs-door5',
            --'lh34hlabs-door6',
            --'lh34hlabs-smalllab',
            --'lh34hlabs-door7',
           --- 'lh34hlabs-door8',
           -- 'lh34hlabs-door9',
           -- 'lh34hlabs-door10',
           -- 'lh34hlabs-door11'
           357,
           359,
           360,
           361,
           362,
           363,
           364,
           365,
           366,
           367,
           368,
           382,
           383,
           369,
           370,
           371,
           372,
           373,
           374,
           375,
           376,
           377,
           378,
           379
        }
    },
    [4] = {
        coords = vector4(3520.91, 3681.95, 21.19, 80.14),
        width = 0.6,
        length = 0.2,
        thermiteAnimation = vector4(3520.97, 3681.80, 21.09, 80.00),
        thermitePtfx = vector3(3520.96, 3682.80, 21.09),
        thermited = false,
        unlockDoors = {
           -- 'lh34hlabs-door2',
            --'lh34hlabs-door6',
            --'lh34hlabs-door11',
           -- 'lh34hlabs-smalllab'
           361,
           362,
           382,
           383,
           378,
           379,
           369
        },
        lockDoors = {
           -- 'lh34hlabs-upperelevator',
           -- 'lh34hlabs-lowerelevator',
           -- 'lh34hlabs-door1',
           -- 'lh34hlabs-door3',
           -- 'lh34hlabs-door4',
           -- 'lh34hlabs-door5',
           -- 'lh34hlabs-door7',
           -- 'lh34hlabs-door8',
           -- 'lh34hlabs-door9',
           -- 'lh34hlabs-door10',
           357,
           358,
           359,
           363,
           364,
           365,
           366,
           367,
           368,
           370,
           371,
           372,
           373,
           374,
           375,
           376,
           377
        }
    },
    [5] = {
        coords = vector4(3525.72, 3688.49, 21.19, 260.28),
        width = 0.6,
        length = 0.2,
        thermiteAnimation = vector4(3525.67, 3688.66, 21.09, 260.00),
        thermitePtfx = vector3(3525.62, 3689.64, 21.09),
        thermited = false,
        unlockDoors = {
           -- 'lh34hlabs-door4',
          --  'lh34hlabs-door5',
           -- 'lh34hlabs-door9',
           -- 'lh34hlabs-door10'
           365,
           366,
           367,
           368,
           374,
           375,
           376,
           377
        },
        lockDoors = {
          --  'lh34hlabs-upperelevator',
          ----  'lh34hlabs-lowerelevator',
          --  'lh34hlabs-door1',
          --  'lh34hlabs-door2',
           -- 'lh34hlabs-door3',
           -- 'lh34hlabs-door6',
           -- 'lh34hlabs-smalllab',
          --  'lh34hlabs-door7',
          --  'lh34hlabs-door8',
          --  'lh34hlabs-door11',
          357,
          358,
          359,
          360,
          361,
          362,
          363,
          364,
          382,
          383,
          369,
          370,
          371,
          372,
          373,
          378,
          379
        }
    }
}

Shared.SmallLab = {
    [1] = {
        coords = vector3(3558.975, 3672.995, 28.117),
        taken = false
    },
    [2] = {
        coords = vector3(3559.710, 3673.843, 28.117),
        taken = false
    }
}
