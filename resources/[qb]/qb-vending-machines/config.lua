Config = {}

--== EDIT THE PRICES TO WHATEVER YOU LIKE. I MADE THEM REALISTIC BUT YOU CAN CHANGE THEM==--

--PROPS--
Config.CoffeeMachineProp = {
    690372739,
}
Config.SnackMachineProp = {
    -654402915,
	-1034034125,
}
Config.FizzyMachineProp = {
    992069095,
	1114264700,
}
Config.WaterMachineProp = {
    1099892058,
    -742198632,
}

--===ITEMS IN EACH MACHINE===-----   ADD WHATEVER YOU WANT
Config.CoffeeItems = {
    label = "Coffee Machine",
        slots = 3,--slots must be same number as amount of items below
        items = {
            [1] = {
                name = "coffee",
                price = 2,
                amount = 5,
                info = {},
                type = "item",
                slot = 1,
            },
            [2] = {
                name = "latte-machiatto",
                price = 3,
                amount = 5,
                info = {},
                type = "item",
                slot = 2,
            },
            [3] = {
                name = "espresso",
                price = 2,
                amount = 5,
                info = {},
                type = "item",
                slot = 3,
            },
        }
    }
    Config.SnackItems = {
        label = "Snack Machine",
            slots = 7,--slots must be same number as amount of items below
            items = {
                [1] = {
                    name = "crisps",
                    price = 2,
                    amount = 5,
                    info = {},
                    type = "item",
                    slot = 1,
                },
                [2] = {
                    name = "egochaser",
                    price = 3,
                    amount = 5,
                    info = {},
                    type = "item",
                    slot = 2,
                },
                [3] = {
                    name = "nachos",
                    price = 2,
                    amount = 5,
                    info = {},
                    type = "item",
                    slot = 3,
                },
                [4] = {
                    name = "snikkel_candy",
                    price = 2,
                    amount = 5,
                    info = {},
                    type = "item",
                    slot = 4,
                },
                [5] = {
                    name = "meteorite-bar",
                    price = 2,
                    amount = 5,
                    info = {},
                    type = "item",
                    slot = 5,
                },
                [6] = {
                    name = "twerks_candy",
                    price = 2,
                    amount = 5,
                    info = {},
                    type = "item",
                    slot = 6,
                },
                [7] = {
                    name = "twix",
                    price = 2,
                    amount = 5,
                    info = {},
                    type = "item",
                    slot = 7,
                },
            }
        }
        Config.FizzyItems = {
            label = "Drinks Machine",
                slots = 7,--slots must be same number as amount of items below
                items = {
                    [1] = {
                        name = "cola",
                        price = 2,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 1,
                    },
                    [2] = {
                        name = "sprunk",
                        price = 3,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 2,
                    },
                    [3] = {
                        name = "orang-o-tang",
                        price = 2,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 3,
                    },
                    [4] = {
                        name = "grapejuice",
                        price = 2,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 4,
                    },
                    [5] = {
                        name = "cranberry",
                        price = 2,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 5,
                    },
                    [6] = {
                        name = "ecoladiet",
                        price = 2,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 6,
                    },
                    [7] = {
                        name = "sprunklight",
                        price = 2,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 7,
                    },
                }
            }
            Config.WaterItems = {
                label = "Drinks Machine",
                    slots = 4,--slots must be same number as amount of items below
                    items = {
                        [1] = {
                            name = "water_bottle",
                            price = 2,
                            amount = 5,
                            info = {},
                            type = "item",
                            slot = 1,
                        },
                        [2] = {
                            name = "water_bottle2",
                            price = 2,
                            amount = 5,
                            info = {},
                            type = "item",
                            slot = 2,
                        },
                    }
                }
        
