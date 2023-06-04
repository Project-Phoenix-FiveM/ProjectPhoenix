# qb-clothing
Clothing for QB-Core Framework :dress:

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

## Screenshots
![image](https://user-images.githubusercontent.com/66404074/153545004-6337e685-d3a5-478c-8fa2-e50f4b1d2030.png)
![image](https://user-images.githubusercontent.com/66404074/153545067-aa9269c9-3bbc-4ce2-bbcf-2dfcff6bbc05.png)
![image](https://user-images.githubusercontent.com/66404074/153545114-0a363fa3-5981-424a-9894-baf15ea1da40.png)
![image](https://user-images.githubusercontent.com/66404074/153545159-255920cc-baf4-4cbb-a569-29b43298638e.png)
![image](https://user-images.githubusercontent.com/66404074/153545179-b4958a16-7ec4-4ae6-a341-ba3786c0042d.png)
![image](https://user-images.githubusercontent.com/66404074/153545214-cb308b2f-9fc4-460b-b630-2dbd80033481.png)

## Features
- Configurable Ped Selection
- Detailed nose, chin, jaw, cheek etc. configuration
- Camera Rotating
- 3 Different Camera Angles
- Clothing Stores
- Barbers
- Job Locker Rooms (Configurable Outfit Presets)
- Saveable Outfits
- /hat, /glasses, /mask (See the commands section below)

### Commands
- /skin (Admin Only) - Opens the clothing menu
- /hat - Toggles the hat on/off
- /mask - Toggles the hmaskat on/off
- /glasses - Toggles the glasses on/off

## Installation
### Manual
- Download the script and put it in the `[qb]` directory.
- Import `qb-clothing.sql` in your database
- Add the following code to your server.cfg/resouces.cfg
```
ensure qb-core
ensure qb-clothing
```

## Configuration
Please see config.lua
