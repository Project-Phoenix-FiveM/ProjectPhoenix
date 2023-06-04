Config = {}
Config.ServiceExtensionOnEscape	= 5

Config.ServiceLocation = vector3(170.0552, -989.230, 30.091)

Config.ServiceLocations = {
	{ type = "cleaning", coords = vector3(172.3472, -1005.82, 29.337) },
	{ type = "cleaning", coords = vector3(176.5671, -1004.31, 29.333) },
	{ type = "cleaning", coords = vector3(198.6010, -1013.68, 29.303) },
	{ type = "cleaning", coords = vector3(195.5679, -1016.82, 29.359) },
	{ type = "cleaning", coords = vector3(191.2855, -1009.08, 29.311) },
	{ type = "cleaning", coords = vector3(185.9871, -1010.50, 29.319) },
	{ type = "cleaning", coords = vector3(177.5478, -1006.31, 29.331) },
	{ type = "cleaning", coords = vector3(185.8083, -1008.28, 29.320) },
	{ type = "gardening", coords = vector3(190.5050, -1003.26, 29.291) },
	{ type = "gardening", coords = vector3(199.2376, -1007.25, 29.291) },
	{ type = "gardening", coords = vector3(189.8262, -1004.42, 29.291) },
	{ type = "gardening", coords = vector3(186.8539, -997.449, 29.289) },
	{ type = "gardening", coords = vector3(181.3150, -997.791, 29.291) }
}

Config.Outfits = { -- Set their community service outfits when they go to community service
    enabled = true, -- If false, outfits wont change
    male = {
        mask = { item = 0, texture = 0 },
        arms = { item = 4, texture = 0 },
        shirt = { item = 15, texture = 0 },
        jacket = { item = 139, texture = 0 },
        pants = { item = 125, texture = 3 },
        shoes = { item = 18, texture = 0 },
        accessories = { item = 0, texture = 0 },
    },
    female = {
        mask = { item = 0, texture = 0 },
        arms = { item = 4, texture = 0 },
        shirt = { item = 2, texture = 0 },
        jacket = { item = 229, texture = 0 },
        pants = { item = 3, texture = 15 },
        shoes = { item = 72, texture = 0 },
        accessories = { item = 0, texture = 0 },
    },
}
