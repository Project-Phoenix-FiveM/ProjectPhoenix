local Resource, Promises, Functions, CallIdentifier = GetCurrentResourceName(), {}, {}, 0

RPC = {}

function ClearPromise(callID)
    Citizen.SetTimeout(5000, function()
        Promises[callID] = nil
    end)
end

function ParamPacker(...)
    local params, pack = {...} , {}

    for i = 1, 15, 1 do
        pack[i] = {param = params[i]}
    end

    return pack
end

function ParamUnpacker(params, index)
    local idx = index or 1

    if idx <= #params then
        return params[idx]["param"], ParamUnpacker(params, idx + 1)
    end
end

function UnPacker(params, index)
    local idx = index or 1

    if idx <= 15 then
        return params[idx], UnPacker(params, idx + 1)
    end
end

------------------------------------------------------------------
--                  (Trigger Server Calls)
------------------------------------------------------------------

function RPC.execute(src, name, ...)
    local callID, solved = CallIdentifier, false
    CallIdentifier = CallIdentifier + 1

    Promises[callID] = promise:new()

    TriggerClientEvent("rpc:request", src, Resource, name, callID, ParamPacker(...), true)

    Citizen.SetTimeout(20000, function()
        if not solved then
            Promises[callID]:resolve({nil})
            print("RPC Client Timeout | Resource: " .. Resource .. " Event: " .. name)
        end
    end)

    local response = Citizen.Await(Promises[callID])

    solved = true

    ClearPromise(callID)

    return ParamUnpacker(response)
end

RegisterNetEvent("rpc:response")
AddEventHandler("rpc:response", function(origin, callID, response)
    if Resource == origin and Promises[callID] then
        Promises[callID]:resolve(response)
    end
end)

------------------------------------------------------------------
--                  (Receive Remote Calls)
------------------------------------------------------------------

function RPC.register(name, func)
    Functions[name] = func
end

function RPC.remove(name)
    Functions[name] = nil
end

RegisterNetEvent("rpc:request")
AddEventHandler("rpc:request", function(origin, name, callID, params, packaged)
    local src = source

    local response

    if Functions[name] == nil then return end

    local success, error = pcall(function()
        if packaged then
            response = ParamPacker(Functions[name](src, ParamUnpacker(params)))
        else
            response = ParamPacker(Functions[name](src, UnPacker(params)))
        end
    end)

    if not success then
        print("RPC Client Error | Resource: " .. Resource .. " Event: " .. name .. " Origin: " .. origin .. " Error: " .. error)
    end

    if response == nil then
        response = {}
    end

    TriggerClientEvent("rpc:response", src, origin, callID, response)
end)

------------------------------------------------------------------
--                  (Timeout & Error Events)
------------------------------------------------------------------

RegisterNetEvent("rpc:server:timeout")
AddEventHandler("rpc:server:timeout", function(Resource, name)
    --print("RPC Server Timeout | Resource: " .. Resource .. " Event: " .. name)
end)

RegisterNetEvent("rpc:client:error")
AddEventHandler("rpc:client:error", function(Resource, origin, name, error)
    --print("RPC Server Error | Resource: " .. Resource .. " Event: " .. name .. " Origin: " .. origin .. " Error: " .. error)
end)