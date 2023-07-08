--#region Variables

local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local inInventory = false
local currentWeapon = nil
local currentOtherInventory = nil
local Drops = {}
local CurrentDrop = nil
local DropsNear = {}
local CurrentVehicle = nil
local CurrentGlovebox = nil
local CurrentStash = nil
local isHotbar = false
local WeaponAttachments = {}
local showBlur = true

isCrafting = false

RegisterNUICallback('showBlur', function()
    Wait(50)
    TriggerEvent("qb-inventory:client:showBlur")
end)

RegisterNetEvent("qb-inventory:client:showBlur", function()
    Wait(50)
    showBlur = not showBlur
    if not showBlur then
        TriggerScreenblurFadeOut(400)
    else
        TriggerScreenblurFadeIn(400)
    end
end)

--#endregion Variables

--#region Functions

---Checks if you have an item or not
---@param items string | string[] | table<string, number> The items to check, either a string, array of strings or a key-value table of a string and number with the string representing the name of the item and the number representing the amount
---@param amount? number The amount of the item to check for, this will only have effect when items is a string or an array of strings
---@return boolean success Returns true if the player has the item
local function HasItem(items, amount)
    local isTable = type(items) == 'table'
    local isArray = isTable and table.type(items) == 'array' or false
    local totalItems = #items
    local count = 0
    local kvIndex = 2
	if isTable and not isArray then
        totalItems = 0
        for _ in pairs(items) do totalItems += 1 end
        kvIndex = 1
    end
    for _, itemData in pairs(PlayerData.items) do
        if isTable then
            for k, v in pairs(items) do
                local itemKV = {k, v}
                if itemData and itemData.name == itemKV[kvIndex] and ((amount and itemData.amount >= amount) or (not isArray and itemData.amount >= v) or (not amount and isArray)) then
                    count += 1
                end
            end
            if count == totalItems then
                return true
            end
        else -- Single item as string
            if itemData and itemData.name == items and (not amount or (itemData and amount and itemData.amount >= amount)) then
                return true
            end
        end
    end
    return false
end

exports("HasItem", HasItem)

---Opens the vending machine shop
local function OpenFoodsVending()
    local ShopItems = {}
    ShopItems.label = "Vending Machine"
    ShopItems.items = Config.VendingFoods
    ShopItems.slots = #Config.VendingFoods
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Vendingshop_"..math.random(1, 99), ShopItems)
end

---Opens the vending machine shop
local function OpenDrinksVending()
    local ShopItems = {}
    ShopItems.label = "Vending Machine"
    ShopItems.items = Config.VendingDrinks
    ShopItems.slots = #Config.VendingDrinks
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Vendingshop_"..math.random(1, 99), ShopItems)
end

---Opens the vending machine shop
local function OpenCoffeeVending()
    local ShopItems = {}
    ShopItems.label = "Vending Machine"
    ShopItems.items = Config.VendingCoffee
    ShopItems.slots = #Config.VendingCoffee
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Vendingshop_"..math.random(1, 99), ShopItems)
end

---Draws 3d text in the world on the given position
---@param x number The x coord of the text to draw
---@param y number The y coord of the text to draw
---@param z number The z coord of the text to draw
---@param text string The text to display
local function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = string.len(text) / 370
    DrawRect(0.0, 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

---Load an animation dictionary before playing an animation from it
---@param dict string Animation dictionary to load
local function LoadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return end

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

---Returns a formatted attachments table from item data
---@param itemdata table Data of an item
---@return table attachments
local function FormatWeaponAttachments(itemdata)
    local attachments = {}
    itemdata.name = itemdata.name:upper()
    if itemdata.info.attachments ~= nil and next(itemdata.info.attachments) ~= nil then
        for _, v in pairs(itemdata.info.attachments) do
            attachments[#attachments+1] = {
                attachment = v.item,
                label = v.label,
                image = QBCore.Shared.Items[v.item].image,
                component = v.component
            }
        end
    end
    return attachments
end

---Checks if the vehicle's engine is at the back or not
---@param vehModel integer The model hash of the vehicle
---@return boolean isBackEngine
local function IsBackEngine(vehModel)
    return BackEngineVehicles[vehModel]
end

---Opens the trunk of the closest vehicle
local function OpenTrunk()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    LoadAnimDict("amb@prop_human_bum_bin@idle_b")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 4.0, 4.0, -1, 50, 0, false, false, false)
    if IsBackEngine(GetEntityModel(vehicle)) then
        SetVehicleDoorOpen(vehicle, 4, false, false)
    else
        SetVehicleDoorOpen(vehicle, 5, false, false)
    end
end

---Closes the trunk of the closest vehicle
local function CloseTrunk()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    LoadAnimDict("amb@prop_human_bum_bin@idle_b")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "exit", 4.0, 4.0, -1, 50, 0, false, false, false)
    if IsBackEngine(GetEntityModel(vehicle)) then
        SetVehicleDoorShut(vehicle, 4, false)
    else
        SetVehicleDoorShut(vehicle, 5, false)
    end
end

---Closes the inventory NUI
local function closeInventory()
    SendNUIMessage({
        action = "close",
    })
end

---Toggles the hotbar of the inventory
---@param toggle boolean If this is true, the hotbar will open
local function ToggleHotbar(toggle)
    local HotbarItems = {
        [1] = PlayerData.items[1],
        [2] = PlayerData.items[2],
        [3] = PlayerData.items[3],
        [4] = PlayerData.items[4],
    }

    SendNUIMessage({
        action = "toggleHotbar",
        open = toggle,
        items = HotbarItems
    })
end

---Plays the opening animation of the inventory
local function openAnim()
    local ped = PlayerPedId()
    LoadAnimDict('pickup_object')
    TaskPlayAnim(ped,'pickup_object', 'putdown_low', 5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
    SetTimeout(500, function()
        StopAnimTask(ped, 'pickup_object', 'putdown_low', 1.0)
    end)
end

---Removes drops in the area of the client
---@param index integer The drop id to remove
local function RemoveNearbyDrop(index)
    if not DropsNear[index] then return end

    local dropItem = DropsNear[index].object
    if DoesEntityExist(dropItem) then
        DeleteEntity(dropItem)
    end

    DropsNear[index] = nil

    if not Drops[index] then return end

    Drops[index].object = nil
    Drops[index].isDropShowing = nil
end

---Removes all drops in the area of the client
local function RemoveAllNearbyDrops()
    for k in pairs(DropsNear) do
        RemoveNearbyDrop(k)
    end
end

---Creates a new item drop object on the ground
---@param index integer The drop id to save the object in
local function CreateItemDrop(index)
    local dropItem = CreateObject(Config.ItemDropObject, DropsNear[index].coords.x, DropsNear[index].coords.y, DropsNear[index].coords.z, false, false, false)
    DropsNear[index].object = dropItem
    DropsNear[index].isDropShowing = true
    PlaceObjectOnGroundProperly(dropItem)
    FreezeEntityPosition(dropItem, true)
    exports['qb-target']:AddTargetEntity(dropItem, {
        options = {
            {
                icon = 'fas fa-backpack',
                label = "Open Bag",
                action = function()
                    TriggerServerEvent("inventory:server:OpenInventory", "drop", index)
                end,
            }
        },
        distance = 2.5,
    })
end

local function toggleItem(give, item, amount, info)
    return TriggerServerEvent("inventory:server:toggleItem", give, item, amount, info)
end

exports("toggleItem", toggleItem)

--[[ local TimeAllowed = 60 * 60 * 24 -- Maths for 1 day dont touch its very important and could break everything

local function ConvertQuality(inventory, other)
    local time = GetCloudTimeAsInt()
    for _, item in pairs(inventory) do
        if item.type ~= "weapon" then
            if item.created then
                local DecayRate = QBCore.Shared.Items[item.name:lower()]["decay"] ~= nil and QBCore.Shared.Items[item.name:lower()]["decay"] or 0.0
                local inventoryTable = {}
                for k, v in pairs(item.created) do
                    local TimeExtra = math.ceil((TimeAllowed * DecayRate))
                    local percentDone = 100 - math.ceil((((time - v) / TimeExtra) * 100))
                    if percentDone < 0 then percentDone = 0 end
                    inventoryTable[#inventoryTable+1] = percentDone
                end
                item.info.quality = inventoryTable
            end
        end
    end
    if other then
        for _, item in pairs(other.inventory) do
            if item.type ~= "weapon" then
                if item.created then
                    local DecayRate = QBCore.Shared.Items[item.name:lower()]["decay"] ~= nil and QBCore.Shared.Items[item.name:lower()]["decay"] or 0.0
                    local otherTable = {}
                    for k, v in pairs(item.created) do
                        local TimeExtra = math.ceil((TimeAllowed * DecayRate))
                        local percentDone = 100 - math.ceil((((time - v) / TimeExtra) * 100))
                        if percentDone < 0 then percentDone = 0 end
                        otherTable[#otherTable+1] = percentDone
                    end
                    item.info.quality = otherTable
                end
            end
        end
    end
    return inventory, other
end ]]
--#endregion Functions

--#region Events

RegisterNetEvent('Inventory:Client:OnPlayerLoaded', function()
    LocalPlayer.state:set("inv_busy", false, true)
    PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback("inventory:server:GetCurrentDrops", function(theDrops)
		Drops = theDrops
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    LocalPlayer.state:set("inv_busy", true, true)
    PlayerData = {}
    RemoveAllNearbyDrops()
end)

RegisterNetEvent('QBCore:Client:UpdateObject', function()
    QBCore = exports['qb-core']:GetCoreObject()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
    SendNUIMessage({
        action = 'UpdateCash',
        cash = PlayerData.money['cash']
    })
end)

AddEventHandler('onResourceStop', function(name)
    if name ~= GetCurrentResourceName() then return end
    if Config.UseItemDrop then RemoveAllNearbyDrops() end
end)

RegisterNetEvent("qb-inventory:client:closeinv", function()
    closeInventory()
end)

RegisterNetEvent('inventory:client:CheckOpenState', function(type, id, label)
    local name = QBCore.Shared.SplitStr(label, "-")[2]
    if type == "stash" then
        if name ~= CurrentStash or CurrentStash == nil then
            TriggerServerEvent('inventory:server:SetIsOpenState', false, type, id)
        end
    elseif type == "trunk" then
        if name ~= CurrentVehicle or CurrentVehicle == nil then
            TriggerServerEvent('inventory:server:SetIsOpenState', false, type, id)
        end
    elseif type == "glovebox" then
        if name ~= CurrentGlovebox or CurrentGlovebox == nil then
            TriggerServerEvent('inventory:server:SetIsOpenState', false, type, id)
        end
    elseif type == "drop" then
        if name ~= CurrentDrop or CurrentDrop == nil then
            TriggerServerEvent('inventory:server:SetIsOpenState', false, type, id)
        end
    end
end)

RegisterNetEvent('inventory:client:ItemBox', function(itemData, type, amount)
    amount = amount or 1
    SendNUIMessage({
        action = "itemBox",
        item = itemData,
        type = type,
        itemAmount = amount
    })
end)

RegisterNetEvent('inventory:client:requiredItems', function(items, bool)
    local itemTable = {}
    if bool then
        for k in pairs(items) do
            itemTable[#itemTable+1] = {
                item = items[k].name,
                label = QBCore.Shared.Items[items[k].name]["label"],
                image = items[k].image,
            }
        end
    end

    SendNUIMessage({
        action = "requiredItem",
        items = itemTable,
        toggle = bool
    })
end)

RegisterNetEvent('inventory:server:RobPlayer', function(TargetId)
    SendNUIMessage({
        action = "RobMoney",
        TargetId = TargetId,
    })
end)

RegisterNetEvent('qb-inventory:client:giveAnim', function()
    LoadAnimDict('mp_common')
	TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_b', 8.0, 1.0, -1, 16, 0, 0, 0, 0)
end)

RegisterNUICallback("GiveItem", function(data, cb)
    local player, distance = QBCore.Functions.GetClosestPlayer(GetEntityCoords(PlayerPedId()))
    if player ~= -1 and distance < 3 then
        if data.inventory == 'player' then
            local playerId = GetPlayerServerId(player)
            SetCurrentPedWeapon(PlayerPedId(),'WEAPON_UNARMED',true)
            TriggerServerEvent("inventory:server:GiveItem", playerId, data.item.name, data.amount, data.item.slot)
        else
            QBCore.Functions.Notify("You do not own this item!", "error")
        end
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
    cb('ok')
end)

RegisterNetEvent('inventory:client:OpenInventory', function(PlayerAmmo, inventory, other)
    if not IsEntityDead(PlayerPedId()) then
        ToggleHotbar(false)
        if showBlur == true then
            TriggerScreenblurFadeIn(400)
        end
        SetNuiFocus(true, true)
        if other then
            currentOtherInventory = other.name
        end
        SendNUIMessage({
            action = "open",
            inventory = inventory,
            slots = Config.MaxInventorySlots,
            other = other,
            maxweight = Config.MaxInventoryWeight,
            Ammo = PlayerAmmo,
            maxammo = Config.MaximumAmmoValues,
            cash = PlayerData.money['cash']
        })
        inInventory = true
    end
end)

RegisterNetEvent('inventory:client:UpdatePlayerInventory', function(isError)
    SendNUIMessage({
        action = "update",
        inventory = PlayerData.items,
        maxweight = Config.MaxInventoryWeight,
        slots = Config.MaxInventorySlots,
        error = isError,
    })
end)

RegisterNetEvent('inventory:client:PickupSnowballs', function()
    local ped = PlayerPedId()
    LoadAnimDict('anim@mp_snowball')
    TaskPlayAnim(ped, 'anim@mp_snowball', 'pickup_snowball', 3.0, 3.0, -1, 0, 1, 0, 0, 0)
    QBCore.Functions.Progressbar("pickupsnowball", "Collecting snowballs..", 1500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        StopAnimTask(ped, 'anim@mp_snowball', 'pickup_snowball', -1)
	    TriggerServerEvent('inventory:server:snowball', 'add')
        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["snowball"], "add")
    end, function() -- Cancel
        StopAnimTask(ped, 'anim@mp_snowball', 'pickup_snowball', -1)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

--not exports['qb-smallresources']:GetPropStatus()

local fucksake = false

RegisterNetEvent('inventory:client:UseWeapon', function(weaponData, shootbool)
    local ped = PlayerPedId()
    local weaponName = tostring(weaponData.name)
    local weaponHash = joaat(weaponData.name)
    local weaponinhand = GetCurrentPedWeapon(PlayerPedId())
    if not fucksake then
        if currentWeapon == weaponName and weaponinhand then
            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
            if QBCore.Functions.GetPlayerData().job.name == 'police' then
                Wait(1000)
            else
                Wait(1100)
            end
            RemoveAllPedWeapons(ped, true)
            TriggerEvent('weapons:client:SetCurrentWeapon', nil, shootbool)
            currentWeapon = nil
        elseif weaponName == "weapon_stickybomb" or weaponName == "weapon_pipebomb" or weaponName == "weapon_smokegrenade" or weaponName == "weapon_flare" or weaponName == "weapon_proxmine" or weaponName == "weapon_ball"  or weaponName == "weapon_molotov" or weaponName == "weapon_grenade" or weaponName == "weapon_bzgas" or weaponName == "weapon_book" or weaponName == "weapon_cash" or weaponName == "weapon_shoe" or weaponName == "weapon_brick" then
            GiveWeaponToPed(ped, weaponHash, 1, false, false)
            SetPedAmmo(ped, weaponHash, 1)
            SetCurrentPedWeapon(ped, weaponHash, true)
            TriggerEvent('weapons:client:SetCurrentWeapon', weaponData, shootbool)
            currentWeapon = weaponName
        elseif weaponName == "weapon_snowball" then
            GiveWeaponToPed(ped, weaponHash, 10, false, false)
            SetPedAmmo(ped, weaponHash, 10)
            SetCurrentPedWeapon(ped, weaponHash, true)
            TriggerServerEvent('inventory:server:snowball', 'remove')
            TriggerEvent('weapons:client:SetCurrentWeapon', weaponData, shootbool)
            currentWeapon = weaponName
        else
            TriggerEvent('weapons:client:SetCurrentWeapon', weaponData, shootbool)
            local ammo = tonumber(weaponData.info.ammo) or 0
            if weaponName == "weapon_petrolcan" or weaponName == "weapon_fireextinguisher" then
                ammo = 4000
            end

            GiveWeaponToPed(ped, weaponHash, ammo, false, false)
            SetPedAmmo(ped, weaponHash, ammo)
            SetCurrentPedWeapon(ped, weaponHash, true)

            if weaponData.info.attachments then
                for _, attachment in pairs(weaponData.info.attachments) do
                    GiveWeaponComponentToPed(ped, weaponHash, joaat(attachment.component))
                end
            end

            currentWeapon = weaponName
        end
    else
        QBCore.Functions.Notify("You can't use weapon while holding object", 'error')
    end
end)

RegisterNetEvent('inventory:client:CheckWeapon', function(weaponName)
    if currentWeapon ~= weaponName:lower() then return end
    local ped = PlayerPedId()
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    RemoveAllPedWeapons(ped, true)
    currentWeapon = nil
end)

-- This needs to be changed to do a raycast so items arent placed in walls
RegisterNetEvent('inventory:client:AddDropItem', function(dropId, player, coords)
    local forward = GetEntityForwardVector(GetPlayerPed(GetPlayerFromServerId(player)))
    local x, y, z = table.unpack(coords + forward * 0.5)
    Drops[dropId] = {
        id = dropId,
        coords = {
            x = x,
            y = y,
            z = z - 0.3,
        },
    }
end)

RegisterNetEvent('inventory:client:RemoveDropItem', function(dropId)
    Drops[dropId] = nil
    if Config.UseItemDrop then
        RemoveNearbyDrop(dropId)
    else
        DropsNear[dropId] = nil
    end
end)

RegisterNetEvent('inventory:client:DropItemAnim', function()
    local ped = PlayerPedId()
    SendNUIMessage({
        action = "close",
    })
    LoadAnimDict("pickup_object")
    TaskPlayAnim(ped, "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetTimeout(1700, function()
        StopAnimTask(ped, 'pickup_object', 'pickup_low', -1)
    end)
end)

RegisterNetEvent('inventory:client:SetCurrentStash', function(stash)
    CurrentStash = stash
end)

--#endregion Events

--#region Commands

RegisterCommand('closeinv', function()
    closeInventory()
end, false)

RegisterCommand('inventory', function()
    if not isCrafting and not inInventory then
        if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
            local ped = PlayerPedId()
            local curVeh = nil

            if IsPedInAnyVehicle(ped, false) then -- Is Player In Vehicle
                local vehicle = GetVehiclePedIsIn(ped, false)
                CurrentGlovebox = QBCore.Functions.GetPlate(vehicle)
                curVeh = vehicle
                CurrentVehicle = nil
            else
                local vehicle = QBCore.Functions.GetClosestVehicle()
                if vehicle ~= 0 and vehicle ~= nil then
                    local pos = GetEntityCoords(ped)
                    local minimum, maximum = GetModelDimensions(GetEntityModel(vehicle))
                    local ratio = math.abs(minimum.y/maximum.y)
                    local offset = minimum.y - (maximum.y + minimum.y)*ratio
                    local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, offset, 0)
                    if IsBackEngine(GetEntityModel(vehicle)) then
                        trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, math.abs(offset), 0)
                    end
                    if #(pos - trunkpos) < 1.5 and not IsPedInAnyVehicle(ped) then
                        if GetVehicleDoorLockStatus(vehicle) < 2 then
                            if GetVehicleEngineHealth(vehicle) <= 100.0 then
                                return QBCore.Functions.Notify("Vehicle is broken, can't open trunk", "error")
                            else
                                CurrentVehicle = QBCore.Functions.GetPlate(vehicle)
                                curVeh = vehicle
                                CurrentGlovebox = nil
                            end
                        else
                            QBCore.Functions.Notify("Vehicle Locked", "error")
                            return
                        end
                    else
                        CurrentVehicle = nil
                    end
                else 
                    CurrentVehicle = nil
                end
            end

            if CurrentVehicle then -- Trunk
                local vehicleClass = GetVehicleClass(curVeh)
                local maxweight
                local slots
                if vehicleClass == 0 then
                    maxweight = 300000
                    slots = 20
                elseif vehicleClass == 1 then
                    maxweight = 450000
                    slots = 25
                elseif vehicleClass == 2 then
                    maxweight = 650000
                    slots = 40
                elseif vehicleClass == 3 then
                    maxweight = 500000
                    slots = 25
                elseif vehicleClass == 4 then
                    maxweight = 450000
                    slots = 25
                elseif vehicleClass == 5 then
                    maxweight = 200000
                    slots = 20
                elseif vehicleClass == 6 then
                    maxweight = 200000
                    slots = 20
                elseif vehicleClass == 7 then
                    maxweight = 150000
                    slots = 15
                elseif vehicleClass == 8 then
                    maxweight = 0
                    slots = 0
                elseif vehicleClass == 9 then
                    maxweight = 1000000
                    slots = 50
                elseif vehicleClass == 10 then
                    maxweight = 1500000
                    slots = 50
                elseif vehicleClass == 12 then
                    maxweight = 750000
                    slots = 40
                elseif vehicleClass == 13 then
                    maxweight = 0
                    slots = 0
                elseif vehicleClass == 14 then
                    maxweight = 650000
                    slots = 40
                elseif vehicleClass == 15 then
                    maxweight = 120000
                    slots = 50
                elseif vehicleClass == 16 then
                    maxweight = 120000
                    slots = 50
                else
                    maxweight = 60000
                    slots = 35
                end
                local other = {
                    maxweight = maxweight,
                    slots = slots,
                }
                TriggerServerEvent("inventory:server:OpenInventory", "trunk", CurrentVehicle, other)
                OpenTrunk()
            elseif CurrentGlovebox then
                local vehicleClass = GetVehicleClass(curVeh)
                local maxweight
                local slots
                if vehicleClass == 0 then
                    maxweight = 50000
                    slots = 5
                elseif vehicleClass == 1 then
                    maxweight = 50000
                    slots = 5
                elseif vehicleClass == 2 then
                    maxweight = 60000
                    slots = 5
                elseif vehicleClass == 3 then
                    maxweight = 50000
                    slots = 5
                elseif vehicleClass == 4 then
                    maxweight = 50000
                    slots = 5
                elseif vehicleClass == 5 then
                    maxweight = 50000
                    slots = 5
                elseif vehicleClass == 6 then
                    maxweight = 50000
                    slots = 5
                elseif vehicleClass == 7 then
                    maxweight = 50000
                    slots = 5
                elseif vehicleClass == 8 then
                    maxweight = 30000
                    slots = 5
                elseif vehicleClass == 9 then
                    maxweight = 60000
                    slots = 5
                elseif vehicleClass == 10 then
                    maxweight = 60000
                    slots = 5
                elseif vehicleClass == 12 then
                    maxweight = 50000
                    slots = 5
                elseif vehicleClass == 13 then
                    maxweight = 0
                    slots = 0
                elseif vehicleClass == 14 then
                    maxweight = 50000
                    slots = 5
                elseif vehicleClass == 15 then
                    maxweight = 50000
                    slots = 5
                elseif vehicleClass == 16 then
                    maxweight = 50000
                    slots = 5
                else
                    maxweight = 50000
                    slots = 5
                end
                local other = {
                    maxweight = maxweight,
                    slots = slots,
                }
                TriggerServerEvent("inventory:server:OpenInventory", "glovebox", CurrentGlovebox, other)
            elseif CurrentDrop ~= 0 then
                TriggerServerEvent("inventory:server:OpenInventory", "drop", CurrentDrop)
            else
                openAnim()
                TriggerServerEvent("inventory:server:OpenInventory")
            end
        end
    end
end, false)

RegisterKeyMapping('inventory', 'Open Inventory', 'keyboard', 'TAB')

RegisterCommand('hotbar', function()
    isHotbar = not isHotbar
    if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
        ToggleHotbar(isHotbar)
    end
end, false)

RegisterKeyMapping('hotbar', 'Toggles keybind slots', 'keyboard', 'z')

for i = 1, 5 do
    RegisterCommand('slot' .. i,function()
        if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
            if i == 6 then
                i = Config.MaxInventorySlots
            end
            TriggerServerEvent("inventory:server:UseItemSlot", i)
        end
    end, false)
    RegisterKeyMapping('slot' .. i, 'Uses the item in slot ' .. i, 'keyboard', i)
end

--#endregion Commands

--#region NUI

RegisterNUICallback('RobMoney', function(data, cb)
    TriggerServerEvent("police:server:RobPlayer", data.TargetId)
    cb('ok')
end)

RegisterNUICallback('Notify', function(data, cb)
    QBCore.Functions.Notify(data.message, data.type)
    cb('ok')
end)

RegisterNUICallback('GetWeaponData', function(cData, cb)
    local data = {
        WeaponData = QBCore.Shared.Items[cData.weapon],
        AttachmentData = FormatWeaponAttachments(cData.ItemData)
    }
    cb(data)
end)

RegisterNUICallback('openJewelry', function(cData, cb)
    local Player = QBCore.Functions.GetPlayerData()
    closeInventory()
    Wait(100)
    openAnim()
    TriggerEvent("inventory:client:SetCurrentStash", "Jewelry_"..Player.citizenid)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Jewelry_"..Player.citizenid, {
    maxweight = 30000, slots = 5,})
    cb('ok')
end)

RegisterNUICallback('RemoveAttachment', function(data, cb)
    local ped = PlayerPedId()
    local WeaponData = QBCore.Shared.Items[data.WeaponData.name]
    data.AttachmentData.attachment = data.AttachmentData.attachment:gsub("(.*).*_",'')
    QBCore.Functions.TriggerCallback('weapons:server:RemoveAttachment', function(NewAttachments)
        if NewAttachments ~= false then
            local attachments = {}
            RemoveWeaponComponentFromPed(ped, joaat(data.WeaponData.name), joaat(data.AttachmentData.component))
            for _, v in pairs(NewAttachments) do
                attachments[#attachments+1] = {
                    attachment = v.item,
                    label = v.label,
                    image = QBCore.Shared.Items[v.item].image
                }
            end
            local DJATA = {
                Attachments = attachments,
                WeaponData = WeaponData,
            }
            cb(DJATA)
        else
            RemoveWeaponComponentFromPed(ped, joaat(data.WeaponData.name), joaat(data.AttachmentData.component))
            cb({})
        end
    end, data.AttachmentData, data.WeaponData)
end)

RegisterNUICallback('getCombineItem', function(data, cb)
    cb(QBCore.Shared.Items[data.item])
end)

RegisterNUICallback("CloseInventory", function(_, cb)
    if currentOtherInventory == "none-inv" then
        CurrentDrop = nil
        CurrentVehicle = nil
        CurrentGlovebox = nil
        CurrentStash = nil
        SetNuiFocus(false, false)
        inInventory = false
        TriggerScreenblurFadeOut(400)
        ClearPedTasks(PlayerPedId())
        return
    end
    if CurrentVehicle ~= nil then
        CloseTrunk()
        TriggerServerEvent("inventory:server:SaveInventory", "trunk", CurrentVehicle)
        CurrentVehicle = nil
    elseif CurrentGlovebox ~= nil then
        TriggerServerEvent("inventory:server:SaveInventory", "glovebox", CurrentGlovebox)
        CurrentGlovebox = nil
    elseif CurrentStash ~= nil then
        TriggerServerEvent("inventory:server:SaveInventory", "stash", CurrentStash)
        CurrentStash = nil
    else
        TriggerServerEvent("inventory:server:SaveInventory", "drop", CurrentDrop)
        CurrentDrop = nil
    end
    Wait(50)
    TriggerScreenblurFadeOut(1000)
    SetNuiFocus(false, false)
    inInventory = false
    cb('ok')
end)

RegisterNUICallback("UseItem", function(data, cb)
    TriggerServerEvent("inventory:server:UseItem", data.inventory, data.item)
    cb('ok')
end)

RegisterNUICallback("combineItem", function(data, cb)
    Wait(150)
    TriggerServerEvent('inventory:server:combineItem', data.reward, data.fromItem, data.toItem)
    cb('ok')
end)

RegisterNUICallback('combineWithAnim', function(data, cb)
    local ped = PlayerPedId()
    local combineData = data.combineData
    local aDict = combineData.anim.dict
    local aLib = combineData.anim.lib
    local animText = combineData.anim.text
    local animTimeout = combineData.anim.timeOut
    QBCore.Functions.Progressbar("combine_anim", animText, animTimeout, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = aDict,
        anim = aLib,
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, aDict, aLib, 1.0)
        TriggerServerEvent('inventory:server:combineItem', combineData.reward, data.requiredItem, data.usedItem)
    end, function() -- Cancel
        StopAnimTask(ped, aDict, aLib, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
    end)
    cb('ok')
end)

RegisterNUICallback("SetInventoryData", function(data, cb)
    TriggerServerEvent("inventory:server:SetInventoryData", data.fromInventory, data.toInventory, data.fromSlot, data.toSlot, data.fromAmount, data.toAmount)
    cb('ok')
end)

RegisterNUICallback("PlayDropSound", function(_, cb)
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
    cb('ok')
end)

RegisterNUICallback("PlayDropFail", function(_, cb)
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
    cb('ok')
end)

--#endregion NUI

--#region Threads

CreateThread(function()
    while true do
        local sleep = 100
        if DropsNear ~= nil then
			local ped = PlayerPedId()
			local closestDrop = nil
			local closestDistance = nil
            for k, v in pairs(DropsNear) do

                if DropsNear[k] ~= nil then
                    if Config.UseItemDrop then
                        if not v.isDropShowing then
                            CreateItemDrop(k)
                        end
                    else
                        sleep = 0
                        DrawMarker(2, v.coords.x, v.coords.y, v.coords.z - 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.1, 255, 255, 255, 155, false, false, false, false, false, false, false)
                    end

					local coords = (v.object ~= nil and GetEntityCoords(v.object)) or vector3(v.coords.x, v.coords.y, v.coords.z)
					local distance = #(GetEntityCoords(ped) - coords)
					if distance < 2 and (not closestDistance or distance < closestDistance) then
						closestDrop = k
						closestDistance = distance
					end
                end
            end


			if not closestDrop then
				CurrentDrop = 0
			else
				CurrentDrop = closestDrop
			end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        if Drops ~= nil and next(Drops) ~= nil then
            local pos = GetEntityCoords(PlayerPedId(), true)
            for k, v in pairs(Drops) do
                if Drops[k] ~= nil then
                    local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                    if dist < Config.MaxDropViewDistance then
                        DropsNear[k] = v
                    else
                        if Config.UseItemDrop and DropsNear[k] then
                            RemoveNearbyDrop(k)
                        else
                            DropsNear[k] = nil
                        end
                    end
                end
            end
        else
            DropsNear = {}
        end
        Wait(500)
    end
end)

--[[ CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.VendingFoodsObjects, {
        options = {
            {
                icon = "fas fa-candy-cane",
                label = "Buy Snacks",
                action = function()
                    OpenFoodsVending()
                end
            },
        },
        distance = 2.5
    })
end)

CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.VendingDrinksObjects, {
        options = {
            {
                icon = "fas fa-wine-bottle",
                label = "Buy Soda",
                action = function()
                    OpenDrinksVending()
                end
            },
        },
        distance = 2.5
    })
end)

CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.VendingCoffeeObjects, {
        options = {
            {
                icon = "fas fa-coffee",
                label = "Buy Coffee",
                action = function()
                    OpenCoffeeVending()
                end
            },
        },
        distance = 2.5
    })
end) ]]
--#endregion Threads
CreateThread(function() exports['qb-inventory']:LoadSuccess() end)