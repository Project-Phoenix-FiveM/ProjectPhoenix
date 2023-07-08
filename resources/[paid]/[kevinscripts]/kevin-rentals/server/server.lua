local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('kevin-rentals:sendinfomation', function(data, payMethod, rentTime)
	local PlayerID = source
    local Player = QBCore.Functions.GetPlayer(PlayerID)

    local Payment = data.price
    if Player.PlayerData.money[payMethod] >= Payment then
        Player.Functions.RemoveMoney(payMethod, Payment, 'Vehicle rental')
        TriggerClientEvent('kevin-rentals:createvehicle', PlayerID, data.hash, data.price, data.vehicle, data.gas, rentTime)
    else
		TriggerClientEvent('QBCore:Notify', PlayerID, 'You do not have enough money..', 'error')
    end
end)

RegisterNetEvent('kevin-rentals:sendvehicledata', function(vehicle, plate, rentTime)
	local PlayerID = source
    local Player = QBCore.Functions.GetPlayer(PlayerID)
    if not vehicle then return end

    local Time = os.date('%I:%M %p')
    local Date = os.date('%A, %B %d')

    local currentTimestamp = os.time()
    local addTime = currentTimestamp + rentTime * 60 * 60
    local expireTime = os.date('%I:%M %p', addTime)
    
	local info = {}
	info.firstname = Player.PlayerData.charinfo.firstname
	info.lastname = Player.PlayerData.charinfo.lastname
    info.model = vehicle
    info.plate = plate
	info.date = Date
    info.rentedtime = Time
    info.rentaltime = expireTime
	Player.Functions.AddItem('rentalpapers', 1, nil, info)
	TriggerClientEvent('inventory:client:ItemBox', PlayerID,  QBCore.Shared.Items['rentalpapers'], 'add')
end)

RegisterNetEvent('kevin-rentals:returnvehicle', function(price, id)
    local PlayerID = source
    local Player = QBCore.Functions.GetPlayer(PlayerID)
    if not id then return end
    local money = price * Config.MoneyReturn
    Player.Functions.AddMoney('cash', money, 'Vehicle return')
    TriggerClientEvent('QBCore:Notify', PlayerID, 'You recieved some money back $'..money, 'primary', 6000)
end)

QBCore.Functions.CreateUseableItem('rentalpapers', function(source, item)
    local PlayerId = source
    if not item.info.plate then return end
    TriggerClientEvent('kevin-rentals:client:givekeys', PlayerId, item.info.plate)
end)