# qb-rentals
This is a vehicle rental script for Cars, Aircrafts and Boats. This script is made for the qbcore framework and utilizes qb-target and qb-menu.

# Features
- Fully Configurable
- Checks to see if player has correct amount of cash
- Checks to see if rental spot it open
- Provides rental papers for the vehicle
- Not in use 0.00 In use 0.00-0.01
- Ability to return all vehicles 
- License Checks

# Dependencies 
- [qb-target](https://github.com/BerkieBb/qb-target)
- [qb-menu](https://github.com/qbcore-framework/qb-menu)

# Installation
Go to qb-core/server/player.lua (line 94)
Replace the licenses metadata with the snippet below
```lua
PlayerData.metadata['licences'] = PlayerData.metadata['licences'] or {
        ['driver'] = true,
        ['business'] = false,
        ['weapon'] = false,
        ['pilot'] = false
}
```
# Optional
*This allows you to add the ability for police to grant and revoke pilot licenses*
Go to qb-policejob/server/main.lua (line 124)
Replace the old line with this
```lua
if args[2] == "driver" or args[2] == "weapon" or args[2] == "pilot" then
```
Go to qb-policejob/server/main.lua (line 148)
Replace the old line with this
```lua
if args[2] == "driver" or args[2] == "weapon" or args[2] == "pilot" then
```
 
# Rental Papers Item
 
 ```lua
  ["rentalpapers"]				 = {["name"] = "rentalpapers", 					["label"] = "Rental Papers", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "rentalpapers.png", 		["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false, 	["combinable"] = nil, 	["description"] = "Yea, this is my car i can prove it!"},
  ```
  # Rental Papers Item Description - qb-inventory/html/js/app.js (Line 577)
  
 ```lua
   } else if (itemData.name == "stickynote") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p>' + itemData.info.label + '</p>');
        } else if (itemData.name == "rentalpapers") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p><strong>Name: </strong><span>'+ itemData.info.firstname + '</span></p><p><strong>Last Name: </strong><span>'+ itemData.info.lastname+ '</span></p><p><strong>Plate: </strong><span>'+ itemData.info.plate + '<p><strong>Model: </strong><span>'+ itemData.info.model +'</span></p>');
```
# Change Logs
- 1.0 - Inital release
- 1.1 - Script optimization / Locales
- 2.0 - Script Revamp

# Credits - [itsHyper](https://github.com/itsHyper) & elfishii 
