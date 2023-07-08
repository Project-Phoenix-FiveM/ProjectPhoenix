local isVip = false
local wasCalled = false
local enabledVip = Config.ForceVip

-- if you want this script for... lets say like only vip, edit this function.
-- WE DO NOT provide any help with setting the VIP. You need to contact your own programmer for this feature.
function YourSpecialPermission()
    if enabledVip then
        return isVip
    end
    return true
end

RegisterNetEvent("rcore_radiocar:fetchPermission")
AddEventHandler("rcore_radiocar:fetchPermission", function(status)
    if not wasCalled then
        wasCalled = true
        isVip = status
    end
end)

-- this works on ACE permission so check in readme.md for the code.
CreateThread(function()
    TriggerServerEvent("rcore_radiocar:fetchPermission")
end)