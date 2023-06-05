![Redline Studios Banner](https://i.imgur.com/VFEXnGd.png)
# Redline Studios Discord:
https://discord.gg/RCU9XEvnsE

# Redline Studios Prison Script
-----------------------------------------------------------------------------------------------------------------

## FEATURES:
- Reduce your time doing jobs!
    - Janitor - Go sweep the courtyard!
    - Cook - Prepare some slop!
    - Eletrician - Fix electrical boxes!
    - Randomly find items used for crafting!
- Change into a prisoner outfit!
    - Set male/female outifts from the config
- Prison Crafting
    - Set a location in the config
    - Set the items and required materials
- Prison Food & Drinks w/ Minigames!
    - Canteen
    - Soda Machine (Minigame)
    - Coffee Machine (Minigame)
    - Slushy Machine (Minigame)
    - Configure what minigame to use for each drink machine!
        - Uses PS-UI, QB-Lock, and QB-Skillbar
        - All configurable from the config
- Prison break!
	- qb-target at gate panels
	- PS-Var or PS-Thermite Minigames
- Lockers for prisoners!
    - Adds lockers to every cell
    - Lockers open a citizenid stash
    - Police can seize the stashes by entering a citizenid
- Be a lifer in prison!
    - Stay in prison forever! Time never reduces

-----------------------------------------------------------------------------------------------------------------

## DEVELOPMENT FEATURES:
- Debug Configs
    - Prints for debugging
    - Polyzoine Debug
- Create/Destroy all qb-target zones
    - Resource Start/Stop
    - Player Loaded/Unloaded
- Choose to remove player jobs when entering prison
- Supports citizenid table for lifers
- Support for qb-prisonjobs
    - Paid script by xThrasherrr#6666
    - Adds more prison jobs
    - Adds more variety/randomness to crafting
    - Uses b1-skillz for lifting weights/chinups w/ cooldown
    - Prison Trader
    - More Items to be found

-----------------------------------------------------------------------------------------------------------------

## Installation:
- Add slushy.png to your inventory/html/images folder
- Add 'slushy' to qb-core/shared/items.lua
```lua
['slushy']                      = {['name'] = 'slushy',                     ['label'] = 'Slushy',                   ['weight'] = 750,       ['type'] = 'item',      ['image'] = 'slushy.png',       ['unique'] = true,      ['useable'] = true,     ['shouldClose'] = true,     ['combinable'] = nil,   ['description'] = 'A nice cold drink in the coldest place in San Andreas'},
```

-----------------------------------------------------------------------------------------------------------------


## Dependencies:

- qb-policejob https://github.com/qbcore-framework/qb-policejob
- qb-target https://github.com/qbcore-framework/qb-target
- qb-menu https://github.com/qbcore-framework/qb-menu
- qb-lock https://github.com/Tex27/qb-lock
- OPTIONAL FOR PRISON SHIV: Custom-Weapons https://github.com/NoobySloth/Custom-Weapons
- OPTIONAL FOR CONFIG:
	- ps-ui https://github.com/Project-Sloth/ps-ui
	- qb-skillbar https://github.com/qbcore-framework/qb-skillbar
	- qb-prisonjobs https://thrasherrrdev.tebex.io/package/5226873
	- QBCore prison_map https://github.com/qbcore-framework/prison_map (WORK IN PROGRESS)
	- Gabz Prison https://fivem.gabzv.com/package/4724793 (Set Up)

-----------------------------------------------------------------------------------------------------------------

## Credits:
- IN1GHTM4R3 - https://github.com/IN1GHTM4R3/qb-prison - The Original Resource
- xViperAG https://github.com/xViperAG - New rework
- xThrasherrr https://github.com/xThrasherrr - New Rework
-----------------------------------------------------------------------------------------------------------------
