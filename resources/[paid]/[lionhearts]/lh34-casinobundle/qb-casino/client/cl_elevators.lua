local Elevators = {
    [1] = {
        label = "Casino",
        text = "Main Floor",
        coords = vector4(960.35, 43.1, 71.7, 279.04)
    },
    [2] = {
        label = "Office",
        text = "Management",
        coords = vector4(993.89, 56.13, 75.06, 229.93),
        restricted = true,
    },
    [3] = {
        label = "Rooftop",
        text = "Rooftop Skybar",
        coords = vector4(964.93, 58.52, 112.55, 56.75)
    },
    [4] = {
        label = "Penthouse",
        text = "Diamond Casino Penthouse",
        coords = vector4(981.8, 54.47, 116.16, 332.57)
    },
    [5] = {
        label = "Hotel",
        text = "Diamond Casino Hotel",
        coords = vector4(913.82, -54.9, 21.0, 153.91)
    }
}

RegisterNetEvent('qb-casino:client:ElevatorMenu', function(data)
    local menu = {
        {
            header = "Elevator Controls",
            txt = "ESC or click to close",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-menu:closeMenu",
            }
        }
    }

    for i=1, #Elevators, 1 do
        if data.index == i then
            menu[#menu+1] = {
                header = Elevators[i].label..' | Current',
                txt = Elevators[i].text,
                isMenuHeader = true,
                icon = 'fas fa-circle'
            }
        elseif Elevators[i].restricted then
            if PlayerJob.name == 'casino' then
                menu[#menu+1] = {
                    header = Elevators[i].label,
                    txt = Elevators[i].text,
                    icon = 'fas fa-circle-chevron-right',
                    params = {
                        event = "qb-casino:client:TakeElevator",
                        args = i
                    }
                }
            else
                menu[#menu+1] = {
                    header = Elevators[i].label..' | Restricted',
                    txt = Elevators[i].text,
                    isMenuHeader = true,
                    icon = 'fas fa-circle'
                }
            end
        else
            menu[#menu+1] = {
                header = Elevators[i].label,
                txt = Elevators[i].text,
                icon = 'fas fa-circle-chevron-right',
                params = {
                    event = "qb-casino:client:TakeElevator",
                    args = i
                }
            }
        end
    end

    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-casino:client:TakeElevator', function(data)
    QBCore.Functions.Progressbar("waiting_elevator", "Waiting for the elevator..", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do Wait(10) end
        local ped = PlayerPedId()
        SetEntityCoords(ped, Elevators[data].coords.x, Elevators[data].coords.y, Elevators[data].coords.z - 1.0, 0, 0, 0, false)
        SetEntityHeading(ped, Elevators[data].coords.w)
        Wait(100)
        DoScreenFadeIn(1000)
    end, function() -- Cancel
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

CreateThread(function()
    exports["qb-target"]:AddBoxZone("elevator_casino", vector3(960.07, 42.29, 71.7), 0.2, 0.2, {
        name = "elevator_casino",
        heading = 102.00,
        debugPoly = false,
        minZ = 71.75,
        maxZ = 72.1
     }, {
        options = {
            {
                type = 'client',
                event = 'qb-casino:client:ElevatorMenu',
                icon = 'fas fa-circle-chevron-up',
                label = 'Elevator',
                index = 1
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("elevator_management", vector3(993.3, 55.57, 75.06), 0.2, 0.2, {
        name = "elevator_management",
        heading = 58.47,
        debugPoly = false,
        minZ = 75.1,
        maxZ = 75.45
     }, {
        options = {
            {
                type = 'client',
                event = 'qb-casino:client:ElevatorMenu',
                icon = 'fas fa-circle-chevron-up',
                label = 'Elevator',
                index = 2
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("elevator_rooftop", vector3(964.5, 57.52, 112.55), 0.2, 0.2, {
        name = "elevator_rooftop",
        heading = 239.45,
        debugPoly = false,
        minZ = 112.4,
        maxZ = 112.75
     }, {
        options = {
            {
                type = 'client',
                event = 'qb-casino:client:ElevatorMenu',
                icon = 'fas fa-circle-chevron-down',
                label = 'Elevator',
                index = 3
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("elevator_penthouse", vector3(982.38, 53.8, 116.16), 0.2, 0.2, {
        name = "elevator_penthouse",
        heading = 146.70,
        debugPoly = false,
        minZ = 116.20,
        maxZ = 116.55
     }, {
        options = {
            {
                type = 'client',
                event = 'qb-casino:client:ElevatorMenu',
                icon = 'fas fa-circle-chevron-down',
                label = 'Elevator',
                index = 4
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("elevator_penthouse2", vector3(982.50, 57.25, 116.16), 0.2, 0.2, {
        name = "elevator_penthouse2",
        heading = 146.70,
        debugPoly = false,
        minZ = 116.20,
        maxZ = 116.55
     }, {
        options = {
            {
                type = 'client',
                event = 'qb-casino:client:ElevatorMenu',
                icon = 'fas fa-circle-chevron-down',
                label = 'Elevator',
                index = 4
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("elevator_hotel", vector3(913.30, -54.02, 21.0), 0.2, 0.2, {
        name = "elevator_hotel",
        heading = 326.75,
        debugPoly = false,
        minZ = 21.05,
        maxZ = 21.40
     }, {
        options = {
            {
                type = 'client',
                event = 'qb-casino:client:ElevatorMenu',
                icon = 'fas fa-circle-chevron-down',
                label = 'Elevator',
                index = 5
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("elevator_hotel2", vector3(910.06, -51.98, 21.0), 0.2, 0.2, {
        name = "elevator_hotel2",
        heading = 326.75,
        debugPoly = false,
        minZ = 21.05,
        maxZ = 21.40
     }, {
        options = {
            {
                type = 'client',
                event = 'qb-casino:client:ElevatorMenu',
                icon = 'fas fa-circle-chevron-down',
                label = 'Elevator',
                index = 5
            },
        },
        distance = 1.5
    })
end)
