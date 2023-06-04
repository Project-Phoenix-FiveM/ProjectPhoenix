local Translations = {
    error = {
        no_money = 'Not enough money',
        too_far = 'You are too far from your Hot Dog Stand',
        no_stand = 'You do not have a hotdog stand',
        cust_refused = 'Customer Refused!',
        no_stand_found = 'Your hot dog stand was nowhere to be seen, You will not receive your deposit back!',
        no_more = 'You have no %{value} more about this in front of council',
        deposit_notreturned = 'You did not have a Hot Dog Stand',
        no_dogs = 'You do not have any hotdogs',
    },
    success = {
        deposit = 'You paid a $%{deposit} deposit!',
        deposit_returned = 'Your $%{deposit} deposit has been returned!',
        sold_hotdogs = '%{value} x Hotdog(\'s) sold for $%{value2}',
        made_hotdog = 'You made a %{value} Hot Dogs',
        made_luck_hotdog = 'You made %{value} x %{value2} Hot Dogs',
    },
    info = {
        command = "Delete Stand (Admin Only)",
        blip_name = 'Hotdog Stand',
        start_working = '[E] Start Working',
        start_work = 'Start Working',
        stop_working = '[E] Stop Working',
        stop_work = 'Stop Working',
        grab_stall = '[~g~G~s~] Grab Stall',
        drop_stall = '[~g~G~s~] Release Stall',
        grab = 'Grab Stall',
        prepare = 'Prepare Hotdog',
        toggle_sell = 'Toggle Selling',
        selling_prep = '[~g~E~s~] Hotdog prepare [Sale: ~g~Selling~w~]',
        not_selling = '[~g~E~s~] Hotdog prepare [Sale: ~r~Not Selling~w~]',
        sell_dogs = '[~g~7~s~] Sell %{value} x HotDogs for $%{value2} / [~g~8~s~] Reject',
        sell_dogs_target = 'Sell %{value} x HotDogs for $%{value2}',
        admin_removed = "Hot Dog Stand Removed",
        label_a = "Perfect (A)",
        label_b = "Rare (B)",
        label_c = "Common (C)"
    },
        keymapping = {
        gkey = 'Let go of hotdog stand',
        
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
