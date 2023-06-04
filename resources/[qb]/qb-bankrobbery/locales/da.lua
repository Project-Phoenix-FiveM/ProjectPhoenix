local Translations = {
    success = {
        success_message = "Vellykket",
        fuses_are_blown = "Sikringerne er sprunget",
        door_has_opened = "Døren er åbnet"
    },
    error = {
        cancel_message = "Annulleret",
        safe_too_strong = "Det ser ud til, at pengeskabslåsen er for stærkt...",
        missing_item = "Du mangler en ting...",
        bank_already_open = "Banken er allerede åben...",
        minimum_police_required = "Minimum af %{police} politi påkrævet",
        security_lock_active = "Sikkerhedslåsen er aktiv, åbning af døren er i øjeblikket ikke mulig",
        wrong_type = "%{receiver} modtog ikke den rigtige type til argument '%{argument}'\nmodtaget type: %{receivedType}\nmodtaget værdi: %{receivedValue}\nforventet type: %{expected}",
        fuses_already_blown = "Sikringerne er allerede sprunget...",
        event_trigger_wrong = "%{event}%{extraInfo} blev udløst, da nogle betingelser ikke var opfyldt, kilde: %{source}",
        missing_ignition_source = "Du mangler en tændkilde"
    },
    general = {
        breaking_open_safe = "Brækker pengeskabet op...",
        connecting_hacking_device = "Tilslutter hackerenheden...",
        fleeca_robbery_alert = "Fleeca bankrøveri forsøg",
        paleto_robbery_alert = "Blain County Savings bank røveriforsøg",
        pacific_robbery_alert = "Pacific Standard Bank røveriforsøg",
        break_safe_open_option_target = "Bræk pengeskabet åben",
        break_safe_open_option_drawtext = "[E] Bryd pengeskabet op",
        validating_bankcard = "Validerer kort...",
        thermite_detonating_in_seconds = "Thermite slukker om %{time} sekund(er)",
        bank_robbery_police_call = "10-90: Bankrøveri"
    }
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
