local Translations = {

    info = {
        status = {
            ['bolo'] = "BOLO",
            ['stolen'] = "STOLEN",
            ['warrant'] = "WARRANT",
            ['flagged'] = "FLAGGED",
            ['negative'] = "NEGATIVE",
        },
        class = {
            ['compact'] = "Compact", 
            ['sedan'] = "Sedan",
            ['suv'] = "SUV",
            ['coupe'] = "Coupe",
            ['muscle'] = "Muscle",
            ['sports_classic'] = "Classic",
            ['sports'] = "Sports",
            ['super'] = "Super",
            ['motorcycle'] = "Motorcycle",
            ['offroad'] = "Off-road",
            ['industrial'] = "Industrial",
            ['utility'] = "Utility",
            ['van'] = "Van",
            ['service'] = "Service",
            ['military'] = "Military",
            ['truck'] = "Truck",
        },
    },
    error = {
        ['readerdisabled'] = "Plate reader not engaged",
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})