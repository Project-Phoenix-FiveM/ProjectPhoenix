local Translations = {
    error = {
        minimum_store_robbery_police = "Not Enough Police (%{MinimumStoreRobberyPolice} Required)",
        not_driver = "You Are Not The Driver",
        demolish_vehicle = "You Are Not Allowed To Demolish Vehicles Now",
        process_canceled = "Process canceled..",
        you_broke_the_lock_pick = "You Broke The Lock Pick",
    },
    text = {
        the_cash_register_is_empty = "The Cash Register Is Empty",
        try_combination = "~g~E~w~ - Try Combination",
        safe_opened = "Safe Opened",
        emptying_the_register= "Emptying The Register..",
        safe_code = "Safe Code: "
    },
    email = {
        shop_robbery = "10-31 | Shop Robbery",
        someone_is_trying_to_rob_a_store = "Someone Is Trying To Rob A Store At %{street} (CAMERA ID: %{cameraId1})",
        storerobbery_progress = "Storerobbery in progress"
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
