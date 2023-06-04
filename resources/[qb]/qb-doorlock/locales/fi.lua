local Translations = {
    error = {
        not_authorized = "Sinulla ei ole avaimia!",
        lockpick_fail = "Epäonnistui",
        screwdriverset_not_found = "Sinulla ei ole ruuvimeisseliä!",
        door_not_locked = "Ovi ei ole lukossa",
        door_not_lockpickable = "Ovea ei voi tiirikoida"
    },
    success = {
        lockpick_success = "Onnistui!"
    },
    general = {
        locking = "~r~Lukitaan..",
        unlocking = "~g~Avataan..",
        locked = "~r~Lukittu",
        unlocked = "~g~Auki",
        locked_button = "[~g~E~w~] - Lukittu",
        unlocked_button = "[~g~E~w~] - Avattu"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
