local QBCore = exports['qb-core']:GetCoreObject()
local walkstyle = 'default'
local walktable = {}
local walkpause = false

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(2000)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local savedwalk = GetResourceKvpString('walkstyles')
    if savedwalk then walktable = json.decode(savedwalk) end

    if walktable[PlayerData.citizenid] then
        walkstyle = walktable[PlayerData.citizenid]
    end
end)

RegisterNetEvent('ps-walks:walkpause', function()
	walkpause = not walkpause
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Wait(2000)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local savedwalk = GetResourceKvpString('walkstyles')
    if savedwalk then walktable = json.decode(savedwalk) end

    if walktable[PlayerData.citizenid] then
        walkstyle = walktable[PlayerData.citizenid]
    end
end)

local function saveWalks()
    SetResourceKvp('walkstyles', json.encode(walktable))
end

local function SetWalks(anim)
	local ped = PlayerPedId()
	if anim == 'default' then
		ResetPedMovementClipset(ped)
		ResetPedWeaponMovementClipset(ped)
		ResetPedStrafeClipset(ped)
	else
		RequestAnimSet(anim)
		while not HasAnimSetLoaded(anim) do Wait(0) end
		SetPedMovementClipset(ped, anim)
		ResetPedWeaponMovementClipset(ped)
		ResetPedStrafeClipset(ped)
	end
end

RegisterNetEvent('ps-walks:set', function(data)
    local anim = Config.WalkingSyles[data.id]
	walkstyle = anim
	SetWalks(anim)
    local PlayerData = QBCore.Functions.GetPlayerData()
    walktable[PlayerData.citizenid] = anim
    saveWalks()
end)

CreateThread(function()
    while true do
        Wait(1000)
		if not walkpause then
			local ped = PlayerPedId()
			local walkstyleCurrent = GetPedMovementClipset(ped)
			if walkstyleCurrent ~= joaat(walkstyle) or walkstyle == "default" then
				SetWalks(walkstyle)
			end
		end
    end
end)

CreateThread(function()
    local walkId = exports['qb-radialmenu']:AddOption({
        id = 'walkstyles',
        title = 'Walkstyle',
        icon = 'person-walking',
        items = {
            {
                id = 'arrogant',
                title = 'Arrogant',
                icon = 'person-walking',
                type = 'client',
                event = 'ps-walks:set',
                shouldClose = true
            }, {
                id = 'casual',
                title = 'Casual',
                icon = 'person-walking',
                type = 'client',
                event = 'ps-walks:set',
                shouldClose = true
            }, {
                id = 'casual2',
                title = 'Casual 2',
                icon = 'person-walking',
                type = 'client',
                event = 'ps-walks:set',
                shouldClose = true
            }, {
                id = 'casual3',
                title = 'Casual 3',
                icon = 'person-walking',
                type = 'client',
                event = 'ps-walks:set',
                shouldClose = true
            }, {
                id = 'casual4',
                title = 'Casual4',
                icon = 'person-walking',
                type = 'client',
                event = 'ps-walks:set',
                shouldClose = true
            }, {
                id = 'casual5',
                title = 'Casual 5',
                icon = 'person-walking',
                type = 'client',
                event = 'ps-walks:set',
                shouldClose = true
            }, {
                id = 'casual6',
                title = 'Casual 6',
                icon = 'person-walking',
                type = 'client',
                event = 'ps-walks:set',
                shouldClose = true
            }, {
                id = 'morewalk',
                title = 'More Styles',
                icon = 'bars',
                items = {
                    {
                        id = 'confident',
                        title = 'Confident',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'ps-walks:set',
                        shouldClose = true
                    }, {
                        id = 'business',
                        title = 'Business',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'ps-walks:set',
                        shouldClose = true
                    }, {
                        id = 'business2',
                        title = 'Business 2',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'ps-walks:set',
                        shouldClose = true
                    }, {
                        id = 'business3',
                        title = 'Business 3',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'ps-walks:set',
                        shouldClose = true
                    }, {
                        id = 'femme',
                        title = 'Femme',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'ps-walks:set',
                        shouldClose = true
                    }, {
                        id = 'flee',
                        title = 'Flee',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'ps-walks:set',
                        shouldClose = true
                    }, {
                        id = 'muscle',
                        title = 'Muscle',
                        icon = 'person-walking',
                        type = 'client',
                        event = 'ps-walks:set',
                        shouldClose = true
                    }, {
                        id = 'morewalk',
                        title = 'More Styles',
                        icon = 'bars',
                        items = {
                           --
                           {
                                id = 'gangster',
                                title = 'Gangster',
                                icon = 'person-walking',
                                type = 'client',
                                event = 'ps-walks:set',
                                shouldClose = true
                            }, {
                                id = 'gangster2',
                                title = 'Gangster 2',
                                icon = 'person-walking',
                                type = 'client',
                                event = 'ps-walks:set',
                                shouldClose = true
                            }, {
                                id = 'gangster3',
                                title = 'Gangster 3',
                                icon = 'person-walking',
                                type = 'client',
                                event = 'ps-walks:set',
                                shouldClose = true
                            }, {
                                id = 'gangster4',
                                title = 'Gangster 4',
                                icon = 'person-walking',
                                type = 'client',
                                event = 'ps-walks:set',
                                shouldClose = true
                            }, {
                                id = 'gangster5',
                                title = 'Gangster 5',
                                icon = 'person-walking',
                                type = 'client',
                                event = 'ps-walks:set',
                                shouldClose = true
                            }, {
                                id = 'heels',
                                title = 'Heels',
                                icon = 'person-walking',
                                type = 'client',
                                event = 'ps-walks:set',
                                shouldClose = true
                            }, {
                                id = 'heels2',
                                title = 'Heels 2',
                                icon = 'person-walking',
                                type = 'client',
                                event = 'ps-walks:set',
                                shouldClose = true
                            }, {
                                id = 'morewalk',
                                title = 'More Styles',
                                icon = 'bars',
                                items = {
                                    --
                                    {
                                        id = 'hiking',
                                        title = 'Hiking',
                                        icon = 'person-walking',
                                        type = 'client',
                                        event = 'ps-walks:set',
                                        shouldClose = true
                                    }, {
                                        id = 'quick',
                                        title = 'Quick',
                                        icon = 'person-walking',
                                        type = 'client',
                                        event = 'ps-walks:set',
                                        shouldClose = true
                                    }, {
                                        id = 'wide',
                                        title = 'Wide',
                                        icon = 'person-walking',
                                        type = 'client',
                                        event = 'ps-walks:set',
                                        shouldClose = true
                                    }, {
                                        id = 'scared',
                                        title = 'Scared',
                                        icon = 'person-walking',
                                        type = 'client',
                                        event = 'ps-walks:set',
                                        shouldClose = true
                                    }, {
                                        id = 'brave',
                                        title = 'Brave',
                                        icon = 'person-walking',
                                        type = 'client',
                                        event = 'ps-walks:set',
                                        shouldClose = true
                                    }, {
                                        id = 'tipsy',
                                        title = 'Tipsy',
                                        icon = 'person-walking',
                                        type = 'client',
                                        event = 'ps-walks:set',
                                        shouldClose = true
                                    }, {
                                        id = 'injured',
                                        title = 'Injured',
                                        icon = 'person-walking',
                                        type = 'client',
                                        event = 'ps-walks:set',
                                        shouldClose = true
                                    }, {
                                        id = 'morewalk',
                                        title = 'More Styles',
                                        icon = 'bars',
                                        items = {
                                            --
                                            {
                                                id = 'tough',
                                                title = 'Tough',
                                                icon = 'person-walking',
                                                type = 'client',
                                                event = 'ps-walks:set',
                                                shouldClose = true
                                            }, {
                                                id = 'sassy',
                                                title = 'Sassy',
                                                icon = 'person-walking',
                                                type = 'client',
                                                event = 'ps-walks:set',
                                                shouldClose = true
                                            }, {
                                                id = 'sad',
                                                title = 'Sad',
                                                icon = 'person-walking',
                                                type = 'client',
                                                event = 'ps-walks:set',
                                                shouldClose = true
                                            }, {
                                                id = 'posh',
                                                title = 'Posh',
                                                icon = 'person-walking',
                                                type = 'client',
                                                event = 'ps-walks:set',
                                                shouldClose = true
                                            }, {
                                                id = 'alien',
                                                title = 'Alien',
                                                icon = 'person-walking',
                                                type = 'client',
                                                event = 'ps-walks:set',
                                                shouldClose = true
                                            }, {
                                                id = 'nonchalant',
                                                title = 'Nonchalant',
                                                icon = 'person-walking',
                                                type = 'client',
                                                event = 'ps-walks:set',
                                                shouldClose = true
                                            }, {
                                                id = 'hobo',
                                                title = 'Hobo',
                                                icon = 'person-walking',
                                                type = 'client',
                                                event = 'ps-walks:set',
                                                shouldClose = true
                                            }, {
                                                id = 'morewalk',
                                                title = 'More Styles',
                                                icon = 'bars',
                                                items = {
                                                    --
                                                    {
                                                        id = 'money',
                                                        title = 'Money',
                                                        icon = 'person-walking',
                                                        type = 'client',
                                                        event = 'ps-walks:set',
                                                        shouldClose = true
                                                    }, {
                                                        id = 'swagger',
                                                        title = 'Swagger',
                                                        icon = 'person-walking',
                                                        type = 'client',
                                                        event = 'ps-walks:set',
                                                        shouldClose = true
                                                    }, {
                                                        id = 'shady',
                                                        title = 'Shady',
                                                        icon = 'person-walking',
                                                        type = 'client',
                                                        event = 'ps-walks:set',
                                                        shouldClose = true
                                                    }, {
                                                        id = 'maneater',
                                                        title = 'Man Eater',
                                                        icon = 'person-walking',
                                                        type = 'client',
                                                        event = 'ps-walks:set',
                                                        shouldClose = true
                                                    }, {
                                                        id = 'chichi',
                                                        title = 'Chichi',
                                                        icon = 'person-walking',
                                                        type = 'client',
                                                        event = 'ps-walks:set',
                                                        shouldClose = true
                                                    }, {
                                                        id = 'default',
                                                        title = 'Default',
                                                        icon = 'person-walking',
                                                        type = 'client',
                                                        event = 'ps-walks:set',
                                                        shouldClose = true
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    })
end)