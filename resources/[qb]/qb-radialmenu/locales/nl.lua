local Translations = {
    error = {
        no_people_nearby = "Geen spelers in de buurt",
        no_vehicle_found = "Geen voertuig gevonden",
        extra_deactivated = "Extra %{extra} is gedeactiveerd",
        extra_not_present = "Extra %{extra} was niet gevonden op het voertuig",
        not_driver = "Jij bent niet de bestuurder van het voertuig",
        vehicle_driving_fast = "Het voertuig rijd te snel",
        seat_occupied = "De stoel is bezet",
        race_harness_on = "Je hebt een race harnas om, je kunt niet veranderen van stoel",
        obj_not_found = "Kon opgevraagde object niet creëren",
        not_near_ambulance = "Jij bent niet in de buurt van een Ambulance",
        far_away = "Jij bent te ver weg",
        stretcher_in_use = "Het brancard is al in gebruikt",
        not_kidnapped = "Je hebt de persoon niet ontvoerd",
        trunk_closed = "De kofferbak is gesloten",
        cant_enter_trunk = "Je kunt niet in deze kofferbak stappen",
        already_in_trunk = "Je bent al in de kofferbak",
        someone_in_trunk = "Er zit al iemand in de kofferbak"
    },
    success = {
        extra_activated = "Extra %{extra} is geactiveerd",
        entered_trunk = "Je bent in de kofferbak"
    },
    info = {
        no_variants = "Er zijn hier geen varianten voor",
        wrong_ped = "Dit ped model heeft hier geen opties voor",
        nothing_to_remove = "Je hebt niks om af te zetten",
        already_wearing = "Je draagt dat al",
        switched_seats = "Je zit nu in de %{seat}"
    },
    general = {
        command_description = "Open Radial Menu",
        push_stretcher_button = "[E] - Duw Brancard",
        stop_pushing_stretcher_button = "[E] - Duwen Stoppen",
        lay_stretcher_button = "[G] - Lig Op Brancard",
        push_position_drawtext = "Duw Hier",
        get_off_stretcher_button = "[G] - Van Brancard Af Gaan",
        get_out_trunk_button = "[E] Stap uit de kofferbak",
        close_trunk_button = "[G] Sluit de kofferbak",
        open_trunk_button = "[G] Open de kofferbak",
        getintrunk_command_desc = "Stap In De Kofferbak",
        putintrunk_command_desc = "Zet een Speler in de Kofferbak"
    },
    options = {
        emergency_button = "Paniekknop",
        driver_seat = "Bestuurders stoel",
        passenger_seat = "Passagiers stoel",
        other_seats = "Andere stoel",
        rear_left_seat = "stoel links-achter",
        rear_right_seat = "stoel rechts-achter"
    },
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
