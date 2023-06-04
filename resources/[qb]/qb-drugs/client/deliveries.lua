QBCore = exports['qb-core']:GetCoreObject()
local currentDealer = nil
local dealerIsHome = false
local waitingDelivery = nil
local activeDelivery = nil
local deliveryTimeout = 0
local waitingKeyPress = false
local dealerCombo = nil
local drugDeliveryZone

-- Handlers

AddStateBagChangeHandler('isLoggedIn', nil, function(_, _, value)
    if value then
        QBCore.Functions.TriggerCallback('qb-drugs:server:RequestConfig', function(DealerConfig)
            Config.Dealers = DealerConfig
        end)
        Wait(1000)
        InitZones()
    else
        if not Config.UseTarget and dealerCombo then dealerCombo:destroy() end
    end
end)

-- Functions

local function GetClosestDealer()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    for k,v in pairs(Config.Dealers) do
        local dealerCoords = vector3(v.coords.x, v.coords.y, v.coords.z)
        if #(pCoords - dealerCoords) < 2 then
            currentDealer = k
            break
        end
    end
end

local function OpenDealerShop()
    GetClosestDealer()
    local repItems = {}
    repItems.label = Config.Dealers[currentDealer]["name"]
    repItems.items = {}
    repItems.slots = 30
    for k, _ in pairs(Config.Dealers[currentDealer]["products"]) do
        if QBCore.Functions.GetPlayerData().metadata["dealerrep"] >= Config.Dealers[currentDealer]["products"][k].minrep then
            repItems.items[k] = Config.Dealers[currentDealer]["products"][k]
        end
    end
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Dealer_"..Config.Dealers[currentDealer]["name"], repItems)
end

local function KnockDoorAnim(home)
    local knockAnimLib = "timetable@jimmy@doorknock@"
    local knockAnim = "knockdoor_idle"
    local PlayerPed = PlayerPedId()
    local myData = QBCore.Functions.GetPlayerData()
    if home then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
        Wait(100)
        while (not HasAnimDictLoaded(knockAnimLib)) do
            RequestAnimDict(knockAnimLib)
            Wait(100)
        end
        TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
        Wait(3500)
        TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
        Wait(1000)
        dealerIsHome = true
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {
                Lang:t("info.dealer_name", {dealerName = Config.Dealers[currentDealer]["name"]}),
                Lang:t("info.fred_knock_message", {firstName = myData.charinfo.firstname})
            }
        })
        exports['qb-core']:DrawText(Lang:t("info.other_dealers_button"), 'left')
        AwaitingInput()
    else
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
        Wait(100)
        while (not HasAnimDictLoaded(knockAnimLib)) do
            RequestAnimDict(knockAnimLib)
            Wait(100)
        end
        TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
        Wait(3500)
        TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
        Wait(1000)
        QBCore.Functions.Notify(Lang:t("info.no_one_home"), 'error')
    end
end

local function KnockDealerDoor()
    GetClosestDealer()
    local hours = GetClockHours()
    local min = Config.Dealers[currentDealer]["time"]["min"]
    local max = Config.Dealers[currentDealer]["time"]["max"]
    if max < min then
        if hours <= max then
            KnockDoorAnim(true)
        elseif hours >= min then
            KnockDoorAnim(true)
        else
            KnockDoorAnim(false)
        end
    else
        if hours >= min and hours <= max then
            KnockDoorAnim(true)
        else
            KnockDoorAnim(false)
        end
    end
end

local function RandomDeliveryItemOnRep()
    local myRep = QBCore.Functions.GetPlayerData().metadata["dealerrep"]
    local availableItems = {}
    for k, _ in pairs(Config.DeliveryItems) do
        if Config.DeliveryItems[k]["minrep"] <= myRep then
            availableItems[#availableItems+1] = k
        end
    end
    return availableItems[math.random(1, #availableItems)]
end

local function RequestDelivery()
    if not waitingDelivery then
        GetClosestDealer()
        local location = math.random(1, #Config.DeliveryLocations)
        local amount = math.random(1, 3)
        local item = RandomDeliveryItemOnRep()
        waitingDelivery = {
            ["coords"] = Config.DeliveryLocations[location]["coords"],
            ["locationLabel"] = Config.DeliveryLocations[location]["label"],
            ["amount"] = amount,
            ["dealer"] = currentDealer,
            ["itemData"] = Config.DeliveryItems[item],
            ["item"] = item
        }
        QBCore.Functions.Notify(Lang:t("info.sending_delivery_email"), 'success')
        TriggerServerEvent('qb-drugs:server:giveDeliveryItems', waitingDelivery)
        SetTimeout(2000, function()
            TriggerServerEvent('qb-phone:server:sendNewMail', {
                sender = Config.Dealers[currentDealer]["name"],
                subject = "Delivery Location",
                message = Lang:t("info.delivery_info_email", {itemAmount = amount, itemLabel = QBCore.Shared.Items[waitingDelivery["itemData"]["item"]]["label"]}),
                button = {
                    enabled = true,
                    buttonEvent = "qb-drugs:client:setLocation",
                    buttonData = waitingDelivery
                }
            })
        end)
    else
        QBCore.Functions.Notify(Lang:t("error.pending_delivery"), 'error')
    end
end

local function DeliveryTimer()
    CreateThread(function()
        while deliveryTimeout - 1 > 0 do
            deliveryTimeout -= 1
            Wait(1000)
        end
        deliveryTimeout = 0
    end)
end

local function PoliceCall()
    if Config.PoliceCallChance <= math.random(1, 100) then
        TriggerServerEvent('police:server:policeAlert', 'Suspicous activity')
    end
end

local function DeliverStuff()
    if deliveryTimeout > 0 then
        Wait(500)
        TriggerEvent('animations:client:EmoteCommandStart', {"bumbin"})
        PoliceCall()
        QBCore.Functions.Progressbar("work_dropbox", Lang:t("info.delivering_products"), 3500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('qb-drugs:server:successDelivery', activeDelivery, true)
            activeDelivery = nil
            if Config.UseTarget then
                exports['qb-target']:RemoveZone('drugDeliveryZone')
            else
                drugDeliveryZone:destroy()
            end
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
        end)
    else
        TriggerServerEvent('qb-drugs:server:successDelivery', activeDelivery, false)
    end
    deliveryTimeout = 0
end

local function SetMapBlip(x, y)
    SetNewWaypoint(x, y)
    QBCore.Functions.Notify(Lang:t("success.route_has_been_set"), 'success');
end

-- PolyZone specific functions

function AwaitingInput()
    CreateThread(function()
        waitingKeyPress = true
        while waitingKeyPress do
            if not dealerIsHome then
                if IsControlPressed(0, 38) then
                    exports['qb-core']:KeyPressed()
                    KnockDealerDoor()
                end
            elseif dealerIsHome then
                if IsControlJustPressed(0, 38) then
                    OpenDealerShop()
                    exports['qb-core']:KeyPressed()
                    waitingKeyPress = false
                end
                if IsControlJustPressed(0, 47) then
                    if waitingDelivery then
                        exports['qb-core']:KeyPressed()
                        waitingKeyPress = false
                    end
                    RequestDelivery()
                    exports['qb-core']:KeyPressed()
                    dealerIsHome = false
                    waitingKeyPress = false
                end
            end
            Wait(0)
        end
    end)
end

function InitZones()
    if #Config.Dealers == 0 then return end

    if Config.UseTarget then
        for k,v in pairs(Config.Dealers) do
            exports["qb-target"]:AddBoxZone("dealer_"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 1.5, 1.5, {
                name = "dealer_"..k,
                heading = v.heading,
                minZ = v.coords.z - 1,
                maxZ = v.coords.z + 1,
                debugPoly = false,
            }, {
                options = {
                    {
                        icon = 'fas fa-user-secret',
                        label = Lang:t("info.target_request"),
                        action = function()
                            RequestDelivery()
                        end,
                        canInteract = function()
                            GetClosestDealer()
                            local hours = GetClockHours()
                            local min = Config.Dealers[currentDealer]["time"]["min"]
                            local max = Config.Dealers[currentDealer]["time"]["max"]
                            if max < min then
                                if hours <= max then
                                    if not waitingDelivery then
                                        return true
                                    end
                                elseif hours >= min then
                                    if not waitingDelivery then
                                        return true
                                    end
                                end
                            else
                                if hours >= min and hours <= max then
                                    if not waitingDelivery then
                                        return true
                                    end
                                end
                            end
                        end
                    },
                    {
                        icon = 'fas fa-user-secret',
                        label = Lang:t("info.target_openshop"),
                        action = function()
                            OpenDealerShop()
                        end,
                        canInteract = function()
                            GetClosestDealer()
                            local hours = GetClockHours()
                            local min = Config.Dealers[currentDealer]["time"]["min"]
                            local max = Config.Dealers[currentDealer]["time"]["max"]
                            if max < min then
                                if hours <= max then
                                    return true
                                elseif hours >= min then
                                    return true
                                end
                            else
                                if hours >= min and hours <= max then
                                    return true
                                end
                            end
                        end
                    }
                },
                distance = 1.5
            })
        end
    else
        local dealerPoly = {}
        for k,v in pairs(Config.Dealers) do
            dealerPoly[#dealerPoly+1] = BoxZone:Create(vector3(v.coords.x, v.coords.y, v.coords.z), 1.5, 1.5, {
                heading = -20,
                name="dealer_"..k,
                debugPoly = false,
                minZ = v.coords.z - 1,
                maxZ = v.coords.z + 1,
            })
        end
        dealerCombo = ComboZone:Create(dealerPoly, {name = "dealerPoly"})
        if not dealerCombo then return end
        dealerCombo:onPlayerInOut(function(isPointInside)
            if isPointInside then
                if not dealerIsHome then
                    exports['qb-core']:DrawText(Lang:t("info.knock_button"),'left')
                    AwaitingInput()
                elseif dealerIsHome then
                    exports['qb-core']:DrawText(Lang:t("info.other_dealers_button"), 'left')
                    AwaitingInput()
                end
            else
                waitingKeyPress = false
                exports['qb-core']:HideText()
            end
        end)
    end
end

-- Events

RegisterNetEvent('qb-drugs:client:RefreshDealers', function(DealerData)
    if not Config.UseTarget and dealerCombo then dealerCombo:destroy() end
    Config.Dealers = DealerData
    Wait(1000)
    InitZones()
end)

RegisterNetEvent('qb-drugs:client:updateDealerItems', function(itemData, amount)
    TriggerServerEvent('qb-drugs:server:updateDealerItems', itemData, amount, currentDealer)
end)

RegisterNetEvent('qb-drugs:client:setDealerItems', function(itemData, amount, dealer)
    Config.Dealers[dealer]["products"][itemData.slot].amount = Config.Dealers[dealer]["products"][itemData.slot].amount - amount
end)

RegisterNetEvent('qb-drugs:client:setLocation', function(locationData)
    if activeDelivery then
        SetMapBlip(activeDelivery["coords"]["x"], activeDelivery["coords"]["y"])
        QBCore.Functions.Notify(Lang:t("error.pending_delivery"), 'error')
        return
    end
    activeDelivery = locationData
    deliveryTimeout = 300
    DeliveryTimer()
    SetMapBlip(activeDelivery["coords"]["x"], activeDelivery["coords"]["y"])
    if Config.UseTarget then
        exports["qb-target"]:AddBoxZone('drugDeliveryZone', vector3(activeDelivery["coords"].x, activeDelivery["coords"].y, activeDelivery["coords"].z), 1.5, 1.5, {
            name = 'drugDeliveryZone',
            heading = 0,
            minZ = activeDelivery["coords"].z - 1,
            maxZ = activeDelivery["coords"].z + 1,
            debugPoly = false
        }, {
            options = {
                {
                    icon = 'fas fa-user-secret',
                    label = Lang:t("info.target_deliver"),
                    action = function()
                        DeliverStuff()
                        waitingDelivery = nil
                    end,
                    canInteract = function()
                        if waitingDelivery then
                            return true
                        end
                    end
                }
            },
            distance = 1.5
        })
    else
        drugDeliveryZone = BoxZone:Create(vector3(activeDelivery["coords"].x, activeDelivery["coords"].y, activeDelivery["coords"].z), 1.5, 1.5, {
            heading = 0,
            name="drugDelivery",
            debugPoly = false,
            minZ = activeDelivery["coords"].z - 1,
            maxZ = activeDelivery["coords"].z + 1,
        })
        drugDeliveryZone:onPlayerInOut(function(isPointInside)
            if isPointInside then
                local inDeliveryZone = true
                exports['qb-core']:DrawText(Lang:t("info.deliver_items_button", {itemAmount = activeDelivery["amount"], itemLabel = QBCore.Shared.Items[activeDelivery["itemData"]["item"]]["label"]}),'left')
                CreateThread(function()
                    while inDeliveryZone do
                        if IsControlJustPressed(0, 38) then
                            exports['qb-core']:KeyPressed()
                            DeliverStuff()
                            waitingDelivery = nil
                            break
                        end
                        Wait(0)
                    end
                end)
            else
                inDeliveryZone = false
                exports['qb-core']:HideText()
            end
        end)
    end
end)

RegisterNetEvent('qb-drugs:client:sendDeliveryMail', function(type, deliveryData)
    if type == 'perfect' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[deliveryData["dealer"]]["name"],
            subject = "Delivery",
            message = Lang:t("info.perfect_delivery", {dealerName = Config.Dealers[deliveryData["dealer"]]["name"]})
        })
    elseif type == 'bad' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[deliveryData["dealer"]]["name"],
            subject = "Delivery",
            message = Lang:t("info.bad_delivery")
        })
    elseif type == 'late' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[deliveryData["dealer"]]["name"],
            subject = "Delivery",
            message = Lang:t("info.late_delivery")
        })
    end
end)
