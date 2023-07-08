This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0
International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

# tr-mining
Mining Script for QBCore

## Whats included
- Easy to use config
- 100 x 100 Images
- Turn on and off blips
- 15x Mining Locations
- 3 different mining ore rewards
- DrawtextUi & Target Combined

## Dependencies
- [qb-core](https://github.com/qbcore-framework/qb-core) **Lastest Core with DrawtextUI**
- [qb-target](https://github.com/BerkieBb/qb-target)
- [qb-menu](https://github.com/qbcore-framework/qb-menu)
- [PolyZone](https://github.com/mkafrin/PolyZone)
- [nw-mine](https://github.com/Nowimps8/nw_mine)

## Installation

Add the item to your **qb-core/shared/item.lua**
```
-- Mining
	['mining_pickaxe'] 			     = {['name'] = 'mining_pickaxe', 				['label'] = 'Mining Pickaxe', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'mining_pickaxe.png', 			['unique'] = true, 			['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Classic\'s pickaxe for mining'},
	['mining_pan'] 			    	 = {['name'] = 'mining_pan', 					['label'] = 'Washing Pan', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'mining_pan.png', 				['unique'] = true, 			['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Classic\'s washing pan'},
	['mining_stone'] 			     = {['name'] = 'mining_stone', 					['label'] = 'Mined Stone', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'mining_stone.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Mined Stone'},
	['mining_washedstone'] 			 = {['name'] = 'mining_washedstone', 			['label'] = 'Washed Stone', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'mining_washedstone.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Wasted Stone'},
	['mining_ironfragment'] 		 = {['name'] = 'mining_ironfragment', 			['label'] = 'Iron Fragment', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'mining_ironfragment.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Iron fragment from mining'},
	['mining_ironbar'] 				 = {['name'] = 'mining_ironbar', 				['label'] = 'Iron Bar', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'mining_ironbar.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Iron Bar'},
	['mining_goldnugget'] 			 = {['name'] = 'mining_goldnugget', 			['label'] = 'Golden Nugget', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'mining_goldnugget.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Golden nugget from mining'},
	['mining_goldbar'] 				 = {['name'] = 'mining_goldbar', 				['label'] = 'Gold Bar', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'mining_goldbar.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Gold Bar'},
	['mining_copperfragment'] 		 = {['name'] = 'mining_copperfragment', 		['label'] = 'Copper Fragment', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'mining_copperfragment.png', 	['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Copper fragment from mining'},
	['mining_copperbar'] 			 = {['name'] = 'mining_copperbar', 				['label'] = 'Copper Bar', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'mining_copperbar.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Copper Bar'},

```
For images move the images from the img folder to your inventory image folder **qb-inventory/html/images**

If you use another Drawtext like cd_drawtextui for example change the following in the **client/main.lua 287 - 296**

**Before** DRAWTEXT
```
exports['qb-core']:DrawText(Config.Text['MiningAlert'], 'left')

exports['qb-core']:DrawText(Config.Text['StartMining'],'left')
```

**After**
```
TriggerEvent('cd_drawtextui:ShowUI', 'show', Config.Text['MiningAlert'])
		
TriggerEvent('cd_drawtextui:ShowUI', 'show', Config.Text['StartMining'])
```

**Before** HIDETEXT
```
exports['qb-core']:HideText()
```

**After**
```
TriggerEvent('cd_drawtextui:HideUI')
```

**You will also need to remove this line if you are using CD_Drawtextui** 
**Line 160**
```
exports['qb-core']:KeyPressed()
```

## **Drawtext Ui Files will be provided if you don't have it installed in your core**
- [QBCore_Drawtext](https://github.com/trclassic92/QBCore_Drawtext) **Only add if you dont have the lastest core update**


## Preview Pictures
- [Youtube Video](https://youtu.be/9VXjTrUdjfc)
![Preview Screenshot](https://i.imgur.com/jIJ9SOU.png)
![Preview Screenshot](https://i.imgur.com/mu0gNQC.jpeg)
![Preview Screenshot](https://i.imgur.com/7gKe9wE.jpeg)
![Preview Screenshot](https://i.imgur.com/cGaTg3V.jpeg)
![Preview Screenshot](https://i.imgur.com/my22yZL.jpeg)
![Preview Screenshot](https://i.imgur.com/fUQ61Bl.jpeg)
![Preview Screenshot](https://i.imgur.com/S382wMf.jpeg)
![Preview Screenshot](https://i.imgur.com/VJCk6cx.jpeg)

## Discord
- [Join Discord](https://discord.gg/zRCdhENsHG)

## Support The Script
- [Ko-fi Link](https://ko-fi.com/trclassic)
