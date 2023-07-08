local usedSupplies = false
local insideBathroom = false

--- Method to check if a room is available by checking if the name of the owner exists
--- @param name string - Name of the hotel room owner or nil
--- @return string string - Owner string or available
local getOwnerString = function(name)
    if name then 
        return "Owner: "..name
    else
        return "Available"
    end
end

RegisterNetEvent('qb-casino:client:HotelStash', function(data)
    local keyboard, input = exports["var-password"]:Keyboard({
        header = "Password", 
        rows = {""}
    })
    if keyboard then
        QBCore.Functions.TriggerCallback('qb-casino:server:HotelStash', function(correct)
            if correct then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "casino"..Shared.Hotelrooms[data.index].label, {
                    maxweight = 1000000,
                    slots = 25
                })
                TriggerEvent("inventory:client:SetCurrentStash", "casino"..Shared.Hotelrooms[data.index].label)
            else
                QBCore.Functions.Notify('Incorrect password', 'error', 2500)
            end
        end, data.index, input)
    end
end)

RegisterNetEvent('qb-casino:client:ManageCasino', function()
    if PlayerJob.name ~= 'casino' then return end
    if PlayerJob.grade.level < 1 then return end

    local menu = {
        {
            header = "Casino Manager",
            txt = "ESC or click to close",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-menu:closeMenu",
            }
        }
    }

    QBCore.Functions.TriggerCallback('qb-casino:server:GetRoomInfo', function(result)
        for i=1, #result do
            menu[#menu+1] = {
                header = "Room "..result[i].roomlabel,
                txt = getOwnerString(result[i].name),
                icon = 'fas fa-list-ul',
                params = {
                    event = "qb-casino:client:ManageRoom",
                    args = {
                        id = result[i].id,
                        name = result[i].name,
                        expire = result[i].expire,
                        password = result[i].password
                    }
                }
            }
        end
        exports['qb-menu']:openMenu(menu)
    end)
end)

RegisterNetEvent('qb-casino:client:ManageRoom', function(data)
    if PlayerJob.name ~= 'casino' then return end
    if PlayerJob.grade.level < 1 then return end

    local menu = {
        {
            header = "Room "..Shared.Hotelrooms[data.id].label,
            txt = "Return",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-casino:client:ManageCasino",
            }
        }
    }

    if data.name then
        menu[#menu+1] = {
            header = getOwnerString(data.name),
            txt = "Expires: "..data.expire,
            isMenuHeader = true,
            icon = 'fas fa-user-tag'
        }
        menu[#menu+1] = {
            header = "Change Safe Password",
            txt = "Currently: "..data.password,
            icon = 'fas fa-key',
            params = {
                event = "qb-casino:client:ChangePassword",
                args = data.id
            }
        }
        menu[#menu+1] = {
            header = "Kick Out",
            txt = "Resets the room",
            icon = 'fas fa-user-slash',
            params = {
                iSserver = true,
                event = "qb-casino:server:KickOut",
                args = data.id
            }
        }
        menu[#menu+1] = {
            header = "Extend Room",
            txt = "Extends with 7 days",
            icon = 'fas fa-plus',
            params = {
                event = "qb-casino:client:Extend",
                args = data.id
            }
        }
    else
        menu[#menu+1] = {
            header = "Rent Out",
            txt = "",
            icon = 'fas fa-pen-nib',
            params = {
                event = "qb-casino:client:RentOutRoom",
                args = data.id
            }
        }
    end

    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-casino:client:RentOutRoom', function(index)
    local dialog = exports['qb-input']:ShowInput({
		header = "Room "..Shared.Hotelrooms[index].label,
		submitText = "Submit",
		inputs = {
			{
				text = "Citizen ID",
				name = "citizenid",
				type = "text",
				isRequired = true,
				default = "",
			}
        }
    })
    if not dialog or not next(dialog) then return end
    TriggerServerEvent('qb-casino:server:RentOutRoom', index, string.upper(dialog.citizenid))
end)

RegisterNetEvent('qb-casino:client:ChangePassword', function(index)
    local dialog = exports['qb-input']:ShowInput({
		header = "Change Password",
		submitText = "Submit",
		inputs = {
			{
				text = "Password",
				name = "password",
				type = "text",
				isRequired = true,
				default = "",
			}
        }
    })
    if not dialog or not next(dialog) then return end
    TriggerServerEvent('qb-casino:server:ChangePassword', index, dialog.password)
end)

RegisterNetEvent('qb-casino:server:KickOut', function(index)
    local dialog = exports['qb-input']:ShowInput({
        header = "Kick out of room "..Shared.Hotelrooms[index].label,
        submitText = "Submit",
        inputs = {
            {
                text = "Enter 'Yes'",
                name = "text",
                type = "text",
                isRequired = true,
                default = "",
            }
        }
    })
    if not dialog or not next(dialog) then return end
    if string.lower(dialog.text) == "yes" then
        TriggerServerEvent('qb-casino:server:KickOut', index)
    else
        QBCore.Functions.Notify('Invalid Input..', 'error', 2500)
    end
end)

RegisterNetEvent('qb-casino:client:Extend', function(index)
    local dialog = exports['qb-input']:ShowInput({
        header = "Extend Room Duration "..Shared.Hotelrooms[index].label,
        submitText = "Submit",
        inputs = {
            {
                text = "Enter 'Yes'",
                name = "text",
                type = "text",
                isRequired = true,
                default = "",
            }
        }
    })
    if not dialog or not next(dialog) then return end
    if string.lower(dialog.text) == "yes" then
        TriggerServerEvent('qb-casino:server:Extend', index)
    else
        QBCore.Functions.Notify('Invalid Input..', 'error', 2500)
    end
end)

RegisterNetEvent('qb-casino:client:ServiceStash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "casino_service", {
        maxweight = 4000000,
        slots = 60,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "casino_service")
end)

RegisterNetEvent('qb-casino:client:HotelShop', function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Hotel Supplies", Shared.HotelShop)
end)

RegisterNetEvent('qb-casino:client:UseCasinoSupplies', function()
    if not insideBathroom then
        QBCore.Functions.Notify('You need a bathroom to clean yourself up..', 'error', 2500)
        return 
    end
    if usedSupplies then return end
    usedSupplies = true
    QBCore.Functions.Notify('You feel refreshened..', 'success')

    CreateThread(function()
        local duration = 90 -- 90 seconds
        local time = 0
        
        while time < 2*duration do
            Wait(500)
            time += 1
            SetPlayerStamina(PlayerId(), GetPlayerStamina(PlayerId()) + 1)
        end
        usedSupplies = false
        QBCore.Functions.Notify('You no longer feel refreshened..', 'error')
    end)
end)

CreateThread(function()
    -- Hotel Room Stashes
    for i=1, #Shared.Hotelrooms do
        exports["qb-target"]:AddCircleZone("casino_hotel"..i, Shared.Hotelrooms[i].stash.xyz, 0.75, {
            name = "casino_hotel"..i,
            useZ = true,
            debugPoly = false,
         }, {
            options = {
                {
                    type = 'client',
                    event = 'qb-casino:client:HotelStash',
                    icon = 'fas fa-hand-holding',
                    label = 'Open Safe',
                    index = i
                },
            },
            distance = 1.5
        })
    end

    -- Service Room Hotel
    exports["qb-target"]:AddBoxZone("casino_service", vector3(888.63, -61.0, 21.01), 5.0, 0.5, {
        name = "casino_service",
        heading = 238,
        debugPoly = false,
        minZ = 18.61,
        maxZ = 22.61
     }, {
        options = {
            {
                type = 'client',
                event = 'qb-casino:client:ServiceStash',
                icon = 'fas fa-hand-holding',
                label = 'Open Stash',
                job = 'casino'
            },
            {
                type = 'client',
                event = 'qb-casino:client:HotelShop',
                icon = 'fas fa-cart-plus',
                label = 'Purchase Goods',
                job = {['casino'] = 1}
            },
        },
        distance = 1.5
    })

    local zones = {}
    for i=1, #Shared.BathRooms do
        zones[#zones+1] = BoxZone:Create(Shared.BathRooms[i], 5.0, 5.0, {
            name = 'casino_bathroom'..i,
            minZ = 20.00,
            maxZ = 22.00,
            debugPoly = false,
            heading = 58.00
        })
    end

    local bathroomCombo = ComboZone:Create(zones, {
		name = "bathroomCombo", 
		debugPoly = false
	})

    bathroomCombo:onPlayerInOut(function(isPointInside, point, zone)
        insideBathroom = isPointInside
    end)
end)
