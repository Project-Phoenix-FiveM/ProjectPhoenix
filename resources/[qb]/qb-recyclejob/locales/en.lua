local Translations = {
    success = {
        you_have_been_clocked_in = "You Have Been Clocked In",
    },
    text = {
        point_enter_warehouse = "[E] Enter Warehouse",
        enter_warehouse= "Enter Warehouse",
        exit_warehouse= "Exit Warehouse",
        point_exit_warehouse = "[E] Exit Warehouse",
        clock_out = "[E] Clock Out",
        clock_in = "[E] Clock In",
        hand_in_package = "Hand In Package",
        point_hand_in_package = "[E] Hand In Package",
        get_package = "Get Package",
        point_get_package = "[E] Get Package",
        picking_up_the_package = "Picking up the package",
        unpacking_the_package = "Unpacking the package",
    },
    error = {
        you_have_clocked_out = "You Have Clocked Out"
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})