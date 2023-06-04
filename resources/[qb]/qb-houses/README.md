# qb-houses
Real Estate for QB-Core Framework :house_with_garden:

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
- [qb-radialmenu](https://github.com/qbcore-framework/qb-radialmenu) - For the menu in screenshots
- [qb-anticheat](https://github.com/qbcore-framework/qb-anticheat) - Anti Cheat 
- [qb-phone](https://github.com/qbcore-framework/qb-phone) - Houses app
- [qb-multicharacter](https://github.com/qbcore-framework/qb-multicharacter) - Checking if player is inside after character chosen (You need to edit the lines if you don't use this)
- [qb-garages](https://github.com/qbcore-framework/qb-garages) - House Garage
- [qb-interior](https://github.com/qbcore-framework/qb-interior) - Necessary for house interiors
- [qb-clothing](https://github.com/qbcore-framework/qb-clothing) - Outfits
- [qb-weathersync](https://github.com/qbcore-framework/qb-weathersync) - Desync weather inside house
- [qb-weed](https://github.com/qbcore-framework/qb-weed) - Weed plant
- [qb-skillbar](https://github.com/qbcore-framework/qb-skillbar) - Skills

## Screenshots
![Buy House](https://imgur.com/4eQnRqA.png)
![House Door](https://imgur.com/UQzvdzn.png)
![Garage](https://imgur.com/XRbkzsP.png)
![Radial Menu](https://imgur.com/GTpalYW.png)
![Decorate](https://imgur.com/Bbp6rvI.png)
![Object Placing](https://imgur.com/fmV0gPM.png)
![Stash](https://imgur.com/HarcCIU.png)
![Inside Door](https://imgur.com/Y0rzBuy.png)
![Security Camera](https://imgur.com/a0qPwsL.png)

# House Tiers
## T1
![Tier 1](https://i.imgur.com/pLVzo6G.jpg)
![Tier 1](https://i.imgur.com/YqZHjra.jpg)
## T2
![Tier 2](https://i.imgur.com/mp3XL4Y.jpg)
![Tier 2](https://i.imgur.com/3DH9RFw.jpg)
## T3
![Tier 3](https://i.imgur.com/1XF60jD.jpg)
![Tier 3](https://i.imgur.com/iVYajrY.jpg)
## T4
![Tier 4](https://i.imgur.com/ubt165o.jpg)
![Tier 4](https://i.imgur.com/x5nXid5.jpg)
## T5
![Tier 5](https://i.imgur.com/CbqPcq0.jpg)
![Tier 5](https://i.imgur.com/RxKlteo.jpg)
## T6
![Tier 6](https://i.imgur.com/pRS6XdN.jpg)
![Tier 6](https://i.imgur.com/sNFavws.jpg)

## Features
- Stormram for police
- House garage
- Adding houses in-game with command (See commands section below)
- House decoration
- Key system
- Outfits
- Stash
- Real Estate Job
- Different interiors based on house tier
- Doorbell
- Automatically adds blip for owned house

### Commands
- /decorate - Allows the player decorate the house
- /createhouse [price] [tier] - Creates a house and saves it to database (Only people with "realestate" job)
- /addgarage - Adds a garage to nearby house (Only people with "realestate" job)
- /enter - Enters the nearby house (keys needed)
- /ring - Rings the bell of nearby house

## Installation
### Manual
- Download the script and put it in the `[qb]` directory.
- Import `qb-houses.sql` in your database
- Add the following code to your server.cfg/resouces.cfg
```
ensure qb-core
ensure qb-radialmenu
ensure qb-anticheat
ensure qb-phone
ensure qb-multicharacter
ensure qb-garages
ensure qb-interior
ensure qb-clothing
ensure qb-weathersync
ensure qb-weed
ensure qb-skillbar
```

## Configuration
```
Config = Config or {} -- Don't touch

Config.MinZOffset = 30 -- Minimum Z Offset houses will be (You don't need to change it:)

Config.RamsNeeded = 2 -- How many times stormram needs to be used to break the door.

Config.Houses = {} -- Don't touch

Config.Furniture = {
	["sofas"] = { -- Category id (don't change unless you know what you're doing)
		label = "Sofas", -- Category label displayed on decorate section
		items = {
			[1] = { ["object"] = "miss_rub_couch_01", ["price"] = 300, ["label"] = "Old couch" }, -- You can add or edit objects here
			[2] = { ["object"] = "prop_fib_3b_bench", ["price"] = 700, ["label"] = "Threesits couch" },
			[3] = { ["object"] = "prop_ld_farm_chair01", ["price"] = 250, ["label"] = "Old chair" },
			[4] = { ["object"] = "prop_ld_farm_couch01", ["price"] = 300, ["label"] = "Old treesits couch" },
			[5] = { ["object"] = "prop_ld_farm_couch02", ["price"] = 300, ["label"] = "Old striped couch" },
			[6] = { ["object"] = "v_res_d_armchair", ["price"] = 300, ["label"] = "Old 1 Seat Couch Yellow" },
			[7] = { ["object"] = "v_res_fh_sofa", ["price"] = 3700, ["label"] = "corner sofa" },
			[8] = { ["object"] = "v_res_mp_sofa", ["price"] = 3700, ["label"] = "corner sofa 2" },
			[9] = { ["object"] = "v_res_d_sofa", ["price"] = 700, ["label"] = "couch 1" },
			[10] = { ["object"] = "v_res_j_sofa", ["price"] = 700, ["label"] = "Couch 2" },
			[11] = { ["object"] = "v_res_mp_stripchair", ["price"] = 700, ["label"] = "Couch 3" },
			[12] = { ["object"] = "v_res_m_h_sofa_sml", ["price"] = 700, ["label"] = "Couch 4" },
			[13] = { ["object"] = "v_res_r_sofa", ["price"] = 700, ["label"] = "Couch 5" },
			[14] = { ["object"] = "v_res_tre_sofa", ["price"] = 700, ["label"] = "Couch 6" },
			[15] = { ["object"] = "v_res_tre_sofa_mess_a", ["price"] = 700, ["label"] = "Couch 7" },
			[16] = { ["object"] = "v_res_tre_sofa_mess_b", ["price"] = 700, ["label"] = "Couch 8" },
			[17] = { ["object"] = "v_res_tre_sofa_mess_c", ["price"] = 700, ["label"] = "Couch 9" },
			[18] = { ["object"] = "v_res_tt_sofa", ["price"] = 700, ["label"] = "Couch 10" },
			[19] = { ["object"] = "prop_rub_couch02", ["price"] = 700, ["label"] = "Couch 11" },
			[20] = { ["object"] = "v_ilev_m_sofa", ["price"] = 2000, ["label"] = "White Couch" },
			[21] = { ["object"] = "v_med_p_sofa", ["price"] = 1000, ["label"] = "Lether Couch Brown" },
			[22] = { ["object"] = "v_club_officesofa", ["price"] = 500, ["label"] = "pauper Couch rood" },
			[23] = { ["object"] = "bkr_prop_clubhouse_sofa_01a", ["price"] = 1000, ["label"] = "Black Couch" },
			[24] = { ["object"] = "apa_mp_h_stn_sofacorn_01", ["price"] = 5000, ["label"] = "corner sofa 3" },
			[25] = { ["object"] = "prop_couch_lg_02", ["price"] = 1000, ["label"] = "Couch hout" },
			[26] = { ["object"] = "apa_mp_h_stn_sofacorn_10", ["price"] = 5000, ["label"] = "corner sofa 4" },
			[27] = { ["object"] = "apa_mp_h_yacht_sofa_02", ["price"] = 1000, ["label"] = "Brown Couch" },
			[28] = { ["object"] = "apa_mp_h_yacht_sofa_01", ["price"] = 5000, ["label"] = "White long Couch" }
		},
	},

........
}
```
