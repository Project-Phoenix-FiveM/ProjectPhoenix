local QBCore = exports['qb-core']:GetCoreObject()

local CraftingItems = {
    ["main"] = {
        ["items"] = {
            [1] = { name = "lockpick", amount = 50, type = "item", slot = 1, threshold = 0, points = 12,
                costs = {["metalscrap"] = 22, ["plastic"] = 32},
                info = {}
            },
            [2] = { name = "electronickit", amount = 50, type = "item", slot = 2, threshold = 0, points = 12,
                costs = {["metalscrap"] = 30, ["plastic"] = 45, ["aluminum"] = 28},
                info = {}
            },
            [3] = { name = "handcuffs", amount = 50, type = "item", slot = 3, threshold = 0, points = 12,
                costs = {["electronickit"] = 2, ["plastic"] = 52, ["steel"] = 40},
                info = {}
            },
            [4] = { name = "gatecrack", amount = 50, type = "item", slot = 4, threshold = 0, points = 12,
                costs = {["metalscrap"] = 10, ["plastic"] = 50, ["aluminum"] = 30, ["iron"] = 17, ["electronickit"] = 2},
                info = {}
            },
            [5] = { name = "handcuffs", amount = 50, type = "item", slot = 5, threshold = 0, points = 12,
                costs = {["metalscrap"] = 36, ["steel"] = 24, ["aluminum"] = 28},
                info = {}
            },
            [6] = { name = "repairkit", amount = 50, type = "item", slot = 6, threshold = 0, points = 12,
                costs = {["metalscrap"] = 32, ["steel"] = 43, ["copper"] = 61},
                info = {}
            },
            [7] = { name = "pistol_ammo", amount = 50, type = "item", slot = 7, threshold = 0, points = 12,
                costs = {["metalscrap"] = 50, ["steel"] = 37, ["copper"] = 26},
                info = {}
            },
            [8] = { name = "ironoxide", amount = 50, type = "item", slot = 8, threshold = 0, points = 12,
                costs = {["iron"] = 60, ["glass"] = 30},
                info = {}
            },
            [9] = { name = "aluminumoxide", amount = 50, type = "item", slot = 9, threshold = 0, points = 12,
                costs = {["iron"] = 33, ["steel"] = 44, ["plastic"] = 55, ["aluminum"] = 22},
                info = {}
            },
            [10] = { name = "armor", amount = 50, type = "item", slot = 10, threshold = 0, points = 12,
                costs = {["iron"] = 33, ["steel"] = 44, ["plastic"] = 55, ["aluminum"] = 22},
                info = {}
            },
            [11] = { name = "drill", amount = 50, type = "item", slot = 11, threshold = 0, points = 12,
                costs = {["iron"] = 50, ["steel"] = 50},
                info = {}
            }
        }
    },
    ["material"] = {
        ["items"] = {
            [1] = { name = "aluminum", amount = 9999, type = "item", slot = 1, threshold = 0, points = 0,
                costs = {["recyclablematerial"] = 1},
                info = {}
            },
            [2] = { name = "plastic", amount = 9999, type = "item", slot = 2, threshold = 0, points = 0,
                costs = {["recyclablematerial"] = 1},
                info = {}
            },
            [3] = { name = "copper", amount = 9999, type = "item", slot = 3, threshold = 0, points = 0,
                costs = {["recyclablematerial"] = 1},
                info = {}
            },
            [4] = { name = "rubber", amount = 9999, type = "item", slot = 4, threshold = 0, points = 0,
                costs = {["recyclablematerial"] = 1},
                info = {}
            },
            [5] = { name = "metalscrap", amount = 9999, type = "item", slot = 5, threshold = 0, points = 0,
                costs = {["recyclablematerial"] = 1},
                info = {}
            },
            [6] = { name = "steel", amount = 9999, type = "item", slot = 6, threshold = 0, points = 0,
                costs = {["recyclablematerial"] = 1},
                info = {}
            },
            [7] = { name = "glass", amount = 9999, type = "item", slot = 7, threshold = 0, points = 0,
                costs = {["recyclablematerial"] = 1},
                info = {}
            },
        }
    },
    ["attachments"] = {
        ["items"] = {
            [1] = { name = "pistol_extendedclip", amount = 9999, type = "item", slot = 1, threshold = 0, points = 1,
                costs = {["metalscrap"] = 140, ["steel"] = 250, ["rubber"] = 60},
                info = {}
            },
            [2] = { name = "pistol_suppressor", amount = 9999, type = "item", slot = 2, threshold = 10, points = 2,
                costs = {["metalscrap"] = 165, ["steel"] = 285, ["rubber"] = 75},
                info = {}
            },
            [3] = { name = "smg_extendedclip", amount = 9999, type = "item", slot = 3, threshold = 25, points = 3,
                costs = {["metalscrap"] = 190, ["steel"] = 305, ["rubber"] = 85},
                info = {}
            },
            [4] = { name = "microsmg_extendedclip", amount = 9999, type = "item", slot = 4, threshold = 50, points = 4,
                costs = {["metalscrap"] = 205, ["steel"] = 340, ["rubber"] = 110},
                info = {}
            },
            [5] = { name = "smg_drum", amount = 9999, type = "item", slot = 5, threshold = 75, points = 5,
                costs = {["metalscrap"] = 230, ["steel"] = 365, ["rubber"] = 130},
                info = {}
            },
            [6] = { name = "smg_scope", amount = 9999, type = "item", slot = 6, threshold = 100, points = 6,
                costs = {["metalscrap"] = 255, ["steel"] = 390, ["rubber"] = 145},
                info = {}
            },
            [7] = { name = "assaultrifle_extendedclip", amount = 9999, type = "item", slot = 7, threshold = 150, points = 7,
                costs = {["metalscrap"] = 270, ["steel"] = 435, ["rubber"] = 155, ["smg_extendedclip"] = 1},
                info = {}
            },
            [8] = { name = "assaultrifle_drum", amount = 9999, type = "item", slot = 8, threshold = 200, points = 8,
                costs = {["metalscrap"] = 300, ["steel"] = 469, ["rubber"] = 170, ["smg_extendedclip"] = 2},
                info = {}
            },
        }
    },
}

-- DO NOT TOUCH BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING --
-- DO NOT TOUCH BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING --
-- DO NOT TOUCH BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING --

--[[local function ItemsToItemInfo(craftingType)
	local items = {}
	for _, item in pairs(CraftingItems[craftingType]["items"]) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = "",
			label = itemInfo["label"],
			description = itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	CraftingItems[craftingType]["items"] = items
end]]--

local function ItemsToItemInfo()
	itemInfos = {
		[1] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 22x, " ..QBCore.Shared.Items["plastic"]["label"] .. ": 32x."},
		[2] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 30x, " ..QBCore.Shared.Items["plastic"]["label"] .. ": 42x."},
		[3] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 30x, " ..QBCore.Shared.Items["plastic"]["label"] .. ": 45x, "..QBCore.Shared.Items["aluminum"]["label"] .. ": 28x."},
		[4] = {costs = QBCore.Shared.Items["electronickit"]["label"] .. ": 2x, " ..QBCore.Shared.Items["plastic"]["label"] .. ": 52x, "..QBCore.Shared.Items["steel"]["label"] .. ": 40x."},
		[5] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 10x, " ..QBCore.Shared.Items["plastic"]["label"] .. ": 50x, "..QBCore.Shared.Items["aluminum"]["label"] .. ": 30x, "..QBCore.Shared.Items["iron"]["label"] .. ": 17x, "..QBCore.Shared.Items["electronickit"]["label"] .. ": 1x."},
		[6] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 36x, " ..QBCore.Shared.Items["steel"]["label"] .. ": 24x, "..QBCore.Shared.Items["aluminum"]["label"] .. ": 28x."},
		[7] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 32x, " ..QBCore.Shared.Items["steel"]["label"] .. ": 43x, "..QBCore.Shared.Items["plastic"]["label"] .. ": 61x."},
		[8] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 50x, " ..QBCore.Shared.Items["steel"]["label"] .. ": 37x, "..QBCore.Shared.Items["copper"]["label"] .. ": 26x."},
		[9] = {costs = QBCore.Shared.Items["iron"]["label"] .. ": 60x, " ..QBCore.Shared.Items["glass"]["label"] .. ": 30x."},
		[10] = {costs = QBCore.Shared.Items["aluminum"]["label"] .. ": 60x, " ..QBCore.Shared.Items["glass"]["label"] .. ": 30x."},
		[11] = {costs = QBCore.Shared.Items["iron"]["label"] .. ": 33x, " ..QBCore.Shared.Items["steel"]["label"] .. ": 44x, "..QBCore.Shared.Items["plastic"]["label"] .. ": 55x, "..QBCore.Shared.Items["aluminum"]["label"] .. ": 22x."},
		[12] = {costs = QBCore.Shared.Items["iron"]["label"] .. ": 50x, " ..QBCore.Shared.Items["steel"]["label"] .. ": 50x, "..QBCore.Shared.Items["screwdriverset"]["label"] .. ": 3x, "..QBCore.Shared.Items["advancedlockpick"]["label"] .. ": 2x."},
	}

	local items = {}
	for _, item in pairs(Config.CraftingItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = itemInfos[item.slot],
			label = itemInfo["label"],
			description = itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	Config.CraftingItems = items
    --CraftingItems[craftingType]["items"] = items
end

--[[local function GetThresholdItems(type, isAttachment)
	ItemsToItemInfo(type)
	local items = {}
	for k in pairs(CraftingItems[type]["items"]) do
        if isAttachment then
            if QBCore.Functions.GetPlayerData().metadata["attachmentcraftingrep"] >= CraftingItems[type]["items"][k].threshold then
                items[k] = CraftingItems[type]["items"]["items"][k]
            end
        else
            if QBCore.Functions.GetPlayerData().metadata["craftingrep"] >= CraftingItems[type]["items"][k].threshold then
                items[k] = CraftingItems[type]["items"][k]
            end
        end
	end
	return items
end]]--

local function SetupAttachmentItemsInfo()
	itemInfos = {
		[1] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 140x, " .. QBCore.Shared.Items["steel"]["label"] .. ": 250x, " .. QBCore.Shared.Items["rubber"]["label"] .. ": 60x"},
		[2] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 165x, " .. QBCore.Shared.Items["steel"]["label"] .. ": 285x, " .. QBCore.Shared.Items["rubber"]["label"] .. ": 75x"},
		[3] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 190x, " .. QBCore.Shared.Items["steel"]["label"] .. ": 305x, " .. QBCore.Shared.Items["rubber"]["label"] .. ": 85x, " .. QBCore.Shared.Items["smg_extendedclip"]["label"] .. ": 1x"},
		[4] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 205x, " .. QBCore.Shared.Items["steel"]["label"] .. ": 340x, " .. QBCore.Shared.Items["rubber"]["label"] .. ": 110x, " .. QBCore.Shared.Items["smg_extendedclip"]["label"] .. ": 2x"},
		[5] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 230x, " .. QBCore.Shared.Items["steel"]["label"] .. ": 365x, " .. QBCore.Shared.Items["rubber"]["label"] .. ": 130x"},
		[6] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 255x, " .. QBCore.Shared.Items["steel"]["label"] .. ": 390x, " .. QBCore.Shared.Items["rubber"]["label"] .. ": 145x"},
		[7] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 270x, " .. QBCore.Shared.Items["steel"]["label"] .. ": 435x, " .. QBCore.Shared.Items["rubber"]["label"] .. ": 155x"},
		[8] = {costs = QBCore.Shared.Items["metalscrap"]["label"] .. ": 300x, " .. QBCore.Shared.Items["steel"]["label"] .. ": 469x, " .. QBCore.Shared.Items["rubber"]["label"] .. ": 170x"},
	}

	local items = {}
	for _, item in pairs(Config.AttachmentCrafting["items"]) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = itemInfos[item.slot],
			label = itemInfo["label"],
			description = itemInfo["description"] or "",
			weight = itemInfo["weight"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	Config.AttachmentCrafting["items"] = items
    --CraftingItems[craftingType]["items"] = items
end

local function GetThresholdItems()
	ItemsToItemInfo()
	local items = {}
	for k in pairs(Config.CraftingItems) do
		if PlayerData.metadata["craftingrep"] >= Config.CraftingItems[k].threshold then
			items[k] = Config.CraftingItems[k]
		end
	end
	return items
end

local function GetAttachmentThresholdItems()
	SetupAttachmentItemsInfo()
	local items = {}
	for k in pairs(Config.AttachmentCrafting["items"]) do
		if PlayerData.metadata["attachmentcraftingrep"] >= Config.AttachmentCrafting["items"][k].threshold then
			items[k] = Config.AttachmentCrafting["items"][k]
		end
	end
	return items
end

RegisterNetEvent('inventory:client:CraftItems', function(itemName, itemCosts, amount, toSlot, points)
    local ped = PlayerPedId()
    SendNUIMessage({
        action = "close",
    })
    isCrafting = true
    QBCore.Functions.Progressbar("repair_vehicle", "Crafting...", (2000 * amount), false, true, {
	    disableMovement = true,
	    disableCarMovement = true,
	    disableMouse = false,
	    disableCombat = true,
	}, {
	    animDict = "mini@repair",
	    anim = "fixing_a_player",
	    flags = 16,
	}, {}, {}, function() -- Done
	    StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("inventory:server:CraftItems", itemName, itemCosts, amount, toSlot, points)
        isCrafting = false
	end, function() -- Cancel
	    StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
        isCrafting = false
	end)
end)

RegisterNetEvent('inventory:client:CraftAttachment', function(itemName, itemCosts, amount, toSlot, points)
    local ped = PlayerPedId()
    SendNUIMessage({
        action = "close",
    })
    isCrafting = true
    QBCore.Functions.Progressbar("repair_vehicle", "Crafting...", (2000 * amount), false, true, {
	    disableMovement = true,
	    disableCarMovement = true,
	    disableMouse = false,
	    disableCombat = true,
	}, {
	    animDict = "mini@repair",
	    anim = "fixing_a_player",
	    flags = 16,
	}, {}, {}, function() -- Done
	    StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("inventory:server:CraftAttachment", itemName, itemCosts, amount, toSlot, points)
        isCrafting = false
	end, function() -- Cancel
	    StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
        isCrafting = false
	end)
end)

--[[RegisterNetEvent('inventory:client:craftTarget',function(data)
    local crafting = {}
    crafting.label = "Crafting"
    crafting.items = GetThresholdItems()
    TriggerServerEvent("inventory:server:OpenInventory", "crafting", "crafting_"..math.random(1, 99), crafting)
end)]]--

RegisterNetEvent("inventory:client:Crafting", function(dropId)
    local crafting = {}
    crafting.label = "Crafting"
    crafting.items = GetThresholdItems()
    TriggerServerEvent("inventory:server:OpenInventory", "crafting", math.random(1, 99), crafting)
end)

RegisterNetEvent("inventory:client:WeaponAttachmentCrafting", function(dropId)
        local crafting = {}
        crafting.label = "Attachment Crafting"
        crafting.items = GetAttachmentThresholdItems()
        TriggerServerEvent("inventory:server:OpenInventory", "attachment_crafting", math.random(1, 99), crafting)
end)

--[[CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.CraftingObject, {
        options = {
            {
                event = "inventory:client:craftTarget",
                icon = "fas fa-tools",
                label = "Craft",
                isAttachment = false,
                name = "main"
            },
        },
        distance = 2.5,
    })
end)]]--

local toolBoxModels = {
    `prop_toolchest_05`,
    `prop_tool_bench02_ld`,
    `prop_tool_bench02`,
    `prop_toolchest_02`,
    `prop_toolchest_03`,
    `prop_toolchest_03_l2`,
    `prop_toolchest_05`,
    `prop_toolchest_04`,
}
exports['qb-target']:AddTargetModel(toolBoxModels, {
        options = {
            {
                event = "inventory:client:WeaponAttachmentCrafting",
                icon = "fas fa-wrench",
                label = "Weapon Attachment Crafting", 
                job = "voncrastenburg"
            },
            {
                event = "inventory:client:Crafting",
                icon = "fas fa-wrench",
                label = "Item Crafting", 
            },
        },
    distance = 1.0
})
