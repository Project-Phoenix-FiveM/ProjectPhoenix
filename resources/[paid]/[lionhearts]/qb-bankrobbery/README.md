Made by Lionh34rt#4305
Discord: https://discord.gg/AWyTUEnGeN
Tebex: https://lionh34rt.tebex.io/

# Description
Bank robbery script for QBCore using Gabz MLO's and UncleJust Maze Bank

Features:
- Optimized and secured
- Server synced
- Highly configurable regarding minigames, rewards and various settings
- Full heist resets

# Dependencies
* [QBCore Framework](https://github.com/qbcore-framework)
* [mkalasers by mkafrin](https://github.com/mkafrin/mka-lasers)
* [Gabz MLO's](https://www.gabzv.com/)
* [Maze Bank MLO by UncleJust (optional)](https://unclejust.tebex.io/)
* [Memorygame by pushkart2](https://github.com/pushkart2/memorygame)
* [Hackinig Minigames by Kylend](https://github.com/dnelyk/Hacking_Minigames)
* [Hack minigame by Jasper-Hustad](https://github.com/Jesper-Hustad/NoPixel-minigame)
* [NoPixel Minigames by Sharkiller](https://github.com/sharkiller/nopixel_minigame)
* [qb-powerplant by Lionh34rt#4305](https://lionh34rt.tebex.io/)

# Installation
* **Install all the dependencies.**
* **Add the doorlocks file to qb-doorlock/configs and remove other bankrelated doors.**
* **Add the items to your qb-core > shared > items.lua.**
* **In cfx-gabz-mapdata, disable entitysets for fleeca, paleto and pacific.** 
* **Change various settings like rewards and copcount to your liking!**
* **Change the CallCops function in cl_main to accomodate the dispatch system you use.**

# Items for qb-core > shared > items.lua

```lua
-- Bankrobbery
['usb_green'] 		 	 		 = {['name'] = 'usb_green',           			['label'] = 'USB Drive',	 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'usb_green.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   	['combinable'] = nil,   ['description'] = 'A green USB flash drive'},
['usb_red'] 		 	 		 = {['name'] = 'usb_red',           			['label'] = 'USB Drive',	 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'usb_red.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   	['combinable'] = nil,   ['description'] = 'A red USB flash drive'},
['usb_blue'] 		 	 		 = {['name'] = 'usb_blue',           			['label'] = 'USB Drive',	 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'usb_blue.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   	['combinable'] = nil,   ['description'] = 'A blue USB flash drive'},
['laptop_green'] 		 	 	 = {['name'] = 'laptop_green',           		['label'] = 'Laptop',	 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'laptop_green.png', 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A laptop that you got from Ph03nix'},
['laptop_red'] 		 	 		 = {['name'] = 'laptop_red',           			['label'] = 'Laptop',	 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'laptop_red.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A laptop that you got from Plague'},
['laptop_blue'] 		 	 	 = {['name'] = 'laptop_blue',           		['label'] = 'Laptop',	 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'laptop_blue.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A laptop that you got from Ramsay'},
['fleeca_bankcard'] 		 	 = {['name'] = 'fleeca_bankcard',        		['label'] = 'Bank Keycard',	 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'fleeca_bankcard.png', 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A keycard stolen from a fleeca bank.'},
['pacific_key1'] 		 	     = {['name'] = 'pacific_key1',        		    ['label'] = 'Bank Data Key',	 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pacific_key1.png', 		['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A data key stolen from the pacific bank.'},
['pacific_key2'] 		 	     = {['name'] = 'pacific_key2',        		    ['label'] = 'Bank Data Key',	 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pacific_key2.png', 		['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A data key stolen from the pacific bank.'},
['pacific_key3'] 		 	     = {['name'] = 'pacific_key3',        		    ['label'] = 'Bank Data Key',	 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pacific_key3.png', 		['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A data key stolen from the pacific bank.'},
['pacific_key4'] 		 	     = {['name'] = 'pacific_key4',        		    ['label'] = 'Bank Data Key',	 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'pacific_key4.png', 		['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A data key stolen from the pacific bank.'},
```

# Config for qb-scoreboard: make sure your banks are named like this or remove the qb-scoreboard triggers in bankrobberies
```lua
["fleeca"] = {
    minimumPolice = 0,
    busy = false,
    label = "Fleeca Bank"
},
["maze"] = {
    minimumPolice = 0,
    busy = false,
    label = "Maze Bank"
},
["paleto"] = {
    minimumPolice = 0,
    busy = false,
    label = "Paleto Bank"
},
["pacific"] = {
    minimumPolice = 0,
    busy = false,
    label = "Pacific Bank"
},
```