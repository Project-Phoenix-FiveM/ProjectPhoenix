-- Medium Housing Shells V1 https://www.k4mb1maps.com/package/4672307

exports('CreateMedium2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 6.04, "y": 0.34, "z": 1.03, "h": 357.99}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_medium2`)
	while not HasModelLoaded(`shell_medium2`) do Wait(1000) end
	local house = CreateObject(`shell_medium2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateMedium3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 3.32, "y": 1.23, "z": 2.57, "h": 273.46}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_medium3`)
	while not HasModelLoaded(`shell_medium3`) do Wait(1000) end
	local house = CreateObject(`shell_medium3`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Modern Housing Shells V1 https://www.k4mb1maps.com/package/4673169

exports('CreateBanham', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -3.26, "y": -1.63, "z": 6.25, "h": 90.49}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_banham`)
	while not HasModelLoaded(`shell_banham`) do Wait(1000) end
	local house = CreateObject(`shell_banham`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateWestons', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.29, "y": 10.59, "z": 6.95, "h": 183.60}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_westons`)
	while not HasModelLoaded(`shell_westons`) do Wait(1000) end
	local house = CreateObject(`shell_westons`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateWestons2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -1.76, "y": 10.62, "z": 6.95, "h": 179.20}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_westons2`)
	while not HasModelLoaded(`shell_westons2`) do Wait(1000) end
	local house = CreateObject(`shell_westons2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Classic Housing Shells V1 https://www.k4mb1maps.com/package/4673140

exports('CreateClassicHouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.78, "y": -2.11, "z": 5.26, "h": 87.93}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`classichouse_shell`)
	while not HasModelLoaded(`classichouse_shell`) do Wait(1000) end
	local house = CreateObject(`classichouse_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateClassicHouse2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.78, "y": -2.09, "z": 5.26, "h": 90.58}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`classichouse2_shell`)
	while not HasModelLoaded(`classichouse2_shell`) do Wait(1000) end
	local house = CreateObject(`classichouse2_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateClassicHouse3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.78, "y": -2.12, "z": 5.26, "h": 91.60}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`classichouse3_shell`)
	while not HasModelLoaded(`classichouse3_shell`) do Wait(1000) end
	local house = CreateObject(`classichouse3_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Highend Housing Shells V1 https://www.k4mb1maps.com/package/4673131

exports('CreateHighend1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -2.23, "y": 9.01, "z": 8.69, "h": 178.81}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_apartment1`)
	while not HasModelLoaded(`shell_apartment1`) do Wait(1000) end
	local house = CreateObject(`shell_apartment1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateHighend2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -2.25, "y": 9.00, "z": 8.69, "h": 177.86}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_apartment2`)
	while not HasModelLoaded(`shell_apartment2`) do Wait(1000) end
	local house = CreateObject(`shell_apartment2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateHighend3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 11.75, "y": 4.55, "z": 8.13, "h": 129.16}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_apartment3`)
	while not HasModelLoaded(`shell_apartment3`) do Wait(1000) end
	local house = CreateObject(`shell_apartment3`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Deluxe Housing Shells V1 https://www.k4mb1maps.com/package/4673159

exports('CreateHighend', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -22.37, "y": -0.33, "z": 7.26, "h": 267.73}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_highend`)
	while not HasModelLoaded(`shell_highend`) do Wait(1000) end
	local house = CreateObject(`shell_highend`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateHighendV2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -10.51, "y": 0.86, "z": 6.56, "h": 270.38}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_highendv2`)
	while not HasModelLoaded(`shell_highendv2`) do Wait(1000) end
	local house = CreateObject(`shell_highendv2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Stash House Shells https://www.k4mb1maps.com/package/4673273

exports('CreateStashHouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 20.88, "y": -0.40, "z": 15.42, "h": 86.54}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`stashhouse_shell`)
	while not HasModelLoaded(`stashhouse_shell`) do Wait(1000) end
	local house = CreateObject(`stashhouse_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateStashHouse2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -1.98, "y": 2.26, "z": 1.0, "h": 263.81}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`stashhouse2_shell`)
	while not HasModelLoaded(`stashhouse2_shell`) do Wait(1000) end
	local house = CreateObject(`stashhouse2_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Garage Shells https://www.k4mb1maps.com/package/4673177

exports('CreateGarageLow', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 5.85, "y": 3.86, "z": 1.0, "h": 180.05}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_garages`)
	while not HasModelLoaded(`shell_garages`) do Wait(1000) end
	local house = CreateObject(`shell_garages`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateGarageHigh', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 12.02, "y": -14.30, "z": 0.99, "h": 89.42}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_garagel`)
	while not HasModelLoaded(`shell_garagel`) do Wait(1000) end
	local house = CreateObject(`shell_garagel`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Office Shells https://www.k4mb1maps.com/package/4673258

exports('CreateOffice2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 3.66, "y": -1.94, "z": 1.26, "h": 92.73}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_office2`)
	while not HasModelLoaded(`shell_office2`) do Wait(1000) end
	local house = CreateObject(`shell_office2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateOfficeBig', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -12.48, "y": 1.91, "z": 5.30, "h": 175.13}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_officebig`)
	while not HasModelLoaded(`shell_officebig`) do Wait(1000) end
	local house = CreateObject(`shell_officebig`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Store Shells https://www.k4mb1maps.com/package/4673264

exports('CreateBarber', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 1.54, "y": 5.40, "z": 1.0, "h": 175.27}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_barber`)
	while not HasModelLoaded(`shell_barber`) do Wait(1000) end
	local house = CreateObject(`shell_barber`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateGunstore', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -1.02, "y": -5.43, "z": 1.03, "h": 359.77}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_gunstore`)
	while not HasModelLoaded(`shell_gunstore`) do Wait(1000) end
	local house = CreateObject(`shell_gunstore`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateStore2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.64, "y": -5.07, "z": 1.02, "h": 1.91}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_store2`)
	while not HasModelLoaded(`shell_store2`) do Wait(1000) end
	local house = CreateObject(`shell_store2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateStore3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.14, "y": -7.87, "z": 2.01, "h": 358.15}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_store3`)
	while not HasModelLoaded(`shell_store3`) do Wait(1000) end
	local house = CreateObject(`shell_store3`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Warehouse Shells https://www.k4mb1maps.com/package/4673185

exports('CreateWarehouse2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 12.51, "y": -0.01, "z": 1.03, "h": 94.52}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_warehouse2`)
	while not HasModelLoaded(`shell_warehouse2`) do Wait(1000) end
	local house = CreateObject(`shell_warehouse2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateWarehouse3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 2.61, "y": -1.65, "z": 1.00, "h": 85.2}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_warehouse3`)
	while not HasModelLoaded(`shell_warehouse3`) do Wait(1000) end
	local house = CreateObject(`shell_warehouse3`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Highend Lab Shells https://www.k4mb1maps.com/package/4698329

exports('CreateK4Coke', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -11.06, "y": -2.52, "z": 22.64, "h": 272.51}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4coke_shell`)
	while not HasModelLoaded(`k4coke_shell`) do Wait(1000) end
	local house = CreateObject(`k4coke_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Meth', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -11.06, "y": -2.48, "z": 9.47, "h": 277.54}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4meth_shell`)
	while not HasModelLoaded(`k4meth_shell`) do Wait(1000) end
	local house = CreateObject(`k4meth_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Weed', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -11.05, "y": -2.50, "z": 20.96, "h": 283.97}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4weed_shell`)
	while not HasModelLoaded(`k4weed_shell`) do Wait(1000) end
	local house = CreateObject(`k4weed_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Furnished Stash House Shells  https://www.k4mb1maps.com/package/4672293

exports('CreateContainer2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 0.02, "y": -5.37, "z": 1.12, "h": 355.28}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`container2_shell`)
	while not HasModelLoaded(`container2_shell`) do Wait(1000) end
	local house = CreateObject(`container2_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateFurniStash1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 21.41, "y": -0.52, "z": 19.33, "h": 85.84}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`stashhouse1_shell`)
	while not HasModelLoaded(`stashhouse1_shell`) do Wait(1000) end
	local house = CreateObject(`stashhouse1_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateFurniStash3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.003, "y": 5.5, "z": 3.04, "h": 180.77}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`stashhouse3_shell`)
	while not HasModelLoaded(`stashhouse3_shell`) do Wait(1000) end
	local house = CreateObject(`stashhouse3_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Furnished Housing Shells https://www.k4mb1maps.com/package/4672272

exports('CreateFurniLow', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 5.05, "y": -1.39, "z": 3.0, "h": 357.14}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`furnitured_lowapart`)
	while not HasModelLoaded(`furnitured_lowapart`) do Wait(1000) end
	local house = CreateObject(`furnitured_lowapart`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateFurniMotel', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -1.51, "y": -3.99, "z": 1.08, "h": 1.28}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`furnitured_motel`)
	while not HasModelLoaded(`furnitured_motel`) do Wait(1000) end
	local house = CreateObject(`furnitured_motel`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Furnished Motel Shells  https://www.k4mb1maps.com/package/4672296

exports('CreateFurniMotelClassic', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 0.045, "y": -3.707, "z": 1.05, "h": 351.86}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`classicmotel_shell`)
	while not HasModelLoaded(`classicmotel_shell`) do Wait(1000) end
	local house = CreateObject(`classicmotel_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateFurniMotelHigh', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 3.21, "y": 3.50, "z": 1.16, "h": 178.23}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`highendmotel_shell`)
	while not HasModelLoaded(`highendmotel_shell`) do Wait(1000) end
	local house = CreateObject(`highendmotel_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Furnished Modern Hotels https://www.k4mb1maps.com/package/4672290

exports('CreateFurniMotelModern2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.87, "y": 4.38, "z": 1.16, "h": 176.40}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`modernhotel2_shell`)
	while not HasModelLoaded(`modernhotel2_shell`) do Wait(1000) end
	local house = CreateObject(`modernhotel2_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateFurniMotelModern3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.95, "y": 4.38, "z": 1.16, "h": 176.01}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`modernhotel3_shell`)
	while not HasModelLoaded(`modernhotel3_shell`) do Wait(1000) end
	local house = CreateObject(`modernhotel3_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Drug Lab Shells https://www.k4mb1maps.com/package/4672285

exports('CreateCoke', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -6.24, "y": 8.48, "z": 1.00, "h": 179.30}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_coke1`)
	while not HasModelLoaded(`shell_coke1`) do Wait(1000) end
	local house = CreateObject(`shell_coke1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateCoke2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -6.32, "y": 8.60, "z": 1.03, "h": 179.23}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_coke2`)
	while not HasModelLoaded(`shell_coke2`) do Wait(1000) end
	local house = CreateObject(`shell_coke2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateMeth', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -6.39, "y": 8.54, "z": 1.03, "h": 178.84}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_meth`)
	while not HasModelLoaded(`shell_meth`) do Wait(1000) end
	local house = CreateObject(`shell_meth`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateWeed', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 17.46, "y": 11.71, "z": 1.01, "h": 88.37}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_weed`)
	while not HasModelLoaded(`shell_weed`) do Wait(1000) end
	local house = CreateObject(`shell_weed`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateWeed2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 17.85, "y": 11.75, "z": 1.01, "h": 88.11}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`shell_weed2`)
	while not HasModelLoaded(`shell_weed2`) do Wait(1000) end
	local house = CreateObject(`shell_weed2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Mansion Housing Shells https://www.k4mb1maps.com/package/4783251

exports('CreateMansion', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.32, "y": -0.68, "z": 7.86, "h": 178.98}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4_mansion_shell`)
	while not HasModelLoaded(`k4_mansion_shell`) do Wait(1000) end
	local house = CreateObject(`k4_mansion_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateMansion2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.32, "y": -0.57, "z": 7.86, "h": 178.74}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4_mansion2_shell`)
	while not HasModelLoaded(`k4_mansion2_shell`) do Wait(1000) end
	local house = CreateObject(`k4_mansion2_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateMansion3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.18, "y": -0.57, "z": 7.86, "h": 180.76}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4_mansion3_shell`)
	while not HasModelLoaded(`k4_mansion3_shell`) do Wait(1000) end
	local house = CreateObject(`k4_mansion3_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Empty Hotel Shells https://www.k4mb1maps.com/package/4811134

exports('CreateHotel1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.94, "y": 4.39, "z": 1.17, "h": 177.55}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4_hotel1_shell`)
	while not HasModelLoaded(`k4_hotel1_shell`) do Wait(1000) end
	local house = CreateObject(`k4_hotel1_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateHotel2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.99, "y": 4.39, "z": 1.17, "h": 178.62}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4_hotel2_shell`)
	while not HasModelLoaded(`k4_hotel2_shell`) do Wait(1000) end
	local house = CreateObject(`k4_hotel2_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateHotel3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.90, "y": 4.39, "z": 1.17, "h": 182.13}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4_hotel3_shell`)
	while not HasModelLoaded(`k4_hotel3_shell`) do Wait(1000) end
	local house = CreateObject(`k4_hotel3_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Empty Motel Shells https://www.k4mb1maps.com/package/4811137

exports('CreateMotel1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.46, "y": -2.46, "z": 1.00, "h": 274.07}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4_motel1_shell`)
	while not HasModelLoaded(`k4_motel1_shell`) do Wait(1000) end
	local house = CreateObject(`k4_motel1_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateMotel2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 0.06, "y": -3.75, "z": 1.05, "h": 359.40}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4_motel2_shell`)
	while not HasModelLoaded(`k4_motel2_shell`) do Wait(1000) end
	local house = CreateObject(`k4_motel2_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateMotel3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 3.13, "y": 3.50, "z": 1.16, "h": 182.53}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4_motel3_shell`)
	while not HasModelLoaded(`k4_motel3_shell`) do Wait(1000) end
	local house = CreateObject(`k4_motel3_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Default Shells V2 https://www.k4mb1maps.com/package/5015832

exports('CreateV2Default1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -2.32, "y": -0.63, "z": 1.60, "h": 272.87}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`default_housing1_k4mb1`)
	while not HasModelLoaded(`default_housing1_k4mb1`) do Wait(1000) end
	local house = CreateObject(`default_housing1_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Default2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -5.14, "y": -5.05, "z": 3.18, "h": 270.61}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`default_housing2_k4mb1`)
	while not HasModelLoaded(`default_housing2_k4mb1`) do Wait(1000) end
	local house = CreateObject(`default_housing2_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Default3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -1.35, "y": -2.06, "z": 1.11, "h": 1.14}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`default_housing3_k4mb1`)
	while not HasModelLoaded(`default_housing3_k4mb1`) do Wait(1000) end
	local house = CreateObject(`default_housing3_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Default4', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 0.13, "y": -3.85, "z": 1.09, "h": 1.71}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`default_housing4_k4mb1`)
	while not HasModelLoaded(`default_housing4_k4mb1`) do Wait(1000) end
	local house = CreateObject(`default_housing4_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Default5', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 1.42, "y": -14.34, "z": 1.14, "h": 0.87}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`default_housing5_k4mb1`)
	while not HasModelLoaded(`default_housing5_k4mb1`) do Wait(1000) end
	local house = CreateObject(`default_housing5_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Default6', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.75, "y": -6.49, "z": 1.03, "h": 359.60}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`default_housing6_k4mb1`)
	while not HasModelLoaded(`default_housing6_k4mb1`) do Wait(1000) end
	local house = CreateObject(`default_housing6_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Deluxe Shells V2 https://www.k4mb1maps.com/package/5043817

exports('CreateV2Deluxe1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -22.28, "y": -0.45, "z": 7.26, "h": 268.97}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`deluxe_housing1_k4mb1`)
	while not HasModelLoaded(`deluxe_housing1_k4mb1`) do Wait(1000) end
	local house = CreateObject(`deluxe_housing1_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Deluxe2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -10.30, "y": 0.87, "z": 6.55, "h": 274.91}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`deluxe_housing2_k4mb1`)
	while not HasModelLoaded(`deluxe_housing2_k4mb1`) do Wait(1000) end
	local house = CreateObject(`deluxe_housing2_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Deluxe3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -9.37, "y": 5.66, "z": 1.08, "h": 270.04}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`deluxe_housing3_k4mb1`)
	while not HasModelLoaded(`deluxe_housing3_k4mb1`) do Wait(1000) end
	local house = CreateObject(`deluxe_housing3_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Highend Shells V2 https://www.k4mb1maps.com/package/5043819

exports('CreateV2HighEnd1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -2.22, "y": 9.02, "z": 8.69, "h": 182.64}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`highend_housing1_k4mb1`)
	while not HasModelLoaded(`highend_housing1_k4mb1`) do Wait(1000) end
	local house = CreateObject(`highend_housing1_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2HighEnd2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -2.22, "y": 8.97, "z": 8.69, "h": 171.95}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`highend_housing2_k4mb1`)
	while not HasModelLoaded(`highend_housing2_k4mb1`) do Wait(1000) end
	local house = CreateObject(`highend_housing2_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2HighEnd3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 11.48, "y": 4.50, "z": 6.42, "h": 128.15}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`highend_housing3_k4mb1`)
	while not HasModelLoaded(`highend_housing3_k4mb1`) do Wait(1000) end
	local house = CreateObject(`highend_housing3_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Medium Shells V2 https://www.k4mb1maps.com/package/5043821

exports('CreateV2Medium1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.24, "y": -5.66, "z": 1.71, "h": 1.5}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`medium_housing1_k4mb1`)
	while not HasModelLoaded(`medium_housing1_k4mb1`) do Wait(1000) end
	local house = CreateObject(`medium_housing1_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Medium2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 6.04, "y": 0.34, "z": 1.03, "h": 357.99}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`medium_housing2_k4mb1`)
	while not HasModelLoaded(`medium_housing2_k4mb1`) do Wait(1000) end
	local house = CreateObject(`medium_housing2_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Medium3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 3.42, "y": 1.18, "z": 1.01, "h": 274.17}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`medium_housing3_k4mb1`)
	while not HasModelLoaded(`medium_housing3_k4mb1`) do Wait(1000) end
	local house = CreateObject(`medium_housing3_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Modern Shells V2 https://www.k4mb1maps.com/package/5043818

exports('CreateV2Modern1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.29, "y": 10.52, "z": 6.30, "h": 178.92}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`modern_housing1_k4mb1`)
	while not HasModelLoaded(`modern_housing1_k4mb1`) do Wait(1000) end
	local house = CreateObject(`modern_housing1_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Modern2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -1.76, "y": 10.37, "z": 6.30, "h": 184.71}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`modern_housing2_k4mb1`)
	while not HasModelLoaded(`modern_housing2_k4mb1`) do Wait(1000) end
	local house = CreateObject(`modern_housing2_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateV2Modern3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -3.39, "y": -1.45, "z": 5.65, "h": 90.77}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`modern_housing3_k4mb1`)
	while not HasModelLoaded(`modern_housing3_k4mb1`) do Wait(1000) end
	local house = CreateObject(`modern_housing3_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- K4mv1 Vinewood V2 Shells -- https://www.k4mb1maps.com/package/5251329

exports('VineWoodHouse1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 11.86, "y": -2.73, "z": 3.96, "h": 2.11}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`vinewood_housing1_k4mb1`)
	while not HasModelLoaded(`vinewood_housing1_k4mb1`) do Wait(1000) end
	local house = CreateObject(`vinewood_housing1_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)


exports('VineWoodHouse2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 1.57, "y": 4.96, "z": 9.63, "h": 2.11}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`vinewood_housing2_k4mb1`)
	while not HasModelLoaded(`vinewood_housing2_k4mb1`) do Wait(1000) end
	local house = CreateObject(`vinewood_housing2_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('VineWoodHouse3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 3.41, "y": 7.11, "z": 2.76, "h": 2.11}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`vinewood_housing3_k4mb1`)
	while not HasModelLoaded(`vinewood_housing3_k4mb1`) do Wait(1000) end
	local house = CreateObject(`vinewood_housing3_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-------- K4MB1 September Update

exports('CreateK4GunWarehouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 0.29, "y": 4.74, "z": -0.0, "h": 179.603271}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`gunworkshop_k4mb1`)
	while not HasModelLoaded(`gunworkshop_k4mb1`) do Wait(1000) end
	local house = CreateObject(`gunworkshop_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4LuxuryHouse1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -6.344482, "y": -1.034912, "z": 3.0, "h": 268.09}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`luxury_housing1_k4mb1`)
	while not HasModelLoaded(`luxury_housing1_k4mb1`) do Wait(1000) end
	local house = CreateObject(`luxury_housing1_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4LuxuryHouse2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -6.344482, "y": -1.034912, "z": 3.0, "h": 268.09}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`luxury_housing2_k4mb1`)
	while not HasModelLoaded(`luxury_housing2_k4mb1`) do Wait(1000) end
	local house = CreateObject(`luxury_housing2_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4LuxuryHouse3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -6.344482, "y": -1.034912, "z": 3.0, "h": 268.09}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`luxury_housing3_k4mb1`)
	while not HasModelLoaded(`luxury_housing3_k4mb1`) do Wait(1000) end
	local house = CreateObject(`luxury_housing3_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4LuxuryHouse4', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -6.344482, "y": -1.034912, "z": 3.0, "h": 268.09}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`luxury_housing4_k4mb1`)
	while not HasModelLoaded(`luxury_housing4_k4mb1`) do Wait(1000) end
	local house = CreateObject(`luxury_housing4_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4ManorHouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 6.839844, "y": -9.136841, "z": 13.0, "h": 359.318207}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`manor_housing1_k4mb1`)
	while not HasModelLoaded(`manor_housing1_k4mb1`) do Wait(1000) end
	local house = CreateObject(`manor_housing1_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Garage1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 0.000366, "y": 14.130432, "z": 1.827162, "h": 183.492355}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`new_garages1_k4mb1`)
	while not HasModelLoaded(`new_garages1_k4mb1`) do Wait(1000) end
	local house = CreateObject(`new_garages1_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Garage2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -3.737671, "y": -0.096680, "z": 1.427162, "h": 268.669922}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`new_garages2_k4mb1`)
	while not HasModelLoaded(`new_garages2_k4mb1`) do Wait(1000) end
	local house = CreateObject(`new_garages2_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Garage3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -3.737671, "y": -0.096680, "z": 1.427162, "h": 268.669922}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`new_garages3_k4mb1`)
	while not HasModelLoaded(`new_garages3_k4mb1`) do Wait(1000) end
	local house = CreateObject(`new_garages3_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Garage4', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 8.806641, "y": 1.580383, "z": 1.439952, "h": 93.087669}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`new_garages4_k4mb1`)
	while not HasModelLoaded(`new_garages4_k4mb1`) do Wait(1000) end
	local house = CreateObject(`new_garages4_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Safehouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -5.317017, "y": 1.031738, "z": 1.439952, "h": 269.149353}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`safehouse_k4mb1`)
	while not HasModelLoaded(`safehouse_k4mb1`) do Wait(1000) end
	local house = CreateObject(`safehouse_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Warehouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 13.414185, "y": -7.386108, "z": 2.539952, "h": 90.148018}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`warehouse_k4mb1`)
	while not HasModelLoaded(`warehouse_k4mb1`) do Wait(1000) end
	local house = CreateObject(`warehouse_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- New Garages https://www.k4mb1maps.com/package/5294668

exports('CreateK4NewGarage', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.010498, "y": 13.742065, "z": 5.216461, "h": 180.0}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`new_garages1_k4mb1`)
	while not HasModelLoaded(`new_garages1_k4mb1`) do Wait(1000) end
	local house = CreateObject(`new_garages1_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4NewGarage2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -3.885496, "y": 0.018372, "z": 0.119728, "h": 271.723022}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`new_garages2_k4mb1`)
	while not HasModelLoaded(`new_garages2_k4mb1`) do Wait(1000) end
	local house = CreateObject(`new_garages2_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4NewGarage3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -3.557486, "y": -0.223755, "z": 0.113129, "h": 269.100739}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`new_garages3_k4mb1`)
	while not HasModelLoaded(`new_garages3_k4mb1`) do Wait(1000) end
	local house = CreateObject(`new_garages3_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4NewGarage4', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 8.948175, "y": 1.714355, "z": 0.049950, "h": 95.899307}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`new_garages4_k4mb1`)
	while not HasModelLoaded(`new_garages4_k4mb1`) do Wait(1000) end
	local house = CreateObject(`new_garages4_k4mb1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Basement Shells

exports('CreateK4Basement', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -5.08, "y": -4.33, "z": 5.90, "h": 3.45}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_basement1_shell`)
	while not HasModelLoaded(`k4mb1_basement1_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_basement1_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Basement1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -5.08, "y": -4.33, "z": 5.90, "h": 3.45}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_basement2_shell`)
	while not HasModelLoaded(`k4mb1_basement2_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_basement2_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Basement2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -5.08, "y": -4.33, "z": 5.90, "h": 3.45}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_basement3_shell`)
	while not HasModelLoaded(`k4mb1_basement3_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_basement3_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Basement3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -5.08, "y": -4.33, "z": 5.90, "h": 3.45}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_basement4_shell`)
	while not HasModelLoaded(`k4mb1_basement4_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_basement4_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4Basement4', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -5.08, "y": -4.33, "z": 5.90, "h": 3.45}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_basement5_shell`)
	while not HasModelLoaded(`k4mb1_basement5_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_basement5_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Casino Hotel

exports('CreateK4CasinoHotel', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -3.03, "y": -0.03, "z": 0.10, "h": 266.89}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_casinohotel_shell`)
	while not HasModelLoaded(`k4mb1_casinohotel_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_casinohotel_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- New Houses

exports('CreateK4House1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -8.33, "y": 1.01, "z": 2.02, "h": 270.22}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_house1_shell`)
	while not HasModelLoaded(`k4mb1_house1_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_house1_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4House2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -8.33, "y": 1.01, "z": 2.02, "h": 270.22}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_house2_shell`)
	while not HasModelLoaded(`k4mb1_house2_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_house2_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4House3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 9.00, "y": -7.43, "z": 2.02, "h": 1.04}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_house3_shell`)
	while not HasModelLoaded(`k4mb1_house3_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_house3_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateK4House4', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -2.22, "y": -2.50, "z": 0.70, "h": 357.22}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_house4_shell`)
	while not HasModelLoaded(`k4mb1_house4_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_house4_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Furnished Offices

exports('CreateFurnishedOffice1', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 3.33, "y": -2.05, "z": 1.39, "h": 92.20}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_furnishedoffice1_shell`)
	while not HasModelLoaded(`k4mb1_furnishedoffice1_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_furnishedoffice1_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateFurnishedOffice2', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.42, "y": 3.54, "z": 1.36, "h": 179.63}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_furnishedoffice2_shell`)
	while not HasModelLoaded(`k4mb1_furnishedoffice2_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_furnishedoffice2_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateFurnishedOffice3', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.66, "y": 5.81, "z": 1.51, "h": 90.57}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_furnishedoffice3_shell`)
	while not HasModelLoaded(`k4mb1_furnishedoffice3_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_furnishedoffice3_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateFurnishedOffice4', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 8.60, "y": -2.28, "z": 1.56, "h": 91.17}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_furnishedoffice4_shell`)
	while not HasModelLoaded(`k4mb1_furnishedoffice4_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_furnishedoffice4_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

exports('CreateFurnishedOffice5', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 3.19, "y": -13.87, "z": 1.26, "h": 2.37}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_furnishedoffice5_shell`)
	while not HasModelLoaded(`k4mb1_furnishedoffice5_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_furnishedoffice5_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Hood House

exports('CreateHoodHouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -2.49, "y": -7.38, "z": 2.01, "h": 93.19}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_hoodhouse1_shell`)
	while not HasModelLoaded(`k4mb1_hoodhouse1_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_hoodhouse1_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Laundry Shell

exports('CreateLaundry', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 10.45, "y": -5.70, "z": 3.37, "h": 5.13}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_laundry_shell`)
	while not HasModelLoaded(`k4mb1_laundry_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_laundry_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Paleto House

exports('CreatePaletoHouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.92, "y": 5.65, "z": 3.34, "h": 90.05}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_palhouse1_shell`)
	while not HasModelLoaded(`k4mb1_palhouse1_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_palhouse1_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Sandy House

exports('CreateSandyHouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 1.65, "y": -4.60, "z": 3.19, "h": 2.53}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`k4mb1_sandyhouse1_shell`)
	while not HasModelLoaded(`k4mb1_sandyhouse1_shell`) do Wait(1000) end
	local house = CreateObject(`k4mb1_sandyhouse1_shell`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Empty House

exports('CreateEmptyHouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.42, "y": -2.35, "z": 1.91, "h": 271.88}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`kambi_emptyhouse1`)
	while not HasModelLoaded(`kambi_emptyhouse1`) do Wait(1000) end
	local house = CreateObject(`kambi_emptyhouse1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)

-- Furnished House

exports('CreateFurnishedHouse', function(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.47, "y": -2.38, "z": 1.90, "h": 274.87}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
	RequestModel(`kambi_furnishedhouse1`)
	while not HasModelLoaded(`kambi_furnishedhouse1`) do Wait(1000) end
	local house = CreateObject(`kambi_furnishedhouse1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end)