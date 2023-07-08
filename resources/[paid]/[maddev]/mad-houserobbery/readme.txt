Items to add in qb-core/shared/items

['stolenmicro'] 		 = {['name'] = 'stolenmicro', 			['label'] = 'Micro-ondas', 			['weight'] = 200, 		['type'] = 'item', 		['image'] = '', ['unique'] = true,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = ''},	
['stolencoffee'] 		 = {['name'] = 'stolencoffee', 			['label'] = 'Maquina de Café', 		['weight'] = 200, 		['type'] = 'item', 		['image'] = '', ['unique'] = true,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = ''},	
['stolentv'] 			 = {['name'] = 'stolentv', 			['label'] = 'TV', 			        ['weight'] = 200, 		['type'] = 'item', 		['image'] = '', ['unique'] = true,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = ''},	
['stolenscope'] 		 = {['name'] = 'stolenscope', 			['label'] = 'Telescópio', 			['weight'] = 200, 		['type'] = 'item', 		['image'] = '', ['unique'] = true,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = ''},	
['stolenart'] 			 = {['name'] = 'stolenart', 			['label'] = 'Pintura', 			    ['weight'] = 200, 		['type'] = 'item', 		['image'] = '', ['unique'] = true,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = ''},	
['stolenlaptop'] 		 = {['name'] = 'stolenlaptop', 			['label'] = 'Portátil', 			['weight'] = 200, 		['type'] = 'item', 		['image'] = '', ['unique'] = true,    	['useable'] = true, 	['shouldClose'] = true,	   		['combinable'] = nil,   ['description'] = ''},	


Open sound file and drag the .ogg file into the interactsound folder client/html/sounds

Dependacys

ps-ui
qb-target
qb-core


Important!!!

If you want to use Advanced LockPick / Lockpick you must add this event at qb-smallresources/server/consumables.lua  at line 125 for lockpick or 130 for advanced lockpick
TriggerClientEvent("qb-houserobbery:client:openDoor", source)
 
You will get something like this 

QBCore.Functions.CreateUseableItem("lockpick", function(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, false)
    TriggerClientEvent("qb-houserobbery:client:openDoor", source)
end)

QBCore.Functions.CreateUseableItem("advancedlockpick", function(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, true)
    TriggerClientEvent("qb-houserobbery:client:openDoor", source)
end)


Very Important!!!

'anim@heists@box_carry@', 'walk' Never use this animation set in other scripts, will generate incompatibilities with the house robbery script