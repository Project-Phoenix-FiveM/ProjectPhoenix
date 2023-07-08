Core, Cfg, Framework = exports['t1ger_lib']:GetLib()
Lib = exports['t1ger_lib']:GetUtils()

database_table, mech_shops, carjack = 't1ger_mechanicsystem', {}, {}

Citizen.CreateThread(function ()
    while GetResourceState('t1ger_lib') ~= 'started' do Citizen.Wait(0) end
    if GetResourceState('t1ger_lib') == 'started' then
        SetupVehicleMetadata()
        InitializeResource()
    end
end)

RegisterServerEvent('mechanicsystem:server:playerLoaded')
AddEventHandler('mechanicsystem:server:playerLoaded', function()
    local src = Core.Player.GetSource(source)
    local playerMechId = GetPlayerMechId(src)

    local isAdmin = Core.Player.IsAdmin(src)
    TriggerClientEvent('mechanicsystem:client:isAdmin', src, isAdmin)
    local identifier = Core.Player.GetIdentifier(src)
    if mech_shops[playerMechId] ~= nil and identifier == mech_shops[playerMechId].boss then 
        TriggerClientEvent('mechanicsystem:client:setMechanicId', src, playerMechId, true)
    else
        TriggerClientEvent('mechanicsystem:client:setMechanicId', src, playerMechId, false)
    end
    TriggerClientEvent('mechanicsystem:client:updateShops', src, mech_shops)
    TriggerClientEvent('mechanicsystem:client:createShopBlips', -1, mech_shops)
    TriggerClientEvent('mechanicsystem:client:createMarkerBlips', src, playerMechId)


    -- Useable Items:
    CreateUseableItems()
    
    -- Spawn Lifts:
    CreateShopLifts()
end)

GetPlayerMechId = function(src)
    local src = Core.Player.GetSource(src)
    local identifier = Core.Player.GetIdentifier(src)
    local playerJob = Core.Player.GetPlayerJob(src)

    if not mech_shops then 
        return 0 
    end

    for k,v in pairs(mech_shops) do
        if playerJob.name == v.job.name then
            return v.id
        end
        if next(v.employees) ~= nil then
            for _,employee in pairs(v.employees) do
                if employee.identifier == identifier then
                    return v.id
                end
            end
        end
    end

    return 0
end

Core.RegisterCallback('mechanicsystem:server:getPlayerMechId', function(src, cb)
    local src = Core.Player.GetSource(src)
    cb(GetPlayerMechId(src))
end)

CreateUseableItems = function()
    -- Useable Items for Car Jack:
    Core.UseableItem(Config.Items['kits'][Config.CarJack.ItemId].name, function(src, item)
        if item == nil then
            RconPrint('[^1ERROR #5383^0 UseableItem ('..Config.Items['kits'][Config.CarJack.ItemId].name..') does not exists in your items.\n')
        else
            TriggerClientEvent('mechanicsystem:client:useCarJack', src, Config.Items['kits'][Config.CarJack.ItemId], Config.CarJack)
        end
    end)
    -- Useable Items for Body Repairs:
    for k,v in pairs(Config.BodyRepair.Parts) do
        Core.UseableItem(Config.Items['bodyparts'][v.itemId].name, function(src, item)
            if item == nil then
                RconPrint('[^1ERROR #5383^0 UseableItem ('..Config.Items['bodyparts'][v.itemId].name..') does not exists in your items.\n')
            else
                TriggerClientEvent('mechanicsystem:client:installBodyPart', src, Config.Items['bodyparts'][v.itemId], k, v)
            end
        end)
    end
    -- Useable Items for Parts (Service & Health):
    for type, tb in pairs(Config.Parts) do
        for name, part in pairs(tb) do
            Core.UseableItem(Config.Items[type][part.itemId].name, function(src, item)
                if item == nil then
                    RconPrint('[^1ERROR #5383^0 UseableItem ('..Config.Items[type][part.itemId].name..') does not exists in your items.\n')
                else
                    local cfg = {}
                    if type == 'service' then 
                        cfg = Config.Service
                    elseif type == 'health' then
                        cfg = Config.Diagnose
                    end
                    TriggerClientEvent('mechanicsystem:client:usePart', src, type, Config.Items[type][part.itemId], name, part, cfg)
                end
            end)
        end
    end
    -- Useable Items for Repair Kits:
    for type, tb in pairs(Config.RepairKit) do
        Core.UseableItem(Config.Items['kits'][Config.RepairKit[type].itemId].name, function(src, item)
            if item == nil then
                RconPrint('[^1ERROR #5383^0 UseableItem ('..Config.Items['kits'][Config.RepairKit[type].itemId].name..') does not exists in your items.\n')
            else
                TriggerClientEvent('mechanicsystem:client:useRepairKit', src, Config.Items['kits'][Config.RepairKit[type].itemId], type, Config.RepairKit[type])
            end
        end)
    end
    -- Useable Items for Patch Kit:
    Core.UseableItem(Config.Items['kits'][Config.PatchKit.ItemId].name, function(src, item)
        if item == nil then
            RconPrint('[^1ERROR #5383^0 UseableItem ('..Config.Items['kits'][Config.PatchKit.ItemId].name..') does not exists in your items.\n')
        else
            TriggerClientEvent('mechanicsystem:client:usePatchKit', src, Config.Items['kits'][Config.PatchKit.ItemId], Config.PatchKit)
        end
    end)
    -- Useable Items for Prop Emotes:
    for k,v in pairs(Config.Emotes.Props) do
        local item_name = Config.Items['props'][v.itemId].name
        Core.UseableItem(item_name, function(src, item)
            if item == nil then
                RconPrint('[^1ERROR #5383^0 UseableItem ('..item_name..') does not exists in your items.\n')
            else
                TriggerClientEvent('mechanicsystem:client:propEmote', src, Config.Items['props'][v.itemId], v)
            end
        end)
    end
end

CreateShopLifts = function()
    if next(mech_shops) ~= nil then
        for id, shop in pairs(mech_shops) do
            if shop.lifts_spawned == nil or shop.lifts_spawned == false then
                SpawnCustomLifts(shop)
            end
        end
    end
end



Core.RegisterCallback('mechanicsystem:server:isAdmin', function(src, cb)
    cb(Core.Player.IsAdmin(src))
end)

RegisterServerEvent('mechanicsystem:server:createShop')
AddEventHandler('mechanicsystem:server:createShop', function(data)
    local src = source

    local job = {
        name = data.job_name,
        label = data.job_label,
        defaultDuty = Config.ShopCreator.defaultDuty,
        offDutyPay = Config.ShopCreator.offDutyPay,
        grades = {},
        offduty = true
    }

    for k,v in pairs(Config.ShopCreator.grades) do
        job.grades[tostring(v.grade)] = {name = v.name, label = v.label, grade = v.grade, salary = v.salary, isboss = (v.isboss or nil)}
    end

    local callback = Core.CreateJob(job)

    if callback ~= nil and type(callback) == 'table' and next(callback) then
        job.label = callback.label
        if Framework == 'QB' then
            for k,v in pairs(callback.grades) do 
                job.grades[tostring(k)] = {name = v.name, label = v.name, grade = k, salary = v.payment, isboss = (v.isboss or nil)}
            end
        else
            local boss_grade = 0
            for k,v in pairs(callback.grades) do
                if v.grade > boss_grade then
                    boss_grade = v.grade
                end
                job.grades[tostring(v.grade)] = {name = v.name, label = v.label, grade = v.grade, salary = v.salary, isboss = (v.isboss or nil)}
            end
            job.grades[tostring(boss_grade)].isboss = true
        end
    end

    local employees, storage, billing, lifts = {}, {}, {}, {}

    local blip_cfg = Config.ShopCreator.blip
    local blip = { enable = data.blip_use, coords = data.blip_coords, sprite = blip_cfg.sprite, display = blip_cfg.display, scale = blip_cfg.scale, color = blip_cfg.color }

    local markers = {}
    for k,v in pairs(Config.Markers) do
        if v.enable then
            markers[tostring(k)] = {}
        end
    end

    MySQL.Async.execute('INSERT INTO '..database_table..' (name, account, employees, storage, job, blip, markers, billing, lifts) VALUES (@name, @account, @employees, @storage, @job, @blip, @markers, @billing, @lifts)', {
        ['@name'] = data.shop_name,
        ['@account'] = data.account,
        ['@employees'] = json.encode(employees),
        ['@storage'] = json.encode(storage),
        ['@job'] = json.encode(job),
        ['@blip'] = json.encode(blip),
        ['@markers'] = json.encode(markers),
        ['@billing'] = json.encode(billing),
        ['@lifts'] = json.encode(lifts),
    }, function(affectedRows)
        GetMechanicShops()
        TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
        local shop_id = nil
        for k,v in pairs(mech_shops) do
            if v.name == data.shop_name then
                shop_id = v.id
                break
            end
        end
        TriggerClientEvent('mechanicsystem:client:addShopBlip', -1, shop_id, mech_shops[shop_id])
        Core.Notification(src, {
            title = '',
            message = Lang['you_created_mech_shop']:format(data.shop_name),
            type = 'success'
        })
        Core.Notification(src, {
            title = '',
            message = Lang['you_created_new_job']:format(data.job_label, data.job_name),
            type = 'success'
        })
    end)
end)

Core.RegisterCallback('mechanicsystem:server:getShops', function(src, cb)
    cb(mech_shops)
end)

RegisterServerEvent('mechanicsystem:server:setBoss')
AddEventHandler('mechanicsystem:server:setBoss', function(data)
    local src = source
    local boss_grade = GetBossGrade(data.shop.id)

    local match = false

    if next(data.shop.employees) ~= nil then 
        for k,v in pairs(data.shop.employees) do
            if v.identifier == data.player.identifier then
                match = true
                break
            end
        end
    end

    if match == false then
        table.insert(data.shop.employees, {identifier = data.player.identifier, name = Core.Player.GetName(data.player.source), job_grade = boss_grade})
        TriggerClientEvent('mechanicsystem:client:setMechanicId', data.player.source, data.shop.id, true)
    end

    if mech_shops[data.shop.id].boss ~= nil then 
        local old_boss = Core.Player.GetSrcFromIdentifier(mech_shops[data.shop.id].boss)
        if old_boss ~= nil then
            Core.Player.SetPlayerJob(old_boss, data.shop.job.name, 0)
        end
    end

    Core.Player.SetPlayerJob(data.player.source, data.shop.job.name, boss_grade.grade)

    mech_shops[data.shop.id].boss = Core.Player.GetIdentifier(data.player.source)
    mech_shops[data.shop.id].employees = data.shop.employees
    
    TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
    
    Core.Notification(src, {
        title = '',
        message = Lang['you_assigned_new_boss']:format(Core.Player.GetName(data.player.source), data.shop.name),
        type = 'inform'
    })
end)

GetBossGrade = function(id)
    for k,v in pairs(mech_shops[id].job.grades) do
        if v.isboss ~= nil then
            return {name = v.name, label = v.label, grade = v.grade}
        end
    end
end

RegisterServerEvent('mechanicsystem:server:createMarker')
AddEventHandler('mechanicsystem:server:createMarker', function(input, args)
    local src = Core.Player.GetSource(source)
    
    local marker = {
        coords = {x = input[1][1], y = input[1][2], z = input[1][3]},
        type = input[2],
        color = {r = input[3], g = input[4], b = input[5], a = input[6]},
        bobUpAndDown = input[7],
        faceCamera = input[8]
    }

    if args.type == 'storage' then
        marker.id = 'mechstorage'..args.data.id
        marker.storage = {
            id = 'mechstorage'..args.data.id,
            label = args.data.name..' Storage',
            slots = Config.Markers['storage'].storage.slots,
            weight = Config.Markers['storage'].storage.weight,
            owner = nil -- make sure its accessable by everyone!!
        }
    elseif args.type == 'garage' then 
        marker.id = 'mechgarage'..args.data.id
    elseif args.type == 'boss' then 
        marker.id = 'mechboss'..args.data.id
    elseif args.type == 'duty' then 
        marker.id = 'mechduty'..args.data.id
    elseif args.type == 'mechworkbench' then 
        marker.id = 'workbench'..args.data.id
    elseif args.type == 'repair' then 
        marker.id = 'mechrepair'..args.data.id
    end

    args.data.markers[args.type] = marker

    mech_shops[args.data.id].markers = args.data.markers
    
    if args.type == 'storage' then
        CreateStorage(mech_shops[args.data.id])
    end
    
    TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
    TriggerClientEvent('mechanicsystem:client:createMarkerBlips', -1, args.data.id)
    
    Core.Notification(src, {
        title = '',
        message = Lang['you_created_marker'],
        type = 'success'
    })
end)

CreateStorage = function(shop)
    local storage = shop.markers['storage'].storage
    Core.CreateStash(storage.id, storage.label, storage.slots, storage.weight, storage.owner)
end

RegisterServerEvent('mechanicsystem:server:deleteMarker')
AddEventHandler('mechanicsystem:server:deleteMarker', function(args)
    local src = Core.Player.GetSource(source)
    args.data.markers[args.type] = {}
    mech_shops[args.data.id].markers = args.data.markers
    TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
    TriggerClientEvent('mechanicsystem:client:createMarkerBlips', -1, args.data.id)
    Core.Notification(src, {
        title = '',
        message = Lang['you_deleted_marker'],
        type = 'inform'
    })
end)

RegisterServerEvent('mechanicsystem:server:createLift')
AddEventHandler('mechanicsystem:server:createLift', function(data)
    local src = Core.Player.GetSource(source)
    mech_shops[data.id].lifts = data.lifts
    TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
    Core.Notification(src, {
        title = '',
        message = Lang['lift_added_to_shop_x']:format(data.name),
        type = 'success'
    })
end)

RegisterServerEvent('mechanicsystem:server:updateDisable')
AddEventHandler('mechanicsystem:server:updateDisable', function(data, state)
    local src = source
    mech_shops[data.id].disabled = state
    TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
    local notification = Lang['you_disabled_shop_x']:format(mech_shops[data.id].name)
    if state == false then
        notification = Lang['you_enabled_shop_x']:format(mech_shops[data.id].name)
    end
    Core.Notification(src, {
        title = '',
        message = notification,
        type = 'inform'
    })
end)

RegisterServerEvent('mechanicsystem:server:deleteShop')
AddEventHandler('mechanicsystem:server:deleteShop', function(data)
    local src = source

    if not Core.Player.IsAdmin(src) then
        local identifier = Core.Player.GetIdentifier(src)
        return print("player: "..identifier..' tried deleting a shop')
    end

    -- update jobs for online players:
    local onlinePlayers = Core.GetOnlinePlayers()
    for id, player in pairs(onlinePlayers) do
        if player.job.name == data.job.name or player.job.name == 'off'..data.job.name then
            Core.Player.SetPlayerJob(player.source, 'unemployed', 0)
        end
    end

    -- delete the job:
    Core.DeleteJob(data.job.name)

    -- delete the shop:
    mech_shops[data.id] = nil
    MySQL.Async.execute('DELETE FROM '..database_table..' WHERE id = @id', {
        ['@id'] = data.id
    }, function(affectedRows)
        GetMechanicShops()
        TriggerClientEvent('mechanicsystem:client:removeShopBlip', -1, data.id)
        TriggerClientEvent('mechanicsystem:client:deleteMarkerBlips', -1, data.id)
        TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
        Core.Notification(src, {
            title = '',
            message = Lang['you_deleted_shop_x']:format(data.name),
            type = 'inform'
        })
    end)
end)

Core.RegisterCallback('mechanicsystem:server:getBills', function(src, cb, id)
    cb(mech_shops[id].billing)
end)

RegisterServerEvent('mechanicsystem:server:createBill')
AddEventHandler('mechanicsystem:server:createBill', function(shopId, input)
    local src = Core.Player.GetSource(source)
    local targetSrc = Core.Player.GetSource(input[1])
    local name = Core.Player.GetFullName(targetSrc)

    if Core.Player.GetMoney(targetSrc, 'bank') >= input[2] then
        TriggerClientEvent('mechanicsystem:client:sendBill', targetSrc, shopId, input, src)
        Core.Notification(src, {
            title = '',
            message = Lang['bill_sent_to_x']:format(input[2], name),
            type = 'inform'
        })
    else
        Core.Notification(src, {
            title = '', 
            message = Lang['bill_x_no_money']:format(name),
            type = 'inform'
        })
    end
end)

RegisterServerEvent('mechanicsystem:server:payBill')
AddEventHandler('mechanicsystem:server:payBill', function(shopId, input, bool, playerSrc)
    local src = Core.Player.GetSource(playerSrc)
    local srcIdentifier = Core.Player.GetIdentifier(src)
    local targetSrc = Core.Player.GetSource(source)
    local targetIdentifier = Core.Player.GetIdentifier(targetSrc)
    local targetName = Core.Player.GetFullName(targetSrc)

    if bool == true then 

        Core.Player.RemoveMoney(targetSrc, input[2], 'bank')
        mech_shops[shopId].account = (mech_shops[shopId].account + tonumber(input[2]))
        local bill_id = GenerateBillingNumber(shopId)
        local bill_data = {
            id = bill_id,
            shop = mech_shops[shopId].name,
            sender = {id = srcIdentifier, name = Core.Player.GetFullName(src)},
            receiver = {id = targetIdentifier, name = targetName},
            amount = input[2],
            note = input[3],
            date = os.date('%d-%m-%Y'),
            time = os.date('%H:%M')
        }

        mech_shops[shopId].billing[bill_id] = bill_data

        Core.Notification(src, {
            title = '',
            message = Lang['bill_paid_by_x']:format(targetName, input[2]),
            type = 'success'
        })

        TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
    else 
        Core.Notification(src, {
            title = '',
            message = Lang['bill_declined_by_x']:format(targetName, input[2]),
            type = 'inform'
        })
    end
end)

GenerateBillingNumber = function(shopId)
    local number, number_exists = nil, true
    while number_exists do
        Wait(1)
		math.randomseed(GetGameTimer())
		number = '#'..string.upper(Lib.GetRandomLetter(2))..'-'..Lib.GetRandomNumber(5)
        if next(mech_shops[shopId].billing) ~= nil then
            if mech_shops[shopId].billing[number] == nil then 
                number_exists = false
            end
        else
            number_exists = false
        end
    end

    return number
end

RegisterServerEvent('mechanicsystem:server:setJobsConfig')
AddEventHandler('mechanicsystem:server:setJobsConfig',function(type, cfg, num)
    if type == 'road_side_repairs' then
        Config.RoadSideRepairs.Jobs[num] = cfg
    elseif type == 'break_downs' then 
        Config.BreakDowns.Jobs[num] = cfg
    elseif type == 'scrap_cars' then 
        Config.ScrapCars.Jobs[num] = cfg
    end
    TriggerClientEvent('mechanicsystem:client:setJobsConfig', -1, type, cfg, num)
end)

RegisterServerEvent('mechanicsystem:server:jobPayout')
AddEventHandler('mechanicsystem:server:jobPayout',function(payout)
	local src = Core.Player.GetSource(source)
    math.randomseed(GetGameTimer())
    local cash = math.random(payout.min, payout.max)
    Core.Player.AddMoney(src, cash)
    Core.Notification(src, {
        title = '',
        message = Lang['npc_job_cash_reward']:format(cash),
        type = 'success'
    })
end)

RegisterServerEvent('mechanicsystem:server:scrapReward')
AddEventHandler('mechanicsystem:server:scrapReward',function(rewardSettings)
	local src = Core.Player.GetSource(source)

    local materials = Config.Items['materials']
    local giveItems = {}

    for i = 1, rewardSettings.count do 
        math.randomseed(GetGameTimer())
        local itemId = math.random(#materials)
        while giveItems[itemId] ~= nil do
            itemId = math.random(#materials)
            Wait(1)
        end
        math.randomseed(GetGameTimer())
        local amount = math.random(rewardSettings.amount.min, rewardSettings.amount.max)
        giveItems[itemId] = {id = itemId, name = materials[itemId].name, label = materials[itemId].label, amount = amount}
    end

    for k,v in pairs(giveItems) do
        Core.Player.AddItem(src, v.name, v.amount)
    end

    Core.Notification(src, {
        title = '',
        message = Lang['job_scrapcar_reward_msg'],
        type = 'success'
    })
end)


Core.RegisterCallback('mechanicsystem:server:getPlayerVehicles', function(src, cb)
	local playerSrc = Core.Player.GetSource(src)
    local vehicles = Core.Player.GetAllVehicles(playerSrc)
    cb(vehicles)
end)

Core.RegisterCallback('mechanicsystem:server:getStorage', function(src, cb, shop)
    cb(mech_shops[shop.id].storage)
end)

Core.RegisterCallback('mechanicsystem:server:getAccount', function(src, cb, id)
    cb(mech_shops[id].account)
end)

Core.RegisterCallback('mechanicsystem:server:getEmployees', function(src, cb, id)
    cb(mech_shops[id].employees)
end)

RegisterServerEvent('mechanicsystem:server:updateStorage')
AddEventHandler('mechanicsystem:server:updateStorage', function(id, storage, type, item, amount)
    local src = Core.Player.GetSource(source)
    mech_shops[id].storage = storage
    if type == 'deposit' then
        Core.Player.RemoveItem(src, item, amount)
    elseif type == 'withdraw' then
        Core.Player.AddItem(src, item, amount)
    end
    TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
end)

RegisterServerEvent('mechanicsystem:server:updateAccount')
AddEventHandler('mechanicsystem:server:updateAccount', function(add, id, cash, amount)
    local src = Core.Player.GetSource(source)
    local execute = false

    if add == true then
        local playerMoney = Core.Player.GetMoney(src)
        if playerMoney >= amount then
            Core.Player.RemoveMoney(src, amount)
            PlusMechanicAccount(id, amount)
            execute = true
            Core.Notification(src, {
                title = '',
                message = Lang['money_deposited']:format(amount),
                type = 'success'
            })
        else
            execute = false
            return Core.Notification(src, {
                title = '',
                message = Lang['not_enough_money'],
                type = 'error'
            })
        end
    else
        Core.Player.AddMoney(src, amount)
        MinusMechanicAccount(id, amount)
        execute = true
        Core.Notification(src, {
            title = '',
            message = Lang['money_withdrawn']:format(amount),
            type = 'success'
        })
    end

    if execute then 
        TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
    end
end)

PlusMechanicAccount = function(id, amount)
    local src = source
    if id == nil or id == 0 then 
        return 
    end
    local account = mech_shops[id].account
    account = (account + amount)
    mech_shops[id].account = account
    if src ~= nil then
        Core.Notification(src, {
            title = '',
            message = Lang['account_money_plus']:format(amount),
            type = 'success'
        })
    end
end

MinusMechanicAccount = function(id, amount)
    local src = source
    if id == nil or id == 0 then 
        return 
    end
    local account = mech_shops[id].account
    account = (account - amount)
    if account <= 0 then
        account = 0
    end
    mech_shops[id].account = account
    if src ~= nil then
        Core.Notification(src, {
            title = '',
            message = Lang['account_money_minus']:format(amount),
            type = 'inform'
        })
    end
end

RegisterServerEvent('mechanicsystem:server:updateEmployees')
AddEventHandler('mechanicsystem:server:updateEmployees', function(id, employees)
    mech_shops[id].employees = employees
    TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
end)

RegisterServerEvent('mechanicsystem:server:tryRecruit')
AddEventHandler('mechanicsystem:server:tryRecruit', function(data, args)
    local src = Core.Player.GetSource(source)
    local targetSrc = Core.Player.GetSource(args.serverId)
    local targetIdentifier = Core.Player.GetIdentifier(targetSrc)

    local foundPlayer = false
    for k,v in pairs(data.employees) do
        if v.identifier == targetIdentifier then
            foundPlayer = true
            break
        end
    end
    if foundPlayer == true then
        return Core.Notification(src, {
            title = '',
            message = Lang['employee_already_hired'],
            type = 'error'
        })
    else
        TriggerClientEvent('mechanicsystem:client:sendRecruitment', targetSrc, data, args, src)
        Core.Notification(src, {
            title = '',
            message = Lang['employee_recruit_sent']:format(Core.Player.GetName(targetSrc)),
            type = 'inform'
        })
    end
end)

RegisterServerEvent('mechanicsystem:server:recruitmentRespond')
AddEventHandler('mechanicsystem:server:recruitmentRespond', function(data, args, bool, playerSrc)
    local src = Core.Player.GetSource(playerSrc)
    local targetSrc = Core.Player.GetSource(source)
    local targetIdentifier = Core.Player.GetIdentifier(targetSrc)

    if bool == true then 
        Core.Notification(src, {
            title = '',
            message = Lang['recruitment_accepted2'],
            type = 'success'
        })

        local employee_grade = {name = data.job.grades["0"].name, label = data.job.grades["0"].label, grade = data.job.grades["0"].grade}
        table.insert(data.employees, {identifier = targetIdentifier, name = Core.Player.GetName(targetSrc), job_grade = employee_grade})

        mech_shops[data.id].employees = data.employees
        TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
        TriggerClientEvent('mechanicsystem:client:setMechanicId', targetSrc, data.id, false)
    else 
        Core.Notification(src, {
            title = '',
            message = Lang['recruitment_declined2'],
            type = 'inform'
        })
    end
end)

RegisterServerEvent('mechanicsystem:server:toggleDuty')
AddEventHandler('mechanicsystem:server:toggleDuty', function(shop, onDuty)
    local src = Core.Player.GetSource(source)
    local playerJob = Core.Player.GetPlayerJob(src)
    local identifier = Core.Player.GetIdentifier(src)
    if playerJob.name == shop.job.name then 
        Core.Player.SetPlayerJob(src, 'off'..shop.job.name, playerJob.grade)
        Core.Notification(src, {
            title = '',
            message = Lang['you_clocked_off_duty'],
            type = 'inform'
        })
    else
        if next(mech_shops[shop.id].employees) ~= nil then
            for k,v in pairs(mech_shops[shop.id].employees) do
                if identifier == v.identifier then
                    Core.Player.SetPlayerJob(src, shop.job.name, v.job_grade.grade)
                    Core.Notification(src, {
                        title = '',
                        message = Lang['you_clocked_on_duty'],
                        type = 'success'
                    })
                    break 
                end
            end
        end
    end
end)

Core.RegisterCallback('mechanicsystem:server:getOnlineMechanics', function(src, cb, id)
    local count = 0
    if next(mech_shops[id].employees) then
        for k,v in pairs(mech_shops[id].employees) do
            local xPlayer = Core.Player.GetFromIdentifier(v.identifier)
            if xPlayer then
                count = count + 1
            end
        end
    end
    cb(count)
end)

RegisterServerEvent('mechanicsystem:server:payQuickRepair')
AddEventHandler('mechanicsystem:server:payQuickRepair', function(id, price)
    local src = Core.Player.GetSource(source)
    mech_shops[id].account = (mech_shops[id].account + tonumber(price))
    Core.Player.RemoveMoney(src, price)
    TriggerClientEvent('mechanicsystem:client:updateShops', -1, mech_shops)
end)

RegisterServerEvent('mechanicsystem:server:craftItem')
AddEventHandler('mechanicsystem:server:craftItem', function(materials, output)
    local src = Core.Player.GetSource(source)

    for i = 1, #materials do 
        Core.Player.RemoveItem(src, materials[i].name, materials[i].amount)
    end

    Core.Player.AddItem(src, output.name, 1)
    Core.Notification(src, {
        title = '',
        message = Lang['you_crafted_x_item']:format(1, output.label),
        type = 'success'
    })
end)

RegisterServerEvent('mechanicsystem:server:removeLift')
AddEventHandler('mechanicsystem:server:removeLift', function(netId, liftCoords)
    local src = Core.Player.GetSource(source)
    for num,shop in pairs(mech_shops) do
        if next(shop.lifts) ~= nil then
            for id, lift in pairs(shop.lifts) do
                for model, data in pairs(lift) do
                    if data.netId == netId then
                        mech_shops[num].lifts[id] = nil
                        break 
                    end
                end
            end 
        end
    end
end)

RegisterServerEvent('mechanicsystem:server:deleteProp')
AddEventHandler('mechanicsystem:server:deleteProp', function(netId, prop)
    local src = Core.Player.GetSource(source)
    local item = Config.Items['props'][prop.itemId].name
    Core.Player.AddItem(src, item, 1)
    TriggerEvent('mechanicsystem:server:deleteEntity', netId)
end)

GetPlayerMechanicShop = function(name)
    if mech_shops ~= nil and next(mech_shops) then 
        for k,v in pairs(mech_shops) do
            if v.job.name == name then
                return mech_shops[k]
            end
        end
    end
    return nil
end

AddEventHandler('mechanicsystem:server:getPlayerMechanicShop', function(name, cb)
	cb(GetPlayerMechanicShop(name))
end)

SyncMechanicShops = function()
    if Config.Debug then
        RconPrint('[SAVED] T1GER MECHANIC SHOPS\n')
    end
    if mech_shops and next(mech_shops) then
        for k,v in pairs(mech_shops) do
            MySQL.Async.execute('UPDATE '..database_table..' SET name = @name, account = @account, boss = @boss, employees = @employees, storage = @storage, job = @job, blip = @blip, markers = @markers, billing = @billing, lifts = @lifts, disabled = @disabled WHERE id = @id', {
                ['@id'] = v.id,
                ['@name'] = v.name,
                ['@account'] = v.account,
                ['@boss'] = v.boss,
                ['@employees'] = json.encode(v.employees),
                ['@storage'] = json.encode(v.storage),
                ['@job'] = json.encode(v.job),
                ['@blip'] = json.encode(v.blip),
                ['@markers'] = json.encode(v.markers),
                ['@billing'] = json.encode(v.billing),
                ['@lifts'] = json.encode(v.lifts),
                ['@disabled'] = v.disabled,
            })
        end
    end
end

StartDatabaseSync = function()
    function SaveData()
            SyncMechanicShops()
        SetTimeout(Config.SyncToDatabase * 60 * 1000, SaveData)
    end
    SetTimeout(Config.SyncToDatabase * 60 * 1000, SaveData)
end
StartDatabaseSync()
