RegisterNetEvent('qb-lotto:usar')
AddEventHandler('qb-lotto:usar', function()
	SetNuiFocus( true, true )
	SendNUIMessage({
		showPlayerMenu = true
	})
end)

RegisterNetEvent('qb-lotto:showprice')
AddEventHandler('qb-lotto:showprice', function(money)
	SetNuiFocus( true, true )
	SendNUIMessage({
		showPlayerMenu = nil,
		prize = money
	})
end)

RegisterCommand("helpnui", function(source, args, rawCommand)
	SetNuiFocus( false, false )
	SendNUIMessage({
		showPlayerMenu = false
	})

end)




RegisterNetEvent('qb-lotto:addcalc')
AddEventHandler('qb-lotto:addcalc', function()
	item = true
end)

RegisterNetEvent('qb-lotto:removecalc')
AddEventHandler('qb-lotto:removecalc', function()
	item = false
end)
