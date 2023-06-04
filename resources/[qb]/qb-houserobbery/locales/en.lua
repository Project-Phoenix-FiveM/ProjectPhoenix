local Translations = {
    error = {
        ["missing_something"] = "It looks like you are missing something...",
        ["not_enough_police"] = "Not enough Police..",
        ["door_open"] = "The door is already open..",
        ["process_cancelled"] = "Process Canceled..",
        ["didnt_work"] = "It did not work..",
        ["emty_box"] = "The Box Is Empty..",
    },
    success = {
        ["worked"] = "It worked!",
    },
    info = {
        ["palert"] = "Attempted House Robbery",
        ["henter"] = "~g~E~w~ - To Enter",
        ["hleave"] = "~g~E~w~ - To leave house",
        ["aint"] = "~g~E~w~ - ",
        ["hsearch"] = "Searching..",
        ["hsempty"] = "Empty..",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
