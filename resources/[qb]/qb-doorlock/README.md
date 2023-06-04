# qb-doorlock
Doorlock System For QBCore

This doorlock system is based on [nui_doorlock by thelindat](https://github.com/thelindat/nui_doorlock) and contains compatibility with it's format.

## Dependencies

* [qb-core](https://github.com/qbcore-framework/qb-core)
* [qb-input](https://github.com/qbcore-framework/qb-input) - For Making New Doors
* [qb-lockpick](https://github.com/qbcore-framework/qb-lockpick) - For Lockpicking Doors

## Features

* Quick in-game door creation with /newdoor
* Multiple door types to support all possible doors
* Support for item checking, multiple or single items
* Support for citizenid, gang and job checking
* Support for qb-lockpick
* NUI Text as interaction text
* Great performance
* Uses the native door system
* Support for object names and hashes
* Play any sound you want when unlocking/locking a door
* Highly customisable
* Auto lock, to automatically lock a door after it has been opened
* Admin access option
* Change color based on locked state

## Single Door Configuration

      ['somesingledoor'] = { -- The index of the table, this is used as the doorID
            objName = 'hei_v_ilev_bk_gate2_pris', -- Door object name can be a string or a number. Alias: objHash = 'hei_v_ilev_bk_gate2_pris',
            objCoords  = vec3(261.83, 221.39, 106.41), -- Object coords
            textCoords = vec3(261.83, 221.39, 106.41), -- Coords for the interaction text
            authorizedJobs = { ['police'] = 0 }, -- Job access (checks for a minimum grade of 0)
            authorizedGangs = { ['vagos'] = 0 }, -- Gang access (checks for a minimum grade of 0)
            authorizedCitizenIDs = { ['BUI05180'] = true }, -- Citizen ID access
            items = { ['keycard'] = 1, ['banana'] = 3 }, -- Item access, can be a string or table | the value of the item is the amount of items needed when using a table, if it is a string it will always check if this person has one or more of the item
            needsAllItems = false, -- true or false | Whether to check if the person has all items to unlock the door or just one of the items
            allAuthorized = false, -- true or false | Will give access to everyone if it is true
            objYaw = -110.0, -- Heading of the door. Alias: objHeading = -110.0,
            locked = true, -- true or false | Is the door locked by default
            pickable = false, -- true or false | Can the door be lockpicked. Alias: lockpick = false,
            distance = 1.5, -- At what range the interaction text will show. Alis: maxDistance = 1.5,
            doorType = 'door', -- The type of door, can be door, double, sliding, doublesliding or garage
            fixText = true, -- true or false | fix the text to the center of the door
            doorLabel = 'Cloakroom', -- Label of the door that shows up when nearby
            audioRemote = true, -- true or false | Play sound from the player instead of the door
            audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6}, -- Play sound on door lock
            audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}, -- Play sound on door unlock
            autoLock = 1000, -- Auto lock after this many miliseconds
            doorRate = 1.0,  -- The rate of the animation to lock/unlock the door
            cantUnlock = true -- true or false | Set to true to not allow the player to unlock the door, only lock it. This means a script will have to trigger the unlock
            hideLabel = true, -- Set to true to hide the popup label, for hiding doors
            remoteTrigger = true, -- true or false | If you want to be able to remote trigger a door with H, put this here
      },

## Double Door Configuration

      ['somedoubledoor'] = { -- The index of the table, this is used as the doorID, can be a number or a string
            doors = { -- Table of doors which holds both doors' data
			{
				objName = 'v_ilev_rc_door2', -- Door object name can be a string or a number. Alias: objHash = 'v_ilev_rc_door2',
				objYaw = 135.0, -- Heading of the door. Alias: objHeading = 135.0,
				objCoords = vec3(-447.7283, 6006.702, 31.86523), -- Object coords
			},

			{
				objName = 'v_ilev_rc_door2', -- Door object name can be a string or a number. Alias: objHash = 'v_ilev_rc_door2',
				objYaw = -45.0,  -- Heading of the door. Alias: objHeading = -45.0,
				objCoords = vec3(-449.5656, 6008.538, 31.86523), -- Object coords
			},
		},
            textCoords = vec3(-448.67, 6007.52, 31.86523), -- Coords for the interaction text
            authorizedJobs = { ['police'] = 0 }, -- Job access (checks for a minimum grade of 0)
            authorizedGangs = { ['vagos'] = 0 }, -- Gang access (checks for a minimum grade of 0)
            authorizedCitizenIDs = { ['BUI05180'] = true }, -- Citizen ID access
            items = { ['keycard'] = 1, ['banana'] = 3 }, -- Item access, can be a string or table | the value of the item is the amount of items needed when using a table, if it is a string it will always check if this person has one or more of the item
            needsAllItems = false, -- true or false | Whether to check if the person has all items to unlock the door or just one of the items
            allAuthorized = false, -- true or false | Will give access to everyone if it is true
            locked = true, -- true or false | Is the door locked by default
            pickable = false, -- true or false | Can the door be lockpicked. Alias: lockpick = false,
            distance = 2.5, -- At what range the interaction text will show. Alis: maxDistance = 2.5,
            doorType = 'double', -- The type of door, can be door, double, sliding, doublesliding or garage
                        fixText = true, -- true or false | fix the text to the center of the door
            doorLabel = 'Cloakroom', -- Label of the door that shows up when nearby
            audioRemote = true, -- true or false | Play sound from the player instead of the door
            audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6}, -- Play sound on door lock
            audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}, -- Play sound on door unlock
            autoLock = 1000, -- Auto lock after this many miliseconds
            doorRate = 1.0,  -- The rate of the animation to lock/unlock the door
            cantUnlock = true -- true or false | Set to true to not allow the player to unlock the door, only lock it. This means a script will have to trigger the unlock
            hideLabel = true, -- Set to true to hide the popup label, for hiding doors
            remoteTrigger = true, -- true or false | If you want to be able to remote trigger a door with H, put this here
      },

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>