local Translations = {
    success = {
        success_message = "Succes",
        fuses_are_blown = "De zekering zijn doorgebrand",
        door_has_opened = "De deur is geopend"
    },
    error = {
        cancel_message = "Geannuleerd",
        safe_too_strong = "Het slot van de kluis is te sterk...",
        missing_item = "Je mist een item...",
        bank_already_open = "De bank is al geopend...",
        minimum_police_required = "Minimaal %{police} politie nodig",
        security_lock_active = "Het beveiligingsslot is actief, de deur kan momenteel niet geopend worden",
        wrong_type = "%{receiver} ontving het verkeerde type voor argument '%{argument}'\nontvangen type: %{receivedType}\nontvangen value: %{receivedValue}\n verwacht type: %{expected}",
        fuses_already_blown = "De zekeringen zijn al doorgebrand...",
        event_trigger_wrong = "%{event}%{extraInfo} was uitgevoerd terwijl een paar condities niet zijn vervuld, source: %{source}",
        missing_ignition_source = "Je mist een ontstekingsbron"
    },
    general = {
        breaking_open_safe = "Kluis open breken...",
        connecting_hacking_device = "Hacking device aan het verbinden...",
        fleeca_robbery_alert = "Fleeca bank overval poging",
        paleto_robbery_alert = "Blain County Savings bank overval poging",
        pacific_robbery_alert = "Pacific Standard Bank overval poging",
        break_safe_open_option_target = "Breek Kluis Open",
        break_safe_open_option_drawtext = "[E] Breek kluis open",
        validating_bankcard = "Kaart valideren...",
        thermite_detonating_in_seconds = "Thermite zal af gaan in %{time} seconde(s)",
        bank_robbery_police_call = "Bank Overval"
    }
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
