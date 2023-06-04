# qb-vehiclesales
Used Car Sale for QB-Core Framework :blue_car:

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>


## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-garages](https://github.com/qbcore-framework/qb-garages) - Vehicle ownership
- [qb-phone](https://github.com/qbcore-framework/qb-phone) - For the e-mail
- [qb-logs](https://github.com/qbcore-framework/qb-logs) - Keep event logs

## Screenshots
![Put Vehicle On Sale](https://imgur.com/bzE9e3o.png)
![Vehicle Sale Contract](https://imgur.com/A1ARcFV.png)
![Sell Vehicle To Dealer](https://imgur.com/zpEeBwk.png)
![Vehicle Sold Mail](https://imgur.com/vvz2UM3.png)
![Buy Vehicle](https://imgur.com/BEf5nDu.png)
![Vehicle Actions](https://imgur.com/HMuXtBd.png)

## Features
- Ability to put your vehicle on sale for other players to buy
- Ability to take your vehicle back if it is not sold yet
- Ability to sell your vehicle to the dealer for a fixed amount

## Installation
### Manual
- Download the script and put it in the `[qb]` directory.
- Import `qb-vehiclesales.sql` in your database
- Add the following code to your server.cfg/resouces.cfg
```
ensure qb-core
ensure qb-garages
ensure qb-phone
ensure qb-logs
ensure qb-vehiclesales
```

## Configuration
- To adjust tax, go to qb-vehiclesales\server\main.lua row 85 and change "77" to your liking
```
Config = Config or {}

Config.SellVehicle = { -- Put Vehicle On Sale Marker
    ["x"] = 1235.43,
    ["y"] = 2730.95,
    ["z"] = 37.91,
}

Config.SellVehicleBack = { -- Sell Vehicle To Dealer Marker
    ["x"] = 1235.1,
    ["y"] = 2740.7,
    ["z"] = 37.68,
}

Config.BuyVehicle =     { -- Location Bought Vehicle Will Be Spawned
        ["x"] = 1213.31, 
        ["y"] = 2735.4, 
        ["z"] = 38.27, 
        ["h"] = 182.5
    }

Config.OccasionSlots = { -- Vehicle Display Places
    {
        ["x"] = 1237.07, 
        ["y"] = 2699.0, 
        ["z"] = 38.27, 
        ["h"] = 1.5
    },

    {
        ["x"] = 1232.98, 
        ["y"] = 2698.92, 
        ["z"] = 38.27, 
        ["h"] = 2.5
    },

    {
        ["x"] = 1228.9, 
        ["y"] = 2698.78, 
        ["z"] = 38.27, 
        ["h"] = 3.5
    },

    {
        ["x"] = 1224.9, 
        ["y"] = 2698.51, 
        ["z"] = 38.27, 
        ["h"] = 2.5
    },

    {
        ["x"] = 1220.93, 
        ["y"] = 2698.28, 
        ["z"] = 38.27, 
        ["h"] = 2.5
    },


    {
        ["x"] = 1216.97, 
        ["y"] = 2698.05, 
        ["z"] = 38.27, 
        ["h"] = 0.5
    },

    {
        ["x"] = 1216.67, 
        ["y"] = 2709.21, 
        ["z"] = 38.27, 
        ["h"] = 1.5
    }, 

    {
        ["x"] = 1220.67, 
        ["y"] = 2709.26, 
        ["z"] = 38.27, 
        ["h"] = 1.5
    }, 

    {
        ["x"] = 1224.53, 
        ["y"] = 2709.27, 
        ["z"] = 38.27, 
        ["h"] = 2.5
    }, 

    {
        ["x"] = 1228.52, 
        ["y"] = 2709.42, 
        ["z"] = 38.27, 
        ["h"] = 1.5
    }, 

    {
        ["x"] = 1232.53, 
        ["y"] = 2709.49, 
        ["z"] = 38.27, 
        ["h"] = 1.5
    }, 

    {
        ["x"] = 1236.71, 
        ["y"] = 2709.51, 
        ["z"] = 38.27, 
        ["h"] = 1.5
    }, 

    {
        ["x"] = 1216.41, 
        ["y"] = 2717.99, 
        ["z"] = 38.27, 
        ["h"] = 1.5
    }, 

    {
        ["x"] = 1220.39, 
        ["y"] = 2718.0, 
        ["z"] = 38.27, 
        ["h"] = 0.5
    }, 

    {
        ["x"] = 1224.35, 
        ["y"] = 2718.07, 
        ["z"] = 38.27, 
        ["h"] = 1.5
    }, 

    {
        ["x"] = 1228.41, 
        ["y"] = 2718.22, 
        ["z"] = 38.27, 
        ["h"] = 1.5
    }, 

    {
        ["x"] = 1249.63, 
        ["y"] = 2707.84, 
        ["z"] = 38.27, 
        ["h"] = 99.5
    }, 

    {
        ["x"] = 1248.92, 
        ["y"] = 2712.25, 
        ["z"] = 38.27, 
        ["h"] = 101.5
    }, 

    {
        ["x"] = 1247.3, 
        ["y"] = 2716.59, 
        ["z"] = 38.27, 
        ["h"] = 120.5
    }, 

    {
        ["x"] = 1244.09, 
        ["y"] = 2720.4, 
        ["z"] = 38.27, 
        ["h"] = 149.5
    }, 

    {
        ["x"] = 1239.93, 
        ["y"] = 2722.39, 
        ["z"] = 38.27, 
        ["h"] = 163.5
    }, 

    {
        ["x"] = 1248.28, 
        ["y"] = 2727.41, 
        ["z"] = 38.53, 
        ["h"] = 338.5
    }, 

 
    {
        ["x"] = 1251.84, 
        ["y"] = 2725.65, 
        ["z"] = 38.52, 
        ["h"] = 331.5
    }, 

 
    {
        ["x"] = 1255.19, 
        ["y"] = 2723.21, 
        ["z"] = 38.44, 
        ["h"] = 309.5
    }, 

 
    {
        ["x"] = 1257.28, 
        ["y"] = 2719.77, 
        ["z"] = 38.49, 
        ["h"] = 296.5
    }, 

 
    {
        ["x"] = 1258.43, 
        ["y"] = 2716.2, 
        ["z"] = 38.46, 
        ["h"] = 285.5
    }, 

 
    {
        ["x"] = 1258.92, 
        ["y"] = 2712.28, 
        ["z"] = 38.37, 
        ["h"] = 270.5
    }, 

 
    {
        ["x"] = 1258.9, 
        ["y"] = 2708.3, 
        ["z"] = 38.21, 
        ["h"] = 269.5
    }, 

 
    {
        ["x"] = 1258.87, 
        ["y"] = 2704.21, 
        ["z"] = 38.05, 
        ["h"] = 271.5
    }, 

 
    {
        ["x"] = 1269.11, 
        ["y"] = 2694.67, 
        ["z"] = 37.85, 
        ["h"] = 184.5
    }, 

 
    {
        ["x"] = 1273.53, 
        ["y"] = 2694.98, 
        ["z"] = 37.87, 
        ["h"] = 184.5
    }, 

 
    {
        ["x"] = 1277.56, 
        ["y"] = 2695.43, 
        ["z"] = 37.87, 
        ["h"] = 183.5
    }, 

 
    {
        ["x"] = 1281.53, 
        ["y"] = 2695.67, 
        ["z"] = 37.88, 
        ["h"] = 186.5
    }, 

 
    {
        ["x"] = 1285.51, 
        ["y"] = 2696.02, 
        ["z"] = 37.88, 
        ["h"] = 185.5
    }, 

 
    {
        ["x"] = 1289.74, 
        ["y"] = 2696.27, 
        ["z"] = 37.88, 
        ["h"] = 182.5
    }, 

 
    {
        ["x"] = 1293.75, 
        ["y"] = 2696.47, 
        ["z"] = 37.86, 
        ["h"] = 184.5
    }, 
}
```
