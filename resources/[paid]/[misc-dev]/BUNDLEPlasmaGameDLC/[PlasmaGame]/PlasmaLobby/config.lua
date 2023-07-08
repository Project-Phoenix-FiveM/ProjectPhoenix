HaveTeamDeathMatch = true
HaveCaptureTheOrbs = true
HaveRandomWeapon   = true
HaveBurningMode    = false

MaxPlayerPerTeam = 10
MaxRound = 10

GunName = "WEAPON_PLASMAP" --The Gun used in game. You can have weird issue if you use classic GTA Weapon, I recommend to use modded ADDON (no replace) gun.
GunDamage = 10.0 -- The damage that the gun Deal. You have to put here the damage that the gun deal, its used to heal player after taking a shot.

ShowBlips = true

LstGun = {
	 "WEAPON_PLASMAP",
	 "WEAPON_RAZORBACK",
	 "WEAPON_NEEDLER2",
	 "WEAPON_RAYSHOTGUN"
}
print("Lst Gun : "..tostring(#LstGun))
Maps = {
	["Patoche"] = {
	["Available"] = true,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
	
	["AvailableSpawnSize"] = 2.0,
	
	["blueCoords"] = 	{x=-1183.9326171875,y=-1249.4671630859,z=-80.570420837402},
	["redCoords"] = 	{x=-1120.9388427734,y=-1225.8797607422,z=-80.570520019531},
	["blueFlagCoords"] ={x=-1169.3337402344,y=-1241.2327880859,z=-79.97046661377,h=268.0901184082},
	["redFlagCoords"] = {x=-1133.798828125,y=-1240.5598144531,z=-79.97045135498,h=90.27668762207},
	["mapRedOutCoords"] = {{x=-1121.7076416016,y=-1231.3385009766,z=-79.970596313477,h=176.43196105957}},
	["mapBlueOutCoords"] = {{x=-1183.0317382812,y=-1242.7570800781,z=-79.970611572266,h=2.2128314971924}},
	},

	["Patochemap2"] = {
	["Available"] = true,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
	
	["AvailableSpawnSize"] = 2.0,

	["blueCoords"] = 	{x=-1097.5137939453,y=-1429.8746337891,z=-71.579364013672},
	["redCoords"] = 	{x=-1108.9516601563,y=-1328.4270019531,z=-78.787593078613},
	
	["blueFlagCoords"] ={x=-1112.6137695312,y=-1427.3035888672,z=-71.685882568359,h=165.08520507812},
	["redFlagCoords"] = {x=-1122.8338623047,y=-1347.7055664062,z=-78.085609436035,h=209.87617492676},
	["mapRedOutCoords"] = {{x=-1104.5452880859,y=-1326.2833251953,z=-78.087524414063,h=176.43196105957}},
	["mapBlueOutCoords"] = {{x=-1103.1622314453,y=-1431.7769775391,z=-70.879447937012,h=2.2128314971924}},
	},

	["Patochemap3"] = {
	["Available"] = true,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = false, -- Is Team Death Match available on this map ?
	["Random Weapon"] = false, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = false, -- Is BurningMode available on this map ?
	
	["AvailableSpawnSize"] = 2.0,
	
	["blueCoords"] = 	{x=-1090.0092773438,y=-1427.6304931641,z=-41.027398681641},
	["redCoords"] = 	{x=-1083.7407226563,y=-1299.4934082031,z=-45.292984008789},
	["blueFlagCoords"] ={x=-1077.9738769531,y=-1383.4310302734,z=-41.58277130127,h=304.73278808594},
	["redFlagCoords"] = {x=-1121.5606689453,y=-1319.9503173828,z=-42.036640167236,h=114.33976745605},
	["mapRedOutCoords"] = {{x=-1081.9830322266,y=-1305.0971679688,z=-44.792984008789,h=176.43196105957}},
	["mapBlueOutCoords"] = {{x=-1096.5679931641,y=-1429.9207763672,z=-40.427394866943,h=2.2128314971924}},
	},

	["Patochemap4"] = { --AZTEC
	["Available"] = true,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
		
	["AvailableSpawnSize"] = 2.0,

	["blueCoords"] = 	{x=-1235.5562744141,y=-1232.0369873047,z=-56.227939605713},
	["redCoords"] = 	{x=-1085.3438720703,y=-1248.7126464844,z=-55.601230621338},
	["blueFlagCoords"] ={x=-1220.6120605469,y=-1263.7020263672,z=-55.964233398438,h=248.93444824219},
	["redFlagCoords"] = {x=-1121.197265625,y=-1237.6328125,z=-55.801792144775,h=358.17263793945},
	["mapRedOutCoords"] = {{x=-1085.8603515625,y=-1253.8758544922,z=-55.101226806641,h=176.43196105957}},
	["mapBlueOutCoords"] = {{x=-1235.4989013672,y=-1224.4533691406,z=-55.727935791016,h=2.2128314971924}},
	},

	["Patochemap5"] = {
	["Available"] = true,
	["Capture The Orbs"] = true, -- Is Capture the Flag available on this map ?
	["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	["Burning Mode"] = true, -- Is BurningMode available on this map ?
		
	["AvailableSpawnSize"] = 2.0,
	
	["blueCoords"] = 	{x=-1145.4281005859,y=-1399.2927246094,z=-99.054084777832},
	["redCoords"] = 	{x=-1082.7657470703,y=-1351.5090332031,z=-99.054061889648},
	["blueFlagCoords"] ={x=-1123.5582275391,y=-1382.2653808594,z=-98.558753967285,h=306.86685180664},
	["redFlagCoords"] = {x=-1105.9055175781,y=-1368.3715820312,z=-98.558753967285,h=278.59298706055},
	["mapRedOutCoords"] = {{x=-1081.5863037109,y=-1354.6971435547,z=-98.554061889648,h=176.43196105957}},
	["mapBlueOutCoords"] = {{x=-1147.2255859375,y=-1395.5275878906,z=-98.554069519043,h=2.2128314971924}},
	},
	
	--["MarcMLO"] = {
	--["Available"] = false,
	--["Capture The Orbs"] = false, -- Is Capture the Flag available on this map ?
	--["Team DeathMatch"] = true, -- Is Team Death Match available on this map ?
	--["Random Weapon"] = true, -- Is RandomWeapon available on this map ?
	--["Burning Mode"] = true, -- Is BurningMode available on this map ?
	--
	--["AvailableSpawnSize"] = 2.0,
	--
	--["blueCoords"] = {x=587.72491455078,y=2753.2062988281,z=46.993984222412},
	--["redCoords"] = {x=594.78063964844,y=2753.9221191406,z=46.993988037109},
	--["blueFlagCoords"] = {x=579.14154052734,y=2745.5856933594,z=42.142532348633,h=3.0212199687958},
	--["redFlagCoords"] = {x=604.88806152344,y=2747.576171875,z=42.142490386963,h=7.2482562065125},
	--
	--["mapRedOutCoords"] = {{x=595.02532958984,y=2757.8576660156,z=42.142501831055,h=354.65277099609}},
	---- ["mapBlueOutCoords"] = {x=-1121.7076416016,y=-1231.3385009766,z=-79.970596313477,h=176.43196105957},
	--},
}


PaintBallShop = {
	["PlasmaGame One"] = {
		["Blip"] = {x=-1084.7562255859,y=-1280.9090576172,z=5.6599960327148,sprite=650,scale=0.8,colour=2},
		["Create"] = {{x=-1095.1264648438,y=-1269.3354492188,z=5.8505229949951}},
		["Join"] = 	{
					{x=-1098.5012207031,y=-1270.7672119141,z=5.8445701599121},
					{x=-1087.3604736328,y=-1264.7006835938,z=5.8445706367493}
					},
		["Out"] = {x=-1098.0637207031,y=-1273.4953613281,z=4.8445663452148},
		["MapAvailable"] = {"Patoche","MarcMLO","Patochemap2","Patochemap3","Patochemap4","Patochemap5"},
		
	
	},

	["Plasma 3000"] = {
		["Blip"] = {x=-2249.6872558594,y=197.3249206543,z=174.60237121582,h=115.09670257568,sprite=650,scale=0.8,colour=1},
		["Create"] = {{x=-2236.0327148438,y=207.17329406738,z=174.85327148438,h=298.05242919922}},
		["Join"] = 	{
					{x=-2236.6467285156,y=210.18165588379,z=174.84729003906,h=23.64063835144},
					{x=-2231.1970214844,y=198.7681427002,z=174.84747314453,h=285.80697631836},
					},
		["Out"] = {x=-2239.7763671875,y=206.87864685059,z=174.84732055664,h=299.00036621094},
		["MapAvailable"] = {"Patoche","MarcMLO","Patochemap2","Patochemap3","Patochemap4","Patochemap5"},
		
	
	},
}

FemaleOutfit = {
[3] = {model = 8, colorA = 0, colorB = 0},       -- Torso / Arms / Bras
[4] = {model = 98, colorA = 2, colorB = 1},      -- Legs / Pants / Jambe
[6] = {model = 71, colorA = 2, colorB = 1},      -- Feet / Shoes / Chaussure
                                                
[7] = {model = 0, colorA = 0, colorB = 0},       --Accessories / Accessoires
[8] = {model = 8, colorA = 0, colorB = 0},       --Undershirt / T-Shirt
[11] = {model = 254, colorA = 2, colorB = 1}     --Tops / Veste
                                                
}                                                
                                                
MaleOutfit = {                              
[3] = {model = 7, colorA = 0, colorB = 0},       -- Torso / Arms / Bras
[4] = {model = 95, colorA = 2, colorB = 1},      -- Legs / Pants / Jambe
[6] = {model = 68, colorA = 2, colorB = 1},      -- Feet / Shoes / Chaussure
                                                
[7] = {model = 0, colorA = 0, colorB = 0},       --Accessories / Accessoires
[8] = {model = 15, colorA = 0, colorB = 0},      --Undershirt / T-Shirt
[11] = {model = 246, colorA = 2, colorB = 1},    --Tops / Veste
}


--Custom Mask :
useCustomMask = true

FemaleMask = {
[1]={model = 107, colorA = 7, colorB = 1},
[2]={model = 108, colorA = 0, colorB = 1}
}

MaleMask = {
[1]={model = 107, colorA = 7, colorB = 1},
[2]={model = 108, colorA = 0, colorB = 1}
}