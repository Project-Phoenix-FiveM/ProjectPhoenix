# qb-banking

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
- [qb-logs](https://github.com/qbcore-framework/qb-logs) - For keeping records

## Screenshots
![Account Home](https://i.imgur.com/XazaYYI.png)
![Debit Card Selection on ATM](https://i.imgur.com/dvJ9hnC.png)
![Savings Account](https://i.imgur.com/1HFUL06.png)
![Transfer](https://i.imgur.com/SqADuRg.png)
![Account Options](https://i.imgur.com/blMgfpG.png)

## Features
- Debit card (MasterCard/Visa) with PIN
- Savings Account
- Detailed interface
- /atm for players
- /refreshBanks
- Business and Gang accounts

## Installation
### Manual
- Download the script and put it in the `[qb]` directory.
- Import `qb-banking.sql` in your database
- Add the following code to your server.cfg/resouces.cfg
```
ensure qb-core
ensure qb-logs
ensure qb-banking
```
# Server.cfg Convar Update
- Global DrawTextUi Option
```
setr UseTarget false
``` 

- Global Target Option
```
setr UseTarget true
```

## Configuration
```
Config = {}

Config.Blip = {
    blipName = "Bank", -- Blips name for banks
    blipType = 108, -- Blip icon for banks
    blipColor = 37, -- Blip color for banks
    blipScale = 0.8 -- Blip scale for banks
    }

Config.ATMModels = { -- Props which will be considered as ATM (Can use /atm nearby)
        "prop_atm_01",
        "prop_atm_02",
        "prop_atm_03",
        "prop_fleeca_atm"
    }

Config.BankLocations = { -- Bank locations
    { ['x'] = 149.9,    ['y'] = -1040.46,   ['z'] = 29.37,  ['bankOpen'] = true, ['bankCooldown'] = 0 },
    { ['x'] = 314.23,   ['y'] = -278.83,    ['z'] = 54.17,  ['bankOpen'] = true, ['bankCooldown'] = 0 },
    { ['x'] = -350.8,   ['y'] = -49.57,     ['z'] = 49.04,  ['bankOpen'] = true, ['bankCooldown'] = 0 },
    { ['x'] = -1213.0,  ['y'] = -330.39,    ['z'] = 37.79,  ['bankOpen'] = true, ['bankCooldown'] = 0 },
    { ['x'] = -2962.71, ['y'] = 483.0,      ['z'] = 15.7,   ['bankOpen'] = true, ['bankCooldown'] = 0 },
    { ['x'] = 1175.07,  ['y'] = 2706.41,    ['z'] = 38.09,  ['bankOpen'] = true, ['bankCooldown'] = 0 },
    { ['x'] = 1653.41,  ['y'] = 4850.6,     ['z'] = 41.99,  ['bankOpen'] = true, ['bankCooldown'] = 0 },
    
    -- Pacific Standard Bank
    { ['x'] = 246.64, ['y'] = 223.20, ['z'] = 106.29, ['bankOpen'] = true, ['bankCooldown'] = 0 },
    -- Paleto
    { ['x'] = -113.22, ['y'] = 6470.03, ['z'] = 31.63, ['bankOpen'] = true, ['bankCooldown'] = 0 },
}

Config.cardTypes = { "visa", "mastercard"} -- Debit card types (When requesting a debit card it gives randomly one of these.)
```
