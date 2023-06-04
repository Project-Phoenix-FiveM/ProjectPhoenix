local IsNew = false

RegisterNetEvent('qb-interior:client:SetNewState', function(bool)
    IsNew = bool
end)
-- Functions
function TeleportToInterior(x, y, z, h)
    CreateThread(function()
        SetEntityCoords(PlayerPedId(), x, y, z, 0, 0, 0, false)
        SetEntityHeading(PlayerPedId(), h)

        Wait(100)

        DoScreenFadeIn(1000)
    end)
end

exports('DespawnInterior', function(objects, cb)
    CreateThread(function()
        for _, v in pairs(objects) do
            if DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end

        cb()
    end)
end)

--Core Functions

local function CreateShell(spawn, exitXYZH, model)
    local objects = {}
    local POIOffsets = {}
    POIOffsets.exit = exitXYZH
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1000)
    end
    local house = CreateObject(model, spawn.x, spawn.y, spawn.z, false, false, false)

    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
    TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

exports('CreateShell', function(spawn, exitXYZH, model)
    return CreateShell(spawn, exitXYZH, model)
end)

-- Starting Apartment

exports('CreateApartmentFurnished', function(spawn)

    local exit = json.decode('{"x": 1.5, "y": -10.0, "z": 0, "h":358.50}')
    
    local model = "furnitured_midapart"
    local obj = CreateShell(spawn, exit, model)
    if obj and obj[2] then
		obj[2].clothes = json.decode('{"x": -6.028, "y": -9.5, "z": 1.2, "h":2.263}')
		obj[2].stash = json.decode('{"x": -7.305, "y": -3.922, "z": 0.5, "h":2.263}')
		obj[2].logout = json.decode('{"x": -0.8, "y": 1.0, "z": 1.0, "h":2.263}')
	end
    if IsNew then
        SetTimeout(750, function()
            TriggerEvent('qb-clothes:client:CreateFirstCharacter')
            IsNew = false
        end)
    end
    return { obj[1], obj[2] }
end)

exports('CreateHouseRobbery', function(spawn)
    local exit = json.decode('{"x": 1.46, "y": -10.33, "z": 1.06, "h": 0.39}')
    local model = "furnitured_midapart"
    return CreateShell(spawn, exit, model)
end)

-- Shells (in order by tier starting at 1)

exports('CreateApartmentShell', function(spawn)--fix this
    local exit = json.decode('{"x": 4.693, "y": -6.015, "z": 1.11, "h":358.634}')
    local model = "shell_v16low"
    return CreateShell(spawn, exit, model)
end)

exports('CreateTier1House', function(spawn)
    local exit = json.decode('{"x": 1.561, "y": -14.305, "z": 1.147, "h":2.263}')
    local model = "shell_v16mid"
    return CreateShell(spawn, exit, model)
end)

exports('CreateTrevorsShell', function(spawn)
    local exit = json.decode('{"x": 0.374, "y": -3.789, "z": 2.428, "h":358.633}')
    local model = "shell_trevor"
    return CreateShell(spawn, exit, model)
end)

exports('CreateCaravanShell', function(spawn)
    local exit = json.decode('{"z":3.3, "y":-2.1, "x":-1.4, "h":358.633972168}')
    local model = "shell_trailer"
    return CreateShell(spawn, exit, model)
end)

exports('CreateLesterShell', function(spawn)
    local exit = json.decode('{"x":-1.780, "y":-0.795, "z":1.1,"h":270.30}')
    local model = "shell_lester"
    return CreateShell(spawn, exit, model)
end)

exports('CreateRanchShell', function(spawn)
    local exit = json.decode('{"x":-1.257, "y":-5.469, "z":2.5, "h":270.57,}')
    local model = "shell_ranch"
    return CreateShell(spawn, exit, model)
end)

exports('CreateContainer', function(spawn)
    local exit = json.decode('{"x": 0.08, "y": -5.73, "z": 1.24, "h": 359.32}')
    local model = "container_shell"
    return CreateShell(spawn, exit, model)
end)

exports('CreateFurniMid', function(spawn)
    local exit = json.decode('{"x": 1.46, "y": -10.33, "z": 1.06, "h": 0.39}')
    local model = "furnitured_midapart"
    return CreateShell(spawn, exit, model)
end)

exports('CreateFurniMotelModern', function(spawn)
    local exit = json.decode('{"x": 4.98, "y": 4.35, "z": 1.16, "h": 179.79}')
    local model = "modernhotel_shell"
    return CreateShell(spawn, exit, model)
end)

exports('CreateFranklinAunt', function(spawn)
    local exit = json.decode('{"x": -0.36, "y": -5.89, "z": 1.70, "h": 358.21}')
    local model = "shell_frankaunt"
    return CreateShell(spawn, exit, model)
end)

exports('CreateGarageMed', function(spawn)
    local exit = json.decode('{"x": 13.90, "y": 1.63, "z": 1.0, "h": 87.05}')
    local model = "shell_garagemed"
    return CreateShell(spawn, exit, model)
end)

exports('CreateMichael', function(spawn)
    local exit = json.decode('{"x": -9.49, "y": 5.54, "z": 9.91, "h": 270.86}')
    local model = "shell_michael"
    return CreateShell(spawn, exit, model)
end)

exports('CreateOffice1', function(spawn)
    local exit = json.decode('{"x": 1.88, "y": 5.06, "z": 2.05, "h": 180.07}')
    local model = "shell_office1"
    return CreateShell(spawn, exit, model)
end)

exports('CreateStore1', function(spawn)
    local exit = json.decode('{"x": -2.61, "y": -4.73, "z": 1.08, "h": 1.0}')
    local model = "shell_store1"
    return CreateShell(spawn, exit, model)
end)

exports('CreateWarehouse1', function(spawn)
    local exit = {x = -8.95, y = 0.51, z = 1.04, h = 268.82}
    local model = "shell_warehouse1"
    return CreateShell(spawn, exit, model)
end)
