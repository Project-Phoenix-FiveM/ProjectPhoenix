# Dependencies
- QBCore 
- qb-target https://github.com/qbcore-framework/qb-target
- lj-inventory/qb-inventory
- ox_lib https://github.com/overextended/ox_lib/releases/tag/v2.21.0
------------------------------------------------------------------------------------

# Installation

- Copy the image from the images folder into your inventory images
- Head to your inventory html folder and open the js folder and then open the .js file
- Search for the following:
```lua
} else if (itemData.name == 'stickynote') {
```

above it paste the following:

```lua
    } else if (itemData.name == "rentalpapers") {
        $(".item-info-title").html('<p>' + itemData.label + '</p>')
        $(".item-info-description").html('<p><strong>First Name: </strong><span>'+ itemData.info.firstname + '</span></p><p><strong>Last Name: </strong><span>'+ itemData.info.lastname +
        '</span></p><p><strong>Vehicle Model: </strong><span>'+ itemData.info.model + '</span></p><p><strong>License Plate: </strong><span>'+ itemData.info.plate+
        '</span></p><p><strong>Rental Date: </strong><span>'+ itemData.info.date + '</span></p><p><strong>Rented At: </strong><span>'+ itemData.info.rentedtime + '</span></p><p><strong>Rental Until: </strong><span>'+ 
        itemData.info.rentaltime);
```

- Next go to you qb-core folder then open the shared items.lua and add the following:
```lua
['rentalpapers'] 				 = {['name'] = 'rentalpapers', 			  	  	['label'] = 'Rental Documents', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'documents.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = ''},
```
