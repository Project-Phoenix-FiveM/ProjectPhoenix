QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('police:client:Impound', function(fullImpound, price)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
    local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
    local totalFuel = exports['cdn-fuel']:GetFuel(vehicle)
    if vehicle ~= 0 and vehicle then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            QBCore.Functions.Progressbar("impound_vehicle", "Requesting Impound", 5000, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = false,
            }, {}, {}, {}, function() -- Done
                local plate = QBCore.Functions.GetPlate(vehicle)
                TriggerServerEvent("police:server:Impound", plate, fullImpound, price, bodyDamage, engineDamage, totalFuel) 
                QBCore.Functions.DeleteVehicle(vehicle)
            end, function() -- Cancel
                QBCore.Functions.Notify("Canceled..", "error")
            end)
        end
    end
end)

RegisterNetEvent("police:ImpoundWhich")
AddEventHandler('police:ImpoundWhich', function(data)
    exports['qb-menu']:openMenu({
        {
            header = "Police Impound",
            isMenuHeader = true
        },
        {
            header = "Impound Vehicle",
            txt = "Car will be sent to the impound",
            params = {
                event = "police:FullImpound",
				args = {
					price = data.price,
                    seize = false,
				}
            }
        },
        {
            header = "Seize Vehicle",
            txt = "Car will be held by the PD",
            params = {
                event = "police:FullImpound",
				args = {
					price = data.price,
                    seize = true,
				}
            }
        },
        {
            header = "Close",
            txt = "Close Menu",
            params = {
                event = "qb-menu:client:closeMenu"
            },
        },
    })

end)

RegisterNetEvent("police:FullImpound")
AddEventHandler('police:FullImpound', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = "FINE",
        info = "Set Fine Amount",
        submitText = "Confirm",
        inputs = {
            {
                text = "Fine Amount", -- text you want to be displayed as a place holder
                name = "fineids", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            }
        },
    })


    if dialog ~= nil then
        print(json.encode(dialog.fineids))
        TriggerEvent('police:client:Impound', data.seize, dialog.fineids) 
    end
end)

RegisterNetEvent("qb-policejob:copimpound", function(source, raw)
    exports['qb-menu']:openMenu({
        {
            header = "Impound Options",
            isMenuHeader = true
        },
        {
            header = "Request Impound",
            txt = "Request Tow Worker to impound this vehicle",
            params = {
                event = "tow:requestTow",
            }
        },
        {
            header = "Police Impoud",
            txt = "Impound this vehicle",
            params = {
                event = "qb-policejob:policeimpound",
            },
        },
        {
            header = "Close",
            txt = "Close Menu",
            params = {
                event = "qb-menu:client:closeMenu"
            },
        }, 
    })
end)

RegisterNetEvent("qb-policejob:policeimpound", function(source, args, raw)
    exports['qb-menu']:openMenu({
        {
            header = "Police Impound",
            isMenuHeader = true
        },
        {
            header = "Evidence Of a Crime",
            txt = "Vehicle has been used in or is evidence of a crime.",
            params = {
                event = "police:ImpoundWhich",
                args = {
					price = '750',
				}
            }
        },
        {
            header = "Reckless Evading",
            txt = "Driven carelessly with gross disregard for human life.",
            params = {
                event = "police:ImpoundWhich",
				args = {
					price = '1300',
				}
            }
        },
        {
            header = "Street Racing",
            txt = "Vehicle was uised in a speed contest on a public road/highway.",
            params = {
                event = "police:ImpoundWhich",
				args = {
					price = '800',
				}
            }
        },
        {
            header = "Vehicle Repossession",
            txt = "Vehicle with an outstanding loan that was not paid off and is to be seized.",
            params = {
                event = "police:ImpoundWhich",
				args = {
					price = '2000',
				}
            }
        },
        {
            header = "Robbery or Kidnapping",
            txt = "Vehicle was used in the commission of any robbery or kidnapping related offense.",
            params = {
                event = "police:ImpoundWhich",
				args = {
					price = '4000',
				}
            }
        },
        {
            header = "Inoperable on a scene",
            txt = "Vehicle found on a scene in an inoperable state.",
            params = {
                event = "police:ImpoundWhich",
				args = {
					price = '500',
				}
            }
        },
        {
            header = "Violent Felony",
            txt = "Used in the commission of violent crime either in a drive by shooting or for transporting to and from the scene of a violent crime.",
            params = {
                event = "police:ImpoundWhich",
				args = {
					price = '3500',
				}
            }
        },
        {
            header = "Back",
            txt = "Back to main menu",
            params = {
                event = "qb-policejob:copimpound",
            }
        },
        {
            header = "Close",
            txt = "Close Menu",
            params = {
                event = "qb-menu:client:closeMenu"
            },
        },
    })
end)

RegisterNetEvent("qb-policejob:towimpound", function(source, args, raw)
    exports['qb-menu']:openMenu({
        {
            header = "Tow Impound",
            isMenuHeader = true
        },
        {
            header = "R",
            txt = "Vehicle in an unrecoverable state.",
            params = {
                event = "police:FullImpound",
                args = {
					price = '0',
                    seize = false,
				}
            }
        },
        {
            header = "Back",
            txt = "Back to main menu",
            params = {
                event = "qb-policejob:copimpound",
            }
        },
        {
            header = "Close",
            txt = "Close Menu",
            params = {
                event = "qb-menu:client:closeMenu"
            },
        },
    })
end)

Citizen.CreateThread(function()
exports['qb-target']:AddBoxZone('PDSeized', vector3(474.56927, -1027.015, 28.129756), 1, 1, {
    name='PDSeized',
    heading=57.45,
    debugPoly=false,
    minZ = 26.04,
    maxZ = 31.64,
    }, {
        options = {
            {
                type = 'client',
                event = 'qb-garages:client:VehicleListPD',
                icon = 'fas fa-user',
                label = 'PD Seized Vehicles',
            },
        },
    distance = 3.5
})
end)

RegisterNetEvent('qb-garages:client:VehicleListPD', function()
    QBCore.Functions.TriggerCallback('qb-garages:server:GetDepotVehiclesPD', function(vehcheck)  
        local NoVeh = false
        local menu = {{
            header = "< Go Back",
            params = {
                event = "Garages:OpenDepot",
            }
        }}
        for i = 1, #vehcheck do
            if vehcheck[i].state == 2 then
                table.insert(menu, {
                    header = QBCore.Shared.Vehicles[vehcheck[i].vehicle].name,
                    txt = "Plate: "..vehcheck[i].plate.." | Fine: "..vehcheck[i].depotprice.."$",
                    params = {
                        event = "qb-police:client:returntoimpound",
                        args = {
                            plate = vehcheck[i].plate,
                            vehicle = vehcheck[i].vehicle,
                            engine = vehcheck[i].engine,
                            body = vehcheck[i].body,
                            fuel = vehcheck[i].fuel,
                            fine = vehcheck[i].depotprice,
                            garage = vehcheck[i].garage
                        }
                    }
                })
                NoVeh = true
            end
            if NoVeh then
                exports['qb-menu']:openMenu(menu)
            end
        end
        if not NoVeh then
            TriggerEvent('QBCore:Notify', "There are no seized vehicles", "error", 3000)
        end
    end)
end)

RegisterNetEvent("qb-police:client:returntoimpound")
AddEventHandler('qb-police:client:returntoimpound', function(data)
    TriggerServerEvent("qb-police:server:returntoimpound", data)
end)