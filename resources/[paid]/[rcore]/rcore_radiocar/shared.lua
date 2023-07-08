-- this will deep copy whole table
--- @param object table
function DeepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if _G["type"](object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end

    return _copy(object)
end

function Trim(value)
    return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
end

-- works on both sides in server + client
function IsPlayerInAnyVehicle(source)
    if not IsDuplicityVersion() then
        return IsPedInAnyVehicle(PlayerPedId(), false)
    else
        return GetVehiclePedIsIn(GetPlayerPed(source), false) ~= 0
    end
end

function GetVehPlate(netID)
    local plate = GetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(netID))
    if Config.ForceTrim then
        plate = Trim(plate)
    end
    return plate
end

-- works on server only
function PlayerIdentifier(source, pattern)
    local identifier = "none"

    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(v, pattern) then
            return v
        end
    end

    return identifier
end

function MakeFakeIndexForiPairs(result, table_)
    table_ = DeepCopy(table_)
    for i = 1,200 do
        if not table_[i] then
            table_[i] = {
                active = result,
                fake = true,
            }
        end
    end

    return table_
end

function GetEsxObject()
    local promise_ = promise:new()
    local obj
    xpcall(function()
        obj = exports[Config.esx_resource_name]['getSharedObject']()
        promise_:resolve(obj)
    end, function(error)
        TriggerEvent(Config.ESX or "esx:getSharedObject", function(module)
            obj = module
            promise_:resolve(obj)
        end)
    end)

    Citizen.Await(obj)
    return obj
end

-- bridge for older versions
Config.GetQBCoreObject = function()
    local promise_ = promise:new()
    local obj
    xpcall(function()
        obj = exports[Config.qbcore_resource_name]['GetCoreObject']()
        promise_:resolve(obj)
    end, function(error)
        xpcall(function()
            obj = exports[Config.qbcore_resource_name]['GetSharedObject']()
            promise_:resolve(obj)
        end, function(error)

            local QBCore = nil
            local tries = 10

            LoadQBCore = function()
                if tries == 0 then
                    print("The QBCORE couldnt load any object! You need to correct the event / resource name for export!")
                    return
                end

                tries = tries - 1

                if QBCore == nil then
                    SetTimeout(100, LoadQBCore)
                end

                TriggerEvent(Config.QBCore or "QBCore:GetObject", function(module)
                    QBCore = module

                    obj = QBCore
                    promise_:resolve(QBCore)
                end)
            end

            LoadQBCore()

        end)
    end)

    Citizen.Await(obj)

    return obj
end

function DebugFunction(...)
    if Config.FunctionDebug then
        print(...)
    end
end

function dump(node, printing)
    local cache, stack, output = {}, {}, {}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k, v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k, v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then

                if (string.find(output_str, "}", output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str, "\n", output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output, output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "[" .. tostring(k) .. "]"
                else
                    key = "['" .. tostring(k) .. "']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = " .. tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = {\n"
                    table.insert(stack, node)
                    table.insert(stack, v)
                    cache[node] = cur_index + 1
                    break
                else
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = '" .. tostring(v) .. "'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output, output_str)
    output_str = table.concat(output)
    if not printing then
        print(output_str)
    end
    return output_str
end

Dump = dump

RegisterCommand("cachecar", function()
    dump(cachedCars)
end)