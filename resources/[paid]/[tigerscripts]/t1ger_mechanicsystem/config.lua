Config = {
	Debug = false, -- set  to false to disable debug
	SyncToDatabase = 10,  -- time in minutes to data from server file to database
	
	Menu = { -- settings for admin & mechanic menu
		['admin'] = {
			command = {enable = true, string = 'adminmech'}, -- enable/disable command, set command string.
			keybind = {enable = true, defaultMapping = 'F10'} -- enable/disable keybind, set default mapping (players edit button in-game inside GTA Settings)
		},
		['mechanic'] = {
			command = {enable = true, string = 'mechmenu'}, -- enable/disable command, set command string.
			keybind = {enable = true, defaultMapping = 'F7'} -- enable/disable keybind, set default mapping (players edit button in-game inside GTA Settings)
		},
	},

	ShopCreator = {
		grades = { -- default job grades that are created, once a shop is being created
			[1] = {grade = 0, name = 'recruit', label = 'Recruit', salary = 50},
			[2] = {grade = 1, name = 'employee', label = 'Employee', salary = 75},
			[3] = {grade = 2, name = 'boss', label = 'Boss', salary = 100, isboss = true}
			-- make sure boss grade is the very last one and has the 'isboss = true' as the only one!
		},
		defaultDuty = true, -- set default duty on qb core jobs (doesnt matter for esx)
		offDutyPay = false, -- set off duty payment on qb core jobs (doesnt matter for esx)
		blip = {sprite = 446, display = 4, scale = 0.75, color = 5},
	},

	Markers = {
		['duty'] = {
			enable = true,
			showMarker = true, -- show a marker in-game to see where to interact
			keybind = 38, -- key to interact with marker.
			blip = {enable = true, name = 'Duty Toggle', sprite = 280, display = 4, scale = 0.65, color = 0}, -- blip settings
			renderDist = 5.0, -- thread render dist to show marker
			interactDist = 1.0, -- interact dist to open menu
			menuTitle = 'Duty Toggle', -- menu title in context menu
			icon = 'toggle-on'-- icon in context menu
		},
		['boss'] = {
			enable = true,
			showMarker = true, -- show a marker in-game to see where to interact
			keybind = 38, -- key to interact with marker.
			blip = {enable = true, name = 'Boss Menu', sprite = 164, display = 4, scale = 0.65, color = 0}, -- blip settings
			renderDist = 5.0, -- thread render dist to show marker
			interactDist = 1.0, -- interact dist to open menu
			menuTitle = 'Boss', -- menu title in context menu
			icon = 'crown'-- icon in context menu
		},
		['garage'] = {
			enable = true, -- enable garage marker
			showMarker = true, -- show a marker in-game to see where to interact
			keybind = 38, -- key to interact with marker.
			blip = {enable = true, name = 'Garage', sprite = 357, display = 4, scale = 0.65, color = 0}, -- blip settings
			renderDist = 10.0, -- thread render dist to show marker
			interactDist = 1.0, -- interact dist to open menu
			menuTitle = 'Garage', -- menu title in context menu
			icon = 'car', -- icon in context menu
			useBuiltInGarage = true -- use the built in garage system, see documentation for reference.
		},
		['storage'] = {
			enable = true,
			showMarker = true, -- show a marker in-game to see where to interact
			keybind = 38, -- key to interact with marker.
			blip = {enable = true, name = 'Storage', sprite = 587, display = 4, scale = 0.65, color = 0}, -- blip settings
			renderDist = 5.0, -- thread render dist to show marker
			interactDist = 1.0,-- interact dist to open menu
			menuTitle = 'Storage',-- menu title in context menu
			icon = 'box', -- icon in context menu
			storage = {slots = 50, weight = 100000} -- set storage info in here
		},
		['workbench'] = {
			enable = true,
			showMarker = true, -- swhow a marker in-game to see where to interact
			keybind = 38, -- key to interact with marker.
			blip = {enable = true, name = 'Workbench', sprite = 566, display = 4, scale = 0.65, color = 0}, -- blip settings
			renderDist = 5.0, -- thread render dist to show marker
			interactDist = 1.0,-- interact dist to open menu
			menuTitle = 'Workbench',-- menu title in context menu
			icon = 'toolbox', -- icon in context menu
		},
		['repair'] = {
			enable = true,
			showMarker = true, -- show a marker in-game to see where to interact
			keybind = 38, -- key to interact with marker.
			blip = {enable = true, name = 'Quick Repair', sprite = 402, display = 4, scale = 0.65, color = 0}, -- blip settings
			renderDist = 5.0, -- thread render dist to show marker
			interactDist = 1.0,-- interact dist to open menu
			menuTitle = 'Repair',-- menu title in context menu
			icon = 'screwdriver-wrench', -- icon in context menu
			settings = {
				price = 200, -- price to quick repair
				duration = 2500, -- duration in ms for quick repair
				progressLabel = 'Quick Repairing Vehicle',
				allow = true, -- allow using quick repair if mechanics of the shop are online.
			},
		},
	},
	
	Items = {
		['props'] = {
			[1] = {name = 'roadcone', label = 'Road Cone'},
			[2] = {name = 'toolstrolley', label = 'Tools Trolley'},
			[3] = {name = 'toolbox', label = 'Tool Box'},
			[4] = {name = 'enginehoist', label = 'Engine Hoist'},
			[5] = {name = 'consign', label = 'Con Sign'},
			[6] = {name = 'roadbarrier', label = 'Road Barrier'},
		},
		['health'] = {
			[1] = {name = 'radiator', label = 'Radiator'},
			[2] = {name = 'fuel_pump', label = 'Fuel Pump'},
			[3] = {name = 'brakes', label = 'Brakes'},
			[4] = {name = 'drive_shaft', label = 'Drive Shaft'},
			[5] = {name = 'alternator', label = 'Alternator'},
			[6] = {name = 'clutch', label = 'Clutch'},
		},
		['service'] = {
			[1] = {name = 'oil_filter', label = 'Oil + Filter'},
			[2] = {name = 'air_filter', label = 'Air Filter'},
			[3] = {name = 'fuel_filter', label = 'Fuel Filter'},
			[4] = {name = 'coolant', label = 'Coolant'},
			[5] = {name = 'brake_fluid', label = 'Brake Fluid'},
			[6] = {name = 'steering_fluid', label = 'Power Steering Fluid'},
			[7] = {name = 'transmission_fluid', label = 'Transmission Fluid'},
			[8] = {name = 'spark_plugs', label = 'Spark Plugs'},
			[9] = {name = 'drive_belt', label = 'Drive Belt'},
			[10] = {name = 'flywheel', label = 'Flywheel'},
			[11] = {name = 'tires', label = 'Tires'},
		},
		['kits'] = {
			[1] = {name = 'repairkit', label = 'Repair Kit'},
			[2] = {name = 'repairkit_adv', label = 'Repair Kit Advanced'},
			[3] = {name = 'patchkit', label = 'Patch Kit'},
			[4] = {name = 'carjack', label = 'Car Jack'},
			[5] = {name = 'fuel_can', label = 'Fuel Can'},
			[6] = {name = 'jump_starter', label = 'Jump Starter'},
			[7] = {name = 'tire_repairkit', label = 'Tire Repair Kit'},
		},
		['bodyparts'] = {
			[1] = {name = 'part_door', label = 'Door'},
			[2] = {name = 'part_hood', label = 'Hood'},
			[3] = {name = 'part_trunk', label = 'Trunk'},
			[4] = {name = 'part_window', label = 'Window'},
			[5] = {name = 'part_wheel', label = 'Wheel'},
		},
		['materials'] = {
			[1] = {name = 'scrap_metal', label = 'Scrap Metal'},
			[2] = {name = 'steel', label = 'Steel'},
			[3] = {name = 'aluminium', label = 'Aluminium'},
			[4] = {name = 'plastic', label = 'Plastic'},
			[5] = {name = 'rubber', label = 'Rubber'},
			[6] = {name = 'electric_scrap', label = 'Electric Scrap'},
			[7] = {name = 'glass', label = 'Glass'},
			[8] = {name = 'copper', label = 'Copper'},
			[9] = {name = 'carbon_fiber', label = 'Carbon Fiber'},
			[10] = {name = 'brass', label = 'Brass'},
			[11] = {name = 'synthetic_oil', label = 'Synthetic Oil'},
			[12] = {name = 'acid', label = 'Acid'},
		},
	},

	InviteMember = {
		ShowFullName = true, -- set to false to only show player server id (prevent meta-gaming)
		Distance = 10.0 -- distance to players in area to include.
	},
	
	Lift = {
		Frame = 1409969679, -- model for frame dont touch
		Arms = -334789282, -- model for arms dont touch
		Distance = 2.0, -- dist to lift to interact
		Target = {
			['up'] = {label = 'Lift Up', icon = 'fa-sharp fa-solid fa-arrow-up'},
			['down'] = {label = 'Lift Down', icon = 'fa-sharp fa-solid fa-arrow-down'},
			['stop'] = {label = 'Lift Stop', icon = 'fa-regular fa-circle-stop'},
			['remove'] = {label = 'Remove Lift', icon = 'fa-solid fa-ban'},
		}
	},

	CarJack = { -- Car Jack
		ItemId = 4,
		Anim = {dict = 'missfinale_c2ig_11', name = 'pushcar_offcliff_f', blendIn = 3.0, blendOut = 3.0, duration = -1, flag = 49},
		Prop = {model = 'imp_prop_car_jack_01a', pos = {-0.40, -1.4, -0.8}, rot = {5.0, 0.0, -180.0}},
		Keybind = 38,
		HelpText = '~INPUT_PICKUP~ Attach Car Jack',
		Marker = {type = 27, scale = {0.35, 0.35, 0.35}, rgba = {255, 99, 71, 100}},
		Target = {label = 'Car Jack', icon = 'fa-solid fa-gamepad', dist = 2.0},
		MaxHeight = 10.0, -- max rot the car goes up, 10.0 is decent!
	},
	
	Degradation = {
		Mileage = {-- Mileage is almost based on distance shown in your in-game GPS. There could be a maximum of 5% (plus/minus) difference.
			metric = false, -- true is kilometers and false is miles
			unit = 'Miles', -- or 'KM' or 'Mi' or whatever
		},
		Value = {min = 5, max = 15}, -- between 0-100, ex: part health value 87.6%, randomized degradation value is 10, new part health value would be 77.6%.
		Parts = 2, -- amount of parts to degrade upon crash. Minimum is 1, maximum is 7. With set to 2, it select 2 random parts to degrade with x value.
		Delay = 60, -- delay in seconds between parts malfunction effect play. So default is every 60 seconds it plays effects if health part value is below 'MalfunctionValue'
		Collision = {
			enable = true, --[[
				- enable whether vehicle collision at given speed should apply degradation to health parts
				- you  can disable and add export for apply degradation to health part, if u have a better or another collision thread.
			]] 
			speed = 40, -- minimum speed in either KPH or MPH, before the collision is registered to apply crash degradation of parts
		},
		EnableEffects = true, -- set to false to not apply effects when service part is 0
		Malfunction = { -- 3 effects (ok is not accounted and is max, min is 0)
			failure = {label = 'MECHANICAL FAILURE', health = 0, msg = '%s (%s%s) requires replacement, mechanical failure.'}, -- value equal to or below 0 is failure
			defect = {label = 'DEFECT', health = 25, msg = '%s (%s%s) is defect, soon mechanical failure.'}, -- value equal to or below 25 is defect, (min = failure.health)
			worn = {label = 'WORN', health = 50, msg = '%s (%s%s) is worn, soon defect.'}, -- value equal to or below  50 is WORN, (min = defect.health)
			good = {label = 'GOOD', health = 100}, -- value equal to or below 100 (max) is OK, (min = worn.health)
		},
		Associated = 0.5, -- set % between 0.0 and 100.0 that associated health parts of defect service parts should decrease with. This happens every 1000 ms while driving. So between 0.5 - 5% is okay. 
	},

	Parts = {
		['health'] = { -- health 0-100% affected from in-game crashes, randomly. when below certain values, car acts weird based on parts and its value.
			['radiator'] = {label = 'Radiator', id = 1, health = 100.0, itemId = 1, service = {'oil_filter', 'coolant', 'drive_belt'}, icon = 'https://i.ibb.co/1MR32yx/radiator.png'},
			-- sets high engine temp, sets engine health to 200 causing smoke. 
			['fuel_pump'] = {label = 'Fuel Pump', id = 2, health = 100.0, itemId = 2, service = {'air_filter', 'fuel_filter', 'spark_plugs'}, icon = 'https://i.ibb.co/dLz16dK/fuel-pump.png'},
			-- high fuel consumption and vehicle stalling 
			['brakes'] = {label = 'Brakes', id = 3, health = 100.0, itemId = 3, service = {'brake_fluid'}, icon = 'https://i.ibb.co/h1xTL7B/brakes.png'},
			-- poor braking
			['drive_shaft'] = {label = 'Drive Shaft', id = 4, health = 100.0, itemId = 4, service = {'steering_fluid', 'drive_belt'}, icon = 'https://i.ibb.co/n3nxk31/drive-shaft.png'},
			-- poor steering, random steer while driving
			['alternator'] = {label = 'Alternator', 	id = 5, health = 100.0, itemId = 5, service = {'drive_belt'}, icon = 'https://i.ibb.co/Ct1cHpT/alternator.png'},
			-- if engine is running and speed <= 0 then it kills engine, making the vehicle unable to start
			['clutch'] = 	{label = 'Clutch', 		id = 6, health = 100.0, itemId = 6, service = {'transmission_fluid', 'flywheel'}, icon = 'https://i.ibb.co/5WLn48d/clutch.png'},
			--  difficult gear shifts, slower shifts
		},
		['service'] = { -- service parts based on in-game mileage. Set mileages here for each part. 
			['oil_filter'] = {label = 'Oil + Filter', id = 1, mileage = 50.0, itemId = 1, icon = 'https://i.ibb.co/X3mZwK5/oil-filter.png'},
			['air_filter'] = {label = 'Air Filter', id = 2, mileage = 120.0, itemId = 2, icon = 'https://i.ibb.co/TTWRjdq/air-filter.png'},
			['fuel_filter'] = {label = 'Fuel Filter', id = 3, mileage = 400.0, itemId = 3, icon = 'https://i.ibb.co/wyp34J9/fuel-filter.png'},
			['coolant'] = {label = 'Coolant', id = 4, mileage = 300.0, itemId = 4, icon = 'https://i.ibb.co/tXRgyDZ/coolant.png'},
			['brake_fluid'] = {label = 'Brake Fluid', id = 5, mileage = 300.0, itemId = 5, icon = 'https://i.ibb.co/HG6zvmD/brake-fluid.png'},
			['steering_fluid'] = {label = 'Power Steering Fluid', id = 6, mileage = 500.0, itemId = 6, icon = 'https://i.ibb.co/D7vrVv6/steering-fluid.png'},
			['transmission_fluid'] = {label = 'Transmission Fluid', id = 7, mileage = 450.0, itemId = 7, icon = 'https://i.ibb.co/QCtZKgY/transmission-fluid.png'},
			['spark_plugs'] = {label = 'Spark Plugs', id = 8, mileage = 400.0, itemId = 8, icon = 'https://i.ibb.co/1nvYGv2/spark-plugs.png'},
			['drive_belt'] = {label = 'Drive Belt', id = 9, mileage = 600.0, itemId = 9, icon = 'https://i.ibb.co/k88MBHt/drive-belt.png'},
			['flywheel'] = {label = 'Flywheel', id = 10, mileage = 900.0, itemId = 10, icon = 'https://i.ibb.co/CJ41qnJ/flywheel.png'},
			['tires'] = {label = 'Tires', id = 11, mileage = 600.0, itemId = 11, icon = 'https://i.ibb.co/jDfnrWk/tires.png'},
		},
	},

	Status = {
		Menu = {enable = false, label = 'Vehicle Status', icon = 'fa-solid fa-clipboard-user'},
		Target = {enable = true, label = 'Vehicle Status', icon = 'fa-solid fa-clipboard-user'},
		Distance = 2.5, -- distance from player to closest vehicle
		Options = {
			[1] = {value = 'engineHealth', label = 'Engine Health', icon = 'kit-medical', symbol = '%'},
			[2] = {value = 'bodyHealth', label = 'Body Health', icon = 'car', symbol = '%'},
			[3] = {value = 'tankHealth', label = 'Tank Health', icon = 'gas-pump', symbol = '%'},
			[4] = {value = 'fuelLevel', label = 'Fuel Level', icon = 'gauge', symbol = '%'},
			[5] = {value = 'dirtLevel', label = 'Dirt Level', icon = 'shower', symbol = '%'},
			[6] = {value = 'oilLevel', label = 'Oil Level', icon = 'oil-can', symbol = 'L'},
			[7] = {value = 'engineTemp', label = 'Engine Temperature', icon = 'temperature-high', symbol = '°C'},
			[8] = {value = 'mileage', label = 'Mileage', icon = 'road', symbol = ' KM'},
			[9] = {value = 'plate', label = 'License Plate', icon = 'id-card', symbol = ''},
		},
	},

	Service = {
		Parts = 'service',
		Distance = 2.5, -- distance from player to closest vehicle
		Menu = {enable = false, label = 'Service Check', icon = 'fa-solid fa-clipboard-check'},
		Target = {enable = true, label = 'Service Check', icon = 'fa-solid fa-clipboard-check'},
		EngineTemp = 50, -- deny to service if engine temp is > 50 (set to nil to disable this)
		Anim = {dict = 'mini@repair', name = 'fixing_a_player', blendIn = 4.0, blendOut = -4.0, flag = 49},
		Progbar = {duration = 2500, label = 'Replacing: %s'},
		Skillcheck = {enable = true, difficulty = {'easy', 'easy'}, inputs = {'w', 'a', 's', 'd'}},
	},

	Diagnose = {
		Parts = 'health',
		Distance = 2.5, -- distance from player to closest vehicle
		Menu = {enable = false, label = 'Diagnose Parts Condition', icon = 'fa-solid fa-clipboard-question'},
		Target = {enable = true, label = 'Diagnose Parts Condition', icon = 'fa-solid fa-clipboard-question'},
		EngineTemp = 50, -- deny to replace/repair if engine temp is > 50 (set to nil to disable this)
		Anim = {dict = 'mini@repair', name = 'fixing_a_player', blendIn = 4.0, blendOut = -4.0, flag = 49},
		Progbar = {duration = 2500, label = 'Replacing: %s'},
		Skillcheck = {enable = true, difficulty = {'easy', 'easy'}, inputs = {'w', 'a', 's', 'd'}},
		GiveMaterials = true, -- gives one material that is required to craft that specific part, between 1 and max is required amount of that material.
	},

	BodyRepair = {
		Menu = {enable = false, label = 'Body Repair', icon = 'fa-solid fa-car'},
		Target = {enable = true, label = 'Body Repair', icon = 'fa-solid fa-car'},
		Distance = 2.5, -- distance from player to closest vehicle
		Anim = {dict = 'anim@heists@box_carry@', name = 'idle', blendIn = 4.0, blendOut = 1.0, duration = -1, flags = 49},
		Inspection = {
			marker = {type = 27, scale = {0.35, 0.35, 0.35}, rgba = {255, 255, 0, 100}},
			textUi = {label = '[E] Inspect / [X] Abort', pos = 'right-center', icon = 'car'},
			keybind = 38, -- [E]
			progbar = {duration = 2500, label = 'Inspecting Vehicle'},
			anims = {
				['front'] = {dict = 'mp_intro_seq@', name = 'mp_mech_fix', blendIn = 4.0, blendOut = -4.0, flag = 1, heading = -180.0},
				['rear'] = {dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', name = 'machinic_loop_mechandplayer', blendIn = 4.0, blendOut = -4.0, flag = 1, heading = 0.0},
				['sideL'] = {dict = 'mp_car_bomb', name = 'car_bomb_mechanic', blendIn = 8.0, blendOut = -8.0, flag = 1, heading = -90.0},
				['sideR'] = {dict = 'missmechanic', name = 'work2_base', blendIn = 4.0, blendOut = -4.0, flag = 1, heading = 90.0},
			}
		},
		Install = {
			text = '~INPUT_PICKUP~ Install / ~INPUT_CREATOR_LT~ Cancel',
			keybind = {['install'] = 38, ['cancel'] = 252},
			skillcheck = {enable = true, difficulty = {'easy', 'easy', 'easy'}, inputs = {'w', 'a', 's', 'd'}},
			target = {label = 'Install %s', icon = 'fa-solid fa-car', distance = 5.0},
			cancel = {textUi = '[X] Cancel Install', keybind = 252}
		},
		SetFixed = {
			bodyHealth = 1000.0,
			engineHealth = nil, -- set number from 0.0-1000.0 to also fix engine health during body repairs, else leave at nil to disable.
		},
		Parts = {
			['door'] = {
				itemId = 1,
				type = 'doors',
				label = 'Door',
				prop = {model = 'imp_prop_impexp_car_door_04a', pos = {-0.7, -0.2, 0.0}, rot = {0.0, -10.0, 90.0}},
				anim = {dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', name = 'machinic_loop_mechandplayer', duration = -1, blendIn = 2.0, blendOut = 2.0, flag = 1}
			},
			['hood'] = {
				itemId = 2,
				type = 'doors',
				label = 'Hood',
				prop = {model = 'imp_prop_impexp_bonnet_04a', pos = {0.0, 0.20, 0.12}, rot = {-20.0, 0.0, 180.0}},
				anim = {dict = 'mini@repair', name = 'fixing_a_player', duration = -1, blendIn = 2.0, blendOut = 2.0, flag = 1}
			},
			['trunk'] = {
				itemId = 3,
				type = 'doors',
				label = 'Trunk',
				prop = {model = 'imp_prop_impexp_trunk_01a', pos = {0.0, 0.15, 0.1}, rot = {30.0, 0.0, 0.0}},
				anim = {dict = 'mini@repair', name = 'fixing_a_player', duration = -1, blendIn = 2.0, blendOut = 2.0, flag = 1}
			},
			['window'] = {
				itemId = 4,
				type = 'windows',
				label = 'Window',
				prop = {model = 'h4_prop_yacht_glass_04', pos = {0.0, -0.1, 0.3}, rot = {0.0, 0.0, 0.0}},
				anim = {dict = 'missmechanic', name = 'work_in', duration = -1, blendIn = 2.0, blendOut = 2.0, flag = 1}
			},
			['wheel'] = {
				itemId = 5,
				label = 'Wheel',
				type = 'wheels',
				prop = {model = 'imp_prop_impexp_tyre_01c', pos = {0.0, -0.1, 0.2}, rot = {0.0, 0.0, 0.0}},
				anim = {dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', name = 'machinic_loop_mechandplayer', duration = -1, blendIn = 2.0, blendOut = 2.0, flag = 1}
			},
		}
	},

	PatchKit = { -- Kit to set engine parts health to 5% in case they are failured (0%s)
		ItemId = 3,
		Skillcheck = {enable = true, difficulty = {'easy', 'easy'}, inputs = {'w', 'a', 's', 'd'}},
		Progbar = {duration = 2500, label = 'Using Patch Kit'},
		Anim = {dict = 'mini@repair', name = 'fixing_a_player', blendIn = 4.0, blendOut = -4.0, flag = 49, heading = 0.0},
		Values = {
			['health'] = 5, -- will set failured (0%) parts to 5%; set between 1-100.
			['service'] = 10, -- will set service part (0 mileage) to 10 mileage, max will be selected by script based on default config
		}
	},

	RepairKit = {
		['normal'] = {
			itemId = 1,
			skillcheck = {enable = true, difficulty = {'easy', 'easy'}, inputs = {'w', 'a', 's', 'd'}},
			progbar = {duration = 2500, label = 'Using Repair Kit'},
			anim = {dict = 'mini@repair', name = 'fixing_a_player', blendIn = 4.0, blendOut = -4.0, flag = 49, heading = 0.0},
			notify = 'Repair Kit used', -- set to '' to have no notifications
			engineHealth = 200.0, -- sets engine health to this value.
		},
		['advanced'] = {
			itemId = 2,
			skillcheck = {enable = true, difficulty = {'easy', 'easy'}, inputs = {'w', 'a', 's', 'd'}},
			progbar = {duration = 2500, label = 'Using Repair Kit Advanced'},
			anim = {dict = 'mini@repair', name = 'fixing_a_player', blendIn = 4.0, blendOut = -4.0, flag = 49, heading = 0.0},
			notify = 'Advanced Repair Kit used', -- set to '' to have no notifications
			engineHealth = 1000.0, -- sets engine health to this value.
		}
	},

	Emotes = {
		Keybind = 38, -- keybind to place prop,
		TextStr = '~INPUT_PICKUP~ Place Prop', -- display help text
		Distance = 2.0, -- distance to interact with prop
		Target = {
			[1] = {label = 'Remove', icon = 'fa-solid fa-trash'},
			[2] = {label = 'Carry/Push', icon = 'fa-solid fa-hand'},
		},
		Anim = {
			['push'] = {dict = 'anim@heists@box_carry@', name = 'idle', blendIn = 4.0, blendOut = 1.0, duration = -1, flags = 49},
			['pickup'] = {dict = 'random@domestic', name = 'pickup_low', blendIn = 5.0, blendOut = 1.0, duration = 1.0, flags = 48},
		},
		Props = {
			['-1036807324'] = {label = 'Road Cone', itemId = 1, model = 'prop_roadcone02a', bone = 28422, pos = {0.6,-0.15,-0.1}, rot = {315.0,288.0,0.0}},
			['-1776497660'] = {label = 'Tool Trolley', itemId = 2, model = 'prop_cs_trolley_01', push = true, bone = 28422, pos = {-0.1,-0.6,-0.85}, rot = {-180.0,-165.0,90.0}},
			['-1972842851'] = {label = 'Tool Box', itemId = 3, model = 'prop_tool_box_04', bone = 28422, pos = {0.4,-0.1,-0.1}, rot = {315.0,288.0,0.0}},
			['1742634574'] = {label = 'Engine Hoist', itemId = 4, model = 'prop_engine_hoist', push = true, bone = 28422, pos = {0.0,-0.5,-1.3}, rot = {-195.0,-180.0,180.0}},
			['-2146714905'] = {label = 'Con Sign', itemId = 5, model = 'prop_consign_02a', bone = 28422, pos = {0.0,0.2,-1.05}, rot = {-195.0,-180.0,180.0}},
			['-205311355'] = {label = 'Road Barrier', itemId = 6, model = 'prop_mp_barrier_02b', bone = 28422, pos = {0.0,0.2,-1.05}, rot = {-195.0,-180.0,180.0}}
		}
	},

	BreakDowns = {
		Label = 'Break Downs',
		Icon = 'truck-pickup',
		Description = 'NPC vehicle has a break-down and the vehicle cannot be repaired at scene. Bring a tow-truck and tow the vehicle back to your mechanic shop.',
		TravelDistance = 1000.0, -- Set minimum travel distance from ply coords to NPC job location.
		Blip = {label = 'NPC Break Down', sprite = 1, color = 5, scale = 0.7, route = {enable = true, color = 5}},
		RandomVehicles = {"sultan", "blista", "glendale", "exemplar"}, -- script scrambles random vehicle from this list to spawn.
		Marker = {distance = 5, type = 20, scale = {0.35, 0.35, 0.35}, rgba = {255, 99, 71, 100}},
		Actions = {
			['inspect'] = {
				marker = {distance = 10, type = 20, scale = {0.35, 0.35, 0.35}, rgba = {255, 99, 71, 100}},
				keybind = 38,
				textUi = '[E] Inspect Vehicle Engine',
				anim = {dict = 'mini@repair', name = 'fixing_a_player', flag = 1, blendIn = 2.0, blendOut = -2.0},
				progBar = {label = 'Inspecting Vehicle', duration = 5000},
			},
			['npc_talk'] = {
				distance = 5,
				keybind = 38,
				textUi = '[E] Ask NPC to follow',
			},
			['drop_off'] = {
				marker = {distance = 10, type = 27, scale = {3.5, 3.5, 3.5}, rgba = {255, 99, 71, 100}},
				textUi = 'Drop/Park Vehicle Inside Marker',
			},
			['collect'] = {
				keybind = 38,
				textUi = '~r~[E]~s~ Collect Payment',
				anim = {dict = 'mp_common', name = 'givetake2_a', flag = 49, blendIn = 4.0, blendOut = -4.0},
				progBar = {label = 'Collecting Payment', duration = 2000},
			},
		},
		Jobs = {
			[1] = { pos = {932.04,-62.5,78.76,85.98}, npc_pos = {931.58,-59.92,78.76,135.83}, inUse = false, ped = "s_m_y_dealer_01", dropoff = {-366.25,-124.89,38.7}, payout = {min = 250, max = 400}},
			[2] = { pos = {99.43,247.17,108.19,66.33}, npc_pos = {97.83,250.58,108.38,177.98}, inUse = false, ped = "s_m_y_dealer_01", dropoff = {-218.37,-1296.19,31.3}, payout = {min = 250, max = 400}},
			[3] = { pos = {167.33,-1460.1,29.14,138.45}, npc_pos = {171.92,-1458.62,29.24,126.2}, inUse = false, ped = "s_m_y_dealer_01", dropoff = {716.32,-1080.13,22.28}, payout = {min = 250, max = 400}},
		},
	},

	RoadSideRepairs = {
		Label = 'Road Side Repairs',
		Icon = 'screwdriver-wrench',
		Description = 'NPC vehicle may have a dead battery, ran out of fuel or a bursted tire. Bring your tools and make sure the NPC can get going again.',
		TravelDistance = 1000.0, -- Set minimum travel distance from ply coords to NPC job location.
		Blip = {label = 'Road Side Repair', sprite = 1, color = 5, scale = 0.7, route = {enable = true, color = 5}},
		RandomVehicles = {"sultan", "blista", "glendale", "exemplar"}, -- script scrambles random vehicle from this list to spawn.
		Marker = {distance = 5, type = 20, scale = {0.35, 0.35, 0.35}, rgba = {255, 99, 71, 100}},
		Keybind = 38,
		TextUi = '[E]',
		CollectCash = {markerType = 29, textUi = '[E] Collect Cash', keybind = 38},
		['fuel'] = {
			message = 'The vehicle ran out of fuel, please fill it up!',
			textUi = 'Fuel Vehicle',
			progBar = {label = 'Fuelling Vehicle', duration = 5000},
			anim = {dict = 'timetable@gardener@filling_can', name = 'gar_ig_5_filling_can', flag = 1, blendIn = 2.0, blendOut = 8.0},
			itemId = 5, -- set to nil if no items are required
		},
		['battery'] = {
			message = 'The vehicle battery is dead, please charge the battery!',
			textUi = 'Jump Start Battery',
			progBar = {label = 'Charging Battery', duration = 5000},
			anim = {dict = 'mini@repair', name = 'fixing_a_player', flag = 1, blendIn = 1.0, blendOut = -1.0},
			itemId = 6, -- set to nil if no items are required
		},
		['tire'] = {
			message = 'One of the tires have punctured, please repair the tire!',
			textUi = 'Fix Tire',
			progBar = {label = 'Fixing Tire', duration = 5000},
			anim = {dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', name = 'machinic_loop_mechandplayer', flag = 1, blendIn = 8.0, blendOut = -2.0},
			itemId = 7, -- set to nil if no items are required
		},
		Jobs = {
			[1] = { pos = {880.16,-34.66,78.75,240.94}, inUse = false, ped = 's_m_y_dealer_01', payout = {min = 250, max = 400}},
			[2] = { pos = {1492.09,758.45,77.45,288.26}, inUse = false, ped = 's_m_y_dealer_01', payout = {min = 250, max = 400}},
			[3] = { pos = {387.67,-767.56,29.29,358.94}, inUse = false, ped = 's_m_y_dealer_01', payout = {min = 250, max = 400}},
			[4] = { pos = {-583.75,-239.55,36.08,33.14}, inUse = false, ped = 's_m_y_dealer_01', payout = {min = 250, max = 400}},
			[5] = { pos = {350.12,345.60,105.15,73.70}, inUse = false, ped = 's_m_y_dealer_01', payout = {min = 250, max = 400}},
			[6] = { pos = {106.11,317.55,112.13,340.15}, inUse = false, ped = 's_m_y_dealer_01', payout = {min = 250, max = 400}},
			[7] = { pos = {-250.24,292.83,91.79,85.03}, inUse = false, ped = 's_m_y_dealer_01', payout = {min = 250, max = 400}},
			[8] = { pos = {-1325.35,275.32,63.41,215.43}, inUse = false, ped = 's_m_y_dealer_01', payout = {min = 250, max = 400}},
			[9] = { pos = {-1622.20,-237.69,53.93,158.74}, inUse = false, ped = 's_m_y_dealer_01', payout = {min = 250, max = 400}},
			[10] = { pos = {-1273.45,-1010.42,9.34,195.59}, inUse = false, ped = 's_m_y_dealer_01', payout = {min = 250, max = 400}},
		},
	},

	ScrapCars = {
		Label = 'Scrap Cars',
		Icon = 'recycle',
		Description = 'Pick up a scrap-vehicle and drop it at the scrapyard to disassemble the vehicle and receive some materials.',
		TravelDistance = 1000.0, -- Set minimum travel distance from ply coords to NPC job location.
		Blip = {label = 'Scrap Car - Pick Up', sprite = 1, color = 5, scale = 0.7, route = {enable = true, color = 5}},
		RandomVehicles = {"sultan", "blista", "glendale", "exemplar"}, -- script scrambles random vehicle from this list to spawn.
		Marker = {distance = 5, type = 20, scale = {0.35, 0.35, 0.35}, rgba = {255, 99, 71, 100}},
		Keybind = 38,
		TextUi = '[E]',
		Scrapyard = {
			model = 's_m_y_xmech_02_mp',
			dropoff = vector3(-457.29,-1713.84,18.64),
			spawnPos = vector4(-465.77,-1707.58,18.8,252.19),
			inspectPos = vector4(-459.98,-1712.81,18.67,240.04),
			scenarios = {['idle'] = 'WORLD_HUMAN_AA_SMOKE', ['work'] = 'WORLD_HUMAN_CLIPBOARD'}
		},
		Reward = {
			count = 4, -- how many types of random materials to receive, like alu, steel etc.
			amount = {min = 1, max = 5} -- of selected material, how many to receive randomly from min-max
		},
		Actions = {
			['drop_off'] = {
				marker = {distance = 20, type = 27, scale = {3.5, 3.5, 3.5}, rgba = {255, 99, 71, 100}},
				textUi = 'Drop/Park Vehicle Inside Marker',
			},
			['inspect'] = {
				keybind = 38,
				textUi = '[E] Scrap Vehicle',
			},
			['collect'] = {
				keybind = 38,
				textUi = '[E] Collect Payment',
				anim = {dict = 'mp_common', name = 'givetake2_a', flag = 49, blendIn = 4.0, blendOut = -4.0},
				progBar = {label = 'Collecting Rewards', duration = 2000},
			},
		},
		Jobs = {
			[1] = {pos = vector4(-367.42, -1521.98, 26.72, 174.32), inUse = false},
			[2] = {pos = vector4(-12.45, -1799.43, 26.4, 317.32), inUse = false},
			[3] = {pos = vector4(587.51, -1791.45, 21.08, 172.84), inUse = false},
			[4] = {pos = vector4(1043.62, -2130.04, 31.74, 262.95), inUse = false},
			[5] = {pos = vector4(1160.78, -1651.02, 35.92, 203.69), inUse = false},
			[6] = {pos = vector4(1118.26, -975.1, 45.49, 8.07), inUse = false},
			[7] = {pos = vector4(1100.01, -332.12, 66.21, 124.12), inUse = false},
			[8] = {pos = vector4(700.74, 254.74, 92.31, 237.35), inUse = false},
			[9] = {pos = vector4(177.77, 380.25, 108.03, 356.36), inUse = false},
			[10] = {pos = vector4(-1155.14, -228.36, 36.9, 314.13), inUse = false},
			[11] = {pos = vector4(320.33, -2034.69, 20.17, -38.61), inUse = false},
			[12] = {pos = vector4(-520.84, 574.89, 120.56, -78.21), inUse = false},
			[13] = {pos = vector4(-1452.84, -51.61, 52.75, 73.59), inUse = false},
			[14] = {pos = vector4(361.42, -2474.03, 5.90, -91.64), inUse = false},
			[15] = {pos = vector4(815.73, -2144.15, 28.81, -172.18), inUse = false},
			[16] = {pos = vector4(1300.98, -1736.43, 53.38, -159.24), inUse = false},
			[17] = {pos = vector4(1260.82, -1739.77, 49.13, 116.28), inUse = false},
			[18] = {pos = vector4(1228.02, -1606.06, 51.18, 35.05), inUse = false},
			[19] = {pos = vector4(1201.94, -1387.29, 34.72, 19.94), inUse = false},
			[20] = {pos = vector4(-1106.47, 791.78, 164.17, 13.24), inUse = false},
			[21] = {pos = vector4(-683.99, 602.62, 143.10, -31.46), inUse = false},
			[22] = {pos = vector4(318.58, 495.42, 152.24, -72.93), inUse = false},
			[23] = {pos = vector4(-2165.52, -277.60, 12.22, 157.83), inUse = false},
			[24] = {pos = vector4(-1539.14, -1004.59, 12.51, -104.60), inUse = false},
			[25] = {pos = vector4(-996.22, -1262.95, 5.27, -61.32), inUse = false},
			[26] = {pos = vector4(-135.45, -1971.81, 22.30, -61.32), inUse = false},
			[27] = {pos = vector4(-177.49, -2022.95, 27.12, -106.34), inUse = false},
			[28] = {pos = vector4(-3044.68, 112.43, 11.21, 138.63), inUse = false},
			[29] = {pos = vector4(1364.97, -2065.10, 51.49, 117.16), inUse = false},
			[30] = {pos = vector4(-1104.28, -1953.91, 12.65, 132.38), inUse = false}
		},
	},

	PushVehicle = {
		Enable = true, -- set to false to disable
		Dist = 2.0, -- distance to a vehicle
		DrawText = {
			dist = 4.0, -- distance to draw text visible
			str1 = 'Hold ~g~[LEFT SHIFT]~s~ to Push Vehicle',
			str2 = '~r~[BACKSPACE]~s~ to Stop Push',
			interactDist = 1.2 -- distance to key press works
		},
		HelpText = 'Steer vehicle with ~INPUT_MOVE_LEFT_ONLY~ and ~INPUT_MOVE_RIGHT_ONLY~',
		PushKey = 21, --  DEFAULT KEY: [LEFT SHIFT]
		StopKey = 177, --  DEFAULT KEY: [BACKSPACE]
		LeftKey = 34, --  DEFAULT KEY: [A]
		RightKey = 35, --  DEFAULT KEY: [D]
		Anim = {dict = 'missfinale_c2ig_11', lib = 'pushcar_offcliff_m', blendIn = 3.0, blendOut = 3.0, flag = 35}
	},
	
	FlipVehicle = {
		Enable = true, -- set to false to disable
		Dist = 2.0, -- distance to a vehicle
		DrawText = {
			dist = 4.0, -- distance to draw text visible
			str = '~r~[E]~s~ Flip Vehicle', -- draw text 
			keybind = 38, -- DEFAULT KEY: [E]
			interactDist = 1.0 -- distance to key press works
		},
		Scenario = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD',
		ProgBar = {duration = 3000, label = 'Flipping Vehicle'}
	},

	UnlockVehicle = {
		Enable = true, -- set to false to disable
		Dist = 2.0, -- distance to a vehicle
		DrawText = {
			dist = 4.0, -- distance to draw text visible
			str = '~r~[E]~s~ Unlock Vehicle', -- draw text 
			keybind = 38, -- DEFAULT KEY: [E]
			interactDist = 1.0 -- distance to key press works
		},
		Anim = {dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', name = 'machinic_loop_mechandplayer', blendIn = 3.0, blendOut = 3.0, flag = 31},
		ProgBar = {duration = 3000, label = 'Unlocking Vehicle'}
	},

	ImpoundVehicle = {
		Enable = true, -- set to false to disable
		Dist = 2.0, -- distance to a vehicle
		DrawText = {
			dist = 4.0, -- distance to draw text visible
			str = '~r~[E]~s~ Impound Vehicle', -- draw text 
			keybind = 38, -- DEFAULT KEY: [E]
			interactDist = 1.0 -- distance to key press works
		},
		Scenario = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD',
		ProgBar = {duration = 3000, label = 'Impounding Vehicle'}
	},
	
	FlatbedTowing = {
		Enable = true, -- set to false to disable
		Trucks = {
			['flatbed'] = {offset = {0.0, -2.0, 0.8}, boneIndex_name = 'bodyshell'}
		},
		Command = 'tow',
		DrawText = {
			attach = '~g~[E]~s~ Attach Vehicle',
			detach = '~g~[G]~s~ Detach Vehicle',
			dist = 5.0
		},
		AttachKey = 38, -- default E
		DetachKey = 47, -- default G
		InteractDist = 1.1,
		Marker = {drawDist = 10.0, type = 20, scale = {x = 0.50, y = 0.50, z = 0.50}, color = {r = 240, g = 52, b = 52, a = 100}},
		Blacklisted = {'flatbed', 'towtruck', 'cargobob'} -- vehicles that cannot be attached to flatbed
	},

	Workbench = {
		Enable = true, -- set to false to disable
		Duration = 2500, -- duration in ms for crafting
		ProgressLabel = 'Crafting %sx %s',
		Anim = {dict = 'mini@repair', name = 'fixing_a_player', blendIn = 8.0, blendOut = -8.0, flag = 49},
		SkillCheck = {enable = true, difficulty = {'easy', 'easy'}, inputs = {'w', 'a', 's', 'd'}},
		Categories = {
			['health'] = {-- HEALTH
				label = 'Auto Parts',
				description = 'Auto Parts that sets condition to 100%',
				icon = 'https://i.ibb.co/1MR32yx/radiator.png',
				recipe = {
					[1] = {
						menuTitle = 'Radiator',
						icon = 'https://i.ibb.co/1MR32yx/radiator.png',
						itemId = 1,
						materials = {
							['aluminium'] = 6,
							['copper'] = 4,
							['brass'] = 5,
							['plastic'] = 3,
						}
					},
					[2] = {
						menuTitle = 'Fuel Pump',
						icon = 'https://i.ibb.co/dLz16dK/fuel-pump.png',
						itemId = 2,
						materials = {
							['aluminium'] = 4,
							['steel'] = 2,
							['rubber'] = 1,
							['scrap_metal'] = 3,
							['plastic'] = 1,
						}
					},
					[3] = {
						menuTitle = 'Brakes',
						icon = 'https://i.ibb.co/h1xTL7B/brakes.png',
						itemId = 3,
						materials = {
							['steel'] = 4,
							['scrap_metal'] = 3,
							['copper'] = 2,
							['rubber'] = 1,
							['brass'] = 2,
						}
					},
					[4] = {
						menuTitle = 'Drive Shaft',
						icon = 'https://i.ibb.co/n3nxk31/drive-shaft.png',
						itemId = 4,
						materials = {
							['aluminium'] = 8,
							['steel'] = 12,
							['carbon_fiber'] = 4,
						}
					},
					[5] = {
						menuTitle = 'Alternator',
						icon = 'https://i.ibb.co/Ct1cHpT/alternator.png',
						itemId = 5,
						materials = {
							['aluminium'] = 9,
							['copper'] = 5,
							['plastic'] = 3,
							['brass'] = 1,
						}
					},
					[6] = {
						menuTitle = 'Clutch',
						icon = 'https://i.ibb.co/5WLn48d/clutch.png',
						itemId = 6,
						materials = {
							['steel'] = 4,
							['copper'] = 2,
							['glass'] = 1,
							['rubber'] = 2,
							['carbon_fiber'] = 1,
							['brass'] = 3,
						}
					},
				}
			},
			['service'] = {-- SERVICE
				label = 'Service Parts',
				description = 'Service Parts that sets mileage to new lifespan',
				icon = 'https://i.ibb.co/X3mZwK5/oil-filter.png',
				recipe = {
					[1] = {
						menuTitle = 'Oil + Filter',
						icon = 'https://i.ibb.co/X3mZwK5/oil-filter.png',
						itemId = 1,
						materials = {
							['scrap_metal'] = 6,
							['steel'] = 2,
							['rubber'] = 1,
							['plastic'] = 3,
							['synthetic_oil'] = 2,
						}
					},
					[2] = {
						menuTitle = 'Air Filter',
						icon = 'https://i.ibb.co/TTWRjdq/air-filter.png',
						itemId = 2,
						materials = {
							['scrap_metal'] = 5,
							['steel'] = 2,
							['aluminium'] = 3,
							['plastic'] = 4,
							['glass'] = 1,
						}
					},
					[3] = {
						menuTitle = 'Fuel Filter',
						icon = 'https://i.ibb.co/wyp34J9/fuel-filter.png',
						itemId = 3,
						materials = {
							['scrap_metal'] = 10,
							['steel'] = 2,
							['plastic'] = 3,
							['rubber'] = 1,
						}
					},
					[4] = {
						menuTitle = 'Coolant',
						icon = 'https://i.ibb.co/tXRgyDZ/coolant.png',
						itemId = 4,
						materials = {
							['plastic'] = 4,
							['acid'] = 3,
						}
					},
					[5] = {
						menuTitle = 'Brake Fluid',
						icon = 'https://i.ibb.co/HG6zvmD/brake-fluid.png',
						itemId = 5,
						materials = {
							['plastic'] = 4,
							['acid'] = 2,
							['synthetic_oil'] = 2,
						}
					},
					[6] = {
						menuTitle = 'Power Steering Fluid',
						icon = 'https://i.ibb.co/D7vrVv6/steering-fluid.png',
						itemId = 6,
						materials = {
							['plastic'] = 4,
							['acid'] = 3,
							['synthetic_oil'] = 4,
						}
					},
					[7] = {
						menuTitle = 'Transmission Fluid',
						icon = 'https://i.ibb.co/QCtZKgY/transmission-fluid.png',
						itemId = 7,
						materials = {
							['plastic'] = 4,
							['acid'] = 3,
							['synthetic_oil'] = 4,
						}
					},
					[8] = {
						menuTitle = 'Spark Plugs',
						icon = 'https://i.ibb.co/1nvYGv2/spark-plugs.png',
						itemId = 8,
						materials = {
							['scrap_metal'] = 4,
							['aluminium'] = 4,
							['copper'] = 2,
							['steel'] = 2,
							['plastic'] = 3,
						}
					},
					[9] = {
						menuTitle = 'Drive Belt',
						icon = 'https://i.ibb.co/k88MBHt/drive-belt.png',
						itemId = 9,
						materials = {
							['rubber'] = 10,
							['plastic'] = 2,
							['scrap_metal'] = 2,
						}
					},
					[10] = {
						menuTitle = 'Flywheel',
						icon = 'https://i.ibb.co/CJ41qnJ/flywheel.png',
						itemId = 10,
						materials = {
							['scrap_metal'] = 4,
							['aluminium'] = 6,
							['steel'] = 6,
						}
					},
					[11] = {
						menuTitle = 'Tires',
						icon = 'https://i.ibb.co/jDfnrWk/tires.png',
						itemId = 11,
						materials = {
							['rubber'] = 12,
							['plastic'] = 3,
							['acid'] = 1,
						}
					},
				}
			},
			['kits'] = { -- KITS
				label = 'Kits',
				description = 'Craft kits used for different repairs/interactions.',
				icon = 'https://i.ibb.co/gvS3M01/repairkit.png',
				recipe = {
					[1] = {
						menuTitle = 'Repair Kit',
						icon = 'https://i.ibb.co/gvS3M01/repairkit.png',
						itemId = 1,
						materials = {
							['scrap_metal'] = 10,
							['aluminium'] = 4,
							['plastic'] = 3,
							['rubber'] = 1,
						}
					},
					[2] = {
						menuTitle = 'Repair Kit Advanced',
						icon = 'https://i.ibb.co/jfYHMSh/repairkit-adv.png',
						itemId = 2,
						materials = {
							['scrap_metal'] = 10,
							['steel'] = 2,
							['aluminium'] = 4,
							['copper'] = 5,
							['plastic'] = 3,
							['rubber'] = 1,
							['carbon_fiber'] = 2,
						}
					},
					[3] = {
						menuTitle = 'Patch Kit',
						icon = 'https://i.ibb.co/Wk50FHW/patchkit.png',
						itemId = 3,
						materials = {
							['scrap_metal'] = 8,
							['copper'] = 2,
							['plastic'] = 6,
							['aluminium'] = 3,
							['rubber'] = 4,
						}
					},
					[4] = {
						menuTitle = 'Car Jack',
						icon = 'https://i.ibb.co/6RQKn5S/carjack.png',
						itemId = 4,
						materials = {
							['scrap_metal'] = 5,
							['copper'] = 2,
							['aluminium'] = 3,
							['rubber'] = 4,
						}
					},
					[5] = {
						menuTitle = 'Fuel Can',
						icon = 'https://i.ibb.co/pPdKc5X/fuel-can.png',
						itemId = 5,
						materials = {
							['plastic'] = 5,
							['rubber'] = 2,
						}
					},
					[6] = {
						menuTitle = 'Jump Starter',
						icon = 'https://i.ibb.co/1rrRy2x/jump-starter.png',
						itemId = 6,
						materials = {
							['scrap_metal'] = 2,
							['electric_scrap'] = 3,
							['plastic'] = 1,
						}
					},
					[7] = {
						menuTitle = 'Tire Repair Kit',
						icon = 'https://i.ibb.co/nLQNmHx/tire-repairkit.png',
						itemId = 7,
						materials = {
							['rubber'] = 2,
							['aluminium'] = 3,
							['plastic'] = 1,
						}
					},
				}
			},
			['bodyparts'] = { -- BODY PARTS
				label = 'Body Install Parts',
				description = 'Parts used to install in body repairs.',
				icon = 'https://i.ibb.co/gVmr95j/part-door.png',
				recipe = {
					[1] = {
						menuTitle = 'Door',
						icon = 'https://i.ibb.co/gVmr95j/part-door.png',
						itemId = 1,
						materials = {
							['scrap_metal'] = 3,
							['plastic'] = 2,
							['rubber'] = 1,
						}
					},
					[2] = {
						menuTitle = 'Hood',
						icon = 'https://i.ibb.co/87zZ0yT/part-bonnet.png',
						itemId = 2,
						materials = {
							['scrap_metal'] = 7,
							['aluminium'] = 3,
						}
					},
					[3] = {
						menuTitle = 'Trunk',
						icon = 'https://i.ibb.co/BPvG9kr/part-trunk.png',
						itemId = 3,
						materials = {
							['scrap_metal'] = 8,
							['steel'] = 2,
						}
					},
					[4] = {
						menuTitle = 'Window',
						icon = 'https://i.ibb.co/T8v92PD/part-window.png',
						itemId = 4,
						materials = {
							['scrap_metal'] = 1,
							['glass'] = 5,
						}
					},
					[5] = {
						menuTitle = 'Wheel',
						icon = 'https://i.ibb.co/9bhCDwr/part-wheel.png',
						itemId = 5,
						materials = {
							['scrap_metal'] = 3,
							['rubber'] = 4,
						}
					},
				}
			},
			['props'] = { -- PROPS
				label = 'Props',
				description = 'Props used for emotes/roleplay.',
				icon = 'https://i.ibb.co/zHrxrmc/roadcone.png',
				recipe = {
					[1] = {
						menuTitle = 'Road Cone',
						icon = 'https://i.ibb.co/zHrxrmc/roadcone.png',
						itemId = 1,
						materials = {
							['plastic'] = 6,
							['rubber'] = 2,
						}
					},
					[2] = {
						menuTitle = 'Tools Trolley',
						icon = 'https://i.ibb.co/jWVDFPJ/toolstrolley.png',
						itemId = 2,
						materials = {
							['scrap_metal'] = 4,
							['aluminium'] = 3,
							['plastic'] = 2,
						}
					},
					[3] = {
						menuTitle = 'Tool Box',
						icon = 'https://i.ibb.co/8zmmtr9/toolbox.png',
						itemId = 3,
						materials = {
							['scrap_metal'] = 3,
							['aluminium'] = 2,
							['rubber'] = 1,
						}
					},
					[4] = {
						menuTitle = 'Engine Hoist',
						icon = 'https://i.ibb.co/ygqQpWR/enginehoist.png',
						itemId = 4,
						materials = {
							['scrap_metal'] = 4,
							['aluminium'] = 3,
						}
					},
					[5] = {
						menuTitle = 'Con Sign',
						icon = 'https://i.ibb.co/gWkD0pP/consign.png',
						itemId = 5,
						materials = {
							['scrap_metal'] = 3,
							['steel'] = 2,
						}
					},
					[5] = {
						menuTitle = 'Road Barrier',
						icon = 'https://i.ibb.co/G00TYcr/roadbarrier.png',
						itemId = 5,
						materials = {
							['scrap_metal'] = 3,
							['plastic'] = 4,
						}
					},
				}
			},
		}
	},
}

