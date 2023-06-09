CreateThread(function()
    Wait(500)
    lib.registerContext({
        id = 'av_restaurants:admin',
        title = 'AV Restaurants',
        options = {
            {
                title = 'Create Zone',
                description = 'Create a new restaurant zone.',
                event = "av_restaurant:create"
            },
            {
                title = 'Edit Zone',
                description = 'Edit an existent restaurant zone.',
                event = "av_restaurant:edit"
            }
        },
    })
end)

RegisterNetEvent('av_restaurant:adminMenu')
AddEventHandler('av_restaurant:adminMenu', function()
    lib.showContext('av_restaurants:admin')
end)

AddEventHandler('av_restaurant:edit', function()
    TriggerServerEvent('av_restaurant:getData')
end)

RegisterNetEvent('av_restaurant:listZones')
AddEventHandler('av_restaurant:listZones', function(data)
    local items = {}
    local jobs = {}
    local added = {}
    for k, v in pairs(data) do
        jobs[v['job']] = jobs[v['job']] or {}
        jobs[v['job']][k] = v
        if not added[v['job']] then
            items[#items+1] = {
                title = "Store: "..v['job'],
                description = "Edit this store zones.",
                event = "av_restaurant:listZones2",
                args = {
                    job = v['job'],
                    data = data
                }
            }
            added[v['job']] = true
        end
    end
    items[#items+1] = {
        title = "← Go Back",
        event = "av_restaurant:adminMenu",
    }
    lib.registerContext({
        id = 'av_restaurants:listZones',
        title = 'AV Restaurants',
        options = items,
    })
    lib.showContext('av_restaurants:listZones')
end)

RegisterNetEvent('av_restaurant:listZones2')
AddEventHandler('av_restaurant:listZones2', function(args)
    local data = args['data']
    local job = args['job']
    local items = {}
    for k, v in pairs(data) do 
        if job == v['job'] then
            items[#items+1] = {
                title = "Job: "..v['job'],
                description = "Type: "..v['type'],
                event = "av_restaurant:editZone",
                args = {
                    zone = v
                }
            }
        end
    end
    items[#items+1] = {
        title = "← Go Back",
        params = {
            serverEvent = "av_restaurant:getData",
        }
    }
    lib.registerContext({
        id = 'av_restaurants:listZones2',
        title = 'AV Restaurants',
        options = items,
    })
    lib.showContext('av_restaurants:listZones2')
end)

RegisterNetEvent('av_restaurant:editZone')
AddEventHandler('av_restaurant:editZone', function(data)
    local info = data['zone']
    local menu = {
        {
            title = "Edit Zone",
        },
        {
            title = "TP to Coords",
            description = "Teleport to "..round(info['coords']['x'],1)..", "..round(info['coords']['y'],1)..", "..round(info['coords']['z'],1),
            event = "av_restaurant:teleport",
            args = {
                coords = info['coords'],
                zones = data
            }
        }, 
        {
            title = "Delete Zone",
            description = "You cannot undo this.",
            serverEvent = "av_restaurant:delete",
            args = {
                name = info['name'],
                coords = info['coords']
            }
        }
    }
    lib.registerContext({
        id = 'av_restaurants:editZone',
        title = 'AV Restaurants',
        options = menu,
    })
    lib.showContext('av_restaurants:editZone')
end)