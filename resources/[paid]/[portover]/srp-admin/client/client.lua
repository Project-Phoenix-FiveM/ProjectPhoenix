local banlength = nil
local jaillength = nil
local showCoords = false
local vehicleDevMode = false
local banreason = 'Unknown'
local jailreason = 'Unknown'
local kickreason = 'Unknown'
local permission = nil
local godmode = false
local deletelazer = false
local adminjailCords = vector3(3094.2, -4700.75, 10.5)
local adminjailCordsout = vector3(1846.58, 2583.8, 45.67)
local adminjail = false
local jailtiltime = 0
local jailtiltimeCurrent = 0
local jailbeforesords = nil

local menu = MenuV:CreateMenu(false, 'Admin Menu', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test')
local menu2 = MenuV:CreateMenu(false, 'Admin Options', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test1')
local menu4 = MenuV:CreateMenu(false, 'Online Players', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test3')
local menu5 = MenuV:CreateMenu(false, 'Manage Server', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test4')
local menu6 = MenuV:CreateMenu(false, 'Available Weather Options', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test5')
--local menu7 = MenuV:CreateMenu(false, 'Dealer List', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test6')
local menu8 = MenuV:CreateMenu(false, 'Ban', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test7')
local menu9 = MenuV:CreateMenu(false, 'Kick', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test8')
local menu10 = MenuV:CreateMenu(false, 'Permissions', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test9')
local menu11 = MenuV:CreateMenu(false, 'Developer Options', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test10')
local menu12 = MenuV:CreateMenu(false, 'Vehicle Options', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test11')
local menu13 = MenuV:CreateMenu(false, 'Vehicle Categories', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test12')
local menu14 = MenuV:CreateMenu(false, 'Vehicle Models', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test13')
local menu15 = MenuV:CreateMenu(false, 'Admin Jail', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv', 'test14')

RegisterNetEvent('srp-admin:client:openMenu', function(perm)
    permission = perm

    menu:ClearItems()

    -- Admin Options
    local menu_button = menu:AddButton({
        icon = '😃',
        label = 'Admin Options',
        value = menu2,
        description = 'Misc. Admin Options'
    })

    -- Player Management
    local menu_button2 = menu:AddButton({
        icon = '🙍‍♂️',
        label = 'Player Management',
        value = menu4,
        description = 'View List Of Players'
    })

    menu_button2:On('select', function(item)
        menu4:ClearItems()

        SRPCore.Functions.TriggerCallback('test:getplayers', function(players)
            for k, v in pairs(players) do
                local levl = ""
                if (v["level"] ~= "") then
                    levl = " | L: "..v["level"]
                end
                if (levl == "" and v["tier"]>0) then
                    local tierAbr = ""
                    if (v["tier"] == 1) then
                        tierAbr = "MC"
                    elseif (v["tier"] == 2) then
                        tierAbr = "VS"
                    elseif (v["tier"] == 3) then
                        tierAbr = "VG"
                    elseif (v["tier"] == 4) then
                        tierAbr = "VD"
                    end
                    levl = " | L: "..tierAbr
                end
                local menu_button10 = menu4:AddButton({
                    label = 'ID:' .. v["id"] .. ' | H: '..v["hours"]..levl..' ► ' .. v["name"],
                    value = v,
                    description = 'Player Name',
                    select = function(btn)
                        local select = btn.Value -- get all the values from v!

                        OpenPlayerMenus(select) -- only pass what i select nothing else
                    end
                }) -- WORKS
            end
        end)
    end)

    -- Server Management
    local menu_button3 = menu:AddButton({
        icon = '🎮',
        label = 'Server Management',
        value = menu5,
        description = 'Misc. Server Options'
    })

    -- Vehicles
    local menu_button21 = menu:AddButton({
        icon = '🚗',
        label = 'Vehicles',
        value = menu12,
        description = 'Vehicle Options'
    })

    menu2:ClearItems()

    -- Toggle NoClip
    local menu_button5 = menu2:AddCheckbox({
        icon = '🎥',
        label = 'NoClip',
        value = menu2,
        description = 'Enable/Disable NoClip'
    })

    menu_button5:On('change', function(item, newValue, oldValue)
        ToggleNoClipMode()
    end)

    -- Revive Self
    local menu_button6 = menu2:AddButton({
        icon = '🏥',
        label = 'Revive',
        value = 'revive',
        description = 'Revive Yourself'
    })

    menu_button6:On('select', function(item)
        local PlayerData = SRPCore.Functions.GetPlayerData()

        TriggerEvent('hospital:client:Revive', PlayerPedId())
        TriggerServerEvent("srp-log:server:CreateLog", "admins", "[Menu] Revive self", "green", "**"..PlayerData.name.."** (CitizenID: "..PlayerData.citizenid.." | ID: "..PlayerData.source..")", false)
    end)
    
    local menu_button7 = menu2:AddButton({
        icon = '🧹',
        label = 'Clear',
        value = 'clear',
        description = 'Clear the area of PEDs, vehicle and objects'
    })

    menu_button7:On('select', function(item)
        TriggerServerEvent("srp-admin:Server:ClearArea")
    end)


    -- Invisible
    local menu_button7 = menu2:AddCheckbox({
        icon = '👻',
        label = 'Invisible',
        value = menu2,
        description = 'Enable/Disable Invisibility'
    })

    local invisible = false
    menu_button7:On('change', function(item, newValue, oldValue)
        if not invisible then
            invisible = true
            SetEntityVisible(PlayerPedId(), false, 0)
        else
            invisible = false
            SetEntityVisible(PlayerPedId(), true, 0)
        end
    end)

    -- Godmode
   if hasPermission(permission, 'junioradmin') then
       local menu_button8 = menu2:AddCheckbox({
           icon = '⚡',
           label = 'Godmode',
           value = menu2,
           description = 'Enable/Disable God Mode'
       })

       menu_button8:On('change', function(item, newValue, oldValue)
           godmode = not godmode

           if godmode then
               while godmode do
                   Wait(0)
                   SetPlayerInvincible(PlayerId(), true)
               end
               SetPlayerInvincible(PlayerId(), false)
           end
       end)
   end

    if hasPermission(permission, 'moderator') then
        -- Toggle Names
        local names_button = menu2:AddCheckbox({
            icon = '📋',
            label = 'Names',
            value = menu2,
            description = 'Enable/Disable Names overhead'
        })

        names_button:On('change', function()
            TriggerEvent('srp-admin:client:toggleNames')
        end)

        -- Toggle Player Blips
        local blips_button = menu2:AddCheckbox({
            icon = '📍',
            label = 'Blips',
            value = menu2,
            description = 'Enable/Disable Blips for players in maps'
        })

        blips_button:On('change', function()
            TriggerEvent('srp-admin:client:toggleBlips')
        end)
    end

    menu4:ClearItems()
    menu5:ClearItems()

    if hasPermission(permission, 'juniormoderator') then
        -- Weather Change
        local menu_button11 = menu5:AddButton({
            icon = '🌡️',
            label = 'Weather Options',
            value = menu6,
            description = 'Change The Weather'
        })

        menu_button11:On("select",function()
            menu6:ClearItems()
            local elements = {
                [1] = {
                    icon = '☀️',
                    label = 'Extra Sunny',
                    value = "EXTRASUNNY",
                    description = 'I\'m Melting!'
                },
                [2] = {
                    icon = '☀️',
                    label = 'Clear',
                    value = "CLEAR",
                    description = 'The Perfect Day!'
                },
                [3] = {
                    icon = '☀️',
                    label = 'Neutral',
                    value = "NEUTRAL",
                    description = 'Just A Regular Day!'
                },
                [4] = {
                    icon = '🌁',
                    label = 'Smog',
                    value = "SMOG",
                    description = 'Smoke Machine!'
                },
                [5] = {
                    icon = '🌫️',
                    label = 'Foggy',
                    value = "FOGGY",
                    description = 'Smoke Machine x2!'
                },
                [6] = {
                    icon = '⛅',
                    label = 'Overcast',
                    value = "OVERCAST",
                    description = 'Not Too Sunny!'
                },
                [7] = {
                    icon = '☁️',
                    label = 'Clouds',
                    value = "CLOUDS",
                    description = 'Where\'s The Sun?'
                },
                [8] = {
                    icon = '🌤️',
                    label = 'Clearing',
                    value = "CLEARING",
                    description = 'Clouds Start To Clear!'
                },
                [9] = {
                    icon = '☂️',
                    label = 'Rain',
                    value = "RAIN",
                    description = 'Make It Rain!'
                },

                [10] = {
                    icon = '⛈️',
                    label = 'Thunder',
                    value = "THUNDER",
                    description = 'Run and Hide!'
                },
                [11] = {
                    icon = '❄️',
                    label = 'Snow',
                    value = "SNOW",
                    description = 'Is It Cold Out Here?'
                },
                [12] = {
                    icon = '🌨️',
                    label = 'Blizzard',
                    value = "BLIZZARD",
                    description = 'Snow Machine?'
                },
                [13] = {
                    icon = '❄️',
                    label = 'Light Snow',
                    value = "SNOWLIGHT",
                    description = 'Starting To Feel Like Christmas!'
                },
                [14] = {
                    icon = '🌨️',
                    label = 'Heavy Snow (XMAS)',
                    value = "XMAS",
                    description = 'Snowball Fight!'
                },
                [15] = {
                    icon = '🎃',
                    label = 'Halloween',
                    value = "HALLOWEEN",
                    description = 'What Was That Noise?!'
                }
            }

            for k,v in ipairs(elements) do
                local menu_button14 = menu6:AddButton({icon = v.icon,label = v.label,value = v,description = v.description,select = function(btn)
                    local selection = btn.Value
                    TriggerServerEvent('srp-weathersync:server:setWeather', selection.value)
                    SRPCore.Functions.Notify('Weather Changed To: '..selection.label)
                end})
            end
        end)

        -- Time Change
        local menu_button13 = menu5:AddSlider({
            icon = '⏲️',
            label = 'Server Time',
            value = GetClockHours(),
            values = {{
                label = '00',
                value = '00',
                description = 'Time'
            }, {
                label = '01',
                value = '01',
                description = 'Time'
            }, {
                label = '02',
                value = '02',
                description = 'Time'
            }, {
                label = '03',
                value = '03',
                description = 'Time'
            }, {
                label = '04',
                value = '04',
                description = 'Time'
            }, {
                label = '05',
                value = '05',
                description = 'Time'
            }, {
                label = '06',
                value = '06',
                description = 'Time'
            }, {
                label = '07',
                value = '07',
                description = 'Time'
            }, {
                label = '08',
                value = '08',
                description = 'Time'
            }, {
                label = '09',
                value = '09',
                description = 'Time'
            }, {
                label = '10',
                value = '10',
                description = 'Time'
            }, {
                label = '11',
                value = '11',
                description = 'Time'
            }, {
                label = '12',
                value = '12',
                description = 'Time'
            }, {
                label = '13',
                value = '13',
                description = 'Time'
            }, {
                label = '14',
                value = '14',
                description = 'Time'
            }, {
                label = '15',
                value = '15',
                description = 'Time'
            }, {
                label = '16',
                value = '16',
                description = 'Time'
            }, {
                label = '17',
                value = '17',
                description = 'Time'
            }, {
                label = '18',
                value = '18',
                description = 'Time'
            }, {
                label = '19',
                value = '19',
                description = 'Time'
            }, {
                label = '20',
                value = '20',
                description = 'Time'
            }, {
                label = '21',
                value = '21',
                description = 'Time'
            }, {
                label = '22',
                value = '22',
                description = 'Time'
            }, {
                label = '23',
                value = '23',
                description = 'Time'
            }}
        })

        menu_button13:On("select", function(item, value)
            local PlayerData = SRPCore.Functions.GetPlayerData()

            TriggerServerEvent("srp-weathersync:server:setTime", value, value)
            SRPCore.Functions.Notify("Time changed to " .. value .. " hs 00 min")
            TriggerServerEvent("srp-log:server:CreateLog", "admins", "[Menu] Server time", "green", "**"..PlayerData.name.."** (CitizenID: "..PlayerData.citizenid.." | ID: "..PlayerData.source..") ***Time***: " .. value .. ":00", false)
        end)
    end

    menu12:ClearItems()

    -- Spawn Vehicle
    if hasPermission(permission, 'helper') then
        local menu12_button1 = menu12:AddButton({
            icon = '🚗',
            label = 'Spawn Vehicle',
            value = menu13,
            description = 'Spawn a vehicle'
        })

        local vehicles = {}
        for k, v in pairs(SRPCore.Shared.Vehicles) do
            local category = v["category"]
            if vehicles[category] == nil then
                vehicles[category] = { }
            end
            vehicles[category][k] = v
        end

        menu12_button1:On('Select', function(item)
            menu13:ClearItems()
            for k, v in pairs(vehicles) do
                local menu_button10 = menu13:AddButton({
                    label = k,
                    value = v,
                    description = 'Category Name',
                    select = function(btn)
                        local select = btn.Value
                        OpenCarModelsMenu(select)
                    end
                })
            end
        end)
    end

    -- Fix Vehicle
    if hasPermission(permission, 'helper') then
        local menu12_button2 = menu12:AddButton({
            icon = '🔧',
            label = 'Fix Vehicle',
            value = 'fix',
            description = 'Fix the vehicle you are in'
        })

        menu12_button2:On('Select', function(item)
            local PlayerData = SRPCore.Functions.GetPlayerData()

            TriggerServerEvent('SRPCore:CallCommand', "fix", {})
            TriggerServerEvent("srp-log:server:CreateLog", "admins", "[Menu] Fix vehicle", "green", "**"..PlayerData.name.."** (CitizenID: "..PlayerData.citizenid.." | ID: "..PlayerData.source..")", false)
        end)
    end

    -- Buy vehicle
    if hasPermission(permission, 'god') then
        local menu12_button3 = menu12:AddButton({
            icon = '💲',
            label = 'Buy',
            value = 'buy',
            description = 'Buy the vehicle for free'
        })

        menu12_button3:On('Select', function(item)
            TriggerServerEvent('SRPCore:CallCommand', "admincar", {})
        end)
    end

    -- Remove Vehicle
    if hasPermission(permission, 'moderator') then
        local menu12_button4 = menu12:AddButton({
            icon = '☠',
            label = 'Remove Vehicle',
            value = 'remove',
            description = 'Remove closest vehicle'
        })

        menu12_button4:On('Select', function(item)
            local PlayerData = SRPCore.Functions.GetPlayerData()

            TriggerServerEvent('SRPCore:CallCommand', "dv", {})
            TriggerServerEvent("srp-log:server:CreateLog", "admins", "[Menu] Remove vehicle", "green", "**"..PlayerData.name.."** (CitizenID: "..PlayerData.citizenid.." | ID: "..PlayerData.source..")", false)
        end)
    end

    menu11:ClearItems()

    -- Developer options
    if hasPermission(permission, 'seniormoderator') then
        local menu_button69 = menu:AddButton({
            icon = '🔧',
            label = 'Developer Options',
            value = menu11,
            description = 'Misc. Dev Options'
        })

        -- Coords3 copy
        local coords3_button = menu11:AddButton({
            icon = '📋',
            label = 'Copy vector3',
            value = 'coords',
            description = 'Copy vector3 To Clipboard'
        })

        coords3_button:On("select", function()
            CopyToClipboard('coords3')
        end)

        -- Coords4 copy
        local coords4_button = menu11:AddButton({
            icon = '📋',
            label = 'Copy vector4',
            value = 'coords',
            description = 'Copy vector4 To Clipboard'
        })

        coords4_button:On("select", function()
            CopyToClipboard('coords4')
        end)

        -- Display Coords
        local togglecoords_button = menu11:AddCheckbox({
            icon = '📍',
            label = 'Display Coords',
            value = nil,
            description = 'Show Coords On Screen'
        })

        togglecoords_button:On('change', function()
            ToggleShowCoordinates()
        end)

        -- Copy Heading
        local heading_button = menu11:AddButton({
            icon = '📋',
            label = 'Copy Heading',
            value = 'heading',
            description = 'Copy Heading to Clipboard'
        })

        heading_button:On("select", function()
            CopyToClipboard('heading')
        end)

        -- Vehicle Toggle Dev Mode
        local vehicledev_button = menu11:AddButton({
            icon = '🚘',
            label = 'Vehicle Dev Mode',
            value = nil,
            description = 'Display Vehicle Information'
        })

        vehicledev_button:On('select', function()
            ToggleVehicleDeveloperMode()
        end)

        -- Delete Lase
        local deletelazer_button = menu11:AddCheckbox({
            icon = '🔫',
            label = 'Delete Laser',
            value = menu11,
            description = 'Enable/Disable Laser'
        })

        deletelazer_button:On('change', function(item, newValue, oldValue)
            deleteLazer = not deleteLazer
        end)

        -- Noclip
        local noclip_button = menu11:AddCheckbox({
            icon = '🎥',
            label = 'NoClip',
            value = menu11,
            description = 'Enable/Disable NoClip'
        })

        noclip_button:On('change', function(item, newValue, oldValue)
            ToggleNoClipMode()
        end)
    end

    MenuV:OpenMenu(menu)
end)

hasPermission = function(currentPermission, needPermission)
	local retval = false
	currentPermission = tostring(currentPermission:lower())
	needPermission = tostring(needPermission:lower())

    if SRPCore.Config.Server.PermissionLevels[currentPermission].power >= SRPCore.Config.Server.PermissionLevels[needPermission].power then
        retval = true
    end

	return retval
end

local function round(input, decimalPlaces)
    return tonumber(string.format("%." .. (decimalPlaces or 0) .. "f", input))
end

function CopyToClipboard(dataType)
    local ped = PlayerPedId()
    if dataType == 'coords3' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        SendNUIMessage({
            string = string.format('vector3(%s, %s, %s)', x, y, z)
        })
        SRPCore.Functions.Notify("Coordinates copied to clipboard!", "success")
    elseif dataType == 'coords4' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        SendNUIMessage({
            string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
        })
        SRPCore.Functions.Notify("Coordinates copied to clipboard!", "success")
    elseif dataType == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        SendNUIMessage({
            string = h
        })
        SRPCore.Functions.Notify("Heading copied to clipboard!", "success")
    end
end

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

function ToggleShowCoordinates()
    local x = 0.4
    local y = 0.025
    showCoords = not showCoords
    Citizen.CreateThread(function()
        while showCoords do
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local c = {}
            c.x = round(coords.x, 2)
            c.y = round(coords.y, 2)
            c.z = round(coords.z, 2)
            heading = round(heading, 2)
            Citizen.Wait(0)
            Draw2DText(string.format('~w~Ped Coordinates:~b~ vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, heading), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
        end
    end)
end

function ToggleVehicleDeveloperMode()
    local x = 0.4
    local y = 0.888
    vehicleDevMode = not vehicleDevMode
    Citizen.CreateThread(function()
        while vehicleDevMode do
            local ped = PlayerPedId()
            Citizen.Wait(0)
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local netID = VehToNet(vehicle)
                local hash = GetEntityModel(vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                local eHealth = GetVehicleEngineHealth(vehicle)
                local bHealth = GetVehicleBodyHealth(vehicle)
                Draw2DText('Vehicle Developer Data:', 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
                Draw2DText(string.format('Entity ID: ~b~%s~s~ | Net ID: ~b~%s~s~', vehicle, netID), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.025)
                Draw2DText(string.format('Model: ~b~%s~s~ | Hash: ~b~%s~s~', modelName, hash), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.050)
                Draw2DText(string.format('Engine Health: ~b~%s~s~ | Body Health: ~b~%s~s~', round(eHealth, 2), round(bHealth, 2)), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.075)
            end
        end
    end)
end

-- Car Categories
function OpenCarModelsMenu(category)
    menu14:ClearItems()
    MenuV:OpenMenu(menu14)
    for k, v in pairs(category) do
        local menu_button10 = menu14:AddButton({
             label = v["name"],
             value = k,
             description = 'Spawn ' .. v["name"],
             select = function(btn)
                local PlayerData = SRPCore.Functions.GetPlayerData()

                TriggerServerEvent('SRPCore:CallCommand', "sv", { k })
                TriggerServerEvent("srp-log:server:CreateLog", "admins", "[Menu] Spawn vehicle", "green", "**"..PlayerData.name.."** (CitizenID: "..PlayerData.citizenid.." | ID: "..PlayerData.source..") ***Vehicle*** " .. k, false)
             end
        })
    end
end

-- Player List
function OpenPermsMenu(permsply)
    SRPCore.Functions.TriggerCallback('srp-admin:server:getrank', function(rank)
        if rank then
            local selectedgroup = 'Unknown'
            MenuV:OpenMenu(menu10)
            menu10:ClearItems()
            local menu_button20 = menu10:AddSlider({
                icon = '',
                label = 'Group',
                value = 'user',
                values = {{
                    label = 'User',
                    value = 'user',
                    description = 'Group'
                }, {
                    label = 'DV',
                    value = 'dv',
                    description = 'Group'
                }, {
                    label = 'Trial Helper',
                    value = 'trialhelper',
                    description = 'Group'
                }, {
                    label = 'Helper',
                    value = 'helper',
                    description = 'Group'
                }, {
                    label = 'Junior Moderator',
                    value = 'juniormoderator',
                    description = 'Group'
                }, {
                    label = 'Moderator',
                    value = 'moderator',
                    description = 'Group'
                }, {
                    label = 'Senior Moderator',
                    value = 'seniormoderator',
                    description = 'Group'
                }, {
                    label = 'Junior Admin',
                    value = 'junioradmin',
                    description = 'Group'
                }, {
                    label = 'Administrator',
                    value = 'admin',
                    description = 'Group'
                }, {
                    label = 'Head Admin',
                    value = 'headadmin',
                    description = 'Group'
                }, {
                    label = 'God',
                    value = 'god',
                    description = 'Group'
                }},
                change = function(item, newValue, oldValue)
                    local vcal = newValue
                    if vcal == 1 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "user", label = "User"})
                    elseif vcal == 2 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "dv", label = "DV"})
                    elseif vcal == 3 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "trialhelper", label = "Trial Helper"})
                    elseif vcal == 4 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "helper", label = "Helper"})
                    elseif vcal == 5 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "juniormoderator", label = "Junior Moderator"})
                    elseif vcal == 6 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "moderator", label = "Moderator"})
                    elseif vcal == 7 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "seniormoderator", label = "Senior Moderator"})
                    elseif vcal == 8 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "junioradmin", label = "Junior Admin"})
                    elseif vcal == 9 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "admin", label = "Administrator"})
                    elseif vcal == 10 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "headadmin", label = "Head Admin"})
                    elseif vcal == 11 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "god", label = "God"})
                    end
                end
            })

            local menu_button21 = menu10:AddButton({
                icon = '',
                label = 'Confirm',
                value = "giveperms",
                description = 'Give the permission group',
                select = function(btn)
                    if selectedgroup ~= 'Unknown' then
                        TriggerServerEvent('srp-admin:server:setPermissions', permsply.id, selectedgroup)
			            SRPCore.Functions.Notify('Authority group changed!', 'success')
                        selectedgroup = 'Unknown'
                    else
                        SRPCore.Functions.Notify('Choose a group!', 'error')
                    end
                end
            })
        else
            MenuV:CloseMenu(menu)
        end
    end)
end

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

local function OpenKickMenu(kickplayer)
    MenuV:OpenMenu(menu9)
    menu9:ClearItems()
    local menu_button19 = menu9:AddButton({
        icon = '',
        label = 'Reason',
        value = "reason",
        description = 'Kick reason',
        select = function(btn)
            kickreason = LocalInput('Kick Reason', 255, 'Reason')
        end
    })

    local menu_button18 = menu9:AddButton({
        icon = '',
        label = 'Confirm',
        value = "kick",
        description = 'Confirm the kick',
        select = function(btn)
            if kickreason ~= 'Unknown' then
                TriggerServerEvent('srp-admin:server:kick', kickplayer, kickreason)
                kickreason = 'Unknown'
            else
                SRPCore.Functions.Notify('You must give a reason!', 'error')
            end
        end
    })
end

local function OpenBanMenu(banplayer)
    MenuV:OpenMenu(menu8)
    menu8:ClearItems()
    local menu_button15 = menu8:AddButton({
        icon = '',
        label = 'Reason',
        value = "reason",
        description = 'Ban reason',
        select = function(btn)
            banreason = LocalInput('Ban Reason', 255, 'Reason')
        end
    })

    local menu_button16 = menu8:AddSlider({
        icon = '⏲️',
        label = 'Length',
        value = '3600',
        values = {{
            label = '1 hour',
            value = '3600',
            description = 'Ban Length'
        }, {
            label = '6 hours',
            value ='21600',
            description = 'Ban Length'
        }, {
            label = '12 hours',
            value = '43200',
            description = 'Ban Length'
        }, {
            label = '1 day',
            value = '86400',
            description = 'Ban Length'
        }, {
            label = '3 days',
            value = '259200',
            description = 'Ban Length'
        }, {
            label = '1 week',
            value = '604800',
            description = 'Ban Length'
        }, {
            label = '1 month',
            value = '2678400',
            description = 'Ban Length'
        }, {
            label = '3 months',
            value = '8035200',
            description = 'Ban Length'
        }, {
            label = '6 months',
            value = '16070400',
            description = 'Ban Length'
        }, {
            label = '1 year',
            value = '32140800',
            description = 'Ban Length'
        }, {
            label = 'Permanent',
            value = '99999999999',
            description = 'Ban Length'
        }, {
            label = 'Self',
            value = "self",
            description = 'Ban Length'
        }},
        select = function(btn, newValue, oldValue)
            if newValue == "self" then
                banlength = LocalInputInt('Ban Length', 11, 'Seconds')
            else
                banlength = newValue
            end
        end
    })

    local menu_button17 = menu8:AddButton({
        icon = '',
        label = 'Confirm',
        value = "ban",
        description = 'Confirm the ban',
        select = function(btn)
            if banreason ~= 'Unknown' and banlength ~= nil then
                TriggerServerEvent('srp-admin:server:ban', banplayer, banlength, banreason)
                banreason = 'Unknown'
                banlength = nil
            else
                SRPCore.Functions.Notify('You must give a Reason and set a Length for the ban!', 'error')
            end
        end
    })
end

local function OpenJailMenu(jailplayer)
    MenuV:OpenMenu(menu15)
    menu15:ClearItems()
    local menu_button15 = menu15:AddButton({
        icon = '',
        label = 'Reason',
        value = "reason",
        description = 'Jail reason',
        select = function(btn)
            jailreason = LocalInput('Jail Reason', 255, 'Reason')
        end
    })

    local menu_button16 = menu15:AddSlider({
        icon = '⏲️',
        label = 'Length',
        value = '600',
        values = {{
            label = '1 minute',
            value = '60',
            description = 'Jail Length'
        },{
            label = '5 minutes',
            value = '300',
            description = 'Jail Length'
        }, {
            label = '10 minutes',
            value = '600',
            description = 'Jail Length'
        }, {
            label = '15 minutes',
            value = '900',
            description = 'Jail Length'
        }, {
            label = '20 minutes',
            value = '1200',
            description = 'Jail Length'
        }, {
            label = '30 minutes',
            value = '1800',
            description = 'Jail Length'
        }, {
            label = '1 hour',
            value = '3600',
            description = 'Jail Length'
        }, {
            label = '6 hours',
            value ='21600',
            description = 'Jail Length'
        }, {
            label = '12 hours',
            value = '43200',
            description = 'Jail Length'
        }, {
            label = '1 day',
            value = '86400',
            description = 'Jail Length'
        }, {
            label = '3 days',
            value = '259200',
            description = 'Jail Length'
        }, {
            label = '1 week',
            value = '604800',
            description = 'Jail Length'
        }, {
            label = '1 month',
            value = '2678400',
            description = 'Jail Length'
        }, {
            label = '3 months',
            value = '8035200',
            description = 'Jail Length'
        }, {
            label = '6 months',
            value = '16070400',
            description = 'Jail Length'
        }, {
            label = '1 year',
            value = '32140800',
            description = 'Jail Length'
        }, {
            label = 'Permanent',
            value = '99999999999',
            description = 'Jail Length'
        }, {
            label = 'Self',
            value = "self",
            description = 'Jail Length'
        }},
        select = function(btn, newValue, oldValue)
            if newValue == "self" then
                jaillength = LocalInputInt('Jail Length', 11, 'Seconds')
            else
                jaillength = newValue
            end
        end
    })

    local menu_button18 = menu15:AddButton({
        icon = '',
        label = 'Confirm',
        value = "jail",
        description = 'Confirm the jail',
        select = function(btn)
            if jailreason ~= 'Unknown' then
                if   jaillength ~= nil then
                    TriggerServerEvent('srp-admin:server:jail', jailplayer.id, jaillength, jailreason)
                    jailreason = 'Unknown'
                    jaillength = nil
                else
                    exports.pNotify:SendNotification({text = "You must give a Length for the jail!" ,type = "error"})
                end
            else
                exports.pNotify:SendNotification({text = "You must give a Reason for the jail!" ,type = "error"})
            end
        end
    })
end

function OpenPlayerMenus(player)
    local Players = MenuV:CreateMenu(false, player.cid .. ' Options', 'topright', 13, 110, 253, 'size-125', 'none', 'menuv') -- Players Sub Menu
    Players:ClearItems()
    MenuV:OpenMenu(Players)

    local elements = {}
    local elementsItems = {
        ["cuffuncuff"] = {
            icon = '👮',
            label = "Cuff / Uncuff",
            value = "cuffuncuff",
            description = "Cuff / Uncuff " .. player.cid
        },
        ["kill"] = {
            icon = '💀',
            label = "Kill",
            value = "kill",
            description = "Kill " .. player.cid
        },
        ["revive"] = {
            icon = '🏥',
            label = "Revive",
            value = "revive",
            description = "Revive " .. player.cid
        },
        ["freeze"] = {
            icon = '🥶',
            label = "Freeze",
            value = "freeze",
            description = "Freeze " .. player.cid
        },
        ["spectate"] = {
            icon = '👀',
            label = "Spectate",
            value = "spectate",
            description = "Spectate " .. player.cid
        },
        ["goto"] = {
            icon = '➡️',
            label = "Go To",
            value = "goto",
            description = "Go to " .. player.cid .. " Position"
        },
        ["bring"] = {
            icon = '⬅️',
            label = "Bring",
            value = "bring",
            description = "Bring " .. player.cid .. " to your position"
        },
        ["intovehicle"] = {
            icon = '🚗',
            label = "Sit in vehicle",
            value = "intovehicle",
            description = "Sit in " .. player.cid .. "'s vehicle"
        },
        ["inventory"] = {
            icon = '🎒',
            label = "Open Inventory",
            value = "inventory",
            description = "Open " .. player.cid .. " inventorys"
        },
        ["stealcloth"] = {
            icon = '👕',
            label = "Steal Player Clothes",
            value = "stealcloth",
            description = "Steal player Clothes from " .. player.cid
        },
        ["cloth"] = {
            icon = '👕',
            label = "Give Clothing Menu",
            value = "cloth",
            description = "Give the Cloth menu to " .. player.cid
        },
        ["kick"] = {
            icon = '🥾',
            label = "Kick",
            value = "kick",
            description = "Kick " .. player.cid .. " you need to give a reason"
        },
        ["ban"] = {
            icon = '🚫',
            label = "Ban",
            value = "ban",
            description = "Ban " .. player.cid .. " you need to give a reason"
        },
        ["jail"] = {
            icon = '🔐',
            label = "Admin Jail",
            value = "jail",
            description = "Admin jail " .. player.cid .. " you need to give a reason"
        },
        ["perms"] = {
            icon = '🎟️',
            label = "Permissions",
            value = "perms",
            description = "Give " .. player.cid .. " Permissions"
        }
    }

    -- check permissions
    if hasPermission(permission, 'trialhelper') then -- cuff / uncuff
        table.insert(elements, elementsItems["cuffuncuff"])
    end

    if hasPermission(permission, 'helper') then -- kill
        table.insert(elements, elementsItems["kill"])
    end

    if hasPermission(permission, 'trialhelper') then -- revive
        table.insert(elements, elementsItems["revive"])
    end

    if hasPermission(permission, 'helper') then -- freeze
        table.insert(elements, elementsItems["freeze"])
    end

    if hasPermission(permission, 'helper') then -- spectate
        table.insert(elements, elementsItems["spectate"])
    end

    if hasPermission(permission, 'trialhelper') then -- goto
        table.insert(elements, elementsItems["goto"])
    end

    if hasPermission(permission, 'trialhelper') then -- bring
        table.insert(elements, elementsItems["bring"])
    end

    if hasPermission(permission, 'moderator') then -- siting vehicle
        table.insert(elements, elementsItems["intovehicle"])
    end

    if hasPermission(permission, 'seniormoderator') then -- open inventory
        table.insert(elements, elementsItems["inventory"])
    end

    if hasPermission(permission, 'helper') then -- steal clothing
        table.insert(elements, elementsItems["stealcloth"])
    end

    if hasPermission(permission, 'trialhelper') then -- give clothing
        table.insert(elements, elementsItems["cloth"])
    end

    if hasPermission(permission, 'trialhelper') then -- kick
        table.insert(elements, elementsItems["kick"])
    end

    if hasPermission(permission, 'moderator') then -- ban
        table.insert(elements, elementsItems["ban"])
    end

    if hasPermission(permission, 'trialhelper') then -- ban
        table.insert(elements, elementsItems["jail"])
    end

    if hasPermission(permission, 'admin') then -- permissions
        table.insert(elements, elementsItems["perms"])
    end

    for _, v in ipairs(elements) do
        if v then
            local menu_button10 = Players:AddButton({
                icon = v.icon,
                label = ' ' .. v.label,
                value = v.value,
                description = v.description,
                select = function(btn)
                    local values = btn.Value

                     if values == "stealcloth" then
                        local target = GetPlayerFromServerId(GetPlayerServerId(player.sourceplayer))
                        local targetPed = GetPlayerPed(target)
                        local playerPed = PlayerPedId()

                        for i=1,11 do
                            local clothingNR = GetPedDrawableVariation(targetPed, i)
                            local tXDID = GetPedTextureVariation(targetPed, i)
                            SetPedComponentVariation(playerPed, i, clothingNR, tXDID)
                        end
                    elseif values == "cuffuncuff" then
                        --local targetId = GetPlayerServerId(player.sourceplayer)
                        local targetId = player.sourceplayer

                        SRPCore.Functions.TriggerCallback("srp-admin:server:GetHandcuffStatus", function(result)
                            if res then
                                TriggerServerEvent("police:server:CuffPlayer", targetId, true, true)
                            else
                                TriggerServerEvent("police:server:CuffPlayer", targetId, true, true)
                            end
                        end, targetId)
                    elseif values ~= "ban" and values ~= "kick" and values ~= "perms" and values ~= "jail" then
                        TriggerServerEvent('srp-admin:server:'..values, player)
                    elseif values == "ban" then
                        OpenBanMenu(player)
                    elseif values == "jail" then
                        OpenJailMenu(player)
                    elseif values == "kick" then
                        OpenKickMenu(player)
                    elseif values == "perms" then
                        OpenPermsMenu(player)
                    end
                end
            })
        end
    end
end

local function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

local function DrawEntityBoundingBox(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim =
	{
		x = 0.5*(max.x - min.x),
		y = 0.5*(max.y - min.y),
		z = 0.5*(max.z - min.z)
	}

    local FUR =
    {
		x = position.x + dim.y*rightVector.x + dim.x*forwardVector.x + dim.z*upVector.x,
		y = position.y + dim.y*rightVector.y + dim.x*forwardVector.y + dim.z*upVector.y,
		z = 0
    }

    local FUR_bool, FUR_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    FUR.z = FUR_z
    FUR.z = FUR.z + 2 * dim.z

    local BLL =
    {
        x = position.x - dim.y*rightVector.x - dim.x*forwardVector.x - dim.z*upVector.x,
        y = position.y - dim.y*rightVector.y - dim.x*forwardVector.y - dim.z*upVector.y,
        z = 0
    }
    local BLL_bool, BLL_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    BLL.z = BLL_z

    -- DEBUG
    local edge1 = BLL
    local edge5 = FUR

    local edge2 =
    {
        x = edge1.x + 2 * dim.y*rightVector.x,
        y = edge1.y + 2 * dim.y*rightVector.y,
        z = edge1.z + 2 * dim.y*rightVector.z
    }

    local edge3 =
    {
        x = edge2.x + 2 * dim.z*upVector.x,
        y = edge2.y + 2 * dim.z*upVector.y,
        z = edge2.z + 2 * dim.z*upVector.z
    }

    local edge4 =
    {
        x = edge1.x + 2 * dim.z*upVector.x,
        y = edge1.y + 2 * dim.z*upVector.y,
        z = edge1.z + 2 * dim.z*upVector.z
    }

    local edge6 =
    {
        x = edge5.x - 2 * dim.y*rightVector.x,
        y = edge5.y - 2 * dim.y*rightVector.y,
        z = edge5.z - 2 * dim.y*rightVector.z
    }

    local edge7 =
    {
        x = edge6.x - 2 * dim.z*upVector.x,
        y = edge6.y - 2 * dim.z*upVector.y,
        z = edge6.z - 2 * dim.z*upVector.z
    }

    local edge8 =
    {
        x = edge5.x - 2 * dim.z*upVector.x,
        y = edge5.y - 2 * dim.z*upVector.y,
        z = edge5.z - 2 * dim.z*upVector.z
    }

    DrawLine(edge1.x, edge1.y, edge1.z, edge2.x, edge2.y, edge2.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge3.x, edge3.y, edge3.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge6.x, edge6.y, edge6.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge7.x, edge7.y, edge7.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge5.x, edge5.y, edge5.z, color.r, color.g, color.b, color.a)
    DrawLine(edge4.x, edge4.y, edge4.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
end

CreateThread(function()	-- While loop needed for delete lazer
	while true do
        sleep = 1000
        if deleteLazer then
            sleep = 7
            local color = {r = 255, g = 255, b = 255, a = 200}
            local position = GetEntityCoords(PlayerPedId())
            local hit, coords, entity = RayCastGamePlayCamera(1000.0)
            -- If entity is found then verifie entity
            if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
                local entityCoord = GetEntityCoords(entity)
                local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
                DrawEntityBoundingBox(entity, color)
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                Draw2DText('Obj: ~b~' .. entity .. '~w~ Model: ~b~' .. GetEntityModel(entity), 4, {255, 255, 255}, 0.4, 0.55, 0.888)
                Draw2DText('If you want to delete the object click on ~g~E', 4, {255, 255, 255}, 0.4, 0.55, 0.888 + 0.025)
                -- When E pressed then remove targeted entity
                if IsControlJustReleased(0, 38) then
                    -- Set as missionEntity so the object can be remove (Even map objects)
                    SetEntityAsMissionEntity(entity, true, true)
                    --SetEntityAsNoLongerNeeded(entity)
                    --RequestNetworkControl(entity)
                    DeleteEntity(entity)
                end
            -- Only draw of not center of map
            elseif coords.x ~= 0.0 and coords.y ~= 0.0 then
                -- Draws line to targeted position
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
            end
        end
        Wait(sleep)
	end
end)

RegisterNetEvent('srp-admin:client:jail', function(jailtime, currenttime)
    jailbeforesords = GetEntityCoords(GetPlayerPed(-1))
    jailtiltime = jailtime
    jailtiltimeCurrent = currenttime
    adminjail = true
    exports.pNotify:SendNotification({text = "You have been Admin jailed, to check your time use /ajailtime" ,type = "info", timeout=10000})
end)

RegisterNetEvent('srp-admin:client:unjail', function()
    
    jailtiltime = 0 
    jailtiltimeCurrent = 0
    if jailbeforesords == nil then
        SetEntityCoords(GetPlayerPed(-1), adminjailCordsout.x, adminjailCordsout.y, adminjailCordsout.z)
    else
        SetEntityCoords(GetPlayerPed(-1), jailbeforesords.x, jailbeforesords.y, jailbeforesords.z)
        jailbeforesords = nil
    end
    FreezeEntityPosition(GetPlayerPed(-1), false)
    DisablePlayerFiring(GetPlayerPed(-1), false) -- Disable weapon firing
    exports.pNotify:SendNotification({text = "You have been unjailed" ,type = "info"})
    adminjail = false
end)

RegisterNetEvent('srp-admin:client:jailtime', function()
    if adminjail then
        local togiveJailtime = math.abs((jailtiltimeCurrent-jailtiltime)/10000)
        exports.pNotify:SendNotification({text = "Time left: "..togiveJailtime.." secounds" ,type = "info"})
    else
        exports.pNotify:SendNotification({text = "You are not in Admin Jail" ,type = "error"})
    end
end)

RegisterNetEvent('SRPCore:Client:OnPlayerLoaded')
AddEventHandler('SRPCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("srp-admin:server:checkAdmin")
end)

CreateThread(function()	-- While loop needed for adminjail
	while true do
        if adminjail then
            DisableAllControlActions(0)
            DisableAllControlActions(1)
            DisableAllControlActions(2)
            
            DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
            DisableControlAction(0, 1, active) -- LookLeftRight
            DisableControlAction(0, 2, active) -- LookUpDown
            DisableControlAction(0, 142, active) -- MeleeAttackAlternate
            DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
            
            FreezeEntityPosition(GetPlayerPed(-1), true)

            SetEntityCoords(GetPlayerPed(-1), adminjailCords.x, adminjailCords.y, adminjailCords.z)

            if (jailtiltime <= jailtiltimeCurrent) then
                TriggerEvent("srp-admin:client:unjail")
            end
            jailtiltimeCurrent = jailtiltimeCurrent + 10000;
        end
        Wait(1000)
	end
end)

RegisterNetEvent('srp-admin:Client:ClearArea')
AddEventHandler('srp-admin:Client:ClearArea', function(source2, pos)
    clearAreaFuction(source2, pos)
end)

function clearAreaFuction(source2, pos)
    local PlayerData = SRPCore.Functions.GetPlayerData()
    if PlayerData.source == source2 then
        exports.pNotify:SendNotification({text = "Clearing Area",type = "info"})
    end
    
    local x, y, z = table.unpack(pos)
    ClearAreaOfEverything(x, y, z, 150.0)
    local counterLocal = 0
    while counterLocal < 100 do
        ClearAreaOfPeds(x, y, z, 50.0, 0)
        ClearAreaOfObjects(x, y, z, 50.0, 0)
        ClearAreaOfProjectiles(x, y, z, 50.0, 0)
        ClearAreaOfVehicles(x, y, z, 50.0, false, false, false, false, false)
        Wait(1)
        counterLocal = counterLocal + 1
    end    
    if PlayerData.source == source2 then
        exports.pNotify:SendNotification({text = "Area Cleared",type = "success"})
    end
end


RegisterNetEvent('srp-admin:Client:toggleNoClicp')
AddEventHandler('srp-admin:Client:toggleNoClicp', function()
    ToggleNoClipMode()
end)

RegisterNetEvent('srp-admin:Client:notify')
AddEventHandler('srp-admin:Client:notify', function(message, type)
    exports.pNotify:SendNotification({text = message,type = type})
end)


RegisterNetEvent('srp-admin:Client:fixfull')
AddEventHandler('srp-admin:Client:fixfull', function()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        SetVehicleFixed(GetVehiclePedIsIn(playerPed))
        SetVehicleFuelLevel(GetVehiclePedIsIn(playerPed), 100.0)
        TriggerServerEvent("srp-admin:server:fixfull",GetVehicleNumberPlateText(GetVehiclePedIsIn(playerPed)))
	else
		exports.pNotify:SendNotification({text = "You are not in a Vehicle",type = "error"})
	end
    
end)

RegisterNetEvent('srp-admin:Client:fuelfill')
AddEventHandler('srp-admin:Client:fuelfill', function()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        SetVehicleFuelLevel(GetVehiclePedIsIn(playerPed), 100.0)
        TriggerServerEvent("srp-admin:server:fuelfill", GetVehicleNumberPlateText(GetVehiclePedIsIn(playerPed)))
	else
		exports.pNotify:SendNotification({text = "You are not in a Vehicle",type = "error"})
	end
    
end)


-- Dealer List
-- local function OpenDealerMenu(dealer)
--     local EditDealer = MenuV:CreateMenu(false, 'Edit Dealer ' .. dealer["name"], 'topright', 13, 110, 253, 'size-125', 'none', 'menuv')
--     EditDealer:ClearItems()
--     MenuV:OpenMenu(EditDealer)
--     local elements = {
--         [1] = {
--             icon = '➡️',
--             label = "Go to " .. dealer["name"],
--             value = "goto",
--             description = "Goto dealer " .. dealer["name"]
--         },
--         [2] = {
--             icon = "☠",
--             label = "Remove " .. dealer["name"],
--             value = "remove",
--             description = "Remove dealer " .. dealer["name"]
--         }
--     }
--     for k, v in ipairs(elements) do
--         local menu_button10 = EditDealer:AddButton({
--             icon = v.icon,
--             label = ' ' .. v.label,
--             value = v.value,
--             description = v.description,
--             select = function(btn)
--                 local values = btn.Value
--                 if values == "goto" then
--                     TriggerServerEvent('SRPCore:CallCommand', "dealergoto", { dealer["name"] })
--                 elseif values == "remove" then
--                     TriggerServerEvent('SRPCore:CallCommand', "deletedealer", { dealer["name"] })
--                     EditDealer:Close()
--                     menu7:Close()
--                 end
--             end
--         })
--     end
-- end

-- menu_button4:On('Select', function(item)
--     menu7:ClearItems()
--     SRPCore.Functions.TriggerCallback('test:getdealers', function(dealers)
--         for k, v in pairs(dealers) do
--             local menu_button10 = menu7:AddButton({
--                 label = v["name"], --.. ' | ' .. v[time.min] .. ' | ' .. v[time.max]
--                 value = v,
--                 description = 'Dealer Name',
--                 select = function(btn)
--                     local select = btn.Value
--                     OpenDealerMenu(select)
--                 end
--             })
--         end
--     end)
-- end)
