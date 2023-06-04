Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

-- This is the handler for the cop count, you can change this to anything you want as this is by default the qb-policejob event
RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

--- This function will be executed once a doorlock action is happening, so locking or unlocking a door
--- @param doorId number | string
--- @param setLocked boolean
--- @return nil
function Config.DoorlockAction(doorId, setLocked)
    TriggerServerEvent('qb-doorlock:server:updateState', doorId, setLocked, false, false, true, false, false)
end

--- This function will be triggered once the hack is done
--- @param success boolean
--- @param bank number | string
--- @return nil
function Config.OnHackDone(success, bank)
    TriggerEvent('mhacking:hide')
    if not success then return end
    TriggerServerEvent('qb-bankrobbery:server:setBankState', bank)
end

--- This will be triggered once an action happens that can drop evidence
--- @param pos vector3
--- @param chance number
--- @return nil
function Config.OnEvidence(pos, chance)
    if math.random(1, 100) > chance or QBCore.Functions.IsWearingGloves() then return end
    TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
end

--- This will be called each 10 seconds whilst drilling a safety deposit box
--- @return nil
function Config.OnDrillingAction()
    TriggerServerEvent('hud:server:GainStress', math.random(4, 8))
end

--- This is triggered whenever a robbery call is made by the alarm of a bank
--- @param message string
--- @return nil
function Config.OnPoliceAlert(message)
    TriggerServerEvent("police:server:policeAlert", message)
end

--- This is called when the user is nearby an interaction that requires said items, this will trigger the box that shows what items you need
---
--- Format for `items`:
--- ```lua
--- {
---     [itemIndexNumber] = { name = 'itemName', image = 'itemImage' }
--- }
--- ```
--- @param items table | nil
--- @param show boolean
--- @return nil
function Config.ShowRequiredItems(items, show)
    TriggerEvent('inventory:client:requiredItems', items, show)
end

Config.MinimumPaletoPolice = 0
Config.MinimumPacificPolice = 0
Config.MinimumFleecaPolice = 0
Config.MinimumThermitePolice = 0
Config.OutlawCooldown = 5 -- The amount of minutes it takes for the cops to be able to be called again after they were called
