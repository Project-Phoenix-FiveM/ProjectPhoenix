Core, Cfg, Framework = exports['t1ger_lib']:GetLib()
Lib = exports['t1ger_lib']:GetUtils()

Citizen.CreateThread(function()
    if Core == nil or Core.FrameworkReady() == nil then 
        return error("please start t1ger_lib resource before you start t1ger_mechanicsystem")
    end
    while not Core.FrameworkReady() do Wait(1000); end
    Core.GetJob()
    Wait(1000)
	TriggerServerEvent('mechanicsystem:server:playerLoaded')
end)

player, coords = nil, {}
Citizen.CreateThread(function()
    while true do
        player = PlayerPedId()
        coords = GetEntityCoords(player)
        Wait(500)
    end
end)

isPlayerAdmin = false
RegisterNetEvent('mechanicsystem:client:isAdmin')
AddEventHandler('mechanicsystem:client:isAdmin', function(isAdmin)
    if Config.Debug then
        print("isAdmin:", isAdmin)
    end
    isPlayerAdmin = isAdmin
end)

playerMechId, isMechanicBoss = 0, false
RegisterNetEvent('mechanicsystem:client:setMechanicId')
AddEventHandler('mechanicsystem:client:setMechanicId', function(id, isBoss)
    if Config.Debug then
        print("setPlayerMechId | playerMechId: ", id)
    end
    playerMechId = id
    isMechanicBoss = isBoss
end)

local mech_shops = {}
RegisterNetEvent('mechanicsystem:client:updateShops')
AddEventHandler('mechanicsystem:client:updateShops', function(data)
    mech_shops = data
end)

local shop_blips = {}
CreateShopBlips = function(shopId, blip, shopName)
    if DoesBlipExist(shop_blips[shopId]) then
        RemoveBlip(shop_blips[shopId])
    end
    shop_blips[shopId] = AddBlipForCoord(blip.coords.x, blip.coords.y, blip.coords.z)
    SetBlipSprite(shop_blips[shopId], blip.sprite)
    SetBlipDisplay(shop_blips[shopId], blip.display)
    SetBlipScale(shop_blips[shopId], blip.scale)
    SetBlipColour(shop_blips[shopId], blip.color)
    SetBlipAsShortRange(shop_blips[shopId], true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(shopName)
    EndTextCommandSetBlipName(shop_blips[shopId])
end

local marker_blips = {}
RegisterNetEvent('mechanicsystem:client:createMarkerBlips')
AddEventHandler('mechanicsystem:client:createMarkerBlips', function(shopId)
	if playerMechId ~= 0 and playerMechId == shopId then
        if next(mech_shops[playerMechId].markers) then
            for type, marker in pairs(mech_shops[playerMechId].markers) do
                if next(marker) then
                    if Config.Markers[type].blip.enable == true then
                        if DoesBlipExist(marker_blips[type]) then
                            RemoveBlip(marker_blips[type])
                        end
                        marker_blips[type] = CreateMarkerBlip(Config.Markers[type].blip, marker.coords)
                    end
                else
                    if DoesBlipExist(marker_blips[type]) then
                        RemoveBlip(marker_blips[type])
                    end
                end
            end
        end
    end
end)

CreateMarkerBlip = function(value, pos)
	if value.enable == true then
        local blipCoords = value.pos or nil
        if pos ~= nil then
            blipCoords = pos
        end
		local blip = AddBlipForCoord(blipCoords.x, blipCoords.y, blipCoords.z)
		SetBlipSprite(blip, value.sprite)
		SetBlipDisplay(blip, value.display)
		SetBlipScale(blip, value.scale)
		SetBlipColour(blip, value.color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(value.name)
		EndTextCommandSetBlipName(blip)
        return blip
    else
        return nil
	end
end

RegisterNetEvent('mechanicsystem:client:deleteMarkerBlips')
AddEventHandler('mechanicsystem:client:deleteMarkerBlips', function(shopId)
    if mech_shops[shopId] ~= nil then
        if next(mech_shops[shopId].markers) then
            for type, marker in pairs(mech_shops[shopId].markers) do
                if marker_blips[type] ~= nil and DoesBlipExist(marker_blips[type]) then
                    RemoveBlip(marker_blips[type])
                end
            end
        end
    end
end)

if Config.Menu['admin'].command.enable then
    RegisterCommand(Config.Menu['admin'].command.string, function()
        MechanicAdminMenu()
    end)
end

if Config.Menu['admin'].keybind.enable then
    RegisterCommand('mechanicAdmin', function()
        MechanicAdminMenu()
    end, false)
    RegisterKeyMapping('mechanicAdmin', 'Open Admin Mechanic Menu', 'keyboard', Config.Menu['admin'].keybind.defaultMapping)
end

MechanicAdminMenu = function()
    Core.TriggerCallback('mechanicsystem:server:isAdmin', function(isAdmin)
        if isAdmin then
            lib.registerContext({
                id = 'admin_mech_menu',
                title = Lang['title_mech_admin'],
                options = {
                    {
                        title = Lang['title_view_shops'],
                        icon = 'list',
                        event = 'mechanicsystem:client:viewShops',
                        arrow = true,
                    },
                    {
                        title = Lang['title_create_shop'],
                        icon = 'plus',
                        onSelect = function(args)
                            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                            local display_coords = {Lib.RoundNumber(x,2), Lib.RoundNumber(y,2), Lib.RoundNumber(z,2)}
                            local blipCoords = vector3(Lib.RoundNumber(x,2), Lib.RoundNumber(y,2), Lib.RoundNumber(z,2))

                            local input = lib.inputDialog(Lang['input_title_shop_creation'], {
                                {type = 'input', label = Lang['input_label_shop_name'], required = true, description = Lang['input_desc_shop_name']},
                                {type = 'input', label = Lang['input_label_job_name'], required = true, description = Lang['input_desc_job_name']},
                                {type = 'input', label = Lang['input_label_job_label'], required = true, description = Lang['input_desc_job_label']},
                                {type = 'number', label = Lang['input_label_account'], required = true, default = 0, min = 0, description = Lang['input_desc_account']},
                                {type = 'input', label = Lang['input_label_blip_coords'], disabled = true, default = json.encode(display_coords), value = display_coords, description = Lang['input_desc_blip_coords']},
                                {type = 'checkbox', label = Lang['input_label_blip_enable'], checked = true},
                            })

                            if not input then 
                                return MechanicAdminMenu()
                            end

                            local data = { shop_name = input[1], job_name = input[2], job_label = input[3], account = input[4], blip_coords = blipCoords, blip_use = input[6] }

                            TriggerServerEvent('mechanicsystem:server:createShop', data)

                            Wait(500)
                            
                            MechanicAdminMenu()
                        end,
                    },
                },
            })
            lib.showContext('admin_mech_menu')
        else
            if Config.Debug then
                print('you are not an admin.')
            end
        end
    end)
end

RegisterNetEvent('mechanicsystem:client:viewShops', function()
    local menuOptions = {}
    Core.TriggerCallback('mechanicsystem:server:getShops', function(results)
        if results and next(results) then
            for id, shop in pairs(results) do 
                table.insert(menuOptions, {
                    title = shop.name,
                    icon = 'people-group',
                    args = shop,
                    metadata = {
                        {label = Lang['meta_shop_id'], value = shop.id},
                        {label = Lang['meta_boss'], value = shop.boss or 'N/A'},
                        {label = Lang['meta_job_name'], value = ('%s [%s]'):format(shop.job.label, shop.job.name)},
                    },
                    event = 'mechanicsystem:client:manageShop',
                })
            end
            lib.registerContext({
                id = 'admin_view_shops',
                title = Lang['title_view_shops'],
                menu = 'admin_mech_menu',
                onBack = function()
                    MechanicAdminMenu()
                end,
                options = menuOptions
            })
            lib.showContext('admin_view_shops')
        else
            MechanicAdminMenu()
            Core.Notification({
                title = '',
                message = Lang['no_mechanic_shops'],
                type = 'error'
            })
        end
    end)
end)

RegisterNetEvent('mechanicsystem:client:manageShop', function(data)
    lib.registerContext({
        id = 'admin_manage_shop',
        title = Lang['title_admin_manage_shop']:format(data.name, data.id),
        menu = 'admin_view_shop',
        onBack = function()
            TriggerEvent('mechanicsystem:client:viewShops')
        end,
        options = {
            {title = Lang['title_admin_set_boss'], description = Lang['desc_admin_set_boss'], icon = 'rotate', args = data, event = 'mechanicsystem:client:setBoss'},
            {title = Lang['title_admin_marker_manage'], description = Lang['desc_admin_marker_management'], icon = 'plus', arrow = true, args = data, event = 'mechanicsystem:client:markerManagement'},
            {
                title = Lang['title_admin_spawn_lift'],
                description = Lang['desc_admin_spawn_lift'],
                icon = 'car',
                metadata = {
                    {label = Lang['meta_coords'], value = 'x: '..Lib.RoundNumber(coords.x, 2)..', y: '..Lib.RoundNumber(coords.y, 2)..', z: '..Lib.RoundNumber(coords.z, 2)},
                    {label = Lang['meta_heading'], value = Lib.RoundNumber(GetEntityHeading(player), 2)},
                },
                args = data,
                onSelect = function()
                    lib.hideContext()
                    CreateCustomLift(coords, data)
                end
            },
            {title = Lang['title_admin_disable_shop'], description = Lang['desc_admin_disable_shop'], icon = 'shield', args = data, event = 'mechanicsystem:client:disableShop'},
            {title = Lang['title_admin_delete_shop'], description = Lang['desc_admin_delete_shop'], icon = 'trash', args = data, event = 'mechanicsystem:client:deleteShop'},
        },
    })
    lib.showContext('admin_manage_shop')
end)


RegisterNetEvent('mechanicsystem:client:setBoss', function(data)
    local players = {}
    Core.TriggerCallback('t1ger_lib:getOnlinePlayers', function(results)
        for i = 1, #results, 1 do
            table.insert(players, {
                title = results[i].name,
                icon = 'user',
                description = Lang['desc_admin_click_to_set_boss'],
                metadata = {
                    {label = Lang['meta_player_id'], value = results[i].source},
                },
                args = {shop = data, player = results[i]},
                onSelect = function(args)
                    TriggerServerEvent('mechanicsystem:server:setBoss', args)
                end
            })
        end
        lib.registerContext({
            id = 'admin_set_boss',
            title = Lang['title_admin_set_boss'],
            menu = 'admin_manage_shop',
            options = players
        })
        lib.showContext('admin_set_boss')
    end)
end)

RegisterNetEvent('mechanicsystem:client:markerManagement', function(data)
    local menuOptions = {}

    for k,v in pairs(Config.Markers) do
        if v.enable == true then
            table.insert(menuOptions, {
                title = v.menuTitle,
                icon = v.icon,
                args = {type = k, data = data, value = v},
                event = 'mechanicsystem:client:manageMarker'
            })
        end
    end

    lib.registerContext({
        id = 'marker_management',
        title = Lang['title_admin_marker_manage'],
        menu = 'admin_manage_shop',
        onBack = function()
            TriggerEvent('mechanicsystem:client:manageShop', data)
        end,
        options = menuOptions,
    })
    lib.showContext('marker_management')
end)

RegisterNetEvent('mechanicsystem:client:manageMarker', function(args)
    local menuOptions = {}
    local menuTitle = (args.type:gsub("^%l", string.upper))

    print("type: ", args.type)
    print("has marker: ", args.data.markers[args.type])

    local curMarker = args.data.markers[args.type]

    if curMarker == nil then 
        return print("curMarker is nil")
    end

    if next(curMarker) then
        table.insert(menuOptions, {
            title = Lang['title_admin_del_marker'],
            icon = 'trash',
            args = args,
            onSelect = function(args)
                TriggerServerEvent('mechanicsystem:server:deleteMarker', args)
            end,
        })
    else
        table.insert(menuOptions, {
            title = Lang['title_create_x_marker']:format(menuTitle),
            icon = 'plus',
            args = args,
            onSelect = function(args)
                local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                local markerCoords = {Lib.RoundNumber(x,2), Lib.RoundNumber(y,2), Lib.RoundNumber(z,2)}

                local input = lib.inputDialog(Lang['input_create_marker'], {
                    {type = 'input', label = 'Coords:', disabled = true, default = json.encode(markerCoords), value = markerCoords, description = Lang['desc_marker_coords']},
                    {type = 'number', label = 'Type', default = 20, description = Lang['desc_marker_type'], min = 0, max = 255},
                    {type = 'number', label = 'RGBA [RED]', default = 240, description = 'RGBA - Color RED [R]', min = 0, max = 255},
                    {type = 'number', label = 'RGBA [GREEN]', default = 52, description = 'RGBA - Color GREEN [G]', min = 0, max = 255},
                    {type = 'number', label = 'RGBA [BLUE]', default = 52, description = 'RGBA - Color BLUE [B]', min = 0, max = 255},
                    {type = 'number', label = 'RGBA [ALPHA]', default = 100, description = 'RGBA - Color ALPHA [A]', min = 0, max = 255},
                    {type = 'checkbox', label = 'Bob Up And Down', description = Lang['desc_marker_bob_up_down']},
                    {type = 'checkbox', label = 'Face Camera', checked = true, description = Lang['desc_marker_face_cam']},
                })

                if not input then
                    return lib.showContext('marker_management')
                end

                input[1] = json.decode(input[1])
                if input[7] == nil then
                    input[7] = false
                end
                if input[8] == nil then
                    input[8] = false
                end
                
                TriggerServerEvent('mechanicsystem:server:createMarker', input, args)
            end,
        })
    end

    lib.registerContext({
        id = 'manage_marker',
        title = Lang['title_manage_x_marker']:format(menuTitle),
        menu = 'marker_management',
        options = menuOptions
    })
    lib.showContext('manage_marker')
end)

CreateCustomLift = function(position, data)
    local lift = {}
    local groundBool, groundZ = GetGroundZFor_3dCoord(position.x, position.y, position.z, false)
    local pos = vector3(position.x, position.y, groundZ)
    local heading = GetEntityHeading(player) - 180.0

    for i = 1, 2 do

        local model = nil
        if i == 1 then
            model = Config.Lift.Frame
        elseif i == 2 then 
            model = Config.Lift.Arms
        end

        local objCreated = false

        Lib.CreateObject(model, {x = pos.x, y = pos.y, z = pos.z}, heading, function(obj, networkId)
            FreezeEntityPosition(obj, true)
            SetEntityHeading(obj, heading)
            local objCoords = GetEntityCoords(obj)
            local objHeading = GetEntityHeading(obj)
            local objModel = GetEntityModel(obj)
            lift[model] = {
                coords = {x = Lib.RoundNumber(objCoords.x, 2), y = Lib.RoundNumber(objCoords.y, 2), z = Lib.RoundNumber(objCoords.z, 2)},
                heading = Lib.RoundNumber(objHeading, 2),
                model = objModel,
                netId = networkId
            }
            objCreated = true
        end, true)

        while not objCreated do 
            Wait(1)
        end
    end

    data.lifts[#data.lifts+1] = lift

    TriggerServerEvent('mechanicsystem:server:createLift', data)
end

RegisterNetEvent('mechanicsystem:client:disableShop', function(data)
    lib.registerContext({
        id = 'disable_enable_shop',
        title = Lang['title_admin_disable_shop'],
        canClose = false,
        menu = 'admin_manage_shop',
        options = {
            {
                title = Lang['title_admin_disable'],
                icon = 'ban',
                args = data,
                onSelect = function(args)
                    TriggerServerEvent('mechanicsystem:server:updateDisable', args, true)
                end
            },
            {
                title = Lang['title_admin_enable'],
                icon = 'check',
                args = data,
                onSelect = function(args)
                    TriggerServerEvent('mechanicsystem:server:updateDisable', args, false)
                end
            },
        },
    })
    lib.showContext('disable_enable_shop')
end)

RegisterNetEvent('mechanicsystem:client:deleteShop', function(data)
    lib.registerContext({
        id = 'admin_delete_shop',
        title = Lang['title_admin_delete_shop'],
        canClose = false,
        menu = 'admin_manage_shop',
        options = {
            {
                title = Lang['title_yes'],
                icon = 'check',
                args = data,
                onSelect = function(args)
                    TriggerServerEvent('mechanicsystem:server:deleteShop', args)
                end
            },
            {
                title = Lang['title_no'],
                icon = 'ban',
                args = data,
                event = 'mechanicsystem:client:manageShop'
            },
        },
    })
    lib.showContext('admin_delete_shop')
end)

RegisterNetEvent('mechanicsystem:client:addShopBlip')
AddEventHandler('mechanicsystem:client:addShopBlip', function(id, data)
    if shop_blips[id] ~= nil then
        if DoesBlipExist(shop_blips[id]) then
            RemoveBlip(shop_blips[id])
        end
    end
    shop_blips[id] = AddBlipForCoord(data.blip.coords.x, data.blip.coords.y, data.blip.coords.z)
    SetBlipSprite(shop_blips[id], data.blip.sprite)
    SetBlipDisplay(shop_blips[id], data.blip.display)
    SetBlipScale(shop_blips[id], data.blip.scale)
    SetBlipColour(shop_blips[id], data.blip.color)
    SetBlipAsShortRange(shop_blips[id], true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(data.name)
    EndTextCommandSetBlipName(shop_blips[id])
end)

RegisterNetEvent('mechanicsystem:client:removeShopBlip')
AddEventHandler('mechanicsystem:client:removeShopBlip', function(id)
    if shop_blips[id] ~= nil then
        if DoesBlipExist(shop_blips[id]) then
            RemoveBlip(shop_blips[id])
        end
    end
end)

if Config.Menu['mechanic'].command.enable then
    RegisterCommand(Config.Menu['mechanic'].command.string, function()
        MechanicActionMenu()
    end)
end

if Config.Menu['mechanic'].keybind.enable then
    RegisterCommand('mechanicMenu', function()
        MechanicActionMenu()
    end, false)
    RegisterKeyMapping('mechanicMenu', 'Open Mechanic Menu', 'keyboard', Config.Menu['mechanic'].keybind.defaultMapping)
end

body_report, inspecting, installingPart, usingCarJack = {}, false, false, false

MechanicActionMenu = function()
    if not IsPlayerMechanic() then 
        return 
    end

    local menu_options = {
        {title = Lang['title_billing'], icon = 'file-invoice-dollar', arrow = true, event = 'mechanicsystem:client:billing'},
        {title = Lang['title_npc_jobs'], icon = 'comment-dots', arrow = true, event = 'mechanicsystem:client:jobs_menu'},
    }

    if Config.Status.Menu.enable == true then 
        table.insert(menu_options, {title = Config.Status.Menu.label, icon = Config.Status.Menu.icon, arrow = true, onSelect = function() VehicleStatus() end})
    end
    
    if Config.Service.Menu.enable == true then 
        table.insert(menu_options, {title = Config.Service.Menu.label, icon = Config.Service.Menu.icon, arrow = true, onSelect = function() CheckService() end})
    end

    if Config.Diagnose.Menu.enable == true then 
        table.insert(menu_options, {title = Config.Diagnose.Menu.label, icon = Config.Diagnose.Menu.icon, arrow = true, onSelect = function() DiagnoseParts() end})
    end

    if Config.BodyRepair.Menu.enable == true then 
        table.insert(menu_options, {title = Config.BodyRepair.Menu.label, icon = Config.BodyRepair.Menu.icon, arrow = true, onSelect = function() BodyRepair() end})
    end

    if Config.PushVehicle.Enable == true then
        table.insert(menu_options, {title = Lang['title_push_vehicle'], icon = 'hand', onSelect = function() PushClosestVehicle() end})
    end
    
    if Config.FlipVehicle.Enable == true then
        table.insert(menu_options, {title = Lang['title_flip_vehicle'], icon = 'turn-up', onSelect = function() FlipClosestVehicle() end})
    end
    
    if Config.UnlockVehicle.Enable == true then
        table.insert(menu_options, {title = Lang['title_unlock_vehicle'], icon = 'unlock', onSelect = function() UnlockClosestVehicle() end})
    end
    
    if Config.ImpoundVehicle.Enable == true then
        table.insert(menu_options, {title = Lang['title_impound_vehicle'], icon = 'square-parking', onSelect = function() ImpoundClosestVehicle() end})
    end

    -- make sure to fix, Config.Debug 
    if next(body_report) ~= nil then 
        table.insert(menu_options, {title = Lang['title_body_reports'], icon = 'flag', arrow = true, event = 'mechanicsystem:client:viewBodyDamageReports'})
    end

    lib.registerContext({
        id = 'mechanic_menu',
        title = Lang['title_mechanic_menu'],
        options = menu_options
    })
    lib.showContext('mechanic_menu')
end

RegisterNetEvent('mechanicsystem:client:billing', function()
    lib.registerContext({
        id = 'billing_menu',
        title = Lang['title_billing'],
        onExit = function()
            MechanicActionMenu()
        end,
        menu = 'mechanic_menu',
        options = {
            {
                title = Lang['title_view_bills'],
                icon = 'receipt',
                arrow = true,
                event = 'mechanicsystem:client:viewBills'
            },
            {
                title = Lang['title_create_bill'],
                icon = 'file-invoice-dollar',
                arrow = true,
                onSelect = function()
                    local optionsArray = {}
                    local players = Lib.GetPlayersInArea(GetEntityCoords(PlayerPedId()), Config.InviteMember.Distance)
                    for i = 1, #players do
                        local playerId = GetPlayerServerId(players[i])
                        local fullName = Core.GetFullName(playerId)
                        local optionLabel = fullName..' ['..playerId..']'
                        if Config.InviteMember.ShowFullName == false then
                            optionLabel = '['..playerId..']'
                        end
                        table.insert(optionsArray, {label = optionLabel, value = playerId})
                    end
                    if next(optionsArray) == nil then
                        Core.Notification({
                            title = '',
                            message = Lang['no_players_nearby'],
                            type = 'inform'
                        })
                        return lib.showContext('billing_menu')
                    end
                    local input = lib.inputDialog(Lang['title_create_bill'], {
                        {type = 'select', label = Lang['input_label_bill_player'], description = Lang['input_desc_bill_player'], icon = 'person', options = optionsArray, required = true},
                        {type = 'number', label = Lang['input_label_bill_amount'], icon = 'dollar-sign', required = true, min = 1},
                        {type = 'textarea', label = Lang['input_label_bill_note'], description = Lang['input_desc_bill_note'], icon = 'note', autosize = true, required = true},
                        {type = 'date', label = Lang['input_label_bill_date'], icon = 'calendar', default = true, disabled = true},
                        {type = 'time', label = Lang['input_label_bill_time'], icon = 'clock', format = 24, default = true, disabled = true},
                    })

                    if not input or input == nil then
                        return MechanicActionMenu()
                    end

                    TriggerServerEvent('mechanicsystem:server:createBill', playerMechId, input)
                    Wait(100)
                    TriggerEvent('mechanicsystem:client:billing')
                end,
            },
        },
    })
    lib.showContext('billing_menu')
end)

RegisterNetEvent('mechanicsystem:client:viewBills', function()
    local menuOptions = {}
    Core.TriggerCallback('mechanicsystem:server:getBills', function(results)
        if next(results) ~= nil then
            for k,v in pairs(results) do
                table.insert(menuOptions, {
                    title = Lang['title_bill_overview']:format(v.id, v.amount, v.date, v.time),
                    icon = 'file-invoice-dollar',
                    description = v.note,
                    metadata = {
                        {label = Lang['meta_bill_ref'], value = v.id},
                        {label = Lang['meta_bill_shop'], value = v.shop},
                        {label = Lang['meta_bill_sender'], value = v.sender.name},
                        {label = Lang['meta_bill_receiver'], value = v.receiver.name},
                        {label = Lang['meta_bill_amount'], value = '$'..v.amount},
                        {label = Lang['meta_bill_date'], value = v.date},
                        {label = Lang['meta_bill_time'], value = v.time},
                    },
                })
            end
            lib.registerContext({
                id = 'view_bills',
                title = Lang['title_view_bills'],
                onExit = function()
                    MechanicActionMenu()
                end,
                menu = 'billing_menu',
                options = menuOptions,
            })
            lib.showContext('view_bills')
        else
            Core.Notification({
                title = '',
                message = Lang['no_bills_to_show'],
                type = 'inform'
            })
            return lib.showContext('billing_menu')
        end
    end, playerMechId)
end)

RegisterNetEvent('mechanicsystem:client:sendBill')
AddEventHandler('mechanicsystem:client:sendBill', function(shopId, input, playerSrc)
    lib.registerContext({
        id = 'pay_bill',
        title = Lang['title_bill_respond']:format(input[2]),
        canClose = false,
        options = {
            {
                title = Lang['title_yes'],
                icon = 'check',
                onSelect = function()
                    TriggerServerEvent('mechanicsystem:server:payBill', shopId, input, true, playerSrc)
                    Core.Notification({
                        title = '',
                        message = Lang['you_paid_a_bill']:format(input[2], mech_shops[shopId].name),
                        type = 'inform'
                    })
                end
            },
            {
                title = Lang['title_no'],
                icon = 'ban',
                onSelect = function()
                    TriggerServerEvent('mechanicsystem:server:payBill', shopId, input, false, playerSrc)
                    Core.Notification({
                        title = '',
                        message = Lang['you_declined_bill']:format(input[2], mech_shops[shopId].name),
                        type = 'inform'
                    })
                end
            },
        },
    })
    lib.showContext('pay_bill')
end)

local npc_job, cancel_job = {}, false
RegisterNetEvent('mechanicsystem:client:jobs_menu', function()
    local menuOptions = {
        {
            title = Config.BreakDowns.Label,
            icon = Config.BreakDowns.Icon,
            description = Config.BreakDowns.Description,
            onSelect = function()
                print("selected job: ", Config.BreakDowns.Label)
                GetBreakDownJob()
            end
        },
        {
            title = Config.RoadSideRepairs.Label,
            icon = Config.RoadSideRepairs.Icon,
            description = Config.RoadSideRepairs.Description,
            onSelect = function()
                GetRoadSideRepairJob()
            end
        },
        {
            title = Config.ScrapCars.Label,
            icon = Config.ScrapCars.Icon,
            description = Config.ScrapCars.Description,
            onSelect = function()
                GetScrapCarJob()
            end
        },
    }

    if next(npc_job) ~= nil then
        table.insert(menuOptions, {
            title = Lang['title_cancel_job'],
            icon = 'ban',
            description = Lang['desc_cancel_job'],
            onSelect = function()
                npc_job.cancel = true
            end
        })
    end

    lib.registerContext({
        id = 'select_job_type',
        title = Lang['title_select_job_type'],
        onExit = function()
            MechanicActionMenu()
        end,
        menu = 'mechanic_menu',
        options = menuOptions
        
    })
    lib.showContext('select_job_type')
end)

RegisterNetEvent('mechanicsystem:client:setJobsConfig')
AddEventHandler('mechanicsystem:client:setJobsConfig', function(type, cfg, num)
    if type == 'road_side_repairs' then
        Config.RoadSideRepairs.Jobs[num] = cfg
    elseif type == 'break_downs' then 
        Config.BreakDowns.Jobs[num] = cfg
    elseif type == 'scrap_cars' then 
        Config.ScrapCars.Jobs[num] = cfg
    end
end)

GetScrapCarJob = function()
    math.randomseed(GetGameTimer())
	local num = math.random(1, #Config.ScrapCars.Jobs)
	local distanceCheck = GetTravelDistance(Config.ScrapCars.Jobs[num].pos, Config.ScrapCars.TravelDistance)

	local count = 0
	while not distanceCheck and count < 100 do
		count = count + 1
		num = math.random(1, #Config.ScrapCars.Jobs)
		while Config.ScrapCars.Jobs[num].inUse and count < 100 do
			count = count + 1
			num = math.random(1, #Config.ScrapCars.Jobs)
		end
		distanceCheck = GetTravelDistance(Config.ScrapCars.Jobs[num].pos, Config.ScrapCars.TravelDistance)
	end

	if count == 100 then
        return Core.Notification({
            title = '',
            message = Lang['npc_job_none_available'],
            type = 'inform'
        })
	else
		Config.ScrapCars.Jobs[num].inUse = true
        npc_job = {type = 'scrap_cars', jobId = num, started = true}
		Wait(200)
        TriggerServerEvent('mechanicsystem:server:setJobsConfig', 'scrap_cars', Config.ScrapCars.Jobs[num], num)
        ScrapCarJob(num)
	end
end

ScrapCarJob = function(num)
    local complete = false
    local job = Config.ScrapCars.Jobs[num]

    local CreateDropOffMarker = function(pos)

        local NearbyDropOff = function(point)
            if point.currentDistance < 20.0 and npc_job.dropOffMessage == nil then 
                Core.Notification({
                    title = '',
                    message = Lang['job_scrapcar_park_inside_marker'],
                    type = 'inform'
                })
                npc_job.dropOffMessage = true
            end
            local mk = point.mk
            DrawMarker(mk.type, point.coords.x, point.coords.y, point.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale[1], mk.scale[2], mk.scale[3], mk.rgba[1], mk.rgba[2], mk.rgba[3], mk.rgba[4], false, false, 0, true, false, false, false)
            if point.isClosest and point.currentDistance < 20.0 then
                if not point.textUi then
                    point.textUi = true
                    lib.showTextUI(point.drawText)
                end

                local vehicleCoords = GetEntityCoords(npc_job.vehicle)
                local vehDist = #(vehicleCoords - vector3(pos.x, pos.y, pos.z))

                if not IsEntityAttachedToAnyVehicle(npc_job.vehicle) and vehDist < 3.0 and npc_job.detached == nil then
                    lib.hideTextUI()
                    point.remove(point)
                    Citizen.Wait(1000)
                    SetEntityCoords(npc_job.vehicle, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, false)
                    SetVehicleOnGroundProperly(npc_job.vehicle)
                    SetVehicleUndriveable(npc_job.vehicle, true)
                    if DoesBlipExist(npc_job.blip) then 
                        RemoveBlip(npc_job.blip)
                    end
                    npc_job.detached = true
                end
            elseif point.textUi then 
                point.textUi = false
                lib.hideTextUI()
            end
        end

        local groundBool, groundZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z, false)

        local marker = lib.points.new({
            coords = vector3(pos.x, pos.y, groundZ),
            distance = Config.ScrapCars.Actions['drop_off'].marker.distance,
            mk = {type = Config.ScrapCars.Actions['drop_off'].marker.type, scale = Config.ScrapCars.Actions['drop_off'].marker.scale, rgba = Config.ScrapCars.Actions['drop_off'].marker.rgba},
            drawText = Config.ScrapCars.Actions['drop_off'].textUi,
            textUi = false,
            nearby = NearbyDropOff
        })

    end

    local CreateCollectMarker = function(ped)

        local NearbyScrapNPC = function(point)
            if point.isClosest and point.currentDistance < 2.0 then
                if not point.textUi then
                    point.textUi = true
                    lib.showTextUI(point.drawText)
                end
                if IsControlJustReleased(0, point.keybind) then
                    point.remove(point)
                    lib.hideTextUI()

                    local taskAnim = Config.ScrapCars.Actions['collect'].anim
                    local progBar = Config.ScrapCars.Actions['collect'].progBar

                    if lib.progressBar({
                        duration = progBar.duration,
                        label = progBar.label,
                        useWhileDead = false,
                        canCancel = true,
                        anim = {
                            dict = taskAnim.dict,
                            clip = taskAnim.name,
                            flag = taskAnim.flag,
                            blendIn = taskAnim.blendIn,
                            blendOut = taskAnim.blendOut
                        },
                        disable = {
                            move = true,
                            combat = true
                        }
                    }) then
                        Core.Notification({
                            title = '',
                            message = Lang['job_scrapcar_thanking_msg'],
                            type = 'inform'
                        })

                        TriggerServerEvent('mechanicsystem:server:scrapReward', Config.ScrapCars.Reward)
                        local npc_pos = GetEntityCoords(ped)

                        ClearPedTasksImmediately(ped)
                        ClearAreaOfObjects(npc_pos.x, npc_pos.y, npc_pos.z, 2.0, 0)

                        DeleteEntity(npc_job.vehicle)
                        FreezeEntityPosition(ped, false)
                        SetBlockingOfNonTemporaryEvents(ped, true)
                        SetEntityInvincible(ped, true)
                        TaskGoToCoordAnyMeans(ped, Config.ScrapCars.Scrapyard.spawnPos.x, Config.ScrapCars.Scrapyard.spawnPos.y, Config.ScrapCars.Scrapyard.spawnPos.z, 1.0, 0, 0, 786603, 0xbf800000)
                        SetEntityHeading(ped, Config.ScrapCars.Scrapyard.spawnPos.w)
                        Citizen.Wait(5000)
                        DeleteEntity(ped)
                        npc_job.cancel = true
                        
                    end
                end
            elseif point.textUi then
                lib.hideTextUI()
                point.textUi = false
            end
        end
        
        local pedCoords = GetEntityCoords(ped)
        local marker = lib.points.new({
            coords = vector3(pedCoords.x, pedCoords.y, pedCoords.z),
            distance = 2.0,
            drawText = Config.ScrapCars.Actions['collect'].textUi,
            keybind = Config.ScrapCars.Actions['collect'].keybind,
            textUi = false,
            nearby = NearbyScrapNPC
        })
    end

    local CreatePedInteraction = function(ped)

        local NearbyPed = function(point)
            if point.isClosest and point.currentDistance < 2.0 then
                if not point.textUi then
                    point.textUi = true
                    lib.showTextUI(point.drawText)
                end
                if IsControlJustReleased(0, point.keybind) then
                    point.remove(point)
                    lib.hideTextUI()
                    RemoveBlip(npc_job.blip)

                    local scrapCFG = Config.ScrapCars.Scrapyard
                    
                    -- step 1:
                    FreezeEntityPosition(ped, false)
                    SetEntityInvincible(ped, true)
                    TaskGoToCoordAnyMeans(ped, scrapCFG.inspectPos.x, scrapCFG.inspectPos.y, scrapCFG.inspectPos.z, 1.0, 0, 0, 786603, 0xbf800000)
                    SetEntityHeading(ped, scrapCFG.inspectPos.w)
                    Wait(6000)

                    -- step 2:
                    FreezeEntityPosition(ped, true)
                    TaskStartScenarioInPlace(ped, scrapCFG.scenarios['work'], 0, false)
                    Wait(4000)

                    -- step 3:
                    CreateCollectMarker(ped)
                end
            elseif point.textUi then
                lib.hideTextUI()
                point.textUi = false
            end
        end
        
        local pedCoords = GetEntityCoords(ped)
        local marker = lib.points.new({
            coords = vector3(pedCoords.x, pedCoords.y, pedCoords.z),
            distance = 2,
            drawText = Config.ScrapCars.Actions['inspect'].textUi,
            keybind = Config.ScrapCars.Actions['inspect'].keybind,
            textUi = false,
            nearby = NearbyPed
        })

    end

    npc_job.blip = CreateJobBlip(job.pos, Config.ScrapCars)
    local dropPos = Config.ScrapCars.Scrapyard.dropoff

    while not complete do
        Wait(1)

        if job.inUse then

            if npc_job.startMessage == nil then
                Lib.AdvancedNotification('CHAR_TOW_TONYA', 'CHAR_TOW_TONYA', 6, 'TOW EMERGENCY CALL', false, '~y~GPS UPDATED~s~', Lang['job_scrapcar_start_msg'])
                npc_job.startMessage = true 
            end

			local job_distance = #(coords - vector3(job.pos[1], job.pos[2], job.pos[3]))

            if job_distance < 100.0 and npc_job.vehicle == nil then
				npc_job.vehicle = CreateJobVehicle(job.pos)
				SetEntityAsMissionEntity(npc_job.vehicle, true, true)
			end

            if npc_job.vehicle ~= nil and IsEntityAttachedToAnyVehicle(npc_job.vehicle) and npc_job.towing == nil then
				if DoesBlipExist(npc_job.blip) then RemoveBlip(npc_job.blip) end
                npc_job.towing = true
                if npc_job.pickupMessage == nil then
                    Lib.AdvancedNotification('CHAR_TOW_TONYA', 'CHAR_TOW_TONYA', 6, 'TOW EMERGENCY CALL', false, '~y~GPS UPDATED~s~', Lang['job_scrapcar_pickup_msg'])
                    npc_job.pickupMessage = true 
                else
                    Core.Notification({
                        title = '',
                        message = Lang['job_scrapcar_bring_veh'],
                        type = 'inform'
                    })
                end
                npc_job.blip = CreateJobBlip({dropPos.x, dropPos.y, dropPos.z}, Config.ScrapCars)
            end

            if npc_job.vehicle ~= nil and npc_job.towing ~= nil and npc_job.dropOffMessage == nil then
                if npc_job.towing == true and not IsEntityAttachedToAnyVehicle(npc_job.vehicle) then
                    if DoesBlipExist(npc_job.blip) then RemoveBlip(npc_job.blip) end
                    npc_job.towing = nil
                    local vehicleCoords = GetEntityCoords(npc_job.vehicle)
                    npc_job.blip = CreateJobBlip({vehicleCoords.x, vehicleCoords.y, vehicleCoords.z}, Config.ScrapCars)
                    Core.Notification({
                        title = '',
                        message = Lang['job_scrapcar_veh_dropped'],
                        type = 'inform'
                    })
                end
            end

            local job_dropoff_distance = #(coords - dropPos)

            if npc_job.towing ~= nil and job_dropoff_distance < 80.0 then
                if npc_job.dropOffMarker == nil then
                    CreateDropOffMarker(dropPos)
                    npc_job.dropOffMarker = true
                end
            end

            if npc_job.detached ~= nil and npc_job.ped == nil then
                local pedSpawn = Config.ScrapCars.Scrapyard.spawnPos
                npc_job.ped = CreateJobPed(Config.ScrapCars.Scrapyard.model, {x = pedSpawn.x, y = pedSpawn.y, z = pedSpawn.z}, pedSpawn.w, Config.ScrapCars.Scrapyard.scenarios['idle'])
				SetEntityAsMissionEntity(npc_job.ped, true, true)
                FreezeEntityPosition(npc_job.ped, true)
                SetBlockingOfNonTemporaryEvents(npc_job.ped, true)
                CreatePedInteraction(npc_job.ped)
            end

            if npc_job.cancel then
				if DoesEntityExist(npc_job.vehicle) then DeleteVehicle(npc_job.vehicle) end
				if DoesEntityExist(npc_job.ped) then DeleteEntity(npc_job.ped) end
				if DoesBlipExist(npc_job.blip) then RemoveBlip(npc_job.blip) end
                Config.ScrapCars.Jobs[num].inUse = false
                TriggerServerEvent('mechanicsystem:server:setJobsConfig', 'scrap_cars', Config.ScrapCars.Jobs[num], num)
                npc_job = {}
				break
            end

        end
    end
end

GetBreakDownJob = function()
    math.randomseed(GetGameTimer())
	local num = math.random(1, #Config.BreakDowns.Jobs)
	local distanceCheck = GetTravelDistance(Config.BreakDowns.Jobs[num].pos, Config.BreakDowns.TravelDistance)

	local count = 0
	while not distanceCheck and count < 100 do
		count = count + 1
		num = math.random(1, #Config.BreakDowns.Jobs)
		while Config.BreakDowns.Jobs[num].inUse and count < 100 do
			count = count + 1
			num = math.random(1, #Config.BreakDowns.Jobs)
		end
		distanceCheck = GetTravelDistance(Config.BreakDowns.Jobs[num].pos, Config.BreakDowns.TravelDistance)
	end

	if count == 100 then
        return Core.Notification({
            title = '',
            message = Lang['npc_job_none_available'],
            type = 'inform'
        })
	else
		Config.BreakDowns.Jobs[num].inUse = true
        npc_job = {type = 'break_downs', jobId = num, started = true}
		Wait(200)
        TriggerServerEvent('mechanicsystem:server:setJobsConfig', 'break_downs', Config.BreakDowns.Jobs[num], num)
        BreakDownJob(num)
	end
end

BreakDownJob = function(num)
    local complete = false
    local job = Config.BreakDowns.Jobs[num]

    npc_job.blip = CreateJobBlip(job.pos, Config.BreakDowns)

    local CreateInspectMarker = function(vehicle)
        local NearbyEngine = function(point)
            local mk = point.mk
            DrawMarker(mk.type, point.coords.x, point.coords.y, point.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale[1], mk.scale[2], mk.scale[3], mk.rgba[1], mk.rgba[2], mk.rgba[3], mk.rgba[4], false, false, 0, true, false, false, false)
            if point.isClosest and point.currentDistance < 1.2 then
                if not point.textUi then
                    point.textUi = true
                    lib.showTextUI(point.drawText)
                end
                if IsControlJustReleased(0, point.keybind) then
                    lib.hideTextUI()
                    RemoveBlip(npc_job.blip)
                    SetVehicleDoorOpen(vehicle, 4, 0, 0)
					Citizen.Wait(250)
                    SetEntityCoords(player, point.plyCoords.x, point.plyCoords.y, point.plyCoords.z, 0.0, 0.0, 0.0, false)
                    SetEntityHeading(player, point.heading)

                    if lib.progressBar({
                        duration = point.progBar.duration,
                        label = point.progBar.label,
                        useWhileDead = false,
                        canCancel = true,
                        anim = {
                            dict = point.anim.dict,
                            clip = point.anim.name,
                            flag = point.anim.flag,
                            blendIn = point.anim.blendIn,
                            blendOut = point.anim.blendOut
                        },
                        disable = {
                            move = true,
                            combat = true
                        }
                    }) then
                        point.remove(point)
                        npc_job.inspected = true
                        ClearPedTasks(player)
                        Wait(500)
                        Core.Notification({
                            title = '',
                            message = Lang['job_breakdown_attach_veh'],
                            type = 'inform'
                        })
                        SetVehicleDoorShut(vehicle, 4, 1, 1)
                        ClearPedTasks(player)
                    end
                end
            elseif point.textUi then 
                point.textUi = false
                lib.hideTextUI()
            end
        end

		local d1,d2 = GetModelDimensions(GetEntityModel(vehicle))
		local engineCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, (d2.y + 0.35), 0.0)
        local groundBool, groundZ = GetGroundZFor_3dCoord(engineCoords.x, engineCoords.y, engineCoords.z, false)

        local marker = lib.points.new({
            coords = vector3(engineCoords.x, engineCoords.y, engineCoords.z),
            plyCoords = vector3(engineCoords.x, engineCoords.y, groundZ),
            heading = (GetEntityHeading(vehicle) - 180.0),
            distance = Config.BreakDowns.Actions['inspect'].marker.distance,
            mk = {type = Config.BreakDowns.Actions['inspect'].marker.type, scale = Config.BreakDowns.Actions['inspect'].marker.scale, rgba = Config.BreakDowns.Actions['inspect'].marker.rgba},
            keybind = Config.BreakDowns.Actions['inspect'].keybind,
            drawText = Config.BreakDowns.Actions['inspect'].textUi,
            anim = Config.BreakDowns.Actions['inspect'].anim,
            progBar = Config.BreakDowns.Actions['inspect'].progBar,
            textUi = false,
            nearby = NearbyEngine
        })

    end

    local CreatePedTalkMarker = function(ped)

        local NearbyPed = function(point)
            if point.isClosest and point.currentDistance < 1.0 then
                if not point.textUi then
                    point.textUi = true
                    lib.showTextUI(point.drawText)
                end
                if IsControlJustReleased(0, point.keybind) then
                    npc_job.towtruck = GetEntityAttachedTo(npc_job.vehicle)

					if IsVehicleSeatFree(npc_job.towtruck, 0) then
                        lib.hideTextUI()
                        point.remove(point)
						ClearPedTasksImmediately(ped)
						FreezeEntityPosition(ped, false)
						TaskEnterVehicle(ped, npc_job.towtruck, 20000, 0, 1.0, 1, 0)
					else
                        Core.Notification({
                            title = '',
                            message = Lang['job_breakdown_seat_occupied'],
                            type = 'inform'
                        })
					end

					SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("NPC"))
					SetRelationshipBetweenGroups(0, GetHashKey("NPC"), GetHashKey("PLAYER"))
                    npc_job.talked = true
                end
            elseif point.textUi then 
                point.textUi = false
                lib.hideTextUI()
            end
        end

        local pedCoords = GetEntityCoords(ped)
        local marker = lib.points.new({
            coords = vector3(pedCoords.x, pedCoords.y, pedCoords.z),
            distance = Config.BreakDowns.Actions['npc_talk'].distance,
            keybind = Config.BreakDowns.Actions['npc_talk'].keybind,
            drawText = Config.BreakDowns.Actions['npc_talk'].textUi,
            textUi = false,
            nearby = NearbyPed
        })
    end

    local CreateDropOffMarker = function(pos)

        local NearbyDropOff = function(point)
            local mk = point.mk
            DrawMarker(mk.type, point.coords.x, point.coords.y, point.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale[1], mk.scale[2], mk.scale[3], mk.rgba[1], mk.rgba[2], mk.rgba[3], mk.rgba[4], false, false, 0, true, false, false, false)
            if point.isClosest and point.currentDistance < 10.0 then
                if npc_job.dropOffMessage == nil then 
                    Core.Notification({
                        title = '',
                        message = Lang['job_breakdown_park_inside_marker'],
                        type = 'inform'
                    })
                    npc_job.dropOffMessage = true
                end
                if not point.textUi then
                    point.textUi = true
                    lib.showTextUI(point.drawText)
                end

                local vehicleCoords = GetEntityCoords(npc_job.vehicle)
                local vehDist = #(vehicleCoords - vector3(job.dropoff[1], job.dropoff[2], job.dropoff[3]))

                if not IsEntityAttachedToAnyVehicle(npc_job.vehicle) and vehDist < 3.0 and npc_job.detached == nil then
                    Core.Notification({
                        title = '',
                        message = Lang['job_breakdown_collect_cash'],
                        type = 'inform'
                    })
                    lib.hideTextUI()
                    point.remove(point)
                    TaskLeaveVehicle(npc_job.ped, npc_job.towtruck, 0)
                    Citizen.Wait(3000)
                    TaskTurnPedToFaceEntity(npc_job.ped, npc_job.vehicle, 1.0)
                    Citizen.Wait(1000)
                    if DoesBlipExist(npc_job.blip) then 
                        RemoveBlip(npc_job.blip)
                    end
                    npc_job.detached = true
                end
            elseif point.textUi then 
                point.textUi = false
                lib.hideTextUI()
            end
        end

        local groundBool, groundZ = GetGroundZFor_3dCoord(pos[1], pos[2], pos[3], false)

        local marker = lib.points.new({
            coords = vector3(pos[1], pos[2], groundZ),
            distance = Config.BreakDowns.Actions['drop_off'].marker.distance,
            mk = {type = Config.BreakDowns.Actions['drop_off'].marker.type, scale = Config.BreakDowns.Actions['drop_off'].marker.scale, rgba = Config.BreakDowns.Actions['drop_off'].marker.rgba},
            drawText = Config.BreakDowns.Actions['drop_off'].textUi,
            textUi = false,
            nearby = NearbyDropOff
        })
    end

    while not complete do
        Wait(1)

        if job.inUse then

            if npc_job.alertCall == nil then
                Lib.AdvancedNotification('CHAR_TOW_TONYA', 'CHAR_TOW_TONYA', 6, 'TOW EMERGENCY CALL', false, '~r~BREAKDOWN~s~', Lang['job_breakdown_msg'])
                npc_job.alertCall = true 
            end

			local job_distance = #(coords - vector3(job.pos[1], job.pos[2], job.pos[3]))

            if job_distance < 100.0 and npc_job.vehicle == nil then
				npc_job.vehicle = CreateJobVehicle(job.pos)
				SetEntityAsMissionEntity(npc_job.vehicle, true, true)
			end

            if job_distance < 90.0 and npc_job.ped == nil then
                npc_job.ped = CreateJobPed(job.ped, {x = job.npc_pos[1], y = job.npc_pos[2], z = job.npc_pos[3]}, job.npc_pos[4], 'WORLD_HUMAN_STAND_IMPATIENT')
				SetEntityAsMissionEntity(npc_job.ped, true, true)
            end

            if job_distance < 10.0 and DoesEntityExist(npc_job.vehicle) and DoesEntityExist(npc_job.ped) then

                if job_distance < 6.0 and npc_job.pedShouted == nil then
                    Core.Notification({
                        title = '',
                        message = Lang['job_breakdown_shoutout'],
                        type = 'inform'
                    })
                    npc_job.pedShouted = true
                end
                
                if npc_job.inspectMarker == nil then
                    CreateInspectMarker(npc_job.vehicle)
                    npc_job.inspectMarker = true
                end

                if npc_job.inspected ~= nil and IsEntityAttachedToAnyVehicle(npc_job.vehicle) and npc_job.talkMarker == nil then 
                    CreatePedTalkMarker(npc_job.ped)
                    npc_job.talkMarker = true
                end

            end

            if IsEntityAttachedToAnyVehicle(npc_job.vehicle) and (npc_job.towtruck ~= nil and DoesEntityExist(npc_job.vehicle) and (GetPedInVehicleSeat(npc_job.towtruck, 0) == npc_job.ped)) then
                if npc_job.destination == nil then
                    if DoesBlipExist(npc_job.blip) then 
                        RemoveBlip(npc_job.blip)
                    end
                    npc_job.blip = CreateJobBlip(job.dropoff, Config.BreakDowns)
                    Core.Notification({
                        title = '',
                        message = Lang['job_breakdown_dropoff_msg'],
                        type = 'inform'
                    })
                    npc_job.destination = true
                end
            end

            local job_dropoff_distance = #(coords - vector3(job.dropoff[1], job.dropoff[2], job.dropoff[3]))

            if npc_job.destination ~= nil and job_dropoff_distance < 25.0 then
                if npc_job.dropOffMarker == nil then
                    CreateDropOffMarker(job.dropoff)
                    npc_job.dropOffMarker = true
                end
            end

            if npc_job.detached ~= nil and npc_job.collected == nil then
                local pedCoords = GetEntityCoords(npc_job.ped)
                local pedDistance = #(coords - pedCoords)
                if pedDistance < 5.0 then
                    Lib.Draw3DText(pedCoords.x, pedCoords.y, pedCoords.z, Config.BreakDowns.Actions['collect'].textUi)
                    if IsControlJustPressed(0, Config.BreakDowns.Actions['collect'].keybind) and pedDistance <= 1.0 then
                        local taskAnim = Config.BreakDowns.Actions['collect'].anim
                        local progBar = Config.BreakDowns.Actions['collect'].progBar
                        Lib.LoadAnim(taskAnim.dict)
                        TaskPlayAnim(npc_job.ped, taskAnim.dict, taskAnim.name, taskAnim.blendIn, taskAnim.blendOut, -1, taskAnim.flag, 1, 0, 0, 0)
                        if lib.progressBar({
                            duration = progBar.duration,
                            label = progBar.label,
                            useWhileDead = false,
                            canCancel = true,
                            anim = {
                                dict = taskAnim.dict,
                                clip = taskAnim.name,
                                flag = taskAnim.flag,
                                blendIn = taskAnim.blendIn,
                                blendOut = taskAnim.blendOut
                            },
                            disable = {
                                move = true,
                                combat = true
                            }
                        }) then
                            Core.Notification({
                                title = '',
                                message = Lang['job_breakdown_thanking_msg'],
                                type = 'inform'
                            })
                            if DoesBlipExist(npc_job.blip) then 
                                RemoveBlip(npc_job.blip)
                            end
                            TriggerServerEvent('mechanicsystem:server:jobPayout', job.payout)
                            ClearPedTasksImmediately(npc_job.ped)
                            TaskWanderStandard(npc_job.ped, 10.0, 10)
                            npc_job.collected = true
                            DeleteEntity(npc_job.vehicle)
                            Wait(10000)
                            if DoesEntityExist(npc_job.ped) then
                                SetEntityAsNoLongerNeeded(npc_job.ped)
                            end
                            npc_job.cancel = true
                            
                        end
                    end
                end
            end

            if npc_job.cancel then
				if DoesEntityExist(npc_job.vehicle) then DeleteVehicle(npc_job.vehicle) end
				if DoesEntityExist(npc_job.ped) then DeleteEntity(npc_job.ped) end
				if DoesBlipExist(npc_job.blip) then RemoveBlip(npc_job.blip) end
                Config.BreakDowns.Jobs[num].inUse = false
                TriggerServerEvent('mechanicsystem:server:setJobsConfig', 'break_downs', Config.BreakDowns.Jobs[num], num)
                npc_job = {}
				break
            end

        end
    end
end

GetRoadSideRepairJob = function()
    math.randomseed(GetGameTimer())
	local num = math.random(1, #Config.RoadSideRepairs.Jobs)
	local distanceCheck = GetTravelDistance(Config.RoadSideRepairs.Jobs[num].pos, Config.RoadSideRepairs.TravelDistance)

	local count = 0
	while not distanceCheck and count < 100 do
		count = count + 1
		num = math.random(1, #Config.RoadSideRepairs.Jobs)
		while Config.RoadSideRepairs.Jobs[num].inUse and count < 100 do
			count = count + 1
			num = math.random(1, #Config.RoadSideRepairs.Jobs)
		end
		distanceCheck = GetTravelDistance(Config.RoadSideRepairs.Jobs[num].pos, Config.RoadSideRepairs.TravelDistance)
	end

	if count == 100 then
        return Core.Notification({
            title = '',
            message = Lang['npc_job_none_available'],
            type = 'inform'
        })
	else
		Config.RoadSideRepairs.Jobs[num].inUse = true
        npc_job = {type = 'road_side_repairs', jobId = num, started = true}
		Wait(200)
        TriggerServerEvent('mechanicsystem:server:setJobsConfig', 'road_side_repairs', Config.RoadSideRepairs.Jobs[num], num)
        RoadSideRepairsJob(num)
	end
end

RoadSideRepairsJob = function(num)
    local complete = false
    local job = Config.RoadSideRepairs.Jobs[num]

    local CreateCashMarker = function(repairType)

        local NearbyCashMarker = function(point)
            local mk = point.mk
            DrawMarker(mk.type, point.coords.x, point.coords.y, point.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale[1], mk.scale[2], mk.scale[3], mk.rgba[1], mk.rgba[2], mk.rgba[3], mk.rgba[4], false, false, 0, true, false, false, false)
            if point.isClosest and point.currentDistance < 1.2 then
                if not point.textUi then
                    point.textUi = true
                    lib.showTextUI(point.drawText)
                end
                if IsControlJustReleased(0, point.keybind) then
                    point.remove(point)
                    lib.hideTextUI()
                    RollDownWindow(npc_job.vehicle, 0)
                    Lib.LoadAnim('mp_common')
                    TaskTurnPedToFaceEntity(player, npc_job.ped, 1.0)
                    Wait(1000)
                    TaskPlayAnim(player, 'mp_common', 'givetake2_a', 4.0, 4.0, -1, 0, 1, 0,0,0)
                    Wait(2000)
                    ClearPedTasks(player)
                    RollUpWindow(npc_job.vehicle, 0)
                    SetVehicleCanBeUsedByFleeingPeds(npc_job.vehicle, true)
                    Core.Notification({
                        title = '',
                        message = Lang['npc_job_complete'],
                        type = 'success'
                    })
                    TriggerServerEvent('mechanicsystem:server:jobPayout', job.payout)
                    Wait(500)
                    TaskVehicleDriveWander(npc_job.ped, npc_job.vehicle, 80.0, 786603)
                    Wait(3000)
                    TaskSmartFleePed(npc_job.ped, player, 40.0, 20000)
                    Wait(4000)
                    npc_job.cancel = true
                end
            elseif point.textUi then 
                point.textUi = false
                lib.hideTextUI()
            end
        end

        local d1,d2 = GetModelDimensions(GetEntityModel(npc_job.vehicle))
        local collectCoords = GetOffsetFromEntityInWorldCoords(npc_job.vehicle, (d1.x - 0.2), 0.0, 0.0)
        local pedCoords = GetEntityCoords(npc_job.ped)

        local marker = lib.points.new({
            coords = vector3(collectCoords.x, collectCoords.y, collectCoords.z),
            distance = Config.RoadSideRepairs.Marker.distance,
            type = repairType,
            mk = {type = Config.RoadSideRepairs.CollectCash.markerType, scale = Config.RoadSideRepairs.Marker.scale, rgba = Config.RoadSideRepairs.Marker.rgba},
            keybind = Config.RoadSideRepairs.CollectCash.keybind,
            drawText = Config.RoadSideRepairs.CollectCash.textUi,
            textUi = false,
            nearby = NearbyCashMarker
        })

    end

    local RepairCompleted = function(repairType)
        if lib.progressBar({
            duration = Config.RoadSideRepairs[repairType].progBar.duration,
            label = Config.RoadSideRepairs[repairType].progBar.label,
            useWhileDead = false,
            canCancel = true,
            anim = {
                dict = Config.RoadSideRepairs[repairType].anim.dict,
                clip = Config.RoadSideRepairs[repairType].anim.name,
                flag = Config.RoadSideRepairs[repairType].anim.flag,
                blendIn = Config.RoadSideRepairs[repairType].anim.blendIn,
                blendOut = Config.RoadSideRepairs[repairType].anim.blendOut
            },
            disable = {
                move = true,
                combat = true
            }
        }) then
            npc_job.vehicleFixed = true
            local item = Config.Items['kits'][Config.RoadSideRepairs[repairType].itemId]
            TriggerServerEvent('t1ger_lib:server:removeItem', item.name, 1)
            Core.Notification({
                title = '',
                message = Lang['npc_job_repair_done'],
                type = 'inform'
            })
            CreateCashMarker(repairType)
            return true
        else
            return false
        end
    end

    local CreateRepairMarker = function(vehicle)

        local types = {'fuel', 'tire', 'battery'}
        local repairType = types[math.random(#types)]
        
        Core.Notification({
            title = '',
            message = Config.RoadSideRepairs[repairType].message,
            type = 'inform'
        })

        local pointData = GetRepairPoint(repairType, vehicle)
        
        local NearbyMarker = function(point)
            local mk = point.mk
            DrawMarker(mk.type, point.coords.x, point.coords.y, point.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale[1], mk.scale[2], mk.scale[3], mk.rgba[1], mk.rgba[2], mk.rgba[3], mk.rgba[4], false, false, 0, true, false, false, false)
            if point.isClosest and point.currentDistance < 1.2 then
                if not point.textUi then
                    point.textUi = true
                    lib.showTextUI(point.drawText)
                end
                if IsControlJustReleased(0, point.keybind) then
                    lib.hideTextUI()
                    RemoveBlip(npc_job.blip)
                    local item = Config.Items['kits'][Config.RoadSideRepairs[point.type].itemId]
                    if item == nil then 
                        return print("item for repairtype: ", repairType, "does not exists...")
                    end
                    Core.HasItem(item.name, 1, function(hasItem)
                        if hasItem then
                            if point.type == 'fuel' then
                                local groundBool, groundZ = GetGroundZFor_3dCoord(point.coords.x, point.coords.y, point.coords.z, false)
                                SetEntityCoords(player, point.coords.x, point.coords.y, groundZ, 0.0, 0.0, 0.0, false)
                                SetEntityHeading(player, point.data.heading)
                                point.remove(point)
                                if RepairCompleted(point.type) then 
                                    SetVehicleFixed(vehicle)
                                end
                            elseif point.type == 'tire' then
                                BreakOffVehicleWheel(vehicle, point.data.wheelId, false, true, true, false)
                                local groundBool, groundZ = GetGroundZFor_3dCoord(point.coords.x, point.coords.y, point.coords.z, false)
                                SetEntityCoords(player, point.coords.x, point.coords.y, groundZ, 0.0, 0.0, 0.0, false)
                                SetEntityHeading(player, point.data.heading)
                                point.remove(point)
                                if RepairCompleted(point.type) then 
                                    SetVehicleFixed(vehicle)
                                end
                            elseif point.type == 'battery' then
                                SetVehicleDoorOpen(vehicle, 4, 0, 0)
                                local groundBool, groundZ = GetGroundZFor_3dCoord(point.coords.x, point.coords.y, point.coords.z, false)
                                SetEntityCoords(player, point.coords.x, point.coords.y, groundZ, 0.0, 0.0, 0.0, false)
                                SetEntityHeading(player, point.data.heading)
                                point.remove(point)
                                Wait(100)
                                if RepairCompleted(point.type) then 
                                    Wait(500)
                                    SetVehicleDoorShut(vehicle, 4, 1, 1)
                                end
                            end
                        else
                            point.textUi = false
                            Core.Notification({
                                title = '',
                                message = Lang['npc_job_missing_equipment']:format(item.label),
                                type = 'inform'
                            })
                        end
                    end)
                end
            elseif point.textUi then 
                point.textUi = false
                lib.hideTextUI()
            end
        end

        local attempts = 500
        while pointData == nil or next(pointData) == nil do 
            Wait(1)
            attempts = attempts - 1
            if attempts <= 0 then
                pointData = GetRepairPoint(repairType, vehicle)
                attempts = 500
            end
        end

        local marker = lib.points.new({
            coords = vector3(pointData.coords.x, pointData.coords.y, pointData.coords.z),
            data = pointData,
            heading = pointData.heading,
            distance = Config.RoadSideRepairs.Marker.distance,
            type = repairType,
            mk = {type = Config.RoadSideRepairs.Marker.type, scale = Config.RoadSideRepairs.Marker.scale, rgba = Config.RoadSideRepairs.Marker.rgba},
            keybind = Config.RoadSideRepairs.Keybind,
            drawText = Config.RoadSideRepairs.TextUi..' '..pointData.textUi,
            textUi = false,
            nearby = NearbyMarker
        })
    end

    npc_job.blip = CreateJobBlip(job.pos, Config.RoadSideRepairs)

    while not complete do
        Wait(1)

        if job.inUse then
			local job_distance = #(coords - vector3(job.pos[1], job.pos[2], job.pos[3]))

            if job_distance < 100.0 and npc_job.vehicle == nil then
				npc_job.vehicle = CreateJobVehicle(job.pos)
				SetEntityAsMissionEntity(npc_job.vehicle, true, true)
			end

            if job_distance < 50.0 and npc_job.ped == nil and (npc_job.vehicle ~= nil and DoesEntityExist(npc_job.vehicle)) then
                npc_job.ped = CreateJobPedInVehicle(job.ped, npc_job.vehicle)
				SetEntityAsMissionEntity(npc_job.ped, true, true)
            end

            if job_distance < 10.0 and DoesEntityExist(npc_job.vehicle) and DoesEntityExist(npc_job.ped) then
                if npc_job.repairMarker == nil then
                    CreateRepairMarker(npc_job.vehicle)
                    npc_job.repairMarker = true
                end
            end

            if npc_job.cancel then
				if DoesEntityExist(npc_job.vehicle) then DeleteVehicle(npc_job.vehicle) end
				if DoesEntityExist(npc_job.ped) then DeleteEntity(npc_job.ped) end
				if DoesBlipExist(npc_job.blip) then RemoveBlip(npc_job.blip) end
                Config.RoadSideRepairs.Jobs[num].inUse = false
                TriggerServerEvent('mechanicsystem:server:setJobsConfig', 'road_side_repairs', Config.RoadSideRepairs.Jobs[num], num)
                npc_job = {}
				break
            end

        end
    end
end

ImpoundClosestVehicle = function()
    if Config.ImpoundVehicle.Enable == false then 
        return 
    end
    local cfg = Config.ImpoundVehicle
	local coordA = GetEntityCoords(player, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, cfg.Dist, 0.0)
	local targetVeh, targetVehCoords = Lib.GetVehicleInDirection()
	local impounded = false
	if (DoesEntityExist(targetVeh) and IsEntityAVehicle(targetVeh)) then
		local d1,d2 = GetModelDimensions(GetEntityModel(targetVeh))
		local impound_pos = GetOffsetFromEntityInWorldCoords(targetVeh, d1.x-0.2,0.0,0.0)
		while not impounded do 
			Wait(1)
			local dist = #(coords - vector3(impound_pos.x, impound_pos.y, impound_pos.z))
			if dist < cfg.DrawText.dist then
				Lib.Draw3DText(impound_pos.x, impound_pos.y, impound_pos.z, cfg.DrawText.str)
				if IsControlJustPressed(0, cfg.DrawText.keybind) then 
					if dist <= cfg.DrawText.interactDist then
						TaskTurnPedToFaceEntity(player, targetVeh, 1.0)
						Wait(500)
						SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
						Wait(300)
                        if lib.progressBar({
                            duration = cfg.ProgBar.duration,
                            label = cfg.ProgBar.label,
                            useWhileDead = false,
                            canCancel = true,
                            anim = {
                                scenario = cfg.Scenario
                            },
                            disable = {
                                move = true,
                                combat = true
                            }
                        }) then
                            ClearPedTasks(player)
                            impounded = true
                            break
                        end
					else
                        Core.Notification({
                            title = '',
                            message = Lang['move_closer_to_interact'],
                            type = 'inform'
                        })
					end
				end
			end
		end
		local veh_props = Core.GetVehicleProperties(targetVeh)
        Core.ImpoundVehicle(targetVeh, veh_props.plate)
        Core.Notification({
            title = '',
            message = Lang['vehicle_impounded']:format(veh_props.plate),
            type = 'inform'
        })
	else
        Core.Notification({
            title = '',
            message = Lang['no_veh_nearby'],
            type = 'inform'
        })
        return MechanicActionMenu()
	end
end

UnlockClosestVehicle = function()
    if Config.UnlockVehicle.Enable == false then 
        return 
    end
    local cfg = Config.UnlockVehicle
	local coordA = GetEntityCoords(player, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, cfg.Dist, 0.0)
	local targetVeh, targetVehCoords = Lib.GetVehicleInDirection()
	local unlocked = false
	if (DoesEntityExist(targetVeh) and IsEntityAVehicle(targetVeh)) then
		local d1,d2 = GetModelDimensions(GetEntityModel(targetVeh))
		local unlockPos = GetOffsetFromEntityInWorldCoords(targetVeh, d1.x-0.2,0.0,0.0)
		while not unlocked do 
			Wait(1)
			local dist = #(coords - vector3(unlockPos.x, unlockPos.y, unlockPos.z))
			if dist < cfg.DrawText.dist then
				Lib.Draw3DText(unlockPos.x, unlockPos.y, unlockPos.z, cfg.DrawText.str)
				if IsControlJustPressed(0, cfg.DrawText.keybind) then 
					if dist <= cfg.DrawText.interactDist then
						Lib.LoadAnim(cfg.Anim.dict)
						TaskTurnPedToFaceEntity(player, targetVeh, 1.0)
						Wait(500)
						SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
						Wait(300)
                        if lib.progressBar({
                            duration = cfg.ProgBar.duration,
                            label = cfg.ProgBar.label,
                            useWhileDead = false,
                            canCancel = true,
                            anim = {
                                dict = cfg.Anim.dict,
                                clip = cfg.Anim.name,
                                flag = cfg.Anim.flag,
                                blendIn = cfg.Anim.blendIn,
                                blendOut = cfg.Anim.blendOut
                            },
                            disable = {
                                move = true,
                                combat = true
                            }
                        }) then
                            ClearPedTasks(player)
                            unlocked = true
                            break
                        end
					else
                        Core.Notification({
                            title = '',
                            message = Lang['move_closer_to_interact'],
                            type = 'inform'
                        })
					end
				end
			end
		end
		PlayVehicleDoorOpenSound(targetVeh, 0)
		SetVehicleDoorsLockedForAllPlayers(targetVeh, false)
		SetVehicleDoorsLocked(targetVeh, 1)
        Core.Notification({
            title = '',
            message = Lang['vehicle_unlocked'],
            type = 'inform'
        })
	else
        Core.Notification({
            title = '',
            message = Lang['no_veh_nearby'],
            type = 'inform'
        })
        return MechanicActionMenu()
	end
end

FlipClosestVehicle = function()
    if Config.FlipVehicle.Enable == false then 
        return 
    end
    local cfg = Config.FlipVehicle
	local coordA = GetEntityCoords(player, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, cfg.Dist, 0.0)
	local targetVeh, targetVehCoords = Lib.GetVehicleInDirection()
	local flipped = false 
	if (DoesEntityExist(targetVeh) and IsEntityAVehicle(targetVeh)) then
		local d1,d2 = GetModelDimensions(GetEntityModel(targetVeh))
		local flip_pos = GetOffsetFromEntityInWorldCoords(targetVeh, d1.x-0.2,0.0,0.0)
		while not flipped do 
			Wait(1)
			local dist = #(coords - vector3(flip_pos.x, flip_pos.y, flip_pos.z))
			if dist < cfg.DrawText.dist then
				Lib.Draw3DText(flip_pos.x, flip_pos.y, flip_pos.z, cfg.DrawText.str)
				if IsControlJustPressed(0, cfg.DrawText.keybind) then
					if dist <= cfg.DrawText.interactDist then
						TaskTurnPedToFaceEntity(player, targetVeh, 1.0)
						Wait(500)
						SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
						Wait(300)
                        if lib.progressBar({
                            duration = cfg.ProgBar.duration,
                            label = cfg.ProgBar.label,
                            useWhileDead = false,
                            canCancel = true,
                            anim = {
                                scenario = cfg.Scenario
                            },
                            disable = {
                                move = true,
                                combat = true
                            }
                        }) then
                            ClearPedTasks(player)
                            flipped = true
                            break
                        end
					else
                        Core.Notification({
                            title = '',
                            message = Lang['move_closer_to_interact'],
                            type = 'inform'
                        })
					end
				end
			end
		end
		SetVehicleOnGroundProperly(targetVeh)
	else
        Core.Notification({
            title = '',
            message = Lang['no_veh_nearby'],
            type = 'inform'
        })
        return MechanicActionMenu()
	end
end

local steer_angle = 0.0
PushClosestVehicle = function()
    if Config.PushVehicle.Enable == false then 
        return 
    end
	local cfg = Config.PushVehicle
	local coordA = GetEntityCoords(player, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, cfg.Dist, 0.0)
	local targetVeh, targetVehCoords = Lib.GetVehicleInDirection()
	local pushed = false 
	if (DoesEntityExist(targetVeh) and IsEntityAVehicle(targetVeh)) then
		local front = nil
		local new_dist = 0
		while not pushed do 
			Wait(1)
			local d1,d2 = GetModelDimensions(GetEntityModel(targetVeh))
			local rear_pos = GetOffsetFromEntityInWorldCoords(targetVeh, 0.0, d1.y - 0.25, 0.0)
			local front_pos = GetOffsetFromEntityInWorldCoords(targetVeh, 0.0, d2.y + 0.25, 0.0)
			local veh_pos = GetEntityCoords(targetVeh)
			local distance = #(coords - vector3(veh_pos.x, veh_pos.y, veh_pos.z))
			local dist_rear = #(coords - vector3(rear_pos.x, rear_pos.y, rear_pos.z))
			local dist_front = #(coords - vector3(front_pos.x, front_pos.y, front_pos.z))
			if distance < 5.0 then
				if dist_rear < cfg.DrawText.dist then
					Lib.Draw3DText(rear_pos.x, rear_pos.y, rear_pos.z + 0.4, cfg.DrawText.str1)
					Lib.Draw3DText(rear_pos.x, rear_pos.y, rear_pos.z + 0.30, cfg.DrawText.str2)
					front = false
					new_dist = dist_rear
				elseif dist_front < cfg.DrawText.dist then
					Lib.Draw3DText(front_pos.x, front_pos.y, front_pos.z + 0.4, cfg.DrawText.str1)
					Lib.Draw3DText(front_pos.x, front_pos.y, front_pos.z + 0.30, cfg.DrawText.str2)
					front = true
					new_dist = dist_front
				end
				if IsControlJustPressed(0, cfg.StopKey) then 
					steer_angle = 0.0 
					pushed = true
				end
				if IsControlPressed(0, cfg.PushKey) then
					if new_dist <= cfg.DrawText.interactDist then
						Lib.LoadAnim(cfg.Anim.dict)
						if front then    
							AttachEntityToEntity(player, targetVeh, GetPedBoneIndex(6286), 0.0, (d2.y + 0.25), (d1.z + 1.0), 0.0, 0.0, 180.0, false, false, false, true, false, true)
						else
							AttachEntityToEntity(player, targetVeh, GetPedBoneIndex(6286), 0.0, (d1.y - 0.25), (d1.z + 1.0), 0.0, 0.0, 0.0, false, false, false, true, false, true)
						end
						TaskPlayAnim(player, cfg.Anim.dict, cfg.Anim.lib, cfg.Anim.blendIn, cfg.Anim.blendOut, -1, cfg.Anim.flag, 1.0, 0, 0, 0)
						Wait(300)
						while true do
							Wait(1)
							Lib.DisplayHelpText(Config.PushVehicle.HelpText)
							
							if front then SetVehicleForwardSpeed(targetVeh, -0.80) else SetVehicleForwardSpeed(targetVeh, 0.80) end
							if HasEntityCollidedWithAnything(targetVeh) then SetVehicleOnGroundProperly(targetVeh) end

							local veh_speed = GetFrameTime() * 75
							if IsDisabledControlPressed(0, cfg.LeftKey) then
								SetVehicleSteeringAngle(targetVeh, steer_angle)
								steer_angle = steer_angle + veh_speed
							elseif IsDisabledControlPressed(0, cfg.RightKey) then
								SetVehicleSteeringAngle(targetVeh, steer_angle)
								steer_angle = steer_angle - veh_speed
							else
								SetVehicleSteeringAngle(targetVeh, steer_angle)
								if steer_angle < -0.7 then steer_angle = steer_angle + veh_speed
								elseif steer_angle > 0.7 then steer_angle = steer_angle - veh_speed
								else steer_angle = 0.0 end
							end

							if steer_angle > 25.0 then steer_angle = 25.0 elseif steer_angle < -25.0 then steer_angle = -25.0 end
		
							if not IsDisabledControlPressed(0, cfg.PushKey) then
								StopAnimTask(player, cfg.Anim.dict, cfg.Anim.lib, 2.0)
								DetachEntity(player, false, false)
								break
							end
						end
					else
                        Core.Notification({
                            title = '',
                            message = Lang['move_closer_to_interact'],
                            type = 'inform'
                        })
					end
				end
			end
		end
	else
        Core.Notification({
            title = '',
            message = Lang['no_veh_nearby'],
            type = 'inform'
        })
        return MechanicActionMenu()
	end
end

local towing = {inUse = false, truck = nil, target = nil}

if Config.FlatbedTowing.Enable == true then
    RegisterCommand(Config.FlatbedTowing.Command, function(source, args)
        if towing.inUse == false then 
            FlatbedTowVehicle()
        else
            towing.inUse = false
        end
    end, false)
end

FlatbedTowVehicle = function()
    if Config.FlatbedTowing.Enable == false then 
        return 
    end
    local cfg = Config.FlatbedTowing
	local towtruck = GetVehiclePedIsIn(player, false)
	if towtruck == 0 or towtruck == nil then
        towtruck, closestDist = Lib.GetClosestVehicle(coords, 3.0, false)
	end
	local complete = false
	if (DoesEntityExist(towtruck) and IsEntityAVehicle(towtruck)) then
		if GetEntityModel(towtruck) == GetEntityModel(towing.target) then 
			if GetLastDrivenVehicle() == towtruck then
				return Core.Notification({
                    title = '',
                    message = Lang['veh_not_towtruck'],
                    type = 'inform'
                })
			else
				towtruck = GetLastDrivenVehicle()
			end
		end
		if IsVehicleTowTruck(towtruck) then 
			towing.truck = towtruck
			towing.inUse = true
			while not complete do
				Wait(1)
				local sleep = true

				local d1,d2 = GetModelDimensions(GetEntityModel(towtruck))
				local truck_pos = GetOffsetFromEntityInWorldCoords(towtruck, (d1.x-0.05), (d1.y + 1.0), 0.0)
				local attach_point = GetOffsetFromEntityInWorldCoords(towtruck, 0.0, (d1.y - 3.0), 0.0)
				local distance = #(coords - vector3(truck_pos.x, truck_pos.y, truck_pos.z))

				if distance <= cfg.DrawText.dist then
					sleep = false

					if towing.target == nil then
						local attachDist = #(coords - vector3(attach_point.x, attach_point.y, attach_point.z))
						if attachDist < cfg.Marker.drawDist then 
							local mk = cfg.Marker
							DrawMarker(mk.type, attach_point.x, attach_point.y, attach_point.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
						end
						if distance <= cfg.DrawText.dist then 
							Lib.Draw3DText(truck_pos.x, truck_pos.y, truck_pos.z + 0.4, cfg.DrawText.attach)
						end
						if IsControlJustPressed(0, cfg.AttachKey) then 
							if distance <= cfg.InteractDist then
                                local targetVehicle, closestDistTargetVeh = Lib.GetClosestVehicle(attach_point, 2.0, false)
								if (DoesEntityExist(targetVehicle) and IsEntityAVehicle(targetVehicle)) then
									if VehicleIsBlacklisted(targetVehicle) then 
										return Core.Notification({
                                            title = '',
                                            message = Lang['pickup_blacklisted'],
                                            type = 'inform'
                                        })
									else
										local cfgTruck = k
										for k,v in pairs(cfg.Trucks) do 
											if IsVehicleModel(towtruck, k) then
												cfgTruck = k
												break
											end
										end
										local sk = cfg.Trucks[cfgTruck]
										AttachEntityToEntity(targetVehicle, towtruck, GetEntityBoneIndexByName(towtruck, sk.boneIndex_name), sk.offset[1], sk.offset[2], sk.offset[3], 0, 0, 0, 1, 1, 0, 1, 0, 1)
										towing.target = targetVehicle
										towing.inUse = false
										complete = true
									end
								else
                                    Core.Notification({
                                        title = '',
                                        message = Lang['park_pickup_marker'],
                                        type = 'inform'
                                    })
								end
							else
                                Core.Notification({
                                    title = '',
                                    message = Lang['move_closer_interact'],
                                    type = 'inform'
                                })
							end
						end
					else
						if distance <= cfg.DrawText.dist then 
							Lib.Draw3DText(truck_pos.x, truck_pos.y, truck_pos.z + 0.4, cfg.DrawText.detach)
						end
						if IsControlJustPressed(0, cfg.DetachKey) then
							if distance <= cfg.InteractDist then
								DetachEntity(towing.target)
								SetEntityCoords(towing.target, attach_point.x, attach_point.y, attach_point.z, 1, 0, 0, 1)
								SetVehicleOnGroundProperly(towing.target)
								towing.target = nil
								towing.inUse = false
								complete = true
							else
                                Core.Notification({
                                    title = '',
                                    message = Lang['move_closer_interact'],
                                    type = 'inform'
                                })
							end 
						end
					end
				end

				if distance > 20.0 then 
                    Core.Notification({
                        title = '',
                        message = Lang['towtruck_too_far'],
                        type = 'inform'
                    })
					complete = true
				end

				if towing.inUse == false then
					complete = true
				end

				if sleep then 
					Wait(500)
				end
			end
			towing.inUse = false
		else
            Core.Notification({
                title = '',
                message = Lang['towtruck_not_found'],
                type = 'inform'
            })
		end
    else
        Core.Notification({
            title = '',
            message = Lang['towtruck_not_found'],
            type = 'inform'
        })
	end
end

RegisterNetEvent('mechanicsystem:client:viewBodyDamageReports', function()
    local reports = {}
    for plate, data in pairs(body_report) do
        local displayName = GetDisplayNameFromVehicleModel(GetEntityModel(data.cache.entity))
        table.insert(reports, {
            title = Lang['title_body_report_plate']:format(displayName, data.cache.plate),
            icon = 'car',
            arrow = true,
            args = {plate = plate, data = data, title = Lang['title_body_report_plate']:format(displayName, data.cache.plate)},
            event = 'mechanicsystem:client:viewSelectedBodyDamageReport'
        })
    end
    lib.registerContext({
        id = 'body_damage_report_menu',
        title = Lang['title_body_reports'],
        onExit = function()
            MechanicActionMenu()
        end,
        menu = 'mechanic_menu',
        options = reports,
    })
    lib.showContext('body_damage_report_menu')
end)

RegisterNetEvent('mechanicsystem:client:viewSelectedBodyDamageReport', function(args)
    local report_data = {}
    for id, tb in pairs(args.data) do
        if next(tb) ~= nil and id ~= 'cache' then
            local menuIcon = ''
            if id == 'doors' then 
                menuIcon = 'https://i.ibb.co/gVmr95j/part-door.png'
            elseif id == 'windows' then
                menuIcon = 'https://i.ibb.co/T8v92PD/part-window.png'
            elseif id == 'wheels' then
                menuIcon = 'https://i.ibb.co/9bhCDwr/part-wheel.png'
            end
            local info = ''
            for k,v in pairs(tb) do
                if v.label ~= nil then
                    info = info..'\n'..v.label..' '
                end
            end
            table.insert(report_data, {
                title = Lib.FirstCharUpper(id),
                icon = menuIcon,
                description = Lang['desc_parts_to_install']..info
            })
        end
    end
    if next(report_data) == nil then
        Core.Notification({
            title = '',
            message = Lang['body_report_not_needed'],
            type = 'inform'
        })
        return TriggerEvent('mechanicsystem:client:viewBodyDamageReports')
    end
    lib.registerContext({
        id = 'view_body_damage_report',
        title = args.title,
        onExit = function()
            MechanicActionMenu()
        end,
        menu = 'body_damage_report_menu',
        options = report_data,
    })
    lib.showContext('view_body_damage_report')
end)

local usingMenu = false

Citizen.CreateThread(function()
    while true do
        Wait(1)
		local sleep = true
        if mech_shops ~= nil and next(mech_shops) then
            for id,shop in pairs(mech_shops) do
                if not shop.disabled then 
                    if playerMechId == shop.id or Core.GetJob().name == shop.job.name then
                        if shop.markers ~= nil and next(shop.markers) then
                            for k,marker in pairs(shop.markers) do
                                if marker ~= nil and next(marker) then
                                    local distance = #(coords - vector3(marker.coords.x, marker.coords.y, marker.coords.z))
                                    if distance < Config.Markers[k].renderDist and not usingMenu then
                                        if (k == 'duty' and playerMechId == shop.id) or (k == 'boss' and isMechanicBoss == true) or (k ~= 'duty' and k ~= 'boss' and IsPlayerMechanic()) then
                                            sleep = false
                                            if Config.Markers[k].showMarker and distance > Config.Markers[k].interactDist then
                                                DrawMarker(marker.type, marker.coords.x, marker.coords.y, marker.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.35, 0.35, 0.35, marker.color.r, marker.color.g, marker.color.b, marker.color.a, marker.bobUpAndDown, marker.faceCamera, 2)
                                            end
                                            if distance <= Config.Markers[k].interactDist then
                                                Lib.DisplayHelpText('~INPUT_PICKUP~ '..(k:gsub("^%l", string.upper)))
                                                if IsControlJustPressed(0, Config.Markers[k].keybind) then
                                                    usingMenu = true
                                                    AccessMarker(shop, k, marker)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
		if sleep then
            Wait(1000)
        end
	end
end)

AccessMarker = function(shop, type, marker)
    if type == 'garage' then 
        OpenGarage(shop, type, marker)
    elseif type == 'storage' then
        OpenStorage(shop, type, marker)
    elseif type == 'boss' then
        OpenBossMenu(shop, type, marker)
    elseif type == 'duty' then
        OpenDutyMenu(shop, type, marker)
    elseif type == 'repair' then
        QuickRepairVehicle(shop, type, marker)
    elseif type == 'workbench' then
        if Config.Workbench.Enable == true then
            OpenWorkbenchMenu(shop, type, marker)
        end
    end
end

OpenGarage = function(shop, type, marker)
    -- shop.id (id of the shop)
    -- marker.id (use this ID if u want or dont.)

    if Config.Markers[type].useBuiltInGarage == true then
        lib.registerContext({
            id = 'garage_menu',
            title = Lang['title_mech_garage'],
            onExit = function()
                usingMenu = false
            end,
            options = {
                {
                    title = Lang['title_garage_get_veh'],
                    icon = 'car',
                    args = {shop = shop, type = type, marker = marker},
                    event = 'mechanicsystem:client:getPlayerVehicles'
                },
                {
                    title = Lang['title_garage_store_veh'],
                    icon = 'square-parking',
                    onSelect = function()
                        local vehicle = GetVehiclePedIsIn(player, false)
                        if vehicle ~= 0 then 
                            local props = Core.GetVehicleProperties(vehicle)
                            Core.DeleteVehicle(vehicle)
                            TriggerServerEvent('t1ger_lib:server:updateOwnedVehicle', true, marker.id, props)
                        end
                        usingMenu = false
                    end,
                },
            },
        })
        lib.showContext('garage_menu')
    else
        -- add function for your garage here:
    end

end

RegisterNetEvent('mechanicsystem:client:getPlayerVehicles', function(data)
    local menuOptions = {}

    Core.TriggerCallback('mechanicsystem:server:getPlayerVehicles', function(results)
        if results and next(results) then
            for k, vehicle in pairs(results) do
                -- plate, props, type, job, stored, garage, impound, fuel, engine, body, model
                if vehicle.garage == nil or data.marker.id == vehicle.garage then
                    if vehicle.stored  == nil or (vehicle.stored == true or vehicle.stored == 1) then 
                        local props = json.decode(vehicle.props)
                        local name = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
                        local make = GetLabelText(GetMakeNameFromVehicleModel(props.model))
                        local metaOptions = {
                            {label = Lang['meta_veh_make'], value = make},
                            {label = Lang['meta_veh_model'], value = name},
                            {label = Lang['meta_veh_plate'], value = vehicle.plate},
                        }
                        if props.engineHealth ~= nil or vehicle.engine ~= nil then
                            table.insert(metaOptions, {label = Lang['meta_option_engine'], value = (props.engineHealth/10)..'%' or (props.engine/10)..'%'})
                        end
                        if props.bodyHealth ~= nil or vehicle.body ~= nil then
                            table.insert(metaOptions, {label = Lang['meta_option_body'], value = (props.bodyHealth/10)..'%' or (props.body/10)..'%'})
                        end
                        if props.fuelLevel ~= nil or vehicle.fuel ~= nil then
                            table.insert(metaOptions, {label = Lang['meta_option_fuel'], value = props.fuelLevel..'%' or vehicle.fuel..'%'})
                        end
                        table.insert(menuOptions, {
                            title = make..' '..name..' ['..vehicle.plate..']',
                            icon = 'car',
                            metadata = metaOptions,
                            args = {data, vehicle},
                            onSelect = function()
                                Core.SpawnVehicle(props.model, coords, GetEntityHeading(player), function(vehicle)
                                    Core.SetVehicleProperties(vehicle, props)
                                    SetPedIntoVehicle(player, vehicle, -1)
                                    TriggerServerEvent('t1ger_lib:server:updateOwnedVehicle', false, data.marker.id, props)
                                end, true)
                                usingMenu = false
                            end,
                        })
                    end
                end
            end
            if #menuOptions <= 0 then
                usingMenu = false
                return Core.Notification({
                    title = '',
                    message = Lang['no_owned_vehicles'],
                    type = 'inform'
                })
            end
            lib.registerContext({
                id = 'get_vehicles',
                title = Lang['title_garage_vehicles'],
                onExit = function()
                    usingMenu = false
                end,
                menu = 'garage_menu',
                options = menuOptions,
            })
            lib.showContext('get_vehicles')
        else
            Core.Notification({
                title = '',
                message = Lang['no_owned_vehicles'],
                type = 'inform'
            })
        end
    end)
end)

OpenStorage = function(shop, type, marker)
    local storage = marker.storage
    if Cfg.Inventory == 'default' and Framework == 'ESX' then
        lib.registerContext({
            id = 'storage_menu',
            title = Lang['title_storage'],
            onExit = function()
                usingMenu = false
            end,
            options = {
                {
                    title = Lang['title_withdraw_storage'],
                    description = Lang['desc_withdraw_storage'],
                    icon = 'minus',
                    arrow = true,
                    args = shop,
                    onSelect = function()
                        Core.TriggerCallback('mechanicsystem:server:getStorage', function(results)
                            if next(results) ~= nil then
                                local menuOptions = {}
                                for k,v in pairs(results) do
                                    table.insert(menuOptions, {
                                        title = v.label..' ['..v.count..'x]',
                                        icon = 'plus',
                                        args = v,
                                        onSelect = function()
                                            local input = lib.inputDialog('Withdraw: '..v.label..' ['..v.count..'x]', {
                                                {type = 'number', label = Lang['input_storage_withdraw_amount'], min = 1, max = v.count, icon = 'bars', placeholder = 100}
                                            })
                        
                                            if not input then
                                                return lib.showContext('storage_withdraw')
                                            end
                        
                                            if input[1] == nil or input[1] == '' or input[1] == ' ' then
                                                Core.Notification({
                                                    title = '',
                                                    message = Lang['input_required'],
                                                    type = 'error'
                                                })
                                                return lib.showContext('storage_withdraw')
                                            end
                        
                                            if input[1] <= 0 then 
                                                Core.Notification({
                                                    title = '',
                                                    message = Lang['input_amount_higher_0'],
                                                    type = 'error'
                                                })
                                                return lib.showContext('storage_withdraw')
                                            end

                                            v.count = (v.count - input[1])
                                            if v.count <= 0 then
                                                table.remove(results, k)
                                            end

                                            TriggerServerEvent('mechanicsystem:server:updateStorage', shop.id, results, 'withdraw', v.name, input[1])
                                            Wait(100)
                                            OpenStorage(shop, type, marker)
                                        end,
                                    })
                                end
                                lib.registerContext({
                                    id = 'storage_withdraw',
                                    title = Lang['title_withdraw_storage'],
                                    onExit = function()
                                        usingMenu = false
                                    end,
                                    menu = 'storage_menu',
                                    options = menuOptions,
                                })
                                lib.showContext('storage_withdraw')
                            else
                                Core.Notification({
                                    title = '',
                                    message = Lang['storage_empty'],
                                    type = 'inform'
                                })
                                return OpenStorage(shop, type, marker)
                            end
                        end, shop)
                    end,
                },
                {
                    title = Lang['title_deposit_storage'],
                    description = Lang['desc_deposit_storage'],
                    icon = 'plus',
                    arrow = true,
                    args = shop,
                    onSelect = function()
                        Core.TriggerCallback('t1ger_lib:getPlayerInventory', function(results)
                            if next(results) ~= nil then
                                local menuOptions = {}
                                for k,v in pairs(results) do
                                    table.insert(menuOptions, {
                                        title = v.label..' ['..v.count..'x]',
                                        icon = 'minus',
                                        args = v,
                                        onSelect = function()
                                            local input = lib.inputDialog('Deposit: '..v.label..' ['..v.count..'x]', {
                                                {type = 'number', label = Lang['input_storage_deposit_amount'], min = 1, max = v.count, icon = 'bars', placeholder = 100}
                                            })
                        
                                            if not input then
                                                return lib.showContext('storage_deposit')
                                            end
                        
                                            if input[1] == nil or input[1] == '' or input[1] == ' ' then
                                                Core.Notification({
                                                    title = '',
                                                    message = Lang['input_required'],
                                                    type = 'error'
                                                })
                                                return lib.showContext('storage_deposit')
                                            end
                        
                                            if input[1] <= 0 then 
                                                Core.Notification({
                                                    title = '',
                                                    message = Lang['input_amount_higher_0'],
                                                    type = 'error'
                                                })
                                                return lib.showContext('storage_deposit')
                                            end

                                            Core.TriggerCallback('mechanicsystem:server:getStorage', function(shop_storage)
                                                shop.storage = shop_storage
                                                local match = false
                                                if next(shop.storage) ~= nil then
                                                    for id,item in pairs(shop.storage) do
                                                        if item.name == v.name then
                                                            match = true
                                                            item.count = (item.count + input[1])
                                                            break
                                                        end
                                                    end
                                                    if match == false then
                                                        table.insert(shop.storage, {name = v.name, label = v.label, count = input[1], info = v.info})
                                                    end
                                                else
                                                    table.insert(shop.storage, {name = v.name, label = v.label, count = input[1], info = v.info})
                                                end

                                                TriggerServerEvent('mechanicsystem:server:updateStorage', shop.id, shop.storage, 'deposit', v.name, input[1])
                                                Wait(100)
                                                OpenStorage(shop, type, marker)
                                            end, shop)
                                        end,
                                    })
                                end
                                lib.registerContext({
                                    id = 'storage_deposit',
                                    title = Lang['title_deposit_storage'],
                                    onExit = function()
                                        usingMenu = false
                                    end,
                                    menu = 'storage_menu',
                                    options = menuOptions,
                                })
                                lib.showContext('storage_deposit')
                            else
                                Core.Notification({
                                    title = '',
                                    message = Lang['your_inventory_empty'],
                                    type = 'inform'
                                })
                                return OpenStorage(shop, type, marker)
                            end
                        end)
                    end,
                },
            },
        })
        lib.showContext('storage_menu')
    else
        Core.OpenStash(storage.id, storage.label, storage.slots, storage.weight, storage.owner)
        usingMenu = false
    end
end

OpenBossMenu = function(shop, type, marker)
    lib.registerContext({
        id = 'mech_boss_menu',
        title = Lang['title_boss_menu'],
        onExit = function()
            usingMenu = false
        end,
        options = {
            {title = Lang['title_mech_account'], icon = 'sack-dollar', arrow = true, args = shop, event = 'mechanicsystem:client:account'},
            {title = Lang['title_mech_employees'], icon = 'people-group', arrow = true, args = shop, event = 'mechanicsystem:client:employees'},
        },
    })
    lib.showContext('mech_boss_menu')
end

RegisterNetEvent('mechanicsystem:client:account', function(data)
    Core.TriggerCallback('mechanicsystem:server:getAccount', function(account)
        data.account = account
        lib.registerContext({
            id = 'mech_account',
            title = Lang['title_mech_account'],
            onExit = function()
                usingMenu = false
            end,
            menu = 'mech_boss_menu',
            options = {
                {
                    title = Lang['title_account_balance'],
                    icon = 'sack-dollar',
                    description = '$'..data.account,
                },
                {
                    title = Lang['title_account_deposit'],
                    icon = 'money-bill-trend-up',
                    onSelect = function()
                        local input = lib.inputDialog(Lang['title_mech_account'], {
                            {type = 'input', label = Lang['input_account_cur_balance'], icon = 'sack-dollar', disabled = true, default = data.account},
                            {type = 'number', label = Lang['input_account_deposit_amount'], icon = 'money-bill-trend-up', placeholder = 100}
                        })
    
                        if not input then
                            return TriggerEvent('mechanicsystem:client:account', data)
                        end
    
                        if input[2] == nil or input[2] == '' or input[2] == ' ' then
                            Core.Notification({
                                title = '',
                                message = Lang['input_required'],
                                type = 'error'
                            })
                            return TriggerEvent('mechanicsystem:client:account', data)
                        end
    
                        if input[2] <= 0 then 
                            Core.Notification({
                                title = '',
                                message = Lang['input_amount_higher_0'],
                                type = 'error'
                            })
                            return TriggerEvent('mechanicsystem:client:account', data)
                        end
    
                        TriggerServerEvent('mechanicsystem:server:updateAccount', true, data.id, data.account, input[2])
                        Wait(100)
                        TriggerEvent('mechanicsystem:client:account', data)
                    end,
                },
                {
                    title = Lang['title_account_withdraw'],
                    icon = "money-bill-transfer",
                    onSelect = function()
                        local input = lib.inputDialog(Lang['title_mech_account'], {
                            {type = "input", label = Lang['input_account_cur_balance'], icon = 'sack-dollar', disabled = true, default = data.account},
                            {type = "number", label = Lang['input_account_withdraw_amount'], icon = 'money-bill-transfer', placeholder = 50}
                        })
    
                        if not input then
                            return TriggerEvent('mechanicsystem:client:account', data)
                        end
    
                        if input[2] == nil or input[2] == '' or input[2] == ' ' then
                            Core.Notification({
                                title = '',
                                message = Lang['input_required'],
                                type = 'error'
                            })
                            return TriggerEvent('mechanicsystem:client:account', data)
                        end
    
                        if input[2] <= 0 then 
                            Core.Notification({
                                title = '',
                                message = Lang['input_amount_higher_0'],
                                type = 'error'
                            })
                            return TriggerEvent('mechanicsystem:client:account', data)
                        end
    
                        if input[2] > data.account then
                            Core.Notification({
                                title = '',
                                message = Lang['account_withdraw_max'],
                                type = 'error'
                            })
                            return TriggerEvent('mechanicsystem:client:account', data)
                        end
    
                        TriggerServerEvent('mechanicsystem:server:updateAccount', false, data.id, data.account, input[2])
                        Wait(100)
                        TriggerEvent('mechanicsystem:client:account', data)
                    end,
                },
            },
        })
        lib.showContext('mech_account')
    end, data.id)
end)

RegisterNetEvent('mechanicsystem:client:employees', function(data)
    lib.registerContext({
        id = 'mech_employees',
        title = Lang['title_mech_employees'],
        onExit = function()
            usingMenu = false
        end,
        menu = 'mech_boss_menu',
        options = {
            {
                title = Lang['title_manage_employees'],
                icon = 'people-group',
                description = Lang['desc_manage_employees'],
                arrow = true, 
                args = data,
                event = 'mechanicsystem:client:manageEmployees',
            },
            {
                title = Lang['title_recruit_employees'],
                icon = 'paper-plane',
                arrow = true, 
                args = data,
                event = 'mechanicsystem:client:recruitEmployees',
            },
        },
    })
    lib.showContext('mech_employees')
end)

RegisterNetEvent('mechanicsystem:client:manageEmployees', function(data)
    Core.TriggerCallback('mechanicsystem:server:getEmployees', function(employees)
        data.employees = employees
        local menuOptions = {}
        for k,v in pairs(data.employees) do
            table.insert(menuOptions, {
                title = v.name,
                icon = 'user',
                args = {player = v, shop = data},
                metadata = {
                    {label = Lang['meta_job_grade'], value = v.job_grade.label},
                    {label = Lang['meta_identifier'], value = v.identifier},
                },
                arrow = true,
                event = 'mechanicsystem:client:manageThisEmployee',
            })
        end
        lib.registerContext({
            id = 'manage_employees',
            title = Lang['title_manage_employees'],
            onExit = function()
                usingMenu = false
            end,
            menu = 'mech_employees',
            options = menuOptions,
        })
        lib.showContext('manage_employees')
    end, data.id)
end)

RegisterNetEvent('mechanicsystem:client:manageThisEmployee', function(data)
    local menuOptions = {}

    table.insert(menuOptions, {
        title = Lang['title_fire_employee'],
        icon = 'ban',
        description = Lang['desc_fire'],
        args = data,
        onSelect = function()
            if data.player.identifier == data.shop.boss then
                Core.Notification({
                    title = '',
                    message = Lang['cannot_fire_boss'],
                    type = 'error'
                })
                return TriggerEvent('mechanicsystem:client:manageThisEmployee', data)
            else
                for k,v in pairs(data.shop.employees) do
                    if data.player.identifier == v.identifier then
                        TriggerServerEvent('t1ger_lib:server:setJobOnIdentifier', 'unemployed', 0, data.player.identifier)
                        Core.Notification({
                            title = '',
                            message = Lang['fired_employee']:format(data.player.name),
                            type = 'error'
                        })
                        table.remove(data.shop.employees, k)
                        break
                    end
                end
            end
            TriggerServerEvent('mechanicsystem:server:updateEmployees', data.shop.id, data.shop.employees)
            Wait(100)
            TriggerEvent('mechanicsystem:client:manageEmployees', data.shop)
        end,
    })

    table.insert(menuOptions, {title = Lang['title_promote_emplotee'], icon = 'wrench', description = Lang['desc_promote'], args = data, event = 'mechanicsystem:client:promoteEmployee'})

    lib.registerContext({
        id = 'manage_this_employee',
        title = data.player.name,
        onExit = function()
            usingMenu = false
        end,
        menu = 'manage_employees',
        options = menuOptions,
    })
    lib.showContext('manage_this_employee')
end)

RegisterNetEvent('mechanicsystem:client:promoteEmployee', function(data)
    local menuOptions = {}
    for k,v in pairs(data.shop.job.grades) do
        if v.isboss == nil or (v.isboss ~= nil and v.isboss == false) then
            if data.player.job_grade.grade ~= v.grade then 
                table.insert(menuOptions, {
                    title = v.label,
                    metadata = {
                        {label = Lang['meta_job_grade'], value = v.grade},
                        {label = Lang['meta_job_name'], value = v.name},
                    },
                    onSelect = function()
                        if data.player.identifier == data.shop.boss then
                            Core.Notification({
                                title = '',
                                message = Lang['cannot_demote_boss'],
                                type = 'error'
                            })
                            return TriggerEvent('mechanicsystem:client:manageThisEmployee', data)
                        else
                            for _,y in pairs(data.shop.employees) do
                                if data.player.identifier == y.identifier then
                                    y.job_grade = {name = v.name, label = v.label, grade = v.grade}
                                    TriggerServerEvent('t1ger_lib:server:setJobOnIdentifier', data.shop.job.name, v.grade, data.player.identifier)
                                    Core.Notification({
                                        title = '',
                                        message = Lang['employee_grade_updated']:format(data.player.name),
                                        type = 'success'
                                    })
                                    break
                                end
                            end
                        end
                        TriggerServerEvent('mechanicsystem:server:updateEmployees', data.shop.id, data.shop.employees)
                        Wait(100)
                        TriggerEvent('mechanicsystem:client:manageEmployees', data.shop)
                    end,
                })
            end
        end
    end
    lib.registerContext({
        id = 'promote_employee',
        title = data.player.name,
        onExit = function()
            usingMenu = false
        end,
        menu = 'manage_employees',
        options = menuOptions,
    })
    lib.showContext('promote_employee')
end)

RegisterNetEvent('mechanicsystem:client:recruitEmployees', function(data)
    local menuOptions = {}
    local players = Lib.GetPlayersInArea(GetEntityCoords(PlayerPedId()), Config.InviteMember.Distance)
    for i = 1, #players do
        local fullName = Core.GetFullName(GetPlayerServerId(players[i]))
        local menuTitle = fullName..' ['..GetPlayerServerId(players[i])..']'
        if Config.InviteMember.ShowFullName == false then
            menuTitle = '['..GetPlayerServerId(players[i])..']'
        end
        table.insert(menuOptions, {
            title = menuTitle,
            icon = 'user',
            description = Lang['desc_recruit_employee'],
            args = {name = fullName, serverId = GetPlayerServerId(players[i])},
            onSelect = function(args)
                TriggerServerEvent('mechanicsystem:server:tryRecruit', data, args)
                TriggerEvent('mechanicsystem:client:employees', data)
            end,
        })
    end
    if #menuOptions <= 0 then
        Core.Notification({
            title = '',
            message = Lang['no_players_nearby'],
            type = 'error'
        })
        return TriggerEvent('mechanicsystem:client:employees', data)
    end
    lib.registerContext({
        id = 'recruit_employee',
        title = Lang['title_recruit_employees'],
        menu = 'mech_employees',
        onExit = function()
            usingMenu = false
        end,
        onBack = function()
            TriggerEvent('mechanicsystem:client:employees', data)
        end,
        options = menuOptions,
    })
    lib.showContext('recruit_employee')
end)

RegisterNetEvent('mechanicsystem:client:sendRecruitment')
AddEventHandler('mechanicsystem:client:sendRecruitment', function(data, args, playerSrc)
    lib.registerContext({
        id = 'shop_recruitment',
        title = Lang['title_accept_recruitment']:format(data.name),
        canClose = false,
        options = {
            {
                title = Lang['title_yes'],
                icon = 'check',
                onSelect = function()
                    TriggerServerEvent('mechanicsystem:server:recruitmentRespond', data, args, true, playerSrc)
                    Core.Notification({
                        title = '',
                        message = Lang['recruitment_accepted'],
                        type = 'success'
                    })
                end
            },
            {
                title = Lang['title_no'],
                icon = 'ban',
                onSelect = function()
                    TriggerServerEvent('mechanicsystem:server:recruitmentRespond', data, args, false, playerSrc)
                    Core.Notification({
                        title = '',
                        message = Lang['recruitment_declined'],
                        type = 'inform'
                    })
                end
            },
        },
    })
    lib.showContext('shop_recruitment')
end)

OpenDutyMenu = function(shop, type, marker)
    if Framework == 'ESX' then
        TriggerServerEvent('mechanicsystem:server:toggleDuty', shop)
    elseif Framework == 'QB' then
        Core.ToggleDuty()
    end
    usingMenu = false
end

QuickRepairVehicle = function(shop, type, marker)
    local vehicle = GetVehiclePedIsIn(player, false)
    local canQuickRepair, proceed = false, false
    local health = {}
    health.body = GetVehicleBodyHealth(vehicle)
    health.engine = GetVehicleEngineHealth(vehicle)
    
    if health.body >= 1000.0 and health.engine >= 1000.0 then
        usingMenu = false
        return Core.Notification({
            title = '',
            message = Lang['vehicle_functional'],
            type = 'inform'
        })
    end

    if not Config.Markers['repair'].settings.allow then
        Core.TriggerCallback('mechanicsystem:server:getOnlineMechanics', function(count)
            if count <= 0 then 
                canQuickRepair = true
                proceed = true
            else
                proceed = true
                usingMenu = false
                return Core.Notification({
                    title = '',
                    message = Lang['mechanics_online'],
                    type = 'inform'
                })
            end
        end, shop.id)
    else
        canQuickRepair = true
        proceed = true
    end

    while not proceed do
        Wait(10)
        if not usingMenu then 
            return
        end
    end

    if vehicle == 0 then 
        usingMenu = false
        return Core.Notification({
            title = '',
            message = Lang['must_be_in_vehicle'],
            type = 'inform'
        })
    else
        canQuickRepair = true
    end

    if canQuickRepair then
        Core.TriggerCallback('t1ger_lib:getMoney', function(money)
            if money >= Config.Markers['repair'].settings.price then 
                SetVehicleUndriveable(vehicle, true)
                SetVehicleEngineOn(vehicle, false, true, true)
                FreezeEntityPosition(vehicle, true)
                if lib.progressBar({
                    duration = Config.Markers['repair'].settings.duration,
                    label = Config.Markers['repair'].settings.progressLabel,
                    useWhileDead = false,
                    canCancel = true
                }) then
                    SetVehicleEngineHealth(vehicle, 1000.0)
                    SetVehicleBodyHealth(vehicle, 1000.0)
                    SetVehicleFixed(vehicle)
                    Core.Notification({
                        title = '',
                        message = Lang['vehicle_quick_repaired']:format(Config.Markers['repair'].settings.price),
                        type = 'inform'
                    })
                    TriggerServerEvent('mechanicsystem:server:payQuickRepair', shop.id, Config.Markers['repair'].settings.price)
                end
                SetVehicleUndriveable(vehicle, false)
                FreezeEntityPosition(vehicle, false)
                SetVehicleEngineOn(vehicle, true, true, true)
                usingMenu = false
            else
                usingMenu = false
                return Core.Notification({
                    title = '',
                    message = Lang['not_enough_money'],
                    type = 'error'
                })
            end
        end)
    end
end

OpenWorkbenchMenu = function(shop, type, marker)
    if Config.Workbench.Enable == false then
        return
    end
    local categories = {}
    for category, cat in pairs(Config.Workbench.Categories) do
        table.insert(categories, {
            title = cat.label,
            description = cat.description,
            icon = cat.icon,
            args = cat.recipe,
            onSelect = function(args)
                local recipes = {}
                for k,v in pairs(args) do
                    local metaOptions = {}
                    for item, amount in pairs(v.materials) do
                        table.insert(metaOptions, {
                            label = GetLabelFromItemName(item, 'materials'),
                            value = amount..'x'
                        })
                    end
                    table.insert(recipes, {
                        title = v.menuTitle,
                        icon = v.icon,
                        metadata = metaOptions,
                        args = v.materials,
                        onSelect = function(args)
                            local requiredItems, i = {}, 1
                            for k,v in pairs(args) do 
                                requiredItems[i] = {name = k, amount = v, label = GetLabelFromItemName(k, 'materials')}
                                i = i + 1
                            end
                            if HasMaterials(requiredItems) then
                                local success = false
                                if Config.Workbench.SkillCheck.enable == true then
                                    success = lib.skillCheck(Config.Workbench.SkillCheck.difficulty, Config.Workbench.SkillCheck.inputs)
                                else
                                    success = true 
                                end
                                if success then
                                    if lib.progressBar({
                                        duration = Config.Workbench.Duration,
                                        label = Config.Workbench.ProgressLabel:format(1, Config.Items[category][v.itemId].label),
                                        useWhileDead = false,
                                        canCancel = true,
                                        anim = {
                                            dict = Config.Workbench.Anim.dict,
                                            clip = Config.Workbench.Anim.name,
                                            flag = Config.Workbench.Anim.flag,
                                            blendIn = Config.Workbench.Anim.blendIn,
                                            blendOut = Config.Workbench.Anim.blendOut
                                        },
                                        disable = {
                                            move = true,
                                            combat = true
                                        }
                                    }) then
                                        TriggerServerEvent('mechanicsystem:server:craftItem', requiredItems, Config.Items[category][v.itemId])
                                    end
                                end
                                Wait(100)
                                OpenWorkbenchMenu(shop, type, marker)
                            else
                                lib.showContext('workbench_menu_recipes')
                            end
                        end,
                    })
                end
                lib.registerContext({
                    id = 'workbench_menu_recipes',
                    title = Lang['title_workbench'],
                    menu = 'workbench_menu_categories',
                    onExit = function()
                        usingMenu = false
                    end,
                    options = recipes,
                })
                lib.showContext('workbench_menu_recipes')
            end
        })
    end
    lib.registerContext({
        id = 'workbench_menu_categories',
        title = Lang['title_workbench'],
        onExit = function()
            usingMenu = false
        end,
        options = categories,
    })
    lib.showContext('workbench_menu_categories')
end

HasMaterials = function(materials)
    local proceed, success = false, true
    for i = 1, #materials do 
        Core.TriggerCallback('t1ger_lib:hasItem', function(hasItem, count)
            if not hasItem then
                if count == 0 then 
                    Core.Notification({
                        title = '',
                        message = Lang['you_dont_have_x_item']:format(materials[i].label),
                        type = 'inform'
                    })
                else
                    Core.Notification({
                        title = '',
                        message = Lang['you_need_x_amount_item']:format(count, materials[i].label, materials[i].amount),
                        type = 'inform'
                    })
                end
                success = false
                proceed = true
            end
            if i == #materials then
                proceed = true
            end
        end, materials[i].name, materials[i].amount)
    end
    while not proceed do 
        Wait(1)
    end
    return success
end

RegisterNetEvent('mechanicsystem:client:removeLift', function(args)
    if isPlayerAdmin then
        local lift_coords = GetEntityCoords(args.entity)
        local target_hash = tostring(GetEntityModel(args.entity))
        if GetEntityModel(args.entity) == Config.Lift.Frame then
            for i = 1, 2 do
                local model = nil
                if i == 1 then
                    model = Config.Lift.Frame
                elseif i == 2 then 
                    model = Config.Lift.Arms
                end
                local object = GetClosestObjectOfType(lift_coords.x, lift_coords.y, lift_coords.z, 3.0, model)
                local netId = NetworkGetNetworkIdFromEntity(object)
                if i == 1 then
                    TriggerServerEvent('mechanicsystem:server:removeLift', netId, lift_coords)
                end
                TriggerServerEvent('mechanicsystem:server:deleteEntity', netId, lift_coords)
            end
        end
    else
        return Core.Notification({
            title = '',
            message = Lang['only_admins_can_do_this'],
            type = 'error'
        })
    end
end)

RegisterNetEvent('mechanicsystem:client:useCarJack')
AddEventHandler('mechanicsystem:client:useCarJack', function(item, cfg)
    if usingCarJack then 
        return Core.Notification({
            title = '',
            message = Lang['carjack_using'],
            type = 'inform'
        })
    end

    local vehicle, closestDist = Lib.GetClosestVehicle(coords, 4.0, false)

    if vehicle == nil or not DoesEntityExist(vehicle) then 
        return Core.Notification({
            title = '',
            message = Lang['no_veh_nearby'],
            type = 'inform'
        })
    end

    local isOnCarJack = IsVehicleOnCarJack(NetworkGetNetworkIdFromEntity(vehicle))
    if isOnCarJack then
        return Core.Notification({
            title = '',
            message = Lang['carjack_vehicle_attached'],
            type = 'inform'
        })
    end

    usingCarJack = true

    local carjackObject, netId = nil, nil
    Lib.LoadAnim(cfg.Anim.dict)
    TaskPlayAnim(player, cfg.Anim.dict, cfg.Anim.name, cfg.Anim.blendIn, cfg.Anim.blendOut, cfg.Anim.duration, cfg.Anim.flag, 1.0, 0, 0, 0)

    Wait(250)

    local pX, pY, pZ, rX, rY, rZ = cfg.Prop.pos[1], cfg.Prop.pos[2], cfg.Prop.pos[3], cfg.Prop.rot[1], cfg.Prop.rot[2], cfg.Prop.rot[3]
    Lib.CreateObject(cfg.Prop.model, {x = coords.x, y = coords.y, z = coords.z}, 0.0, function(obj, networkId)
        carjackObject = obj
        netId = networkId
        AttachEntityToEntity(obj, player, GetPedBoneIndex(player, 28422), pX, pY, pZ, rX, rY, rZ, true, true, false, true, 2, 1)
    end, true)
    
    while carjackObject == nil do
        Wait(10)
    end

    local wheel_points = GetCarJackAttachPoints(vehicle)

    local isNearWheel = function(point)
        local carJackCoords = GetEntityCoords(carjackObject)
        if #(carJackCoords - vector3(point.coords.x, point.coords.y, point.coords.z)) <= 0.5 then
            Lib.DisplayHelpText(Config.CarJack.HelpText)
            DrawMarker(point.mk.type, point.coords.x, point.coords.y, point.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, point.mk.scale[1], point.mk.scale[2], point.mk.scale[3], point.mk.rgba[1], point.mk.rgba[2], point.mk.rgba[3], point.mk.rgba[4], false, false, 0, true, false, false, false)
            if IsControlJustReleased(0, point.keybind) then
                DetachEntity(carjackObject, false, false)
                ClearPedTasks(player)
                TriggerServerEvent('t1ger_lib:server:removeItem', item.name, 1)
                TriggerServerEvent('mechanicsystem:server:addCarJack', playerMechId, netId, NetworkGetNetworkIdFromEntity(vehicle), point)
                usingCarJack = false
                for i = 1, #lib.points.getNearbyPoints() do
                    for k,v in pairs(wheel_points) do
                        if v.marker == lib.points.getNearbyPoints()[i] then 
                            point.remove(lib.points.getNearbyPoints()[i])
                        end
                    end
                end
            end
        end
    end

    for k,v in pairs(wheel_points) do
        wheel_points[k].marker = lib.points.new({
            index = k,
            wheelId = v.wheelId,
            label = v.label,
            heading = v.heading,
            coords = vector3(v.coords.x, v.coords.y, v.coords.z),
            distance = 3,
            mk = Config.CarJack.Marker,
            keybind = Config.CarJack.Keybind,
            nearby = isNearWheel
        })
    end

end)

RegisterNetEvent('mechanicsystem:client:addCarJack', function(objNet, vehNet, marker)
    local targetSettings = {
        options = {
            {
                name = 'mechanicsystem:target:carjack',
                label = Config.CarJack.Target.label,
                icon = Config.CarJack.Target.icon,
                type = 'client',
                canInteract = IsNearCarJack,
                distance = Config.CarJack.Target.dist,
                onSelect = function(data)
                    CarJackMenu(data)
                end
            },
        },
        distance = Config.CarJack.Target.dist,
        canInteract = IsNearCarJack,
    }

    local carjack = Lib.NetworkGetEntity(objNet)
    Lib.AddLocalEntity(carjack, targetSettings)

    local carjack = Lib.NetworkGetEntity(objNet)
    local vehicle = Lib.NetworkGetEntity(vehNet)
    SetEntityAsMissionEntity(vehicle)
    FreezeEntityPosition(carjack, true)
    FreezeEntityPosition(vehicle, true)
    SetVehicleOnGroundProperly(vehicle)
    SetEntityCoords(carjack, marker.coords.x, marker.coords.y, marker.coords.z, 0.0, 0.0, 0.0, false)
    SetEntityHeading(carjack, marker.heading)
end)

CarJackMenu = function(data)
    local netId = NetworkGetNetworkIdFromEntity(data.entity)
    local carjack, canUse = GetCarJack(netId)
    local vehicle = Lib.NetworkGetEntity(carjack.vehNet)

    if vehicle == nil or not DoesEntityExist(vehicle) then
        return
    end

    lib.registerContext({
        id = 'carjack_menu',
        title = Lang['title_car_jack'],
        options = {
            {
                title = Lang['title_car_jack_raise'],
                icon = 'arrow-up',
                args = data,
                onSelect = function(args)
                    CarJackHandle('raise', vehicle, carjack.wheelId)
                    lib.showContext('carjack_menu')
                end
            },
            {
                title = Lang['title_car_jack_lower'],
                icon = 'arrow-down',
                args = data,
                onSelect = function(args)
                    CarJackHandle('lower', vehicle, carjack.wheelId)
                    lib.showContext('carjack_menu')
                end
            },
            {
                title = Lang['title_car_jack_remove'],
                icon = 'ban',
                args = data,
                onSelect = function(args)
                    Lib.RemoveLocalEntity(data.entity, {'mechanicsystem:target:carjack'}, Config.CarJack.Target.label)
                    TriggerServerEvent('mechanicsystem:server:removeCarJack', playerMechId, netId)
                end
            },
        },
    })
    lib.showContext('carjack_menu')
end

RegisterNetEvent('mechanicsystem:client:removeCarJack', function(objNet, vehNet)
    local vehicle = Lib.NetworkGetEntity(vehNet)
    SetEntityAsMissionEntity(vehicle)
    SetVehicleOnGroundProperly(vehicle)
    FreezeEntityPosition(vehicle, false)
end)

curVehicle, isInVehicle, isEngineDisabled, isTempEngineDisabled, isEnteringVehicle = {}, false, {}, {}, false
Citizen.CreateThread(function()
    Wait(5000)
    local effectsCount = 0
    local curMeta = false
    while true do
        if not isInVehicle and not IsPlayerDead(PlayerId()) then
            if GetVehiclePedIsUsing(player) ~= 0 or GetVehiclePedIsTryingToEnter(player) ~= 0 and not curMeta then
                curMeta = Core.VehicleMeta.Fetch(GetVehicleNumberPlateText(GetVehiclePedIsUsing(player)))
                if curMeta and next(curMeta) then 
                    isEngineDisabled[GetVehicleNumberPlateText(GetVehiclePedIsUsing(player))] = ShouldEngineDisable(curMeta.health)
                end
            end
            if DoesEntityExist(GetVehiclePedIsTryingToEnter(player)) and GetSeatPedIsTryingToEnter(player) == -1 and not isEnteringVehicle then
                isEnteringVehicle = true
                if isEngineDisabled[GetVehicleNumberPlateText(GetVehiclePedIsUsing(player))] or isTempEngineDisabled[GetVehicleNumberPlateText(GetVehiclePedIsUsing(player))] then 
                    SetVehicleUndriveable(GetVehiclePedIsUsing(player), true)
                end
            elseif not DoesEntityExist(GetVehiclePedIsTryingToEnter(player)) and not IsPedInAnyVehicle(player, true) and isEnteringVehicle then
                isEnteringVehicle = false
                curMeta = false
                SetVehicleUndriveable(GetVehiclePedIsUsing(player), false)
            end
            if IsPedInAnyVehicle(player, false) and GetPedInVehicleSeat(GetVehiclePedIsUsing(player), -1) == player then
                if isEnteringVehicle and (isEngineDisabled[GetVehicleNumberPlateText(GetVehiclePedIsUsing(player))] or isTempEngineDisabled[GetVehicleNumberPlateText(GetVehiclePedIsUsing(player))]) then
                    SetVehicleUndriveable(GetVehiclePedIsUsing(player), true)
                    SetVehicleEngineOn(GetVehiclePedIsUsing(player), false, true, true)
                end
                isEnteringVehicle = false
                isInVehicle = true
                curVehicle.entity = GetVehiclePedIsUsing(player)
                curVehicle.plate = GetVehicleNumberPlateText(curVehicle.entity)
                curVehicle.netId = VehToNet(curVehicle.entity)
                curVehicle.metadata = Core.VehicleMeta.Fetch(curVehicle.plate)
                if curVehicle.metadata and next(curVehicle.metadata) then 
                    isEngineDisabled[curVehicle.plate] = ShouldEngineDisable(curVehicle.metadata.health)
                end
                if isEngineDisabled[curVehicle.plate] or isTempEngineDisabled[curVehicle.plate] then 
                    if IsVehicleEngineStarting(curVehicle.entity) then 
                        SetVehicleEngineOn(curVehicle.entity, false, true, true)
                        SetVehicleUndriveable(curVehicle.entity, true)
                    end
                    if not GetIsVehicleEngineRunning(curVehicle.entity) or GetIsVehicleEngineRunning(curVehicle.entity) == 0 then
                        SetVehicleEngineOn(curVehicle.entity, false, true, true)
                        SetVehicleUndriveable(curVehicle.entity, true)
                    end
                end
                TriggerEvent('mechanicsystem:client:enteredVehicle', curVehicle.entity, curVehicle.plate, curVehicle.netId)
            end
        elseif isInVehicle then
            local isDriver = GetPedInVehicleSeat(curVehicle.entity, -1) == player
            curVehicle.coords = GetEntityCoords(curVehicle.entity)
            if curVehicle.mileage ~= nil and isDriver then
                -- check health start settings:
                if curVehicle.health and next(curVehicle.health) ~= nil then
                    isEngineDisabled[curVehicle.plate] = ShouldEngineDisable(curVehicle.health)
                end
                -- speed:
                curVehicle.speed = GetEntitySpeed(curVehicle.entity)
                if Config.Degradation.Mileage.metric == false then
                    curVehicle.speed = (curVehicle.speed * 3.6)
                else
                    curVehicle.speed = (curVehicle.speed * 2.236936)
                end
                -- check if moving:
                if curVehicle.lastCoords and #(curVehicle.coords - curVehicle.lastCoords) > 3.0 or curVehicle.lastCoords == nil then
                    curVehicle.travelDistance = #(curVehicle.coords - (curVehicle.lastCoords or GetEntityCoords(curVehicle.entity)))
                    curVehicle.lastCoords = curVehicle.coords
                    local meters = curVehicle.travelDistance
                    local kilometers = (meters * 0.001)
                    local miles = (kilometers * 0.621371)
                    local drivenMileage = kilometers
                    if Config.Degradation.Mileage.metric == false then
                        drivenMileage = miles
                    end
                    -- mileage:
                    curVehicle.mileage = Lib.RoundNumber((curVehicle.mileage + drivenMileage), 2)
                    -- service:
                    if curVehicle.service ~= nil and next(curVehicle.service) then
                        for part, lifespan in pairs(curVehicle.service) do
                            if curVehicle.service[part] > 0.0 then
                                curVehicle.service[part] = Lib.RoundNumber((curVehicle.service[part] - drivenMileage), 2)
                            else
                                curVehicle.service[part] = 0.0
                                DegradeAssociatedPart(part)                              
                            end
                        end
                    end
                end
                -- apply effects on vehicle:
                if Config.Degradation.EnableEffects then
                    effectsCount = effectsCount + 1
                    if effectsCount >= Config.Degradation.Delay then
                        local partName = GetRandomMalfunctionPart(curVehicle.health)
                        if partName and type(partName) ~= 'boolean' then
                            PlayMalfunctionPart(curVehicle.entity, partName, curVehicle.health[partName])
                        end
                        effectsCount = 0
                    end
                end
            end
            if not IsPedInAnyVehicle(player, false) or not isDriver or IsPlayerDead(PlayerId()) then
                TriggerEvent('mechanicsystem:client:exitedVehicle', curVehicle.entity, curVehicle.plate, curVehicle.netId, curVehicle.travelDistance, curVehicle.mileage, curVehicle.health, curVehicle.service)
                effectsCount = 0
                isInVehicle = false
                curVehicle = {}
                curMeta = false
            end
        end
        Wait(1000)
    end
end)

AddEventHandler('mechanicsystem:client:enteredVehicle', function(vehicle, plate, netId)
    if not isEngineDisabled[plate] then 
        SetVehicleEngineOn(vehicle, true, false, false)
        SetVehicleUndriveable(vehicle, false)
    end

    local metadata = Core.VehicleMeta.Fetch(plate)
    if not metadata then
        if Config.Debug then
            print("vehicle does not exist in database: ["..plate.."]")
        end
        return
    end

    for k,v in pairs(metadata) do
        curVehicle[k] = v
    end
    
    if Config.Debug then
        local mileage = curVehicle.mileage or 0
        print('mechanicsystem:client:enteredVehicle', 'vehicle', vehicle, 'plate', plate, 'netId', netId, 'mileage: ', mileage)
    end

    if isEngineDisabled[plate] then
        Wait(1000)
        SetVehicleUndriveable(vehicle, false)
    end
end)

AddEventHandler('mechanicsystem:client:exitedVehicle', function(vehicle, plate, netId, travelDist, mileage, health, service)
    if Config.Debug then 
        print('mechanicsystem:client:exitedVehicle', 'vehicle', vehicle, 'plate', plate, 'netId', netId, 'mileage', mileage)
    end
    Core.VehicleMeta.Update(plate, {['mileage'] = mileage, ['health'] = health, ['service'] = service})
end)

RegisterNetEvent('t1ger_lib:vehiclemeta:create')
AddEventHandler('t1ger_lib:vehiclemeta:create', function(plate, metadata)
    if isInVehicle and curVehicle ~= nil and next(curVehicle) then
        curVehicle.metadata = metadata
        for k,v in pairs(metadata) do
            curVehicle[k] = v
        end
    end
end)

PlayMalfunctionPart = function(entity, partName, partValue)
    local condition = GetPartCondition(partValue)
    
    if Config.Debug then
        print("effects on:", entity, "with: "..condition.type, "for: "..partName, "at: "..partValue)
    end

    if condition.msg ~= nil then
        Core.Notification({
            title = '',
            message = condition.msg:format(Config.Parts['health'][partName].label, partValue, '%'),
            type = 'error'
        })
    end

    if condition.type == 'failure' then 
        local plate = GetVehicleNumberPlateText(entity)
        isEngineDisabled[plate] = true
    else
        PlayEffect[partName](entity, condition.type)
    end
end

Citizen.CreateThread(function()
    Wait(5000)
    if Config.Degradation.Collision.enable then
        while true do
            local tick = 1000
            if curVehicle.speed ~= nil then
                if curVehicle.lastSpeed and curVehicle.lastSpeed >= Config.Degradation.Collision.speed then
                    tick = 300
                    local collision = HasEntityCollidedWithAnything(curVehicle.entity)
                    if collision then
                        if Config.Debug then
                            print("crash at speed:", curVehicle.lastSpeed)
                        end
                        if curVehicle.health ~= nil and next(curVehicle.health) then
                            PartDegradation(curVehicle.plate, curVehicle.health)
                        end
                        tick = 5000
                    end
                else
                    tick = 1000
                end
                curVehicle.lastSpeed = curVehicle.speed
            end
            Wait(tick)
        end
    end
end)

PartDegradation = function(plate, partsCondition)
    local indexTable, i, cache = {}, 1, {}

    -- make index table:
    for k,v in pairs(Config.Parts['health']) do
        if partsCondition[k] > 0.0 then
            indexTable[i] = k
            i = i + 1
        end
    end

    -- check if all parts are shit
    if next(indexTable) == nil then 
        return
    end

	for amount = 1, Config.Degradation.Parts do
		math.randomseed(GetGameTimer())
		local index = math.random(#indexTable)

        local attempts = 0
        while cache[index] ~= nil and attempts <= 20 do 
            math.randomseed(GetGameTimer())
            index = math.random(#indexTable)
            if attempts <= 20 then 
                attempts = attempts + 1
            else
                return print("bro u fucked up big time in config")
            end
            Wait(1)
        end

        cache[index] = true

		math.randomseed(GetGameTimer())
        local degradation = math.random(Config.Degradation.Value.min, Config.Degradation.Value.max)

        if degradation > partsCondition[indexTable[index]] then
            degradation = partsCondition[indexTable[index]]
        end

        SetPartHealth(plate, indexTable[index], degradation, 'minus')

        Wait(100)
	end
end

SetPartHealth = function(plate, partName, value, option)
    -- get part:
    local part = {}
    if Config.Parts['health'][partName] == nil then 
        if Config.Debug then
            print("entered part name: "..partName.." does not exist in Config.Parts['health']")
        end
        return 
    else
        part = Config.Parts['health'][partName]
    end

    if value > part.health then value = part.health elseif value < 0 then value = 0 end

    local metadata, msg = {}, ''
    
    if curVehicle.health ~= nil and next(curVehicle.health) then
        if curVehicle.health[partName] ~= nil then
            metadata = curVehicle.health
        else
            if Config.Debug then 
                print("part: "..partName.." does not exist in the vehicle's methadata")
            end
            return 
        end
    else
        local cache = Core.VehicleMeta.Fetch(plate)
        if not cache then
            if Config.Debug then
                print("vehicle does not exist in database: ["..plate.."]")
            end
            return 
        end
        metadata = cache.health
    end 

    if type(option) == 'string' then
        if option == 'plus' then
            metadata[partName] = Lib.RoundNumber((metadata[partName] + value), 2)
            if metadata[partName] > part.health then
                metadata[partName] = Lib.RoundNumber(part.health, 2)
            end
            --msg = Lang['x_condition_upgraded']:format(part.label, value, metadata[partName])
        elseif option == 'minus' then 
            metadata[partName] = Lib.RoundNumber((metadata[partName] - value), 2)
            if metadata[partName] < 0 then
                metadata[partName] = Lib.RoundNumber(0, 2)
            end
            --msg = Lang['x_condition_degraded']:format(part.label, value, metadata[partName])
        else
            metadata[partName] = Lib.RoundNumber(value, 2)
            --msg = Lang['x_condition_set']:format(part.label, metadata[partName])
        end
    else
        return print("why u fuck up config bro??")
    end

    if curVehicle.health ~= nil and next(curVehicle.health) then
        curVehicle.health = metadata
    else
        Core.VehicleMeta.Update(plate, {['health'] = metadata})
    end

    Core.Notification({
        title = '',
        message = msg,
        type = 'inform'
    })
end

SetPartMileage = function(plate, partName, value, option)
    -- get part:
    local part = {}
    if Config.Parts['service'][partName] == nil then 
        if Config.Debug then
            print("entered part name: "..partName.." does not exist in Config.Parts['service']")
        end
        return 
    else
        part = Config.Parts['service'][partName]
    end

    if value > part.mileage then value = part.mileage elseif value <= 0 then value = 0.0 end

    local metadata, msg = {}, ''

    if curVehicle.service ~= nil and next(curVehicle.service) then
        if curVehicle.service[partName] ~= nil then
            metadata = curVehicle.service
        else
            if Config.Debug then 
                print("part: "..partName.." does not exist in the vehicle's methadata")
            end
            return 
        end
    else
        local cache = Core.VehicleMeta.Fetch(plate)
        if not cache then
            if Config.Debug then 
                print("vehicle does not exist in database: ["..plate.."]")
            end
        end
        metadata = cache.service
    end 

    if type(option) == 'string' then
        if option == 'plus' then
            metadata[partName] = Lib.RoundNumber((metadata[partName] + value), 2)
            if metadata[partName] > part.mileage then
                metadata[partName] = Lib.RoundNumber(part.mileage, 2)
            end
            msg = Lang['x_mileage_increased']:format(part.label, value, Config.Degradation.Mileage.unit, metadata[partName], Config.Degradation.Mileage.unit) 
        elseif option == 'minus' then 
            metadata[partName] = Lib.RoundNumber((metadata[partName] - value), 2)
            if metadata[partName] < 0 then
                metadata[partName] = Lib.RoundNumber(0, 2)
            end
            msg = Lang['x_mileage_decreased']:format(part.label, value, Config.Degradation.Mileage.unit, metadata[partName], Config.Degradation.Mileage.unit) 
        else
            metadata[partName] = Lib.RoundNumber(value, 2)
            msg = Lang['x_mileage_set']:format(part.label, metadata[partName], Config.Degradation.Mileage.unit)
        end
    else
        return print("why u fuck up config bro??")
    end

    if curVehicle.service ~= nil and next(curVehicle.service) then
        curVehicle.service = metadata
    else
        Core.VehicleMeta.Update(plate, {['service'] = metadata})
    end

    Core.Notification({
        title = '',
        message = msg,
        type = 'inform'
    })
end

CanInteractVehicle = {
    Hood = function(entity)
        if not IsPlayerMechanic() then 
            return false 
        end

        if installingPart or usingCarJack or inspecting then 
            return false 
        end

        local d1,d2 = GetModelDimensions(GetEntityModel(entity))
        local hoodCoords = GetOffsetFromEntityInWorldCoords(entity, 0.0, (d2.y + 0.2), 0.0)
        local hoodDistance = #(coords - hoodCoords)

        if hoodDistance < 1.0 then 
            return true
        end

        return false
    end,

    Body = function(entity)
        if not IsPlayerMechanic() then 
            return false 
        end

        if installingPart or usingCarJack or inspecting then 
            return false 
        end
        
        local vehCoords = GetEntityCoords(entity)
        local vehDist = #(coords - vehCoords)

        if vehDist <= 3.0 then 
            return true
        end

        return false
    end,
}

local vehicleTarget = {}
if Config.Status.Target.enable == true then
    table.insert(vehicleTarget, {
        type = 'client',
        name = 'mechanicsystem:target:statusCheck',
        onSelect = function(data)
            VehicleStatus(data.entity)
        end,
        icon = Config.Status.Target.icon,
        label = Config.Status.Target.label,
        canInteract = CanInteractVehicle.Hood
    })
end
if Config.Service.Target.enable == true then
    table.insert(vehicleTarget, {
        type = 'client',
        name = 'mechanicsystem:target:serviceCheck',
        onSelect = function(data)
            CheckService(data.entity)
        end,
        icon = Config.Service.Target.icon,
        label = Config.Service.Target.label,
        canInteract = CanInteractVehicle.Hood
    })
end
if Config.Diagnose.Target.enable == true then
    table.insert(vehicleTarget, {
        type = 'client',
        name = 'mechanicsystem:target:diagnoseParts',
        onSelect = function(data)
            DiagnoseParts(data.entity)
        end,
        icon = Config.Diagnose.Target.icon,
        label = Config.Diagnose.Target.label,
        canInteract = CanInteractVehicle.Hood
    })
end
if Config.BodyRepair.Target.enable == true then
    table.insert(vehicleTarget, {
        type = 'client',
        name = 'mechanicsystem:target:bodyRepair',
        onSelect = function(data)
            BodyRepair(data.entity)
        end,
        icon = Config.BodyRepair.Target.icon,
        label = Config.BodyRepair.Target.label,
        canInteract = CanInteractVehicle.Body
    })
end

Lib.AddGlobalVehicle({options = vehicleTarget})

VehicleStatus = function(entity)
    local vehicle = entity
    if vehicle == nil then 
    vehicle = Lib.GetClosestVehicle(coords, Config.Status.Distance, false)
        if vehicle == nil or not DoesEntityExist(vehicle) then 
            Core.Notification({
                title = '',
                message = Lang['no_veh_nearby'],
                type = 'inform'
            })
            return MechanicActionMenu()
        end
    end
    local menuOptions = {}
    for k,v in ipairs(Config.Status.Options) do
        local statusValue = GetStatusOption(k, vehicle)
        if statusValue ~= nil then
            table.insert(menuOptions, {
                title = v.label..' - '..statusValue,
                icon = v.icon
            })
        end
    end
    local context = {
        id = 'status_check',
        menu = 'mechanic_menu',
        title = Lang['title_status_check'],
        options = menuOptions,
    }
    if entity ~= nil then
        context.menu = nil
    end
    lib.registerContext(context)
    lib.showContext(context.id)
end

GetStatusOption = function(selected, vehicle)
    local option = Config.Status.Options[selected].value
    local symbol = Config.Status.Options[selected].symbol
    local statusValue = nil

    if option == 'engineHealth' then
        statusValue = GetVehicleEngineHealth(vehicle)/10
    elseif option == 'bodyHealth' then 
        statusValue = GetVehicleBodyHealth(vehicle)/10
    elseif option == 'tankHealth' then 
        statusValue = GetVehiclePetrolTankHealth(vehicle)/10
    elseif option == 'fuelLevel' then 
        statusValue = Core.GetVehicleFuelLevel(vehicle)
    elseif option == 'dirtLevel' then 
        statusValue = GetVehicleDirtLevel(vehicle)
    elseif option == 'oilLevel' then  
        statusValue = GetVehicleOilLevel(vehicle)
    elseif option == 'engineTemp' then
        statusValue = GetVehicleEngineTemperature(vehicle)
    elseif option == 'mileage' then
        local metadata = Core.VehicleMeta.Fetch(GetVehicleNumberPlateText(vehicle))
        if metadata and next(metadata) then
            statusValue = metadata.mileage or nil
        else
            statusValue = nil
        end
    elseif option == 'plate' then
        statusValue = GetVehicleNumberPlateText(vehicle)
    end

    if statusValue ~= nil then
        if type(statusValue) == 'number' then
            return Lib.RoundNumber(statusValue, 2)..''..symbol
        else
            return statusValue..''..symbol
        end
    else
        return nil
    end
end

CheckService = function(entity)
    local vehicle = entity
    if vehicle == nil then 
        vehicle, closestDist = Lib.GetClosestVehicle(coords, Config.Service.Distance, false)
        if vehicle == nil or not DoesEntityExist(vehicle) then 
            Core.Notification({
                title = '',
                message = Lang['no_veh_nearby'],
                type = 'inform'
            })
            return MechanicActionMenu()
        end
    end

    local metadata = Core.VehicleMeta.Fetch(GetVehicleNumberPlateText(vehicle))
    if not metadata then
        if Config.Debug then
            print("vehicle does not exist in database: ["..GetVehicleNumberPlateText(vehicle).."]")
        end
        return MechanicActionMenu()
    end
    local menuOptions = {}
    for k,v in pairs(Config.Parts[Config.Service.Parts]) do
        local curMileage = (v.mileage - metadata.service[k])
        local serviceIn = (v.mileage - curMileage)

        local contextTitle = Lang['title_service_option_ok']:format(v.label)
        local status = Lib.RoundNumber(serviceIn, 2)..' '..Config.Degradation.Mileage.unit
        if serviceIn <= 0 then
            status = Lang['meta_service_due']
            contextTitle = Lang['title_service_option_due']:format(v.label)
        end
        menuOptions[v.id] = {
            title = contextTitle,
            icon = v.icon,
            metadata = {
                {label = Lang['meta_next_service'], value = status},
                {label = Lang['meta_condition'], value = Lib.RoundNumber(((metadata.service[k] / v.mileage) * 100), 2)..Lang['meta_condition_percent_symbol']},
                {label = Lang['meta_driven_mileage'], value = Lib.RoundNumber(curMileage, 2)..' '..Config.Degradation.Mileage.unit},
                {label = Lang['meta_expected_lifespan'], value = math.floor(v.mileage)..' '..Config.Degradation.Mileage.unit}
            }
        }
    end
    local context = {
        id = 'service_check',
        menu = 'mechanic_menu',
        title = Lang['title_service_check'],
        options = menuOptions,
    }
    if entity ~= nil then
        context.menu = nil
    end
    lib.registerContext(context)
    lib.showContext(context.id)
end

DiagnoseParts = function(entity)
    local vehicle = entity
    if vehicle == nil then 
        vehicle, closestDist = Lib.GetClosestVehicle(coords, Config.Diagnose.Distance, false)
        if vehicle == nil or not DoesEntityExist(vehicle) then 
            Core.Notification({
                title = '',
                message = Lang['no_veh_nearby'],
                type = 'inform'
            })
            return MechanicActionMenu()
        end
    end

    local metadata = Core.VehicleMeta.Fetch(GetVehicleNumberPlateText(vehicle))
    if not metadata then
        if Config.Debug then
            print("vehicle does not exist in database: ["..GetVehicleNumberPlateText(vehicle).."]")
        end
        return MechanicActionMenu()
    end
    local menuOptions = {}
    for k,v in pairs(Config.Parts[Config.Diagnose.Parts]) do
        local curHealth = metadata.health[k]

        local condition = GetPartCondition(metadata.health[k]).label

        local serviceString = ''
        for i = 1, #v.service do
            local service_part = nil
            for partName, partData in pairs(Config.Parts[Config.Service.Parts]) do
                if v.service[i] == partName then
                    service_part = partData.label
                    break
                end
            end
            if i == 1 then
                serviceString = service_part
            else
                serviceString = serviceString..' / '..service_part
            end
        end

        menuOptions[v.id] = {
            title = v.label..' - '..condition,
            icon = v.icon,
            metadata = {
                {label = Lang['meta_condition'], value = Lib.RoundNumber(metadata.health[k], 2)..Lang['meta_condition_percent_symbol']},
                {label = Lang['meta_part_status'], value = condition},
                {label = Lang['meta_associated_parts'], value = serviceString},
            }
        }
    end
    local context = {
        id = 'diagnose_parts_condition',
        menu = 'mechanic_menu',
        title = Lang['title_diagnose_parts_condition'],
        options = menuOptions,
    }
    if entity ~= nil then
        context.menu = nil
    end
    lib.registerContext(context)
    lib.showContext(context.id)
end

BodyRepair = function(entity)
    if inspecting then
        return Core.Notification({
            title = '',
            message = Lang['body_repair_inspecting'],
            type = 'inform'
        })
    end

    local vehicle = entity
    if vehicle == nil then 
        vehicle, closestDist = Lib.GetClosestVehicle(coords, Config.BodyRepair.Distance, false)
        if vehicle == nil or not DoesEntityExist(vehicle) then 
            Core.Notification({
                title = '',
                message = Lang['no_veh_nearby'],
                type = 'inform'
            })
            return MechanicActionMenu()
        end
    end

    local markers = GetVehicleInspectionPoints(vehicle)

    Core.Notification({
        title = '',
        message = Lang['body_repair_inspect'],
        type = 'inform'
    })

    local isOnCarJack = IsVehicleOnCarJack(NetworkGetNetworkIdFromEntity(vehicle))
    if not isOnCarJack then
        SetVehicleOnGroundProperly(vehicle)
        FreezeEntityPosition(vehicle, true)
    end

    inspecting = true

    local inspected = false

    local NearbyInspectionMarker = function(point)
        local mk = Config.BodyRepair.Inspection.marker
        DrawMarker(mk.type, point.coords.x, point.coords.y, point.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale[1], mk.scale[2], mk.scale[3], mk.rgba[1], mk.rgba[2], mk.rgba[3], mk.rgba[4], false, false, 0, true, false, false, false)

        if point.isClosest and point.currentDistance < 1.2 then
            if not point.textUi then
                point.textUi = true
                lib.showTextUI(Config.BodyRepair.Inspection.textUi.label, {
                    position = Config.BodyRepair.Inspection.textUi.pos,
                    icon = Config.BodyRepair.Inspection.textUi.icon,
                })
            end
            if IsControlJustReleased(0, point.keybind) then
                SetEntityHeading(player, point.heading)
                SetEntityCoords(player, point.coords.x, point.coords.y, point.coords.z, 0.0, 0.0, 0.0, false)
                if lib.progressBar({
                    duration = Config.BodyRepair.Inspection.progbar.duration,
                    label = Config.BodyRepair.Inspection.progbar.label,
                    useWhileDead = false,
                    canCancel = true,
                    disable = { move = true, combat = true },
                    anim = {
                        dict = point.anim.dict,
                        clip = point.anim.name,
                        flag = point.anim.flag,
                        blendIn = point.anim.blendIn,
                        blendOut = point.anim.blendOut
                    }
                }) then
                    point.remove(point)
                    lib.hideTextUI()
                    markers[point.index] = nil
                    Wait(500)
                    if next(markers) == nil then
                        inspecting = false
                        inspected = true
                        lib.hideTextUI()
                    end
                end
            end
        elseif point.textUi then 
            point.textUi = false
            lib.hideTextUI()
        end

        if IsControlJustReleased(0, 252) then
            for i = 1, #lib.points.getNearbyPoints() do
                for k,v in pairs(markers) do
                    if v.point == lib.points.getNearbyPoints()[i] then 
                        point.remove(lib.points.getNearbyPoints()[i])
                    end
                end
            end
            inspecting = false
            lib.hideTextUI()
        end
    end

    for k,v in pairs(markers) do
        local groundBool, groundZ = GetGroundZFor_3dCoord(v.pos.x, v.pos.y, v.pos.z, false)
        markers[k].point = lib.points.new({
            index = k,
            coords = vector3(v.pos.x, v.pos.y, groundZ),
            distance = 5,
            heading = v.heading,
            anim = v.anim,
            keybind = 38,
            textUi = false,
            nearby = NearbyInspectionMarker
        })
    end

    while not inspected do 
        Wait(1000)
    end

    local report = FetchVehicleBodyReport(vehicle)

    if HasBodyRepairsToDo(report) then
        Core.Notification({
            title = '',
            message = Lang['body_repair_report'],
            type = 'inform'
        })
        body_report[report.cache.plate] = report
        RefreshVehicleBody(report.cache.entity, body_report[report.cache.plate], report.cache.plate)
    else
        SetVehicleBodyFixed(vehicle, report.cache.plate)
        RemovePlateFromReports(report.cache.plate)
        Core.Notification({
            title = '',
            message = Lang['body_repair_fixed'],
            type = 'inform'
        })
    end
end

RefreshVehicleBody = function(vehicle, damageReport, plate)
    SetVehicleFixed(vehicle)
    if next(damageReport) then
        SetVehicleBodyDamage(vehicle, damageReport)
        if not HasBodyRepairsToDo(damageReport) then
            SetVehicleBodyFixed(vehicle, damageReport.cache.plate)
            RemovePlateFromReports(damageReport.cache.plate)
            Core.Notification({
                title = '',
                message = Lang['body_repair_fixed'],
                type = 'inform'
            })
        end
    else
        RemovePlateFromReports(plate)
        local isOnCarJack = IsVehicleOnCarJack(NetworkGetNetworkIdFromEntity(vehicle))
        if not isOnCarJack then
            FreezeEntityPosition(vehicle, false)
        end
    end
end

RegisterNetEvent('mechanicsystem:client:installBodyPart', function(item, partName, partData)
    if installingPart then 
        return Core.Notification({
            title = '',
            message = Lang['body_repair_already_installing'],
            type = 'inform'
        })
    end

    local vehicle, closestDist = Lib.GetClosestVehicle(coords, 5.0, false)

    if vehicle == nil or not DoesEntityExist(vehicle) then 
        return Core.Notification({
            title = '',
            message = Lang['no_veh_nearby'],
            type = 'inform'
        })
    end

    local plate = Lib.Trim(GetVehicleNumberPlateText(vehicle))
    
    if body_report[plate] == nil then 
        return Core.Notification({
            title = '',
            message = Lang['body_repair_must_inspect'],
            type = 'inform'
        })
    end

    if next(body_report[plate][partData.type]) == nil or (partName == 'hood' and body_report[plate][partData.type]["4"] == nil) or (partName == 'trunk' and body_report[plate][partData.type]["5"] == nil) then
        return Core.Notification({
            title = '',
            message = Lang['body_repair_part_not_needed']:format(partName),
            type = 'inform'
        }) 
    end
    
    installingPart = true

    -- Spawn Prop:
    local partObj = nil
    local anim = Config.BodyRepair.Anim
    Lib.LoadAnim(anim.dict)
	TaskPlayAnim(player, anim.dict, anim.name, anim.blendIn, anim.blendOut, anim.duration, anim.flags, 0, 0, 0, 0)

    Wait(250)

    local pX, pY, pZ, rX, rY, rZ = partData.prop.pos[1], partData.prop.pos[2], partData.prop.pos[3], partData.prop.rot[1], partData.prop.rot[2], partData.prop.rot[3]
    Lib.CreateObject(partData.prop.model, {x = coords.x, y = coords.y, z = coords.z}, 0.0, function(obj, networkId)
        partObj = obj
        AttachEntityToEntity(obj, player, GetPedBoneIndex(player, 28422), pX, pY, pZ, rX, rY, rZ, true, true, false, true, 2, 1)
    end, true)
    
    while partObj == nil do
        Wait(10)
    end

    local inAction = false

    local InstallPartFunction = function(data)
        local closestPart, part_info = GetClosestBodyPart(data.entity, partName, body_report[plate])
        if closestPart then
            local success, callback = TryInstallBodyPart(data.entity, partName, partData, body_report[plate][partData.type], part_info)
            if success then
                lib.hideTextUI()
                inAction = true
                if partName == 'hood' then
                    body_report[plate][partData.type]["4"] = nil
                elseif partName == 'trunk' then 
                    body_report[plate][partData.type]["5"] = nil
                else
                    body_report[plate][partData.type][tostring(part_info.index)] = nil
                end

                TriggerServerEvent('t1ger_lib:server:removeItem', item.name, 1)
                local netId = NetworkGetNetworkIdFromEntity(partObj)
                TriggerServerEvent('mechanicsystem:server:deleteEntity', netId)
                ClearPedTasks(player) 

                RefreshVehicleBody(data.entity, body_report[plate], plate)
                Lib.RemoveLocalEntity(data.entity, {'mechanicsystem:target:installBodyPart'}, Config.BodyRepair.Install.target.label:format(partData.label))
                installingPart = false
            end
        else
            Core.Notification({
                title = '',
                message = Lang['body_repair_move_closer']:format(partName),
                type = 'inform'
            }) 
        end
    end

    local targetSettings = {
        options = {
            {
                name = 'mechanicsystem:target:installBodyPart',
                icon = Config.BodyRepair.Install.target.icon,
                label = Config.BodyRepair.Install.target.label:format(partData.label),
                type = 'client',
                canInteract = CanInstallBodypart,
                distance =  Config.BodyRepair.Install.target.distance,
                onSelect = function(data) 
                    InstallPartFunction(data)
                end
            }
        },
        distance = Config.BodyRepair.Install.target.distance,
        canInteract = CanInstallBodypart,
    }

    Lib.AddLocalEntity(vehicle, targetSettings)

    lib.showTextUI(Config.BodyRepair.Install.cancel.textUi)
    while partObj ~= nil and DoesEntityExist(partObj) do 
        Wait(0)
        if IsControlJustPressed(0, Config.BodyRepair.Install.cancel.keybind) and not inAction then
            lib.hideTextUI()
            local netId = NetworkGetNetworkIdFromEntity(partObj)
            TriggerServerEvent('mechanicsystem:server:deleteEntity', netId)
            ClearPedTasks(player) 
            RefreshVehicleBody(vehicle, body_report[plate], plate)
            Lib.RemoveLocalEntity(vehicle, {'mechanicsystem:target:installBodyPart'}, Config.BodyRepair.Install.target.label:format(partData.label))
            installingPart = false
        end
    end
end)

RegisterNetEvent('mechanicsystem:client:usePart', function(type, item, partName, part, cfg)

    local vehicle, closestDist = Lib.GetClosestVehicle(coords, 6.0, false)

    if vehicle == nil or not DoesEntityExist(vehicle) then 
        return Core.Notification({
            title = '',
            message = Lang['no_veh_nearby'],
            type = 'inform'
        })
    end

    if partName == 'tires' then 
        local wheel, wheelPos = GetClosestWheel(vehicle, 0.9)
        if next(wheel) == nil then
            return Core.Notification({
                title = '',
                message = Lang['must_be_standing_wheel'],
                type = 'inform'
            })
        end
    else
        local canInteract = GetVehicleClosestHood(vehicle)
        if not canInteract then
            return Core.Notification({
                title = '',
                message = Lang['must_be_standing_hood'],
                type = 'inform'
            })
        end
    end

    local plate = GetVehicleNumberPlateText(vehicle)
    local metadata = Core.VehicleMeta.Fetch(plate)
    if not metadata then
        if Config.Debug then
            print("vehicle does not exist in database: ["..plate.."]")
        end
        return
    end
    
    local conditionGood = false
    if part.mileage ~= nil and (metadata[type][partName] == part.mileage) then 
        conditionGood = true
    elseif part.health ~= nil and (metadata[type][partName] == part.health) then 
        conditionGood = true
    end
    if conditionGood == true then
        return Core.Notification({
            title = '',
            message = Lang['part_condition_is_new'],
            type = 'inform'
        })
    end

    if cfg.EngineTemp ~= nil then 
        local engineTemperature = GetVehicleEngineTemperature(vehicle)
        if engineTemperature > cfg.EngineTemp then 
            return Core.Notification({
                title = '',
                message = Lang['engine_too_hot'],
                type = 'inform'
            })
        end
    end

    local success = false
    if cfg.Skillcheck.enable == true then
        success = lib.skillCheck(cfg.Skillcheck.difficulty, cfg.Skillcheck.inputs)
    else
        success = true 
    end
    if success then
        if lib.progressBar({
            duration = cfg.Progbar.duration,
            label = cfg.Progbar.label:format(item.label),
            useWhileDead = false,
            canCancel = true,
            anim = {
                dict = cfg.Anim.dict,
                clip = cfg.Anim.name,
                flag = cfg.Anim.flag,
                blendIn = cfg.Anim.blendIn,
                blendOut = cfg.Anim.blendOut
            },
            disable = {
                move = true,
                combat = true
            }
        }) then
            TriggerServerEvent('t1ger_lib:server:removeItem', item.name, 1)
            -- give random materials based on recipe for specific item.
            local category = Config.Workbench.Categories[type]
            local materials = {}
            for k,v in pairs(category.recipe) do
                local part = Config.Items[type][v.itemId]
                if part.name == partName then
                    local i = 1
                    for name, amount in pairs(v.materials) do
                        materials[i] = {name = name, amount = amount}
                        i = i + 1
                    end
                end
            end
            PlayUpgradeSound()
            Core.Notification({
                title = '',
                message = Lang['part_x_replaced']:format(item.label),
                type = 'success'
            })
            if type == 'service' then 
                local newValue = part.mileage
                metadata.service[partName] = Lib.RoundNumber(newValue, 2)
                Core.VehicleMeta.Update(plate, {['service'] = metadata.service})
            elseif type == 'health' then 
                local newValue = part.health
                metadata.health[partName] = Lib.RoundNumber(newValue, 2)
                Core.VehicleMeta.Update(plate, {['health'] = metadata.health})
            end
            math.randomseed(GetGameTimer())
            local giveMaterial = materials[math.random(#materials)]
            math.randomseed(GetGameTimer())
            local amount = math.random(1, giveMaterial.amount)
            TriggerServerEvent('t1ger_lib:server:addItem', giveMaterial.name, amount)
            for k,v in pairs(Config.Items['materials']) do 
                if v.name == giveMaterial.name then
                    Core.Notification({
                        title = '',
                        message = Lang['received_scrap_item']:format(amount, v.label),
                        type = 'success'
                    })
                    break
                end
            end
        end
    end

end)

GetClosestWheel = function(vehicle, maxDist)
    local closestWheel, closestCoords = {}, nil
    local bones = {
        ['0'] = {bone = 'wheel_lf', index = 0},
        ['1'] = {bone = 'wheel_rf', index = 1},
        ['2'] = {bone = 'wheel_lr', index = 2},
        ['3'] = {bone = 'wheel_rr', index = 3},
    }

    for i = 0, GetVehicleNumberOfWheels(vehicle) - 1 do
        local boneId = GetEntityBoneIndexByName(vehicle, bones[tostring(i)].bone)
        local boneCoords = GetEntityBonePosition_2(vehicle, boneId)
        local distance = #(coords - boneCoords)
        if distance < maxDist then
            maxDist = distance
            closestWheel = bones[tostring(i)]
            closestCoords = boneCoords
        end
    end
    return closestWheel, closestCoords
end

RegisterNetEvent('mechanicsystem:client:useRepairKit', function(item, type, cfg)
    local vehicle, vehicleCoords = Lib.GetVehicleInDirection()

    if vehicle == nil then
		return Core.Notification({
            title = '',
            message = Lang['no_veh_in_direction'],
            type = 'inform'
        })
	end

    local canInteract = GetVehicleClosestHood(vehicle)
    if not canInteract then
        return Core.Notification({
            title = '',
            message = Lang['must_be_standing_hood'],
            type = 'inform'
        })
    end

    local plate = GetVehicleNumberPlateText(vehicle)

    local success = false
    if cfg.skillcheck.enable == true then
        success = lib.skillCheck(cfg.skillcheck.difficulty, cfg.skillcheck.inputs)
    else
        success = true 
    end
    if success then
        if lib.progressBar({
            duration = cfg.progbar.duration,
            label = cfg.progbar.label,
            useWhileDead = false,
            canCancel = true,
            anim = {
                dict = cfg.anim.dict,
                clip = cfg.anim.name,
                flag = cfg.anim.flag,
                blendIn = cfg.anim.blendIn,
                blendOut = cfg.anim.blendOut
            },
            disable = {
                move = true,
                combat = true
            }
        }) then

            local curHealth = GetVehicleEngineHealth(vehicle)

            if curHealth > cfg.engineHealth then
                return Core.Notification({
                    title = '',
                    message = Lang['repair_kit_not_work'],
                    type = 'inform'
                })
            end

            TriggerServerEvent('t1ger_lib:server:removeItem', item.name, 1)

            PlayUpgradeSound()

            SetVehicleEngineHealth(vehicle, cfg.engineHealth)
            
            if cfg.notify ~= nil or cfg.notify ~= '' then
                Core.Notification({
                    title = '',
                    message = cfg.notify,
                    type = 'success'
                })
            end

            Core.Notification({
                title = '',
                message = Lang['start_engine_check_repair'],
                type = 'success'
            })

        end
    end
end)

RegisterNetEvent('mechanicsystem:client:usePatchKit', function(item, cfg)
    local vehicle, vehicleCoords = Lib.GetVehicleInDirection()

    if vehicle == nil then
		return Core.Notification({
            title = '',
            message = Lang['no_veh_in_direction'],
            type = 'inform'
        })
	end

    local canInteract = GetVehicleClosestHood(vehicle)
    if not canInteract then
        return Core.Notification({
            title = '',
            message = Lang['must_be_standing_hood'],
            type = 'inform'
        })
    end

    local plate = GetVehicleNumberPlateText(vehicle)
    local metadata = Core.VehicleMeta.Fetch(plate)
    if not metadata then
        if Config.Debug then
            print("vehicle does not exist in database: ["..plate.."]")
        end
        return
    end

    local patch_parts = {}
    for k,v in pairs(metadata.health) do
        if v <= 0.0 then
            patch_parts[k] = {type = 'health', value = v, name = k}
        end
    end
    for k,v in pairs(metadata.service) do
        if v <= 0.0 then
            patch_parts[k] = {type = 'service', value = v, name = k}
        end
    end

    if next(patch_parts) == nil then
        return Core.Notification({
            title = '',
            message = Lang['nothing_to_patch'],
            type = 'inform'
        })
    end

    local success = false
    if cfg.Skillcheck.enable == true then
        success = lib.skillCheck(cfg.Skillcheck.difficulty, cfg.Skillcheck.inputs)
    else
        success = true 
    end
    if success then
        if lib.progressBar({
            duration = cfg.Progbar.duration,
            label = cfg.Progbar.label,
            useWhileDead = false,
            canCancel = true,
            anim = {
                dict = cfg.Anim.dict,
                clip = cfg.Anim.name,
                flag = cfg.Anim.flag,
                blendIn = cfg.Anim.blendIn,
                blendOut = cfg.Anim.blendOut
            },
            disable = {
                move = true,
                combat = true
            }
        }) then
            TriggerServerEvent('t1ger_lib:server:removeItem', item.name, 1)
            for k,v in pairs(patch_parts) do
                local value = Lib.RoundNumber(cfg.Values[v.type], 2)
                if v.type == 'service' and value >= Config.Parts['service'][v.name].mileage then
                    value = Config.Parts['service'][v.name].mileage
                elseif v.type == 'health' and value >= Config.Parts['health'][v.name].health then 
                    value = Config.Parts['health'][v.name].health
                end
                metadata[v.type][v.name] = value
            end

            PlayUpgradeSound()

            Core.VehicleMeta.Update(plate, {['health'] = metadata.health, ['service'] = metadata.service})

            Core.Notification({
                title = '',
                message = Lang['patch_kit_used'],
                type = 'success'
            })
        end
    end
end)

PlayUpgradeSound = function()
    PlaySoundFromEntity(GetSoundId(), 'Hydraulics_Down', player, 'Lowrider_Super_Mod_Garage_Sounds', true, 0)
    Wait(200)
    PlaySoundFromEntity(GetSoundId(), 'Hydraulics_Up', player, 'Lowrider_Super_Mod_Garage_Sounds', true, 0)
end

local holdingObj, carryModel = false, 0

CanInteractPropEmote = function(entity)
    local modelHash = GetEntityModel(entity)
    if Config.Emotes.Props[tostring(modelHash)] ~= nil then
        local entityCoords = GetEntityCoords(entity)
        if #(coords - entityCoords) < Config.Emotes.Distance then
            return true
        end
    end
    return false
end

local propEmoteTarget = {
    options = {
        {
            name = 'mechanicsystem:target:removeProp',
            event = 'mechanicsystem:client:removeProp',
            icon = Config.Emotes.Target[1].icon,
            label = Config.Emotes.Target[1].label,
            canInteract = CanInteractPropEmote
        },
        {
            name = 'mechanicsystem:target:carryProp',
            event = 'mechanicsystem:client:carryProp',
            icon = Config.Emotes.Target[2].icon,
            label = Config.Emotes.Target[2].label,
            canInteract = CanInteractPropEmote
        },
    },
    distance = Config.Emotes.Distance,
    canInteract = CanInteractPropEmote,
}

Lib.AddGlobalObject(propEmoteTarget)

RegisterNetEvent('mechanicsystem:client:removeProp', function(args)
    local modelHash = GetEntityModel(args.entity)
    local prop = Config.Emotes.Props[tostring(modelHash)]
    local netId = NetworkGetNetworkIdFromEntity(args.entity)
	TriggerServerEvent('mechanicsystem:server:deleteProp', netId, prop)
end)

RegisterNetEvent('mechanicsystem:client:carryProp', function(args)
    local modelHash = GetEntityModel(args.entity)
    local prop = Config.Emotes.Props[tostring(modelHash)]

    if not NetworkHasControlOfEntity(args.entity) then
        Lib.GetControlOfEntity(args.entity)
    end

    if not NetworkHasControlOfEntity(args.entity) then
        return print("could not get control of entity, try again.")
    end

    holdingObj = true
    if prop.push == nil then
        PropEmoteAnimation('pickup')
        Wait(250)
    else
        PropEmoteAnimation('push')
    end
    Wait(250)
    local boneIndex = GetPedBoneIndex(player, prop.bone)
    local pX, pY, pZ, rX, rY, rZ = prop.pos[1], prop.pos[2], prop.pos[3], prop.rot[1], prop.rot[2], prop.rot[3]

    AttachEntityToEntity(args.entity, player, boneIndex, pX, pY, pZ, rX, rY, rZ, true, true, false, true, 2, 1)

    Wait(500)

    while holdingObj do
        Wait(1)
        Lib.DisplayHelpText(Config.Emotes.TextStr)
        if IsControlJustPressed(0, Config.Emotes.Keybind) then
            holdingObj = false
            if prop.push == nil then 
                PropEmoteAnimation('pickup')
            end
            Wait(250)
            DetachEntity(args.entity)
            ClearPedTasks(player)
        end
    end
end)

RegisterNetEvent('mechanicsystem:client:propEmote', function(item, prop)
    if Lib.IsPlayerInsideVehicle(player) then
        return Core.Notification({
            title = '',
            message = Lang['not_possible_inside_veh'],
            type = 'inform'
        })
    end

    if holdingObj then
        return Core.Notification({
            title = '',
            message = Lang['already_holding_obj'],
            type = 'inform'
        })
    end
    
    TriggerServerEvent('t1ger_lib:server:removeItem', item.name, 1)

    carryModel = 0
	holdingObj = true
    if prop.push ~= nil then
        PropEmoteAnimation('push')
        Wait(250)
    end

    Lib.CreateObject(prop.model, {x = coords.x, y = coords.y, z = coords.z}, 0.0, function(obj, networkId)
        carryModel = obj
    end, true)
    
    while carryModel == 0 do
        Wait(10)
    end

    local boneIndex = GetPedBoneIndex(player, prop.bone)
    local pX, pY, pZ, rX, rY, rZ = prop.pos[1], prop.pos[2], prop.pos[3], prop.rot[1], prop.rot[2], prop.rot[3]
    AttachEntityToEntity(carryModel, player, boneIndex, pX, pY, pZ, rX, rY, rZ, true, true, false, true, 2, 1)

    Wait(500)

    while holdingObj do
        Wait(1)
        Lib.DisplayHelpText(Config.Emotes.TextStr)
        if IsControlJustPressed(0, Config.Emotes.Keybind) then
            holdingObj = false
            if prop.push == nil then 
                PropEmoteAnimation('pickup')
            end
            Wait(250)
            DetachEntity(carryModel)
            ClearPedTasks(player)
        end
    end
end)

IsPlayerMechanic = function(id)
    local isMechanic = false
    if playerMechId > 0 then
        if id == nil then
            id = playerMechId
        end
        if mech_shops[id] ~= nil then 
            if Core.GetJob().name == mech_shops[id].job.name then
                isMechanic = true
                if Core.GetJob().onDuty ~= nil and Core.GetJob().onDuty == false then
                    isMechanic = false
                end
            end
        else
            isMechanic = true
        end
    end
    return isMechanic
end

-- DEBUG COMMANDS --

if Config.Debug then
    RegisterCommand("degrade", function(source, args, rawCommand)
        local part = args[1]
        local value = tonumber(args[2]) 
        local type = tostring(args[3])
        local plate = 'ZCJ 668'
        SetPartHealth(plate, part, value, type)
    end, false)

    RegisterCommand("service", function(source, args, rawCommand)
        local part = args[1]
        local value = tonumber(args[2])
        local type = tostring(args[3])
        local plate = 'ZCJ 668'
        SetPartMileage(plate, part, value, type)
    end, false)

    RegisterCommand("wheels", function(source, args, rawCommand)
        local index = tonumber(args[1])
        local vehicle = GetVehiclePedIsIn(player, false)
        BreakOffVehicleWheel(vehicle, index, false, true, true, false)
    end, false)

    RegisterCommand("getcoords", function(source, args, rawCommand)
        local coords = GetEntityCoords(player)
        local heading = GetEntityHeading(player)
        local groundBool, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)

        local clipboard = Lib.RoundNumber(coords.x, 2)..', '..Lib.RoundNumber(coords.y, 2)..', '..Lib.RoundNumber(groundZ, 2)..', '..Lib.RoundNumber(heading, 2)
        print(clipboard)
        lib.setClipboard(clipboard)
    end, false)
    
end