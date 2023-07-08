Config = Config or {}

--- STARTER PED STUFF HERE
Config.PedModel = `s_m_y_valet_01`
Config.PedLocation = vector4(110.29, -1088.75, 29.3, 355.0)
--- END OF STARTER PED STUFF
Config.FuelScript = 'cdn-fuel' -- cdn-fuel, ps-fuel, lj-fuel change to whatever fuel system you use
Config.MoneyReturn = 0.6 -- this is 60% money return once the rental vehicle is returned

Config.VehicleData = {
    [1] = {
        vehiclehash = 'sultan', -- Name of the vehicle
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065029457590620190/image.png', -- Image of the vehicle 
        icon = 'fas fa-car',
        gas = math.random(30, 70), -- Random amount of gas the vehicle will have 
        price = 500, -- Price of the vehicle to rent
    },
    [2] = {
        vehiclehash = 'bison',
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065029459079594034/image.png',
        icon = 'fas fa-car',
        gas = math.random(30, 70),
        price = 1500,
    },
    [3] = {
        vehiclehash = 'surge',
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065029459666800690/image.png',
        icon = 'fas fa-car',
        gas = math.random(30, 70),
        price = 900,
    },
    [4] = {
        vehiclehash = 'sanchez',
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065029458530148482/image.png',
        icon = 'fas fa-motorcycle',
        gas = math.random(30, 70),
        price = 800,
    },
    [5] = {
        vehiclehash = 'faggio3',
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065074724880781353/image.png',
        icon = 'fas fa-motorcycle',
        gas = math.random(30, 70),
        price = 100,
    },
    [6] = {
        vehiclehash = 'bmx',
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065071122141425706/image.png',
        icon = 'fas fa-bicycle',
        gas = 0,
        price = 250,
    },
    [7] = {
        vehiclehash = 'tribike',
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065071578649477131/image.png',
        icon = 'fas fa-bicycle',
        gas = 0,
        price = 300,
    },
    [8] = {
        vehiclehash = 'furia',
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065072695672315984/image.png',
        icon = 'fas fa-car',
        gas = math.random(30, 70),
        price = 35000,
    },
    [9] = {
        vehiclehash = 'bullet',
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065073275140575362/image.png',
        icon = 'fas fa-car',
        gas = math.random(30, 70),
        price = 45000,
    },
    [10] = {
        vehiclehash = 'emerus',
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065073881876008960/image.png',
        icon = 'fas fa-car',
        gas = math.random(30, 70),
        price = 50000,
    },
    [11] = {
        vehiclehash = 'stretch',
        vehicleimage = 'https://cdn.discordapp.com/attachments/907789876177555495/1065074259279478835/image.png',
        icon = 'fas fa-car',
        gas = math.random(30, 70),
        price = 3000,
    },
}

Config.SpawnLocations = { -- Locations the vehicles spawn at
    vector4(104.22, -1078.56, 28.59, 337.64),
    vector4(108.02, -1079.43, 28.59, 340.45),
    vector4(111.42, -1080.65, 28.59, 339.63),
    vector4(117.54, -1081.83, 28.59, 0.05),
    vector4(121.1, -1081.53, 28.59, 358.75),
    vector4(124.78, -1081.5, 28.59, 359.93)
}