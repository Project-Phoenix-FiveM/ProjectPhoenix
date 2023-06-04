# qb-platescan
This script allows officers to quickly scan plates while patroling. Scanning attempts check for bolos, stolen status, and warrants within ps-mdt. If a vehicle is not owned by a player, than it will generate a name and store it server-side for later use. With the optional snippet from step 5, non-owned vehicles that are stolen have a chance to get marked as flagged. 

This script was forked from @QuantumMalice with updates and bug fixes to existing issues. You can find the original repo [here](https://github.com/QuantumMalice/qb-platescan)

This resource also includes a vehicle target option (boot and number plate vehicle bone) which scans the plate for an even more accurate reading and/or if Police Officers are not doing a traffic stop.

* [Video](https://streamable.com/144ebv)

# Dependencies
* [qb-core](https://github.com/qbcore-framework/qb-core)
* [oxysql](https://github.com/overextended/oxmysql)
* [ox_target](https://github.com/overextended/ox_target) or
* [qb-target](https://github.com/qbcore-framework/qb-target)
* [wk_wars2x](https://github.com/WolfKnight98/wk_wars2x)
* [ps-mdt](https://github.com/Project-Sloth/ps-mdt)
* [ps-dispatch](https://github.com/Project-Sloth/ps-dispatch)

# Installation
*Make sure this script starts after qb-phone & wk_wars2x*
1. Download source files from github
2. Drag into resources folder
3. Replace `cl_plate_reader.lua` in wk_wars2x
4. If using qb-phone, add export to disable scanning spam
5. Add ps-dispatch alerts
6. Add event to vehicle keys script *(Optional)*

## Add phone export:

- **Add this to *qb-phone/client/main.lua*** 
```lua
local function IsPhoneOpen()
    return PhoneData.isOpen
end exports("IsPhoneOpen", IsPhoneOpen)
```

## Add Dispatch compatability

- **Add this snippet into your *ps-dispatch/client/cl_extraevents.lua***

```lua
local function ScanPlate(vehdata, scanStatus)

    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local heading = getCardinalDirectionFromHeading()

    local status = nil

    if vehdata.flagReason[1] ~= nil and vehdata.flagReason[2] ~= nil and vehdata.flagReason[3] ~= nil then
        status = 'Flags: '..vehdata.flagReason[1]..', '..vehdata.flagReason[2]..' '..vehdata.flagReason[3]
    elseif vehdata.flagReason[1] ~= nil and vehdata.flagReason[2] ~= nil then
        status = 'Flags: '..vehdata.flagReason[1]..', '..vehdata.flagReason[2]
    elseif vehdata.flagReason[1] then
        status = 'Flags: '..vehdata.flagReason[1]
    else
        status = 'Flags: NONE'
    end

    local prio = 0
    if vehdata.plateStatus == 'FLAGGED' then prio = 1 end
        
    TriggerEvent("dispatch:clNotify", {
        dispatchcodename = "platescan", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = 'Dispatch',
        firstStreet = locationInfo,
        model = vehdata.info3,
        plate = vehdata.info,
        priority = prio,
        firstColor = status,
        heading = 'Owner: '..vehdata.info2,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = 'Plate Information',
        job = { "police" }
    }, 55, 1)
end

exports('ScanPlate', ScanPlate)
```

- **Add this to your **ps-dispatch/server/sv_dispatchcodes.lua***

```lua
 ["platescan"] =  {displayCode = '10-11', description = "Plate Information", radius = 10.0, recipientList = {'police'}, blipSprite = 66, blipColour = 37, blipScale = 0.6, blipLength = 1, sound = "Lose_1st", sound2 = "GTAO_FM_Events_Soundset", offset = "false", blipflash = "false"},
 ```

## Add vehicle keys event: *Optional*

- **Add this to your vehicle keys script and match up your variables** (*somewhere after a successful hotwire*)
```lua
TriggerEvent("qb-platescan:client:AddStolenPlate", vehicle, plate)
```

# Usage
After wk_wars2x plate reader display is toggled, use left mouse click to scan vehicle plates.

# Credits
- Thanks to [**Linden**](https://github.com/thelindat) for [*linden_outlawalert*](https://github.com/thelindat/linden_outlawalert)