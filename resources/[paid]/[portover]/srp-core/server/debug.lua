-- ToDo: Used Later
-- RegisterServerEvent('SRPCore:DebugSomething', function(table, indent)
--     local resource = GetInvokingResource() or "srp-core"
--     print(('\x1b[4m\x1b[36m[ %s : DEBUG]\x1b[0m'):format(resource))
--     tPrint(table, indent)
--     print('\x1b[4m\x1b[36m[ END DEBUG ]\x1b[0m')
-- end)

local function tPrint(tbl, indent)
    indent = indent or 0
    for k, v in pairs(tbl) do
        local tblType = type(v)
        local formatting = ("%s ^3%s:^0"):format(string.rep("  ", indent), k)

        if tblType == "table" then
            print(formatting)
            tPrint(v, indent + 1)
        elseif tblType == 'boolean' then
            print(("%s^1 %s ^0"):format(formatting, v))
        elseif tblType == "function" then
            print(("%s^9 %s ^0"):format(formatting, v))
        elseif tblType == 'number' then
            print(("%s^5 %s ^0"):format(formatting, v))
        elseif tblType == 'string' then
            print(("%s ^2'%s' ^0"):format(formatting, v))
        else
            print(("%s^2 %s ^0"):format(formatting, v))
        end
    end
end

RegisterServerEvent('SRPCore:DebugSomething')
AddEventHandler('SRPCore:DebugSomething', function(resource, obj, depth)
    print("\x1b[4m\x1b[36m["..resource..":DEBUG]\x1b[0m")
    if type(obj) == "string" then
        print(string.format("%q", obj))
    elseif type(obj) == "table" then
        local str = "{"
        for k, v in pairs(obj) do
            if type(v) == "table" then
                for ik, iv in pairs(v) do
                    str = str.."\n["..k.."] -> ["..ik.."] -> "..tostring(iv)
                end
            else
                str = str.."\n["..k.."] -> "..tostring(v)
            end
        end
        
        print(str.."\n}")
    else
        local success, value = pcall(function() return tostring(obj) end)
        print((success and value or "<!!error in __tostring metamethod!!>"))
    end
    print("\x1b[4m\x1b[36mEND OF DEBUG\x1b[0m")
end)

SRPCore.Debug = function(resource, obj, depth)
    TriggerEvent('SRPCore:DebugSomething', resource, obj, depth)
end

SRPCore.ShowError = function(resource, msg)
    print("\x1b[31m["..resource..":ERROR]\x1b[0m "..msg)
end

SRPCore.ShowSuccess = function(resource, msg)
    print("\x1b[32m["..resource..":LOG]\x1b[0m "..msg)
end
