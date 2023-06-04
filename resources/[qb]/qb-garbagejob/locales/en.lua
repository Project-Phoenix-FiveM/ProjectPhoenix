local Translations = {
    error = {
        ["cancled"] = "Canceled",
        ["no_truck"] = "You have no truck!",
        ["not_enough"] = "Not Enough Money (%{value} required)",
        ["too_far"] = "You are too far away from the drop-off point",
        ["early_finish"] = "Due to early finish (Completed: %{completed} Total: %{total}), your deposit will not be returned.",
        ["never_clocked_on"] = "You never clocked on!",
        ["all_occupied"] = "All parking spots are occupied",
        ["job"] = "You must get the job from the job center",
    },
    success = {
        ["clear_routes"] = "Cleared users routes they had %{value} routes stored",
        ["pay_slip"] = "You got $%{total}, your payslip %{deposit} got paid to your bank account!",
    },
    target = {
        ["talk"] = 'Talk to Garbageman',
        ["grab_garbage"] = "Grab garbage bag",
        ["dispose_garbage"] = "Dispose Garbage Bag",
    },
    menu = {
        ["header"] = "Garbage Main Menu",
        ["collect"] = "Collect Paycheck",
        ["return_collect"] = "Return truck and collect paycheck here!",
        ["route"] = "Request Route",
        ["request_route"] = "Request a garbage Route",
    },
    info = {
        ["payslip_collect"] = "[E] - Payslip",
        ["payslip"] = "Payslip",
        ["not_enough"] = "You have not enough money for the deposit.. Deposit costs are $%{value}",
        ["deposit_paid"] = "You have paid $%{value} deposit!",
        ["no_deposit"] = "You have no deposit paid on this vehicle..",
        ["truck_returned"] = "Truck returned, collect your payslip to receive your pay and deposit back!",
        ["bags_left"] = "There are still %{value} bags left!",
        ["bags_still"] = "There is still %{value} bag over there!",
        ["all_bags"] = "All garbage bags are done, proceed to the next location!",
        ["depot_issue"] = "There was an issue at the depot, please return immediately!",
        ["done_working"] = "You are done working! Go back to the depot.",
        ["started"] = "You have started working, location marked on GPS!",
        ["grab_garbage"] = "[E] Grab a garbage bag",
        ["stand_grab_garbage"] = "Stand here to grab a garbage bag.",
        ["dispose_garbage"] = "[E] Dispose of Garbage Bag",
        ["progressbar"] = "Putting bag in trashmaster ..",
        ["garbage_in_truck"] = "Put the bag in your truck..",
        ["stand_here"] = "Stand here..",
        ["found_crypto"] = "You found a cryptostick on the floor",
        ["payout_deposit"] = "(+ $%{value} deposit)",
        ["store_truck"] =  "[E] - Store Garbage Truck",
        ["get_truck"] =  "[E] - Garbage Truck",
        ["picking_bag"] = "Grabbing garbage bag..",
        ["talk"] = "[E] Talk to Garbage Man",
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
