# mka-lasers
Create moving lasers in FiveM!

<img src="https://i.imgur.com/Yw9jcMR.png" alt="Example of lasers in bank vault" height="400px">

## Creation
Creating new lasers is simple. The `/lasers` command takes three possible sub-commands (start, end, save).

To start creating a new laser, use the command `/lasers start`. A green sphere will appear where you are looking in-game. This is the laser's "origin point" (where the laser will start). You can press E to select that point. You can have multiple origin points, which enables situations where you have a laser moving back and forth between multiple origin-target point pairs. To place more than one origin point just keep pressing E to add more points.

To switch to target point selection mode, press the X key, and the sphere will turn red. You can press E to place a point. Just like origin points, you can place as many target points as you want, however if you have multiple origin points, you must have the same number of target points. These points are the "targets" that your laser will point to. The laser can either follow these points in order, or randomly (only available if you have a single origin point), so make sure to place them in the order you want!

Once you are done selecting the target points, use `/lasers save` to save the created laser. You will be asked to input a name, and then the generated code for the newly created laser will be in the "lasers.txt" file in the resource's folder.

## How to Use
To use your newly created laser, you need to do two things.

1. Import mka-lasers into the resource you want to use it in. You can do this by adding the following to your resource's __resource.lua or fxmanifest.lua file.
```lua
client_scripts {
    '@mka-lasers/client/client.lua',
    'your_scripts_client.lua',
}
```
2. Paste the generated code for your laser from the "lasers.txt" file anywhere in your resource.
3. Call setActive(true) on the laser(s) to turn them on.


## Laser Options

| Property                 | Type    | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Default&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Required | Description                                                                                                                                                                                                                                                                  |
|--------------------------|---------|---------------------------------------------------------------------------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| name                     | String  | ""                                                                              | false    | Name of the laser                                                                                                                                                                                                                                                            |
| travelTimeBetweenTargets | Table   | {1.0, 1.0}                                                                      | false    | The amount of time in seconds for the laser to travel from one target point to the next. This is a table of two values representing the minimum and maximum time, which is randomly selected between. If you don't want a random value, simply put the same number for both. |
| waitTimeAtTargets        | Table   | {0.0, 0.0}                                                                      | false    | The amount of time in seconds the laser will wait once it reaches a target point. This is a table of two values representing the minimum and maximum time, which is randomly selected between. If you don't want a random value, simply put the same number for both.        |
| randomTargetSelection    | Boolean | true                                                                            | false    | Whether the laser randomly selects the next target point. If this is false, the next point in the original order will be selected.                                                                                                                                           |
| maxDistance              | Float   | 20.0                                                                            | false    | Maximum distance of the laser.                                                                                                                                                                                                                                               |
| color                    | Table   | {255, 0, 0, 255}                                                                | false    | Color of the laser in rgba format (red, blue, green, alpha). This has to be a table of four integers representing each of the four colors in rgba.                                                                                                                           |

## onPlayerHit
onPlayerHit is a function on a laser which will call the given callback function anytime the laser goes from not hitting a player to hitting them, and vice-versa.
### Using onPlayerHit
```lua
laser.onPlayerHit(function(playerBeingHit, hitPos)
    if playerBeingHit then
        -- Laser just hit the player
    else
        -- Laser just stopped hitting the player
        -- hitPos will just be a zero vector here
    end
end)

-- You can clear out onPlayerHit by just calling clearOnPlayerHit()
laser.clearOnPlayerHit()
```


## Other Laser Functions
Laser's have a few functions that can be useful for manipulating the laser after you create it. They are as follows:

`getActive()` - Returns the active state of the laser (if it's on or off) \
`setActive(bool)` - Sets the active state of the laser \
`getVisible()` - Returns the visibility of the laser \
`setVisible(bool)` - Sets the visibility of the laser \
`getMoving()` - Returns whether the laser is moving or not \
`setMoving(bool)` - Sets whether the laser is moving or not \
`getColor()` - Returns the color of the laser as red, green, blue, and alpha (rgba) \
`setColor(int, int, int, int)` - Sets the color of the laser using red, green, blue, and alpha (rgba)


