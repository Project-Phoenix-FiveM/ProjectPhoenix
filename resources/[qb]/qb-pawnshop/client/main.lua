local QBCore = exports['qb-core']:GetCoreObject()

local isMelting = false
local canTake = false
local meltTime
local meltedItem = {}

CreateThread(function()
    for _, value in pairs(Config.PawnLocation) do
        local blip = AddBlipForCoord(value.coords.x, value.coords.y, value.coords.z)
        SetBlipSprite(blip, 431)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 5)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Lang:t('info.title'))
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    if Config.UseTarget then
        for key, value in pairs(Config.PawnLocation) do
            exports['qb-target']:AddBoxZone('PawnShop'..key, value.coords, value.length, value.width, {
                name = 'PawnShop'..key,
                heading = value.heading,
                minZ = value.minZ,
                maxZ = value.maxZ,
                debugPoly = value.debugPoly,
            }, {
                options = {
                    {
                        type = 'client',
                        event = 'qb-pawnshop:client:openMenu',
                        icon = 'fas fa-ring',
                        label = 'Pawn Shop',
                    },
                },
                distance = value.distance
            })
        end
    else
        local zone = {}
        for key, value in pairs(Config.PawnLocation) do
            zone[#zone+1] = BoxZone:Create(value.coords, value.length, value.width, {
                name = 'PawnShop'..key,
                heading = value.heading,
                minZ = value.minZ,
                maxZ = value.maxZ,
            })
        end
        local pawnShopCombo = ComboZone:Create( zone, { name = 'NewPawnShopCombo', debugPoly = false })
        pawnShopCombo:onPlayerInOut(function(isPointInside)
            if isPointInside then
                exports['qb-menu']:showHeader({
                    {
                        header = Lang:t('info.title'),
                        txt = Lang:t('info.open_pawn'),
                        params = {
                            event = 'qb-pawnshop:client:openMenu'
                        }
                    }
                })
            else
                exports['qb-menu']:closeMenu()
            end
        end)
    end
end)

RegisterNetEvent('qb-pawnshop:client:openMenu', function()
    if Config.UseTimes then
        if GetClockHours() >= Config.TimeOpen and GetClockHours() <= Config.TimeClosed then
            local pawnShop = {
                {
                    header = Lang:t('info.title'),
                    isMenuHeader = true,
                },
                {
                    header = Lang:t('info.sell'),
                    txt = Lang:t('info.sell_pawn'),
                    params = {
                        event = 'qb-pawnshop:client:openPawn',
                        args = {
                            items = Config.PawnItems
                        }
                    }
                }
            }
            if not isMelting then
                pawnShop[#pawnShop + 1] = {
                    header = Lang:t('info.melt'),
                    txt = Lang:t('info.melt_pawn'),
                    params = {
                        event = 'qb-pawnshop:client:openMelt',
                        args = {
                            items = Config.MeltingItems
                        }
                    }
                }
            end
            if canTake then
                pawnShop[#pawnShop + 1] = {
                    header = Lang:t('info.melt_pickup'),
                    txt = '',
                    params = {
                        isServer = true,
                        event = 'qb-pawnshop:server:pickupMelted',
                        args = {
                            items = meltedItem
                        }
                    }
                }
            end
            exports['qb-menu']:openMenu(pawnShop)
        else
            QBCore.Functions.Notify(Lang:t('info.pawn_closed', { value = Config.TimeOpen, value2 = Config.TimeClosed }))
        end
    else
        local pawnShop = {
            {
                header = Lang:t('info.title'),
                isMenuHeader = true,
            },
            {
                header = Lang:t('info.sell'),
                txt = Lang:t('info.sell_pawn'),
                params = {
                    event = 'qb-pawnshop:client:openPawn',
                    args = {
                        items = Config.PawnItems
                    }
                }
            }
        }
        if not isMelting then
            pawnShop[#pawnShop + 1] = {
                header = Lang:t('info.melt'),
                txt = Lang:t('info.melt_pawn'),
                params = {
                    event = 'qb-pawnshop:client:openMelt',
                    args = {
                        items = Config.MeltingItems
                    }
                }
            }
        end
        if canTake then
            pawnShop[#pawnShop + 1] = {
                header = Lang:t('info.melt_pickup'),
                txt = '',
                params = {
                    isServer = true,
                    event = 'qb-pawnshop:server:pickupMelted',
                    args = {
                        items = meltedItem
                    }
                }
            }
        end
        exports['qb-menu']:openMenu(pawnShop)
    end
end)

RegisterNetEvent('qb-pawnshop:client:openPawn', function(data)
    QBCore.Functions.TriggerCallback('qb-pawnshop:server:getInv', function(inventory)
        local PlyInv = inventory
        local pawnMenu = {
            {
                header = Lang:t('info.title'),
                isMenuHeader = true,
            }
        }
        for _, v in pairs(PlyInv) do
            for i = 1, #data.items do
                if v.name == data.items[i].item then
                    pawnMenu[#pawnMenu + 1] = {
                        header = QBCore.Shared.Items[v.name].label,
                        txt = Lang:t('info.sell_items', { value = data.items[i].price }),
                        params = {
                            event = 'qb-pawnshop:client:pawnitems',
                            args = {
                                label = QBCore.Shared.Items[v.name].label,
                                price = data.items[i].price,
                                name = v.name,
                                amount = v.amount
                            }
                        }
                    }
                end
            end
        end
        pawnMenu[#pawnMenu + 1] = {
            header = Lang:t('info.back'),
            params = {
                event = 'qb-pawnshop:client:openMenu'
            }
        }
        exports['qb-menu']:openMenu(pawnMenu)
    end)
end)

RegisterNetEvent('qb-pawnshop:client:openMelt', function(data)
    QBCore.Functions.TriggerCallback('qb-pawnshop:server:getInv', function(inventory)
        local PlyInv = inventory
        local meltMenu = {
            {
                header = Lang:t('info.melt'),
                isMenuHeader = true,
            }
        }
        for _, v in pairs(PlyInv) do
            for i = 1, #data.items do
                if v.name == data.items[i].item then
                    meltMenu[#meltMenu + 1] = {
                        header = QBCore.Shared.Items[v.name].label,
                        txt = Lang:t('info.melt_item', { value = QBCore.Shared.Items[v.name].label }),
                        params = {
                            event = 'qb-pawnshop:client:meltItems',
                            args = {
                                label = QBCore.Shared.Items[v.name].label,
                                reward = data.items[i].rewards,
                                name = v.name,
                                amount = v.amount,
                                time = data.items[i].meltTime
                            }
                        }
                    }
                end
            end
        end
        meltMenu[#meltMenu + 1] = {
            header = Lang:t('info.back'),
            params = {
                event = 'qb-pawnshop:client:openMenu'
            }
        }
        exports['qb-menu']:openMenu(meltMenu)
    end)
end)

RegisterNetEvent('qb-pawnshop:client:pawnitems', function(item)
    local sellingItem = exports['qb-input']:ShowInput({
        header = Lang:t('info.title'),
        submitText = Lang:t('info.sell'),
        inputs = {
            {
                type = 'number',
                isRequired = false,
                name = 'amount',
                text = Lang:t('info.max', { value = item.amount })
            }
        }
    })
    if sellingItem then
        if not sellingItem.amount then
            return
        end

        if tonumber(sellingItem.amount) > 0 then
            TriggerServerEvent('qb-pawnshop:server:sellPawnItems', item.name, sellingItem.amount, item.price)
        else
            QBCore.Functions.Notify(Lang:t('error.negative'), 'error')
        end
    end
end)

RegisterNetEvent('qb-pawnshop:client:meltItems', function(item)
    local meltingItem = exports['qb-input']:ShowInput({
        header = Lang:t('info.melt'),
        submitText = Lang:t('info.submit'),
        inputs = {
            {
                type = 'number',
                isRequired = false,
                name = 'amount',
                text = Lang:t('info.max', { value = item.amount })
            }
        }
    })
    if meltingItem then
        if not meltingItem.amount then
            return
        end
        if meltingItem.amount ~= nil then
            if tonumber(meltingItem.amount) > 0 then
                TriggerServerEvent('qb-pawnshop:server:meltItemRemove', item.name, meltingItem.amount, item)

            else
                QBCore.Functions.Notify(Lang:t('error.no_melt'), 'error')
            end
        else
            QBCore.Functions.Notify(Lang:t('error.no_melt'), 'error')
        end
    end
end)

RegisterNetEvent('qb-pawnshop:client:startMelting', function(item, meltingAmount, meltTimees)
    if not isMelting then
        isMelting = true
        meltTime = meltTimees
        meltedItem = {}
        CreateThread(function()
            while isMelting do
                if LocalPlayer.state.isLoggedIn then
                    meltTime = meltTime - 1
                    if meltTime <= 0 then
                        canTake = true
                        isMelting = false
                        table.insert(meltedItem, { item = item, amount = meltingAmount })
                        if Config.SendMeltingEmail then
                            TriggerServerEvent('qb-phone:server:sendNewMail', {
                                sender = Lang:t('info.title'),
                                subject = Lang:t('info.subject'),
                                message = Lang:t('info.message'),
                                button = {}
                            })
                        else
                            QBCore.Functions.Notify(Lang:t('info.message'), 'success')
                        end
                    end
                else
                    break
                end
                Wait(1000)
            end
        end)
    end
end)

RegisterNetEvent('qb-pawnshop:client:resetPickup', function()
    canTake = false
end)
