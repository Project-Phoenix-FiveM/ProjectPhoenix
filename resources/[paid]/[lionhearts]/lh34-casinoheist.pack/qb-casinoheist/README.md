Made by Lionh34rt#4305
Discord: https://discord.gg/AWyTUEnGeN
Tebex: https://lionh34rt.tebex.io/

# Description
* **Diamond Casino Heist using NoPixel's Casino misc MLO. (https://3dstore.nopixel.net/)**

# Dependencies
* [QBCore Framework](https://github.com/qbcore-framework)
* [qb-target by BerkieBb](https://github.com/BerkieBb/qb-target)
* [NoPixel casinomisc MLO](https://3dstore.nopixel.net/category/subscriptions)
* [mkalasers by mkafrin](https://github.com/mkafrin/mka-lasers)
* [Memorygame by pushkart2](https://github.com/pushkart2/memorygame)
* [Hack minigame by Jasper-Hustad](https://github.com/Jesper-Hustad/NoPixel-minigame)
* [NoPixel Minigames by Sharkiller](https://github.com/sharkiller/nopixel_minigame)

# Installation
* **Install all the dependencies**
* **Add the doorlocks config file to qb-doorlock**
* **Add the items to your qb-core > shared > items.lua**
* **Add the snippet below to your app.js in qb-inventory to display itemInfo**
* **Change the minimum required cops in sh_shared**
* **Change the reward table to your liking in sv_vault**
* **Change the Alert Cops event in cl_vault to accomodate the dispatch system you use.**

# Items for qb-core > shared > items.lua
```lua
-- Casino Heist
['casino_usb1'] 				 = {['name'] = 'casino_usb1', 					['label'] = 'USB Device', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'casino_usb.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'A USB Device'},
['casino_usb2'] 			 	 = {['name'] = 'casino_usb2', 					['label'] = 'USB Device', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'casino_usb.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'A USB Device'},
['casino_magnet'] 				 = {['name'] = 'casino_magnet', 				['label'] = 'High Powered Magnet', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'casino_magnet.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,		['combinable'] = nil,   ['description'] = 'A high powered magnet'},
['casino_accesscode1'] 			 = {['name'] = 'casino_accesscode1', 			['label'] = 'Casino Access Codes', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'casino_accesscode.png', 	['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Diamond Casino Access Codes'},
['casino_accesscode2'] 			 = {['name'] = 'casino_accesscode2', 			['label'] = 'Casino Access Codes', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'casino_accesscode.png', 	['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Diamond Casino Access Codes'},
['casino_keycard'] 			 	 = {['name'] = 'casino_keycard', 				['label'] = 'Executive Keycard', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'casino_keycard.png', 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,		['combinable'] = nil,   ['description'] = 'Grants unrestricted access..'},
['casino_green'] 		 	 	 = {['name'] = 'casino_green',           		['label'] = 'Laptop',	 				['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'casino_green.png', 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A Green Laptop'},
['casino_red'] 		 	 		 = {['name'] = 'casino_red',           			['label'] = 'Laptop',	 				['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'casino_red.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A Red Laptop'},
['casino_blue'] 		 	 	 = {['name'] = 'casino_blue',           		['label'] = 'Laptop',	 				['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'casino_blue.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A Blue Laptop'},
['casino_gold'] 		 	 	 = {['name'] = 'casino_gold',        		   	['label'] = 'Laptop',	 				['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'casino_gold.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A Gold Laptop'},
['casino_bag'] 		 	 	 	 = {['name'] = 'casino_bag',        		   	['label'] = 'Duffel Bag',	 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'casino_bag.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   	['combinable'] = nil,   ['description'] = 'A Black Duffel Bag'},
['casino_vaultcode'] 			 = {['name'] = 'casino_vaultcode', 				['label'] = 'Casino Vault Codes', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'casino_accesscode.png', 	['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Diamond Casino Vault Access Codes'},

```

# qb-inventory > html > app.js in FormatIteminfo function
```js
} else if (itemData.name == "casino_accesscode1") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Part 1: " + itemData.info.code + "</p>");
} else if (itemData.name == "casino_accesscode2") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Part 2: " + itemData.info.code + "</p>");
} else if (itemData.name == "casino_vaultcode") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html("<p>Access Codes: " + itemData.info.codes + "</p>");
```

# qb-logs (smallresources)
['casinoheist'] = {webhook},