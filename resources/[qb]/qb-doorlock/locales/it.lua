local Translations = {
    error = {
        not_authorized = "Non autorizzato",
        lockpick_fail = "Fallito",
        screwdriverset_not_found = "Non hai un set di cacciaviti",
        door_not_locked = "Questa porta non è chiusa",
        door_not_lockpickable = "Questa porta non può essere scassinata"
    },
    success = {
        lockpick_success = "Successo"
    },
    general = {
        locking = "~r~Chiudendo..",
        unlocking = "~g~Aprendo..",
        locked = "~r~Chiuso",
        unlocked = "~g~Aperto",
        locked_button = "[~g~E~w~] - Chiuso",
        unlocked_button = "[~g~E~w~] - Aperto"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
