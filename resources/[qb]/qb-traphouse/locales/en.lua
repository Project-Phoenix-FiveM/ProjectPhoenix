local Translations = {
    error = {
        not_enough = "You dont have enough cash..",
        no_slots = "There Are No Slots Left",
        occured = "Error Has Occurred",
        have_keys = "This Person Already Has Keys",
        p_have_keys = "%{value} This Person Already Has Keys",
        not_owner = "You Do Not Own A Traphouse Or Are Not The Owner",
        not_online = "This Person Is Not In The City",
        no_money = "There isn't any money in the cupboard",
        incorrect_code = "This Code Is Incorrect",
        up_to_6 = "You Can Give Up To 6 People Access To The Trap House!",
        cancelled = "Acquisitions Canceled",
    },
    success = {
        added = "%{value} Has Been Added To The Traphouse!",
    },
    info = {
        enter = "Enter Traphouse",
        give_keys = "Give Keys of Traphouse",
        pincode = "Traphouse Pincode: %{value}",
        taking_over = "Taking Over",
        pin_code_see = "~b~G~w~ - See Pin Code",
        pin_code = "Pincode: %{value}",
        multikeys = "~b~/multikeys~w~ [id] - To Give Keys",
        take_cash = "~b~E~w~ - Take Cash (~g~$%{value}~w~)",
        inventory = "~b~H~w~ - View Inventory",
        take_over = "~b~E~w~ - Take Over (~g~$5000~w~)",
        leave = "~b~E~w~ - Leave Traphouse",
    },
    targetInfo = {
        options = "Traphouse Options",
        enter = "Enter Traphouse",
        give_keys = "Give Keys of Traphouse",
        pincode = "Traphouse Pincode: %{value}",
        taking_over = "Taking Over",
        pin_code_see = "See Pin Code",
        pin_code = "Pincode: %{value}",
        multikeys = "Give Keys (use /multikey [id])",
        take_cash = "Take Cash ($%{value})",
        inventory = "View Inventory",
        take_over = "Take Over ($5000)",
        leave = "Leave Traphouse",
        close_menu = "⬅ Close Menu",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
