local Translations = {
    error = {
        no_people_nearby = "Ingen spelare i närheten",
        no_vehicle_found = "Inget fordon kunde hittas",
        extra_deactivated = "Extra %{extra} har inaktiverats",
        extra_not_present = "Extra %{extra} finns inte till detta fordon",
        not_driver = "Du är inte föraren",
        vehicle_driving_fast = "Fordonet färdas för fort",
        seat_occupied = "Sätet är upptaget",
        race_harness_on = "Du har 4-punktsbälte på dig, det går inte att byta",
        obj_not_found = "Kunde inte skapa objektet",
        not_near_ambulance = "Du är inte nära en Ambulans",
        far_away = "Du är för långt borta",
        stretcher_in_use = "Den här båren används redan",
        not_kidnapped = "Du har inte kidnappat den här personen",
        trunk_closed = "Bakluckan är stängd",
        cant_enter_trunk = "Du kan inte hoppa in i bagageutrymmet",
        already_in_trunk = "Du är redan i bagageutrymmet",
        someone_in_trunk = "Det är redan någon i bagageutrymmet"
    },
    success = {
        extra_activated = "Extra %{extra} har aktiverats",
        entered_trunk = "Du är i bagageutrymmet"
    },
    info = {
        no_variants = "Det verkar inte finnas några variationer av detta",
        wrong_ped = "Denna ped-modellen är inte tillåten med detta alternativet",
        nothing_to_remove = "Du verkar inte ha något att ta bort",
        already_wearing = "Du har redan detta på dig",
        switched_seats = "Du är nu i %{seat}"
    },
    general = {
        command_description = "Öppna Radialmeny",
        push_stretcher_button = "[E] - Putta bår",
        stop_pushing_stretcher_button = "~g~E~w~ - Sluta putta",
        lay_stretcher_button = "[G] - Ligg på båren",
        push_position_drawtext = "Putta här",
        get_off_stretcher_button = "[G] - Kliv av båren",
        get_out_trunk_button = "[E] Hoppa ut ur bagageutrymmet",
        close_trunk_button = "[G] Stäng bagageluckan",
        open_trunk_button = "[G] Öppna bagageluckan",
        getintrunk_command_desc = "Hoppa in i bagageutrymmet",
        putintrunk_command_desc = "Stoppa spelare i bagageutrymmet"
    },
    options = {
        emergency_button = "Överfallslarm",
        driver_seat = "Förarsäte",
        passenger_seat = "Passagerarsäte",
        other_seats = "Andra säten",
        rear_left_seat = "Vänster baksäte",
        rear_right_seat = "Höger baksäte"
    },
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
