local Translations = {
    error = {
        lockpick_fail = "Mislukt",
        door_not_found = "Model hash niet ontvangen, als de door transparant is, zorg ervoor dat je op de kader van de deur richt",
        same_entity = "Beide deuren kunnen niet hetzelfde object zijn",
        door_registered = "Deze deur is al geregistreerd"
    },
    success = {
        lockpick_success = "Succes"
    },
    general = {
        locked = "Vergrendeld",
        unlocked = "Ontgrendeld",
        locked_button = "[E] - Vergrendeld",
        unlocked_button = "[E] - Ontgrendeld",
        keymapping_description = "Deuren vergendelen/ontgrendelen",
        locked_menu = "Vergrendeld",
        pickable_menu = "Lockpickbaar",
        distance_menu = "Max Afstand",
        item_authorisation_menu = "Item Autorsatie",
        citizenid_authorisation_menu = "CitizenID Autorisatie",
        gang_authorisation_menu = "Gang Autorisatie",
        job_authorisation_menu = "Baan Autorisatie",
        doortype_title = "Deurtype",
        doortype_door = "Enkele Deur",
        doortype_double = "Dubbele Deur",
        doortype_sliding = "Enkel Schuifdeur",
        doortype_doublesliding = "Dubbel Schuifdeur",
        doortype_garage = "Garage",
        doorname_title = "Deurnaam",
        configfile_title = "Config Bestandsnaam",
        submit_text = "Bevestig",
        newdoor_menu_title = "Voeg een nieuwe deur toe",
        newdoor_command_description = "Voeg een nieuwe deur toe aan het deurslot systeem",
        warning = "Waarschuwing",
        created_by = "gemaakt door",
        warn_no_permission_newdoor = "%{player} (%{license}) probeerde een nieuwe deur toe te voegen zonder permissie (source: %{source})",
        warn_no_authorisation = "%{player} (%{license}) probeerde een deur te openen zonder autorisatie (Stuurde: %{doorID})",
        warn_wrong_doorid = "%{player} (%{license}) probeerde een ongeldige deur te updaten (Stuurde: %{doorID})",
        warn_wrong_state = "%{player} (%{license}) stuurde een ongelidge waarde door voor het ver-/ontgrendelen (Stuurde: %{state})",
        warn_wrong_doorid_type = "%{player} (%{license}) stuurde een ongeldige deurID waarde (Stuurde: %{doorID})",
        warn_admin_privilege_used = "%{player} (%{license}) opende een deur met admin privileges"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})