Made by Lionh34rt#4305
Discord: https://discord.gg/AWyTUEnGeN
Tebex: https://lionh34rt.tebex.io/

# Description
* **This package allows your players to rob the Humane Labs via the underwater tunnel, players can receive chemicals like Ecgonine and Methylamine used to create drugs via the Key-Based Labs script.**

# Dependencies
* [QBCore Framework](https://github.com/qbcore-framework)
* [qb-target by BerkieBb](https://github.com/BerkieBb/qb-target)
* [Memorygame by pushkart2](https://github.com/pushkart2/memorygame)
* [Hack minigame by Jasper-Hustad](https://github.com/Jesper-Hustad/NoPixel-minigame)
* [NoPixel Minigames by Sharkiller](https://github.com/sharkiller/nopixel_minigame)

# Installation
* **Run the included sql script**
* **Either add boxville3 to your popgroups, or use my popgroups.ymt file, this goes into qb-smallresources**
* **Add the items to your qb-core > shared > items.lua**
* **Install all the dependencies from the resource pack**
* **Add the doorlocks config file to qb-doorlock**
* **Add an entry for humanelabs to your qb-scoreboard config**
* **Add the elec_buzz_glitch.ogg sound to your interact-sound resource**
* **Change some of the settings to your liking**

# Items for qb-core > shared > items.lua
```lua
-- Humane Labs Heist
['usb_purple'] 		 	 		 = {['name'] = "usb_purple",           			['label'] = "USB Drive",	 			['weight'] = 1000, 		['type'] = "item", 		['image'] = "usb_purple.png", 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   	['combinable'] = nil,   ['created'] = nil,	['decay'] = 0.0, ['description'] = "A purple USB flash drive"},
['laptop_purple'] 		 	 	 = {['name'] = "laptop_purple",        		   	['label'] = "Laptop",	 				['weight'] = 2500, 		['type'] = "item", 		['image'] = "laptop_purple.png", 		['unique'] = true, 		['useable'] = true, 	['shouldClose'] = false,   	['combinable'] = nil,   ['created'] = nil,	['decay'] = 0.0, ['description'] = "A laptop made for hacking"},
['hlabs_formula'] 				 = {['name'] = "hlabs_formula", 				['label'] = "Secret Formula", 			['weight'] = 1000, 		['type'] = "item", 		['image'] = "hlabs_formula.png", 		['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['created'] = nil,	['decay'] = 0.0, ['description'] = "You just reminded yourself why you failed chemistry in high school.."},
['copper_wires']				 = {['name'] = 'copper_wires', 					['label'] = 'Copper Wires', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'copper_wires.png', 		['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['created'] = nil,	['decay'] = 14.0, ['description'] = 'Some copper wiring, good for conducting electricity..'},
['hlabs_chemicals']				 = {['name'] = 'hlabs_chemicals', 				['label'] = 'Unknown Chemical', 		['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'hlabs_chemicals.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,		['combinable'] = nil,   ['created'] = nil,	['decay'] = 14.0, ['description'] = 'Bottles of unknown chemicals, stolen from Humane Labs..'},

-- From My Truck Robbery Script:
['security_card_05'] 			 = {['name'] = 'security_card_05', 			  	['label'] = 'Security Card', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'security_card_05.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	    ['combinable'] = nil,   ['created'] = nil,	['decay'] = 14.0, ['description'] = 'A blue security card.'},

-- From My Key-Based-Labs Script:
['methylamine'] 			 	 = {['name'] = "methylamine", 					['label'] = "Methylamine", 				['weight'] = 4000, 		['type'] = "item", 		['image'] = "methylamine.png", 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['created'] = nil,	['decay'] = 14.0, ['description'] = "A derivative of ammonia, but with one H atom replaced by a methyl group"},
['ecgonine'] 			 		 = {['name'] = "ecgonine", 						['label'] = "Ecgonine", 				['weight'] = 4000, 		['type'] = "item", 		['image'] = "ecgonine.png", 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['created'] = nil,	['decay'] = 14.0, ['description'] = "Ecgonine (tropane derivative) is a tropane alkaloid"},
```

# qb-logs (smallresources)
['humanelabs'] = {webhook},