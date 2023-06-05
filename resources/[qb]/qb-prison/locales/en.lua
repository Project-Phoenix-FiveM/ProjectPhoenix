local Translations = {
    error = {
        ["missing_something"] = "It looks like you are missing something...",
        ["not_enough_police"] = "Not enough Police..",
        ["door_open"] = "The door is already open..",
        ["cancelled"] = "Process Canceled..",
        ["didnt_work"] = "It did not work..",
        ["emty_box"] = "The Box Is Empty..",
        ["injail"] = "You're in jail for %{Time} months..",
        ["item_missing"] = "You are missing an Item..",
        ["escaped"] = "You escaped... Get the hell out of here.!",
        ["do_some_work"] = "Do some work for sentence reduction, instant job: %{currentjob} ",
    },
    success = {
        ["found_phone"] = "You found a phone..",
        ["time_cut"] = "You've worked some time off your sentence.",
        ["free_"] = "You're free! Enjoy it! :)",
        ["timesup"] = "Your time is up! Check yourself out at the visitors center",
    },
    info = {
        ["timeleft"] = "Time Left: %{JAILTIME} months",
        ["lost_job"] = "You're Unemployed",
        ["sent_jail"] = "You've been sent to jail, but kept your job. Nice!",
        ["prison_stash"] = "Enter the Prisoner's CID",
        ["slot"] = "Citizen ID",
    }
}
Lang = Locale:new({
phrases = Translations,
warnOnMissing = true})
