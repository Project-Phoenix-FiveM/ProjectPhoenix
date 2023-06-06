Dumpster Diving script for QBCore.

Dependecies: 
qb-core
qb-target

Paste this in qb-target Config.lua

```
Config.TargetModels = {
["trashsearch"] = {
        models = {
	-1096777189,
	666561306,
	1437508529,
	-1426008804,
	-228596739,
	161465839,
	651101403,
        -58485588,
        218085040,
        -206690185,

        },
        options = {
            {
                type = "client",
                event = "qb-trashsearch:client:searchtrash",
                icon = "fas fa-dumpster",
                label = "Dumpster Dive",
            },
        },
        distance = 3.0
    },
