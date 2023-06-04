local banlength = nil
local developermode = false
local showCoords = false
local vehicleDevMode = false
local banreason = 'Unknown'
local kickreason = 'Unknown'
local menuLocation = 'topright' -- e.g. topright (default), topleft, bottomright, bottomleft

-- Main Menus
local menu1 = MenuV:CreateMenu(false, Lang:t("menu.admin_menu"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test1')
local menu2 = MenuV:CreateMenu(false, Lang:t("menu.admin_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test2')
local menu3 = MenuV:CreateMenu(false, Lang:t("menu.manage_server"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test3')
local menu4 = MenuV:CreateMenu(false, Lang:t("menu.online_players"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test4')
local menu5 = MenuV:CreateMenu(false, Lang:t("menu.vehicle_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test5')
local menu6 = MenuV:CreateMenu(false, Lang:t("menu.dealer_list"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test6')
local menu7 = MenuV:CreateMenu(false, Lang:t("menu.developer_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test7')

--Sub Menus
local menu8 = MenuV:CreateMenu(false, Lang:t("menu.weather_conditions"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test8')
local menu9 = MenuV:CreateMenu(false, Lang:t("menu.ban"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test9')
local menu10 = MenuV:CreateMenu(false, Lang:t("menu.kick"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test10')
local menu11 = MenuV:CreateMenu(false, Lang:t("menu.permissions"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test11')
local menu12 = MenuV:CreateMenu(false, Lang:t("menu.vehicle_categories"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test12')
local menu13 = MenuV:CreateMenu(false, Lang:t("menu.vehicle_models"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test13')
local menu14 = MenuV:CreateMenu(false, Lang:t("menu.entity_view_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test14')
local menu15 = MenuV:CreateMenu(false, Lang:t("menu.spawn_weapons"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test15')

RegisterNetEvent('qb-admin:client:openMenu', function()
    MenuV:OpenMenu(menu1)
end)

--[[
    Main menu buttons
--]]
-- Admin options
menu1:AddButton({
    icon = '😃',
    label = Lang:t("menu.admin_options"),
    value = menu2,
    description = Lang:t("desc.admin_options_desc")
})

--player management
local player_management = menu1:AddButton({
    icon = '🙍‍♂️',
    label = Lang:t("menu.player_management"),
    value = menu4,
    description = Lang:t("desc.player_management_desc")
})

--server management
menu1:AddButton({
    icon = '🎮',
    label = Lang:t("menu.server_management"),
    value = menu3,
    description = Lang:t("desc.server_management_desc")
})

--vehicle spawner
menu1:AddButton({
    icon = '🚗',
    label = Lang:t("menu.vehicles"),
    value = menu5,
    description = Lang:t("desc.vehicles_desc")
})

--dealer list
local menu1_dealer_list = menu1:AddButton({
    icon = '💊',
    label = Lang:t("menu.dealer_list"),
    value = menu6,
    description = Lang:t("desc.dealer_desc")
})

--developer options
menu1:AddButton({
    icon = '🔧',
    label = Lang:t("menu.developer_options"),
    value = menu7,
    description = Lang:t("desc.developer_desc")
})

--[[
    Sub Menus for the above main menu's
--]]

-- Admin Options Menu Buttons
local menu2_admin_noclip = menu2:AddCheckbox({
    icon = '🎥',
    label = Lang:t("menu.noclip"),
    value = nil,
    description = Lang:t("desc.noclip_desc")
})

local menu2_admin_revive = menu2:AddButton({
    icon = '🏥',
    label = Lang:t("menu.revive"),
    value = 'revive',
    description = Lang:t("desc.revive_desc")
})

local menu2_admin_invisible = menu2:AddCheckbox({
    icon = '👻',
    label = Lang:t("menu.invisible"),
    value = nil,
    description = Lang:t("desc.invisible_desc")
})

local menu2_admin_god_mode = menu2:AddCheckbox({
    icon = '⚡',
    label = Lang:t("menu.god"),
    value = nil,
    description = Lang:t("desc.god_desc")
})

local menu2_admin_display_names = menu2:AddCheckbox({
    icon = '📋',
    label = Lang:t("menu.names"),
    value = nil,
    description = Lang:t("desc.names_desc")
})

local menu2_admin_display_blips = menu2:AddCheckbox({
    icon = '📍',
    label = Lang:t("menu.blips"),
    value = nil,
    description = Lang:t("desc.blips_desc")
})

--give weapons
menu2:AddButton({
    icon = '🎁',
    label = Lang:t("menu.spawn_weapons"),
    value = menu15,
    description = Lang:t("desc.spawn_weapons_desc")
})

-- Server Options Menu Buttons
local menu3_server_weather = menu3:AddButton({
    icon = '🌡️',
    label = Lang:t("menu.weather_options"),
    value = menu8,
    description = Lang:t("desc.weather_desc")
})

local menu3_server_time = menu3:AddSlider({
    icon = '⏲️',
    label = Lang:t("menu.server_time"),
    value = GetClockHours(),
    values = {{
        label = '00',
        value = '00',
        description = Lang:t("menu.time")
    }, {
        label = '01',
        value = '01',
        description = Lang:t("menu.time")
    }, {
        label = '02',
        value = '02',
        description = Lang:t("menu.time")
    }, {
        label = '03',
        value = '03',
        description = Lang:t("menu.time")
    }, {
        label = '04',
        value = '04',
        description = Lang:t("menu.time")
    }, {
        label = '05',
        value = '05',
        description = Lang:t("menu.time")
    }, {
        label = '06',
        value = '06',
        description = Lang:t("menu.time")
    }, {
        label = '07',
        value = '07',
        description = Lang:t("menu.time")
    }, {
        label = '08',
        value = '08',
        description = Lang:t("menu.time")
    }, {
        label = '09',
        value = '09',
        description = Lang:t("menu.time")
    }, {
        label = '10',
        value = '10',
        description = Lang:t("menu.time")
    }, {
        label = '11',
        value = '11',
        description = Lang:t("menu.time")
    }, {
        label = '12',
        value = '12',
        description = Lang:t("menu.time")
    }, {
        label = '13',
        value = '13',
        description = Lang:t("menu.time")
    }, {
        label = '14',
        value = '14',
        description = Lang:t("menu.time")
    }, {
        label = '15',
        value = '15',
        description = Lang:t("menu.time")
    }, {
        label = '16',
        value = '16',
        description = Lang:t("menu.time")
    }, {
        label = '17',
        value = '17',
        description = Lang:t("menu.time")
    }, {
        label = '18',
        value = '18',
        description = Lang:t("menu.time")
    }, {
        label = '19',
        value = '19',
        description = Lang:t("menu.time")
    }, {
        label = '20',
        value = '20',
        description = Lang:t("menu.time")
    }, {
        label = '21',
        value = '21',
        description = Lang:t("menu.time")
    }, {
        label = '22',
        value = '22',
        description = Lang:t("menu.time")
    }, {
        label = '23',
        value = '23',
        description = Lang:t("menu.time")
    }}
})

-- Vehicle Spawner Menu Buttons
local menu5_vehicles_spawn = menu5:AddButton({
    icon = '🚗',
    label = Lang:t("menu.spawn_vehicle"),
    value = menu12,
    description = Lang:t("desc.spawn_vehicle_desc")
})

local menu5_vehicles_fix = menu5:AddButton({
    icon = '🔧',
    label = Lang:t("menu.fix_vehicle"),
    value = 'fix',
    description = Lang:t("desc.fix_vehicle_desc")
})

local menu5_vehicles_buy = menu5:AddButton({
    icon = '💲',
    label = Lang:t("menu.buy"),
    value = 'buy',
    description = Lang:t("desc.buy_desc")
})

local menu5_vehicles_remove = menu5:AddButton({
    icon = '🗑️',
    label = Lang:t("menu.remove_vehicle"),
    value = 'remove',
    description = Lang:t("desc.remove_vehicle_desc")
})

local menu5_vehicles_max_upgrades = menu5:AddButton({
    icon = '⚡️',
    label = Lang:t("menu.max_mods"),
    value = 'maxmods',
    description = Lang:t("desc.max_mod_desc")
})

-- Developer Options Menu Buttons
local menu7_dev_copy_vec3 = menu7:AddButton({
    icon = '📋',
    label = Lang:t("menu.copy_vector3"),
    value = 'coords',
    description = Lang:t("desc.vector3_desc")
})

local menu7_dev_copy_vec4 = menu7:AddButton({
    icon = '📋',
    label = Lang:t("menu.copy_vector4"),
    value = 'coords',
    description = Lang:t("desc.vector4_desc")
})

local menu7_dev_copy_heading = menu7:AddButton({
    icon = '📋',
    label = Lang:t("menu.copy_heading"),
    value = 'heading',
    description = Lang:t("desc.copy_heading_desc")
})

local menu7_dev_toggle_coords = menu7:AddCheckbox({
    icon = '📍',
    label = Lang:t("menu.display_coords"),
    value = nil,
    description = Lang:t("desc.display_coords_desc")
})

local menu7_dev_vehicle_mode = menu7:AddCheckbox({
    icon = '🚘',
    label = Lang:t("menu.vehicle_dev_mode"),
    value = nil,
    description = Lang:t("desc.vehicle_dev_mode_desc")
})

local menu7_dev_info_mode = menu7:AddCheckbox({
    icon = '⚫',
    label = Lang:t("menu.hud_dev_mode"),
    value = nil,
    description = Lang:t("desc.hud_dev_mode_desc")
})

local menu7_dev_noclip = menu7:AddCheckbox({
    icon = '🎥',
    label = Lang:t("menu.noclip"),
    value = nil,
    description = Lang:t("desc.noclip_desc")
})

--create dev entity view
menu7:AddButton({
    icon = '🔍',
    label = Lang:t("menu.entity_view_options"),
    value = menu14,
    description = Lang:t("desc.entity_view_desc")
})

--[[
    QB Core Admin Menu button functions below.
--]]

--[[
    General Functions
--]]
local function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0)
    Wait(0)
    end

    if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
        return result
    end
end

local function LocalInputInt(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return tonumber(result)
    end
end

--[[
    Admin Options functions
--]]
-- Toggle player name display
menu2_admin_display_names:On('change', function()
    TriggerEvent('qb-admin:client:toggleNames')
end)

-- Toggle player blip display
menu2_admin_display_blips:On('change', function()
    TriggerEvent('qb-admin:client:toggleBlips')
end)

-- Toggle NoClip
menu2_admin_noclip:On('change', function(_, _, _)
    ToggleNoClip()
end)

-- Revive Self
menu2_admin_revive:On('select', function(_)
    TriggerEvent('hospital:client:Revive', PlayerPedId())
end)

-- Invisible
local invisible = false
menu2_admin_invisible:On('change', function(_, _, _)
    if not invisible then
        invisible = true
        SetEntityVisible(PlayerPedId(), false, 0)
    else
        invisible = false
        SetEntityVisible(PlayerPedId(), true, 0)
    end
end)

-- Godmode
local godmode = false
menu2_admin_god_mode:On('change', function(_, _, _)
    godmode = not godmode

    if godmode then
        while godmode do
            Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end)

-- Weapons list
for _,v in pairs(QBCore.Shared.Weapons) do
    menu15:AddButton({icon = '🎁',
        label = v.label ,
        value = v.value ,
        description = Lang:t("desc.spawn_weapons_desc"),
        select = function(_)
            TriggerServerEvent('qb-admin:giveWeapon', v.name)
            QBCore.Functions.Notify(Lang:t("success.spawn_weapon"))
        end
    })
end


--[[
    Player Management Options functions
--]]
-- Player List
local function OpenPermsMenu(permsply)
    QBCore.Functions.TriggerCallback('qb-admin:server:getrank', function(rank)
        if rank then
            local selectedgroup = 'Unknown'
            MenuV:OpenMenu(menu11)
            menu11:ClearItems()
            menu11:AddSlider({
                icon = '',
                label = 'Group',
                value = 'user',
                values = {{
                    label = 'User',
                    value = 'user',
                    description = 'Group'
                }, {
                    label = 'Admin',
                    value = 'admin',
                    description = 'Group'
                }, {
                    label = 'God',
                    value = 'god',
                    description = 'Group'
                }},
                change = function(_, newValue, _)
                    local vcal = newValue
                    if vcal == 1 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "user", label = "User"}
                    elseif vcal == 2 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "admin", label = "Admin"}
                    elseif vcal == 3 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "god", label = "God"}
                    end
                end
            })

            menu11:AddButton({
                icon = '',
                label = Lang:t("info.confirm"),
                value = "giveperms",
                description = 'Give the permission group',
                select = function(_)
                    if selectedgroup ~= 'Unknown' then
                        TriggerServerEvent('qb-admin:server:setPermissions', permsply.id, selectedgroup)
                        QBCore.Functions.Notify(Lang:t("success.changed_perm"), 'success')
                        selectedgroup = 'Unknown'
                    else
                        QBCore.Functions.Notify(Lang:t("error.changed_perm_failed"), 'error')
                    end
                end
            })
        else
            MenuV:CloseMenu(menu1)
        end
    end)
end

local function OpenKickMenu(kickplayer)
    MenuV:OpenMenu(menu10)
    menu10:ClearItems()
    menu10:AddButton({
        icon = '',
        label = Lang:t("info.reason"),
        value = "reason",
        description = Lang:t("desc.kick_reason"),
        select = function(_)
            kickreason = LocalInput(Lang:t("desc.kick_reason"), 255)
        end
    })

    menu10:AddButton({
        icon = '',
        label = Lang:t("info.confirm"),
        value = "kick",
        description = Lang:t("desc.confirm_kick"),
        select = function(_)
            if kickreason ~= 'Unknown' then
                TriggerServerEvent('qb-admin:server:kick', kickplayer, kickreason)
                kickreason = 'Unknown'
            else
                QBCore.Functions.Notify(Lang:t("error.missing_reason"), 'error')
            end
        end
    })
end

local function OpenBanMenu(banplayer)
    MenuV:OpenMenu(menu9)
    menu9:ClearItems()
    menu9:AddButton({
        icon = '',
        label = Lang:t("info.reason"),
        value = "reason",
        description = Lang:t("desc.ban_reason"),
        select = function(_)
            banreason = LocalInput(Lang:t("desc.ban_reason"), 255)
        end
    })

    menu9:AddSlider({
        icon = '⏲️',
        label = Lang:t("info.length"),
        value = '3600',
        values = {{
            label = Lang:t("time.1hour"),
            value = '3600',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.6hour"),
            value ='21600',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.12hour"),
            value = '43200',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1day"),
            value = '86400',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.3day"),
            value = '259200',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1week"),
            value = '604800',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1month"),
            value = '2678400',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.3month"),
            value = '8035200',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.6month"),
            value = '16070400',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1year"),
            value = '32140800',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.permenent"),
            value = '99999999999',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.self"),
            value = "self",
            description = Lang:t("time.ban_length")
        }},
        select = function(_, newValue, _)
            if newValue == "self" then
                banlength = LocalInputInt('Ban Length', 11)
            else
                banlength = newValue
            end
        end
    })

    menu9:AddButton({
        icon = '',
        label = Lang:t("info.confirm"),
        value = "ban",
        description = Lang:t("desc.confirm_ban"),
        select = function(_)
            if banreason ~= 'Unknown' and banlength ~= nil then
                TriggerServerEvent('qb-admin:server:ban', banplayer, banlength, banreason)
                banreason = 'Unknown'
                banlength = nil
            else
                QBCore.Functions.Notify(Lang:t("error.invalid_reason_length_ban"), 'error')
            end
        end
    })
end

local function OpenPlayerMenus(player)
    local Players = MenuV:CreateMenu(false, player.cid .. Lang:t("info.options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv') -- Players Sub Menu
    Players:ClearItems()
    MenuV:OpenMenu(Players)
    local elements = {
        [1] = {
            icon = '💀',
            label = Lang:t("menu.kill"),
            value = "kill",
            description = Lang:t("menu.kill").. " " .. player.cid
        },
        [2] = {
            icon = '🏥',
            label = Lang:t("menu.revive"),
            value = "revive",
            description = Lang:t("menu.revive") .. " " .. player.cid
        },
        [3] = {
            icon = '🥶',
            label = Lang:t("menu.freeze"),
            value = "freeze",
            description = Lang:t("menu.freeze") .. " " .. player.cid
        },
        [4] = {
            icon = '👀',
            label = Lang:t("menu.spectate"),
            value = "spectate",
            description = Lang:t("menu.spectate") .. " " .. player.cid
        },
        [5] = {
            icon = '➡️',
            label = Lang:t("info.goto"),
            value = "goto",
            description = Lang:t("info.goto") .. " " .. player.cid .. Lang:t("info.position")
        },
        [6] = {
            icon = '⬅️',
            label = Lang:t("menu.bring"),
            value = "bring",
            description = Lang:t("menu.bring") .. " " .. player.cid .. " " .. Lang:t("info.your_position")
        },
        [7] = {
            icon = '🚗',
            label = Lang:t("menu.sit_in_vehicle"),
            value = "intovehicle",
            description = Lang:t("desc.sit_in_veh_desc") .. " " .. player.cid .. " " .. Lang:t("desc.sit_in_veh_desc2")
        },
        [8] = {
            icon = '🎒',
            label = Lang:t("menu.open_inv"),
            value = "inventory",
            description = Lang:t("info.open") .. " " .. player.cid .. Lang:t("info.inventories")
        },
        [9] = {
            icon = '👕',
            label = Lang:t("menu.give_clothing_menu"),
            value = "cloth",
            description = Lang:t("desc.clothing_menu_desc") .. " " .. player.cid
        },
        [10] = {
            icon = '🥾',
            label = Lang:t("menu.kick"),
            value = "kick",
            description = Lang:t("menu.kick") .. " " .. player.cid .. " " .. Lang:t("info.reason")
        },
        [11] = {
            icon = '🚫',
            label = Lang:t("menu.ban"),
            value = "ban",
            description = Lang:t("menu.ban") .. " " .. player.cid .. " " .. Lang:t("info.reason")
        },
        [12] = {
            icon = '🎟️',
            label = Lang:t("menu.permissions"),
            value = "perms",
            description = Lang:t("info.give") .. " " .. player.cid .. " " .. Lang:t("menu.permissions")
        }
    }
    for _, v in ipairs(elements) do
        Players:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values ~= "ban" and values ~= "kick" and values ~= "perms" then
                    TriggerServerEvent('qb-admin:server:'..values, player)
                elseif values == "ban" then
                    OpenBanMenu(player)
                elseif values == "kick" then
                    OpenKickMenu(player)
                elseif values == "perms" then
                    OpenPermsMenu(player)
                end
            end
        })
    end
end

player_management:On('select', function(_)
    menu4:ClearItems()
    QBCore.Functions.TriggerCallback('test:getplayers', function(players)
        for _, v in pairs(players) do
            menu4:AddButton({
                label = Lang:t("info.id") .. v["id"] .. ' | ' .. v["name"],
                value = v,
                description = Lang:t("info.player_name"),
                select = function(btn)
                    local select = btn.Value -- get all the values from v!
                    OpenPlayerMenus(select) -- only pass what i select nothing else
                end
            }) -- WORKS
        end
    end)
end)


--[[
    Server Options functions
--]]

-- Adjust weather on change
menu3_server_weather:On("select",function()
    menu8:ClearItems()
    local elements = {
        [1] = {
            icon = '☀️',
            label = Lang:t("weather.extra_sunny"),
            value = "EXTRASUNNY",
            description = Lang:t("weather.extra_sunny_desc")
        },
        [2] = {
            icon = '☀️',
            label = Lang:t("weather.clear"),
            value = "CLEAR",
            description = Lang:t("weather.clear_desc")
        },
        [3] = {
            icon = '☀️',
            label = Lang:t("weather.neutral"),
            value = "NEUTRAL",
            description = Lang:t("weather.neutral_desc")
        },
        [4] = {
            icon = '🌁',
            label = Lang:t("weather.smog"),
            value = "SMOG",
            description = Lang:t("weather.smog_desc")
        },
        [5] = {
            icon = '🌫️',
            label = Lang:t("weather.foggy"),
            value = "FOGGY",
            description = Lang:t("weather.foggy_desc")
        },
        [6] = {
            icon = '⛅',
            label = Lang:t("weather.overcast"),
            value = "OVERCAST",
            description = Lang:t("weather.overcast_desc")
        },
        [7] = {
            icon = '☁️',
            label = Lang:t("weather.clouds"),
            value = "CLOUDS",
            description = Lang:t("weather.clouds_desc")
        },
        [8] = {
            icon = '🌤️',
            label = Lang:t("weather.clearing"),
            value = "CLEARING",
            description = Lang:t("weather.clearing_desc")
        },
        [9] = {
            icon = '☂️',
            label = Lang:t("weather.rain"),
            value = "RAIN",
            description = Lang:t("weather.rain_desc")
        },

        [10] = {
            icon = '⛈️',
            label = Lang:t("weather.thunder"),
            value = "THUNDER",
            description = Lang:t("weather.thunder_desc")
        },
        [11] = {
            icon = '❄️',
            label = Lang:t("weather.snow"),
            value = "SNOW",
            description = Lang:t("weather.snow_desc")
        },
        [12] = {
            icon = '🌨️',
            label = Lang:t("weather.blizzard"),
            value = "BLIZZARD",
            description = Lang:t("weather.blizzed_desc")
        },
        [13] = {
            icon = '❄️',
            label = Lang:t("weather.light_snow"),
            value = "SNOWLIGHT",
            description = Lang:t("weather.light_snow_desc")
        },
        [14] = {
            icon = '🌨️',
            label = Lang:t("weather.heavy_snow"),
            value = "XMAS",
            description = Lang:t("weather.heavy_snow_desc")
        },
        [15] = {
            icon = '🎃',
            label = Lang:t("weather.halloween"),
            value = "HALLOWEEN",
            description = Lang:t("weather.halloween_desc")
        }
    }
    for _, v in ipairs(elements) do
        menu8:AddButton({icon = v.icon,label = v.label,value = v,description = v.description,select = function(btn)
            local selection = btn.Value
            TriggerServerEvent('qb-weathersync:server:setWeather', selection.value)
            QBCore.Functions.Notify(Lang:t("weather.weather_changed", {value = selection.label}))
        end})
    end
end)

-- Adjust time on change
menu3_server_time:On("select", function(_, value)
    TriggerServerEvent("qb-weathersync:server:setTime", value, value)
    QBCore.Functions.Notify(Lang:t("time.changed", {time = value}))
end)

--[[
    Vehicle Spawner functions
--]]

-- Set vehicle Categories
local vehicles = {}
for k, v in pairs(QBCore.Shared.Vehicles) do
    local category = v["category"]
    if vehicles[category] == nil then
        vehicles[category] = { }
    end
    vehicles[category][k] = v
end

-- Car Categories
local function OpenCarModelsMenu(category)
    menu13:ClearItems()
    MenuV:OpenMenu(menu13)
    for k, v in pairs(category) do
        menu13:AddButton({
            label = v["name"],
            value = k,
            description = 'Spawn ' .. v["name"],
            select = function(_)
                TriggerServerEvent('QBCore:CallCommand', "car", { k })
            end
        })
    end
end

menu5_vehicles_spawn:On('Select', function(_)
    menu12:ClearItems()
    for k, v in pairs(vehicles) do
        menu12:AddButton({
            label = QBCore.Shared.FirstToUpper(k),
            value = v,
            description = Lang:t("menu.category_name"),
            select = function(btn)
                local select = btn.Value
                OpenCarModelsMenu(select)
            end
        })
    end
end)

menu5_vehicles_fix:On('Select', function(_)
    TriggerServerEvent('QBCore:CallCommand', "fix", {})
end)

menu5_vehicles_buy:On('Select', function(_)
    TriggerServerEvent('QBCore:CallCommand', "admincar", {})
end)

menu5_vehicles_remove:On('Select', function(_)
    TriggerServerEvent('QBCore:CallCommand', "dv", {})
end)

menu5_vehicles_max_upgrades:On('Select', function(_)
    TriggerServerEvent('QBCore:CallCommand', "maxmods", {})
end)

--[[
    Developer Options functions
--]]
local entity_view_distance = menu14:AddSlider({
    icon = '📏',
    label = Lang:t("menu.entity_view_distance"),
    value = GetCurrentEntityViewDistance(),
    values = {{
        label = '5',
        value = '5',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '10',
        value = '10',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '15',
        value = '15',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '20',
        value = '20',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '25',
        value = '25',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '30',
        value = '30',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '35',
        value = '35',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '40',
        value = '40',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '45',
        value = '45',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '50',
        value = '50',
        description = Lang:t("menu.entity_view_distance")
    }}
})

local entity_view_copy_info = menu14:AddButton({
    icon = '📋',
    label = Lang:t("menu.entity_view_freeaim_copy"),
    value = 'freeaimEntity',
    description = Lang:t("desc.entity_view_freeaim_copy_desc")
})

local entity_view_freeaim = menu14:AddCheckbox({
    icon = '🔫',
    label = Lang:t("menu.entity_view_freeaim"),
    value = nil,
    description = Lang:t("desc.entity_view_freeaim_desc")
})

local entity_view_vehicle = menu14:AddCheckbox({
    icon = '🚗',
    label = Lang:t("menu.entity_view_vehicles"),
    value = nil,
    description = Lang:t("desc.entity_view_vehicles_desc")
})

local entity_view_ped = menu14:AddCheckbox({
    icon = '🧍‍♂‍',
    label = Lang:t("menu.entity_view_peds"),
    value = nil,
    description = Lang:t("desc.entity_view_peds_desc")
})

local entity_view_object = menu14:AddCheckbox({
    icon = '📦',
    label = Lang:t("menu.entity_view_objects"),
    value = nil,
    description = Lang:t("desc.entity_view_objects_desc")
})

menu7_dev_info_mode:On('change', function(_, _, _)
    developermode = not developermode
    TriggerEvent('qb-admin:client:ToggleDevmode')
    if developermode then
	SetPlayerInvincible(PlayerId(), true)
    else
	SetPlayerInvincible(PlayerId(), false)
    end
end)

entity_view_freeaim:On('change', function(_, _, _)
    ToggleEntityFreeView()
end)

local function CopyToClipboard(dataType)
    local ped = PlayerPedId()
    if dataType == 'coords2' then
        local coords = GetEntityCoords(ped)
        local x = QBCore.Shared.Round(coords.x, 2)
        local y = QBCore.Shared.Round(coords.y, 2)
        SendNUIMessage({
            string = string.format('vector2(%s, %s)', x, y)
        })
        QBCore.Functions.Notify(Lang:t("success.coords_copied"), "success")
    elseif dataType == 'coords3' then
        local coords = GetEntityCoords(ped)
        local x = QBCore.Shared.Round(coords.x, 2)
        local y = QBCore.Shared.Round(coords.y, 2)
        local z = QBCore.Shared.Round(coords.z, 2)
        SendNUIMessage({
            string = string.format('vector3(%s, %s, %s)', x, y, z)
        })
        QBCore.Functions.Notify(Lang:t("success.coords_copied"), "success")
    elseif dataType == 'coords4' then
        local coords = GetEntityCoords(ped)
        local x = QBCore.Shared.Round(coords.x, 2)
        local y = QBCore.Shared.Round(coords.y, 2)
        local z = QBCore.Shared.Round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = QBCore.Shared.Round(heading, 2)
        SendNUIMessage({
            string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
        })
        QBCore.Functions.Notify(Lang:t("success.coords_copied"), "success")
    elseif dataType == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = QBCore.Shared.Round(heading, 2)
        SendNUIMessage({
            string = h
        })
        QBCore.Functions.Notify(Lang:t("success.heading_copied"), "success")
    elseif dataType == 'freeaimEntity' then
        local entity = GetFreeAimEntity()

        if entity then
            local entityHash = GetEntityModel(entity)
            local entityName = Entities[entityHash] or "Unknown"
            local entityCoords = GetEntityCoords(entity)
            local entityHeading = GetEntityHeading(entity)
            local entityRotation = GetEntityRotation(entity)
            local x = QBCore.Shared.Round(entityCoords.x, 2)
            local y = QBCore.Shared.Round(entityCoords.y, 2)
            local z = QBCore.Shared.Round(entityCoords.z, 2)
            local rotX = QBCore.Shared.Round(entityRotation.x, 2)
            local rotY = QBCore.Shared.Round(entityRotation.y, 2)
            local rotZ = QBCore.Shared.Round(entityRotation.z, 2)
            local h = QBCore.Shared.Round(entityHeading, 2)
            SendNUIMessage({
                string = string.format('Model Name:\t%s\nModel Hash:\t%s\n\nHeading:\t%s\nCoords:\t\tvector3(%s, %s, %s)\nRotation:\tvector3(%s, %s, %s)', entityName, entityHash, h, x, y, z, rotX, rotY, rotZ)
            })
            QBCore.Functions.Notify(Lang:t("success.entity_copy"), "success")
        else
            QBCore.Functions.Notify(Lang:t("error.failed_entity_copy"), "error")
        end
    end
end

RegisterNetEvent('qb-admin:client:copyToClipboard', function(dataType)
    CopyToClipboard(dataType)
end)

local function Draw2DText(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end

local function ToggleShowCoordinates()
    local x = 0.4
    local y = 0.025
    showCoords = not showCoords
    CreateThread(function()
        while showCoords do
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local c = {}
            c.x = QBCore.Shared.Round(coords.x, 2)
            c.y = QBCore.Shared.Round(coords.y, 2)
            c.z = QBCore.Shared.Round(coords.z, 2)
            heading = QBCore.Shared.Round(heading, 2)
            Wait(0)
            Draw2DText(string.format('~w~'..Lang:t("info.ped_coords") .. '~b~ vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, heading), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
        end
    end)
end

local function ToggleVehicleDeveloperMode()
    local x = 0.4
    local y = 0.888
    vehicleDevMode = not vehicleDevMode
    CreateThread(function()
        while vehicleDevMode do
            local ped = PlayerPedId()
            Wait(0)
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local netID = VehToNet(vehicle)
                local hash = GetEntityModel(vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                local eHealth = GetVehicleEngineHealth(vehicle)
                local bHealth = GetVehicleBodyHealth(vehicle)
                Draw2DText(Lang:t("info.vehicle_dev_data"), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
                Draw2DText(string.format(Lang:t("info.ent_id") .. '~b~%s~s~ | ' .. Lang:t("info.net_id") .. '~b~%s~s~', vehicle, netID), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.025)
                Draw2DText(string.format(Lang:t("info.model") .. '~b~%s~s~ | ' .. Lang:t("info.hash") .. '~b~%s~s~', modelName, hash), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.050)
                Draw2DText(string.format(Lang:t("info.eng_health") .. '~b~%s~s~ | ' .. Lang:t("info.body_health") .. '~b~%s~s~', QBCore.Shared.Round(eHealth, 2), QBCore.Shared.Round(bHealth, 2)), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.075)
            end
        end
    end)
end

RegisterNetEvent('qb-admin:client:ToggleCoords', function()
    ToggleShowCoordinates()
end)

menu7_dev_copy_vec3:On("select", function()
    CopyToClipboard('coords3')
end)

menu7_dev_copy_vec4:On("select", function()
    CopyToClipboard('coords4')
end)

menu7_dev_copy_heading:On("select", function()
    CopyToClipboard('heading')
end)

entity_view_copy_info:On("select", function()
    CopyToClipboard('freeaimEntity')
end)

menu7_dev_vehicle_mode:On('change', function()
    ToggleVehicleDeveloperMode()
end)

menu7_dev_noclip:On('change', function(_, _, _)
    ToggleNoClip()
end)

menu7_dev_toggle_coords:On('change', function()
    ToggleShowCoordinates()
end)

entity_view_distance:On("select", function(_, value)
    SetEntityViewDistance(value)
    QBCore.Functions.Notify(Lang:t("info.entity_view_distance", {distance = value}))
end)

entity_view_vehicle:On('change', function()
    ToggleEntityVehicleView()
end)

entity_view_object:On('change', function()
    ToggleEntityObjectView()
end)

entity_view_ped:On('change', function()
    ToggleEntityPedView()
end)

--[[
    Dealer List
--]]
local function OpenDealerMenu(dealer)
    local EditDealer = MenuV:CreateMenu(false, Lang:t("menu.edit_dealer") .. dealer["name"], menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv')
    EditDealer:ClearItems()
    MenuV:OpenMenu(EditDealer)
    local elements = {
        [1] = {
            icon = '➡️',
            label = Lang:t("info.goto") .. " " .. dealer["name"],
            value = "goto",
            description = Lang:t("desc.dealergoto_desc") .. " " .. dealer["name"]
        },
        [2] = {
            icon = "☠",
            label = Lang:t("info.remove") .. " " .. dealer["name"],
            value = "remove",
            description = Lang:t("desc.dealerremove_desc") .. " " .. dealer["name"]
        }
    }
    for _, v in ipairs(elements) do
        EditDealer:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values == "goto" then
                    TriggerServerEvent('QBCore:CallCommand', "dealergoto", { dealer["name"] })
                elseif values == "remove" then
                    TriggerServerEvent('QBCore:CallCommand', "deletedealer", { dealer["name"] })
                    EditDealer:Close()
                    menu6:Close()
                end
            end
        })
    end
end

menu1_dealer_list:On('Select', function(_)
    menu6:ClearItems()
    QBCore.Functions.TriggerCallback('test:getdealers', function(dealers)
        for _, v in pairs(dealers) do
            menu6:AddButton({
                label = v["name"],
                value = v,
                description = Lang:t("menu.dealer_name"),
                select = function(btn)
                    local select = btn.Value
                    OpenDealerMenu(select)
                end
            })
        end
    end)
end)