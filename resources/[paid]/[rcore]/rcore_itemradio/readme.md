If you want install the radio by item to the car this is the way to do it.

Just go to the vehicle, give your self item thats defined in config

and double click in inventory on the item while in car.

---

What items to add?

radiocar

esx 1.2 (i dont have for 1.1 you need to add it by your self)

```SQL
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('radiocar_dismounter', 'radiocar_dismounter', '1', '0', '1')
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('radiocar', 'radiocar', '1', '0', '1')
```
qbcore

```LUA
['radiocar_dismounter'] = { ['name'] = 'radiocar_dismounter', ['label'] = 'radiocar_dismounter', ['weight'] = 100, ['type'] = 'item', ['image'] = 'radiocar.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'radiocar_dismounter' },
['radiocar'] = { ['name'] = 'radiocar', ['label'] = 'radiocar', ['weight'] = 100, ['type'] = 'item', ['image'] = 'radiocar.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'radiocar' },
```

---

What to change in config.lua in resource rcore_radiocar?

Config.OnlyCarWhoHaveRadio = true

---