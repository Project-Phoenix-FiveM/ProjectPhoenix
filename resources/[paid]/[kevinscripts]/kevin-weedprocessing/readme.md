# Dependencies

* qbcore
* qb-target
* kevin-consumables https://github.com/KevinGirardx/kevin-buffconsumables
* ps-buffs https://github.com/Project-Sloth/ps-buffs
* ox_lib https://overextended.github.io/docs/ox_lib/

# INSTALLATION

# Run the plants.sql file 

# If you use qb-shops add the following to the Config.Products under ["hardware"] you may need to adjust the number of the table an slot to match your shops item amount
```lua
    [16] = {
        name = "water_can",
        price = 500,
        amount = 50,
        info = {
            uses = 20 -- change to whatever you have set in the config for the Planting.WaterCanUses
        },
        type = "item",
        slot = 16,
    },
    [17] = {
        name = "weed_fertilizer",
        price = 500,
        amount = 50,
        info = {}, 
        type = "item",
        slot = 17,
    },
```

# If you want it to be using a specifc job if the config is set to true then add the snip below to qb-core > shared > job.lua
```lua
   ['weedpicker'] = {
		label = 'Plant Harvester', --- change if you like
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Plant Harvester',
                payment = 10
            },
        },
	},
```

# qb/lj-inventory/html/js/app.js (Line 577 - 650) you can search for stickynote and you will see where it needs to be placed

```lua
    } else if (itemData.name == "weed_jar") {
        $(".item-info-title").html("<p>" + itemData.label + "</p>");
        $(".item-info-description").html(
            "<p><strong>Strain: </strong><span>" +
            itemData.info.packednuggets +'s' +
            "</span></p><p><strong>Amount: </b> " + "<a style=\"font-size:bold;color:green\">" +
            itemData.info.packedamount +"</a>"
        );
    } else if (itemData.name == "weed_bucket") {
        $(".item-info-title").html("<p>" + itemData.label + "</p>");
        $(".item-info-description").html(
            "<p><strong>Strain: </strong><span>" +
            itemData.info.driedplants +'s' +
            "</span></p><p><strong>Amount: </b> " + "<a style=\"font-size:bold;color:green\">" +
            itemData.info.driedamount +"</a>"
        );
    } else if (itemData.name == "water_can") {
        $(".item-info-title").html("<p>" + itemData.label + "</p>");
        $(".item-info-description").html(
            "<p><strong>Uses Remaining: </strong><span>" + "<a style=\"font-size:11px;color:#00CDF7\">" +
            itemData.info.uses + "</a>"
        );
    } else if (itemData.name == "ak_47_seed") {
        $(".item-info-title").html('<p>' + itemData.label + '</p>')
        $(".item-info-description").html('<p><strong>Gender: </strong><span>'+ itemData.info.gender);
    } else if (itemData.name == "blue_dream_seed") {
        $(".item-info-title").html('<p>' + itemData.label + '</p>')
        $(".item-info-description").html('<p><strong>Gender: </strong><span>'+ itemData.info.gender);
    } else if (itemData.name == "og_kush_seed") {
        $(".item-info-title").html('<p>' + itemData.label + '</p>')
        $(".item-info-description").html('<p><strong>Gender: </strong><span>'+ itemData.info.gender);
    } else if (itemData.name == "pineapple_express_seed") {
        $(".item-info-title").html('<p>' + itemData.label + '</p>')
        $(".item-info-description").html('<p><strong>Gender: </strong><span>'+ itemData.info.gender);
    } else if (itemData.name == "purple_haze_seed") {
        $(".item-info-title").html('<p>' + itemData.label + '</p>')
        $(".item-info-description").html('<p><strong>Gender: </strong><span>'+ itemData.info.gender);
    } else if (itemData.name == "white_widow_seed") {
        $(".item-info-title").html('<p>' + itemData.label + '</p>')
        $(".item-info-description").html('<p><strong>Gender: </strong><span>'+ itemData.info.gender);
    } else if (itemData.name == "weed_seed") {
        $(".item-info-title").html('<p>' + itemData.label + '</p>')
        $(".item-info-description").html('<p><strong>Gender: </strong><span>'+ itemData.info.gender);
```

# Go to your qb-core > shared > items.lua and add the following items:

```lua
	-- Kevin WeedProcessing Items--
	['weed_bucket'] 			 		 = {['name'] = 'weed_bucket', 			  			['label'] = 'Weed Bucket', 					['weight'] = 5000, 		['type'] = 'item', 		['image'] = 'weed_bucket.png', 					['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	['emptyweed_jar'] 			 		 = {['name'] = 'emptyweed_jar', 					['label'] = 'Empty Jar', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'emptyweed_jar.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	['weed_jar'] 				 		 = {['name'] = 'weed_jar', 			  	  			['label'] = 'Weed Jar', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weed_jar.png', 					['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	['weed_cone'] 				 		 = {['name'] = 'weed_cone', 			  			['label'] = 'Empty Cone', 					['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weed_cone.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	['weed_conepack'] 			 		 = {['name'] = 'weed_conepack', 					['label'] = 'Pack of Cones', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weed_conepack.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
	
	['ak_47_plant'] 				  	 = {['name'] = 'ak_47_plant', 			     		['label'] = 'Ak 47 Plant', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'ak_47_plant.png',  				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['blue_dream_plant'] 		 		 = {['name'] = 'blue_dream_plant', 			    	['label'] = 'BlueDream Plant', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'blue_dream_plant.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['og_kush_plant'] 				 	 = {['name'] = 'og_kush_plant', 			     	['label'] = 'Og Kush Plant', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'og_kush_plant.png',  				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['pineapple_express_plant'] 		 = {['name'] = 'pineapple_express_plant', 			['label'] = 'Pineapple Express Plant', 		['weight'] = 0, 		['type'] = 'item', 		['image'] = 'pineapple_express_plant.png',  	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['purple_haze_plant'] 				 = {['name'] = 'purple_haze_plant', 			   	['label'] = 'Purple Haze Plant', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'purple_haze_plant.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['white_widow_plant'] 				 = {['name'] = 'white_widow_plant', 			   	['label'] = 'White Widow Plant', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'white_widow_plant.png',  		 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['weed_plant'] 				 		 = {['name'] = 'weed_plant', 			     		['label'] = 'Weed Plant', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_plant.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},

	['ak_47_bud'] 		 				 = {['name'] = 'ak_47_bud', 			    		['label'] = 'Ak 47 dried bud', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'ak_47_bud.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['blue_dream_bud'] 				 	 = {['name'] = 'blue_dream_bud', 			     	['label'] = 'BlueDream dried bud', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'blue_dream_bud.png',  				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['og_kush_bud'] 				  	 = {['name'] = 'og_kush_bud', 			     		['label'] = 'Og Kush dried bud', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'og_kush_bud.png',  				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['pineapple_express_bud'] 			 = {['name'] = 'pineapple_express_bud', 			['label'] = 'Pineapple Express dried bud', 	['weight'] = 0, 		['type'] = 'item', 		['image'] = 'pineapple_express_bud.png',  	 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['purple_haze_bud'] 				 = {['name'] = 'purple_haze_bud', 			     	['label'] = 'Purple Haze dried bud', 		['weight'] = 0, 		['type'] = 'item', 		['image'] = 'purple_haze_bud.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['white_widow_bud'] 				 = {['name'] = 'white_widow_bud', 			     	['label'] = 'White Widow dried bud', 		['weight'] = 0, 		['type'] = 'item', 		['image'] = 'white_widow_bud.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['weed_plant_bud'] 				 	 = {['name'] = 'weed_plant_bud', 			     	['label'] = 'Weed dried bud', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_plant_bud.png',  				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	
	['ak_47_nugget'] 		 			 = {['name'] = 'ak_47_nugget', 			    		['label'] = 'Ak 47 Nugget', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'ak_47_nugget.png',  				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['blue_dream_nugget'] 				 = {['name'] = 'blue_dream_nugget', 			    ['label'] = 'BlueDream Nugget', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'blue_dream_nugget.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['og_kush_nugget'] 				  	 = {['name'] = 'og_kush_nugget', 			     	['label'] = 'Og Kush Nugget', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'og_kush_nugget.png',  				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['pineapple_express_nugget'] 		 = {['name'] = 'pineapple_express_nugget', 			['label'] = 'Pineapple Express Nugget', 	['weight'] = 0, 		['type'] = 'item', 		['image'] = 'pineapple_express_nugget.png',   	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['purple_haze_nugget'] 				 = {['name'] = 'purple_haze_nugget', 			    ['label'] = 'Purple Haze Nugget', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'purple_haze_nugget.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['white_widow_nugget'] 				 = {['name'] = 'white_widow_nugget', 			    ['label'] = 'White Widow Nugget', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'white_widow_nugget.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['weed_nugget'] 				 	 = {['name'] = 'weed_nugget', 			     		['label'] = 'Weed Nugget', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_nugget.png',  				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},

	['ak_47_joint'] 		 			 = {['name'] = 'ak_47_joint', 			    		['label'] = 'Ak 47 Joint', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'ak_47_joint.png',  				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['blue_dream_joint'] 				 = {['name'] = 'blue_dream_joint', 			    	['label'] = 'BlueDream Joint', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'blue_dream_joint.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['og_kush_joint'] 			 		 = {['name'] = 'og_kush_joint', 			     	['label'] = 'Og Kush Joint', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'og_kush_joint.png',  				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['pineapple_express_joint'] 		 = {['name'] = 'pineapple_express_joint', 			['label'] = 'Pineapple ExpressJoint', 		['weight'] = 0, 		['type'] = 'item', 		['image'] = 'pineapple_express_joint.png',   	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['purple_haze_joint'] 				 = {['name'] = 'purple_haze_joint', 			    ['label'] = 'Purple Haze Joint', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'purple_haze_joint.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['white_widow_joint'] 				 = {['name'] = 'white_widow_joint', 			    ['label'] = 'White Widow Joint', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'white_widow_joint.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['weed_joint'] 				 	 	 = {['name'] = 'weed_joint', 			     		['label'] = 'Weed Joint', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_joint.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
    	['ak_47_seed'] 				 	 	 = {['name'] = 'ak_47_seed', 			     		['label'] = 'Ak 47 Seed', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['blue_dream_seed'] 				 = {['name'] = 'blue_dream_seed', 			     	['label'] = 'BlueDream Seed', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['og_kush_seed'] 				 	 = {['name'] = 'og_kush_seed', 			     		['label'] = 'Og Kush Seed', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['pineapple_express_seed'] 			 = {['name'] = 'pineapple_express_seed', 			['label'] = 'Pineapple Express Seed', 		['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['purple_haze_seed'] 				 = {['name'] = 'purple_haze_seed', 			        ['label'] = 'Purple Haze Seed', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['white_widow_seed'] 				 = {['name'] = 'white_widow_seed', 			     	['label'] = 'White Widow Seed', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['weed_seed'] 				 		 = {['name'] = 'weed_seed', 			     		['label'] = 'Weed Seed', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	
	['weed_fertilizer'] 				 = {['name'] = 'weed_fertilizer', 			     	['label'] = 'Fertilizer', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_fertilizer.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['water_can'] 				 		 = {['name'] = 'water_can', 			     		['label'] = 'Water Can', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'water_can.png',  					['unique'] = true, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},

	-----
```

# Take imanges from the images folder and drop into your qb\lj-inventory > html > images


# To setup the player buffs you need to create an item like the coffee item below 

# If you use jim-consumables and dont wish to use kevin-buffconsumables you can do the following:

* Add the following line to jim-consumables > config.lua within Consumables
```lua
    ['coffee'] = { 			emote = 'coffee',		time = 60000, stress = 0, heal = 0, armor = 0, type = 'drink', stats = { effect = 'luck', widepupils = false, canOD = false } },
```

* If you use kevin-buffconsumables the coffee item is already setup in there.

Ps. Dont forget to make a coffee item or whatever item you plant to use in qbcore shared items.lua


# If you use devy-backitems paste the following snippet in the backitems.lua (PS. It may cause flickering of the props if multiple types are stacked in inventory):

```lua
    ["ak_47_bud"] = {
        model="dry_weed_plant1", 
        back_bone = 24818,
        x = -0.20,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 0.0,
    },
    ["blue_dream_bud"] = {
        model="dry_weed_plant1", 
        back_bone = 24818,
        x = -0.20,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 0.0,
    },
    ["og_kush_bud"] = {
        model="dry_weed_plant1", 
        back_bone = 24818,
        x = -0.20,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 0.0,
    },
    ["pineapple_express_bud"] = {
        model="dry_weed_plant1", 
        back_bone = 24818,
        x = -0.20,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 0.0,
    },
    ["purple_haze_bud"] = {
        model="dry_weed_plant1", 
        back_bone = 24818,
        x = -0.20,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 0.0,
    },
    ["white_widow_bud"] = {
        model="dry_weed_plant1", 
        back_bone = 24818,
        x = -0.20,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 0.0,
    },
    ["weed_plant_bud"] = {
        model="bkr_prop_weed_drying_01a", 
        back_bone = 24818,
        x = -0.20,
        y = -0.17,
        z = 0.0,
        x_rotation = 0.0,
        y_rotation = 90.0,
        z_rotation = 0.0,
    },
```

# If you use Renewed-Weaponcarry add the following snippet to the client > main.lua within the local props = {} around line 41
```lua
["ak_47_bud"] = { model = "dry_weed_plant3", hash = joaat("dry_weed_plant3"), tier = 1, yr = 90.0 },
["blue_dream_bud"] = { model = "dry_weed_plant2", hash = "dry_weed_plant2", tier = 1, yr = 90.0 },
["og_kush_bud"] = { model = "dry_weed_plant1", hash = "dry_weed_plant1", tier = 1, yr = 90.0 },
["pineapple_express_bud"] = { model = "dry_weed_plant4", hash = "dry_weed_plant4", tier = 1, yr = 90.0 },
["purple_haze_bud"] = { model = "dry_weed_plant5", hash = "dry_weed_plant5", tier = 1, yr = 90.0 },
["white_widow_bud"] = { model = "dry_weed_plant6", hash = "dry_weed_plant6", tier = 1, yr = 90.0 },
["weed_plant_bud"] = { model = "bkr_prop_weed_drying_01a", hash = "bkr_prop_weed_drying_01a", tier = 1, yr = 90.0 },
```

# In your inventory server.lua locate the 'giveitem' command and add the following within
```lua
    elseif itemData["name"] == "water_can" then
        info.uses = 30
    elseif itemData["name"] == "ak_47_seed" then
        info.gender = 'Male'
    elseif itemData["name"] == "blue_dream_seed" then
        info.gender = 'Male'
    elseif itemData["name"] == "og_kush_seed" then
        info.gender = 'Male'
    elseif itemData["name"] == "pineapple_express_seed" then
        info.gender = 'Male'
    elseif itemData["name"] == "purple_haze_seed" then
        info.gender = 'Male'
    elseif itemData["name"] == "white_widow_seed" then
        info.gender = 'Male'
    elseif itemData["name"] == "weed_seed" then
        info.gender = 'Male'
```