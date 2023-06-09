RegisterNetEvent('av_restaurant:init')
AddEventHandler('av_restaurant:init', function(data)
    for k, v in pairs(data) do
        if v['type'] == "cashier" then
            exports[Config.TargetSystem]:AddBoxZone(v['name'], vector3(v['coords']['x'], v['coords']['y'], v['coords']['z']), v['height'], v['width'], {
                name = v['name'],
                heading = v['heading'],
                debugPoly = false,
                minZ = v['minZ'],
                maxZ = v['maxZ'],
            }, {
                options = {
                    {
                        type = "client",
                        event = Config.Events[v['type']]['event'][1],
                        icon = Config.Events[v['type']]['icon'][1],
                        label = Config.Events[v['type']]['label'][1],
                        job = v['job'],
                        zoneName = v['name']
                    },
                    {
                        type = "client",
                        event = Config.Events[v['type']]['event'][2],
                        icon = Config.Events[v['type']]['icon'][2],
                        label = Config.Events[v['type']]['label'][2],
                        zoneName = v['name']
                    },
                },
                distance = tonumber(v['distance'])
            })
        else
            local job = v['job']
            if v['type'] == "rate" or v['type'] == "tray" then
                job = false
            end
            exports[Config.TargetSystem]:AddBoxZone(v['name'], vector3(v['coords']['x'], v['coords']['y'], v['coords']['z']), v['height'], v['width'], {
                name = v['name'],
                heading = v['heading'],
                debugPoly = false,
                minZ = v['minZ'],
                maxZ = v['maxZ'],
            }, {
                options = {
                    {
                        name = v['job'],
                        type = "client",
                        event = Config.Events[v['type']]['event'],
                        icon = Config.Events[v['type']]['icon'],
                        label = Config.Events[v['type']]['label'],
                        job = job,
                        zoneName = v['name']
                    },
                },
                distance = tonumber(v['distance'])
            })
        end
    end
end)

RegisterNetEvent('av_restaurant:newBoxZone')
AddEventHandler('av_restaurant:newBoxZone', function(data)
	if data['type'] == "cashier" then
		exports[Config.TargetSystem]:AddBoxZone(data['name'], vector3(data['coords']['x'], data['coords']['y'], data['coords']['z']), data['height'], data['width'], {
			name = data['name'],
			heading = data['heading'],
			debugPoly = false,
			minZ = data['minZ'],
			maxZ = data['maxZ'],
		}, {
			options = {
				{
					type = "client",
					event = "av_restaurant:chargeCustomer",
					icon = Config.Events[data['type']]['icon'][1],
					label = Config.Events[data['type']]['label'][1],
					job = data['job'],
					zoneName = data['name']
				},
				{
					type = "client",
					event = "av_restaurant:pay",
					icon = Config.Events[data['type']]['icon'][2],
					label = Config.Events[data['type']]['label'][2],
					zoneName = data['name']
				},
			},
			distance = tonumber(data['distance'])
		})
	else
        local job = data['job']
        if data['type'] == "rate" or data['type'] == "tray" then
            job = false
        end
		exports[Config.TargetSystem]:AddBoxZone(data['name'], vector3(data['coords']['x'], data['coords']['y'], data['coords']['z']), data['height'], data['width'], {
			name = data['name'],
			heading = data['heading'],
			debugPoly = false,
			minZ = data['minZ'],
			maxZ = data['maxZ'],
		}, {
			options = {
				{
                    name = data['job'],
					type = "client",
					event = Config.Events[data['type']]['event'],
					icon = Config.Events[data['type']]['icon'],
					label = Config.Events[data['type']]['label'],
					job = job,
					zoneName = data['name']
				},
			},
			distance = tonumber(data['distance'])
		})
		
	end
end)

RegisterNetEvent('av_restaurant:removeZone')
AddEventHandler('av_restaurant:removeZone', function(name)
	exports[Config.TargetSystem]:RemoveZone(name)
end)