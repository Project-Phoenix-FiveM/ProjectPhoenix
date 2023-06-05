# qb-vending-machines
This is a QB Core made by oosayeroo, but i reworked it with new items and better picture for the items. Hope you like it!

Credit to oosayeroo for providing this script.

## Dependencies :

QBCore Framework - https://github.com/qbcore-framework/qb-core

PolyZone - https://github.com/qbcore-framework/PolyZone

qb-target - https://github.com/qbcore-framework/qb-target

qb-input - https://github.com/qbcore-framework/qb-input

qb-menu - https://github.com/qbcore-framework/qb-menu

## Insert into @qb-core/shared/items.lua 

```
	-- QB-Vending
	['cola'] 				 	     = {['name'] = 'cola', 			  	     		['label'] = 'eCola', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'cola.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Genuine Cola'},
	['ecoladiet'] 				 	 = {['name'] = 'ecoladiet', 			  	    ['label'] = 'Diet eCola', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'ecoladiet.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Genuine Diet Cola'},
	['sprunk'] 				 	     = {['name'] = 'sprunk', 			     	  	['label'] = 'Sprunk', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'sprunk.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Everyone loves a bit of Sprunk in their mouths'},
	['sprunklight'] 				 = {['name'] = 'sprunklight', 			     	['label'] = 'Sprunk Light', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'sprunklight.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Sprunk but lighter!'},
	['orang-o-tang'] 				 = {['name'] = 'orang-o-tang', 			  	  	['label'] = 'Orang o Tang', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'orang-o-tang.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'The orange flavoured cola'},
	['grapejuice'] 				 	 = {['name'] = 'grapejuice', 			  	  	['label'] = 'Grape Juice', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'grapejuice.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Grape Juice!'},
	['cranberry'] 				 	 = {['name'] = 'cranberry', 			  	  	['label'] = 'Cranberry Juice', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'cranberry.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Cranberry Juice!'},
	['crisps'] 		     			 = {['name'] = 'crisps', 		     			['label'] = 'Crisps', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'crisps.png', 		   		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Regular chips'},
	['egochaser'] 		     		 = {['name'] = 'egochaser', 		    		['label'] = 'Ego Chaser Energy Bar', 	['weight'] = 500, 		['type'] = 'item', 		['image'] = 'egochaser.png', 		   	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'The energy you need!'},
	['nachos'] 		     			 = {['name'] = 'nachos', 		     			['label'] = 'Nachos Chips', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'nachos.png', 	  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'anyone got a napkin?'},
	['twix'] 	 	     			 = {['name'] = 'twix', 		     				['label'] = 'Twix Bar', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'twix.png', 	   				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Tasty Bar'},
	['snikkel_candy'] 				 = {['name'] = 'snikkel_candy', 			  	['label'] = 'Snikkel Bar', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'snikkel_candy.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'half milk half dark'},
	['meteorite-bar'] 			     = {['name'] = 'meteorite-bar', 		     	['label'] = 'Meteorite Bar', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'meteorite-bar.png', 	    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Tasty Bar'},
	['twerks_candy'] 	 	     	 = {['name'] = 'twerks_candy', 		    		['label'] = 'Twerks Bar', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'twerks_candy.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Tasty Bar'},
	['water_bottle'] 			     = {['name'] = 'water_bottle', 			  	   	['label'] = 'Water Bottle', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'water_bottle.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Drip, Drop, Drip, Drop. This clock must be stopped.'},
	['water_bottle2'] 			     = {['name'] = 'water_bottle2', 			  	['label'] = 'Voss Water', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'water_bottle2.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'The fancy water kind!'},
	['coffee'] 			     		 = {['name'] = 'coffee', 			   			['label'] = 'Coffee', 					['weight'] = 500, 		['type'] = 'item', 		['image'] = 'coffee.png', 	    		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A hot cup of coffee!'},
	['latte-machiatto'] 	 	     = {['name'] = 'latte-machiatto', 		     	['label'] = 'Latte Machiatto', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'latte-machiatto.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Milky smooth taste'},
	['espresso'] 				     = {['name'] = 'espresso', 			  	     	['label'] = 'Espresso', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'espresso.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'very strong coffee'},
	

```

## Insert Contents of @vending/Images into @inventory/HTML/Images (qb/lj/aj)

## insert into qb-smallresources/config/consumabeseat


```
    ["crisps"] = math.random(35, 54),
    ["egochaser"] = math.random(35, 54),
    ["nachos"] = math.random(35, 54),
    ["snikkel_candy"] = math.random(35, 54),
    ["meteorite-bar"] = math.random(35, 54),
    ["twerks_candy"] = math.random(35, 54),
    ["twix"] = math.random(35, 54),
    
```

## insert into qb-smallresources/config/consumablesdrink

    ["cola"] = math.random(40, 50),
    ["ecoladiet"] = math.random(40, 50),
    ["sprunk"] = math.random(40, 50),
    ["sprunklight"] = math.random(40, 50),
    ["orang-o-tang"] = math.random(40, 50),
    ["grapejuice"] = math.random(40, 50),
    ["cranberry"] = math.random(40, 50),
    ["water_bottle"] = math.random(40, 50),
    ["water_bottle2"] = math.random(40, 50),
    ["coffee"] = math.random(40, 50),
    ["espresso"] = math.random(40, 50),
    ["latte-machiatto"] = math.random(40, 50),
	
