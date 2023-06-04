local Translations = {
    error = {
        no_people_nearby = "Ühtegi mängijat pole läheduses",
        no_vehicle_found = "Ühtegi sõidukit ei leitud",
        extra_deactivated = "Lisa %{extra} on deaktiveeritud",
        extra_not_present = "Lisa %{extra} ei ole autole paigaldatud",
        not_driver = "Sa pole sõiduki juht",
        vehicle_driving_fast = "See sõiduk sõidab liiga kiiresti",
        seat_occupied = "See koht on juba võetud",
        race_harness_on = "Sul on kihutamisega probleeme, sa ei saa kohta vahetada",
        obj_not_found = "Ei saanud tekitada soovitud objekti",
        not_near_ambulance = "Sa pole Haigla/meediku lähedal",
        far_away = "Sa oled liiga kaugel",
        stretcher_in_use = "See kanderaam on juba kasutusel",
        not_kidnapped = "Te ei röövinud seda inimest",
        trunk_closed = "Pagasiruum on suletud",
        cant_enter_trunk = "Sellesse pagasiruumi sa ei pääse",
        already_in_trunk = "Sa oled juba pagasiruumis",
        someone_in_trunk = "Keegi on juba pagasiruumis"
    },
    success = {
        extra_activated = "Lisa %{extra} on aktiveeritud",
        entered_trunk = "Sa oled pagasiruumis"
    },
    info = {
        no_variants = "Selle jaoks ei paista ühtegi varianti olevat",
        wrong_ped = "See ped-mudel ei võimalda seda valikut",
        nothing_to_remove = "Näib, et teil pole midagi eemaldada",
        already_wearing = "Sa juba kannad seda",
        switched_seats = "Sa oled nüüd istumas %{seat}"
    },
    general = {
        command_description = "Avage radiaalne menüü",
        push_stretcher_button = "~g~E~w~ - Lükka kanderaami",
        stop_pushing_stretcher_button = "~g~E~w~ - Lõpeta lükkamine",
        lay_stretcher_button = "~g~G~w~ - Lama kanderaamil",
        push_position_drawtext = "Lükka siia",
        get_off_stretcher_button = "~g~G~w~ - Tule kanderaamilt maha",
        get_out_trunk_button = "[~g~E~w~] Tulge pagasiruumist välja",
        close_trunk_button = "[~g~G~w~] Sulge pagasiruum",
        open_trunk_button = "[~g~G~w~] Ava pagasiruum",
        getintrunk_command_desc = "Astuge pagasiruumi",
        putintrunk_command_desc = "Pange mängija pagasiruumi"
    },
    options = {
        emergency_button = "Hädaabi nupp",
        driver_seat = "Juhi iste",
        passenger_seat = "Reisijaiste",
        other_seats = "Teine iste",
        rear_left_seat = "Tagumine vasak iste",
        rear_right_seat = "Tagumine parem iste"
    },
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
