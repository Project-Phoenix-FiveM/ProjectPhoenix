local Translations = {
    error = {
        ["no_keys"] = "Du hast keine Schlüssel für das Haus...",
        ["not_in_house"] = "Sie sind nicht in einem Haus!",
        ["out_range"] = "Sie haben den Bereich verlassen",
        ["no_key_holders"] = "Keine Schlüsselhalter gefunden..",
        ["invalid_tier"] = "Ungültige Hausstufe",
        ["no_house"] = "Es gibt kein Haus in Ihrer Nähe",
        ["no_door"] = "Du bist nicht nah genug an der Tür...",
        ["locked"] = "Haus ist verschlossen!",
        ["no_one_near"] = "Keiner da!",
        ["not_owner"] = "Dieses Haus gehört Ihnen nicht.",
        ["no_police"] = "Es ist keine Polizei anwesend.",
        ["already_open"] = "Dieses Haus ist bereits geöffnet.",
        ["failed_invasion"] = "Es ist fehlgeschlagen Versuchen Sie es noch einmal",
        ["inprogress_invasion"] = "Jemand arbeitet bereits an der Tür...",
        ["no_invasion"] = "Diese Tür ist nicht aufgebrochen.",
        ["realestate_only"] = "Nur Makler können diesen Befehl verwenden",
        ["emergency_services"] = "Dies ist nur für Notdienste möglich!",
        ["already_owned"] = "Dieses Haus ist bereits in Besitz!",
        ["not_enough_money"] = "Du hast nicht genug Geld.",
        ["remove_key_from"] = "Die Schlüssel wurden entfernt von %{firstname} %{lastname}",
        ["already_keys"] = "Diese Person hat bereits die Schlüssel des Hauses!",
        ["something_wrong"] = "Etwas ist schief gelaufen, versuchen Sie es noch einmal!",
        ["nobody_at_door"] = 'Niemand ist an der Tür...'
    },
    success = {
        ["unlocked"] = "Das Haus ist unverschlossen!",
        ["home_invasion"] = "Die Tür ist jetzt offen.",
        ["lock_invasion"] = "Du hast das Haus wieder abgeschlossen...",
        ["recieved_key"] = "Sie haben die Schlüssel von %{Wert} erhalten!",
        ["house_purchased"] = "Du hast erfolgreich das Haus gekauft!"
    },
    info = {
        ["door_ringing"] = "Jemand klingelt an der Tür!",
        ["speed"] = "Geschwindigkeit ist %{value}",
        ["added_house"] = "Sie haben ein Haus hinzugefügt: %{value}",
        ["added_garage"] = "Sie haben eine Garage angebaut: %{value}",
        ["exit_camera"] = "Kamera Verlassen",
        ["house_for_sale"] = "Haus zu verkaufen",
        ["decorate_interior"] = "Interieur dekorieren",
        ["create_house"] = "Haus erstellen (Makler Only)",
        ["price_of_house"] = "Preis des Hauses",
        ["tier_number"] = "Hausnummer",
        ["add_garage"] = "Haus hinzufügen Garage (Makler Only)",
        ["ring_doorbell"] = "Klingeln Sie an der Tür"
    },
    menu = {
        ["house_options"] = "Haus Optionen",
        ["enter_house"] = "Betreten Sie Ihr Haus",
        ["give_house_key"] = "Hausschlüssel abgeben",
        ["exit_property"] = "Haus Verlassen",
        ["front_camera"] = "Kamera",
        ["back"] = "Zurück",
        ["remove_key"] = "Schlüssel entfernen",
        ["open_door"] = "Tür Öffnen",
        ["view_house"] = "Haus ansehen",
        ["ring_door"] = "Türklingel nutzen",
        ["exit_door"] = "Haus Verlassen",
        ["open_stash"] = "Lager Öffnen",
        ["stash"] = "Lager",
        ["change_outfit"] = "Outfit wechseln",
        ["outfits"] = "Outfits",
        ["change_character"] = "Charakter ändern",
        ["characters"] = "Charaktere",
        ["enter_unlocked_house"] = "Unverschlossenes Haus betreten",
        ["lock_door_police"] = "Tür abschließen"
    },
    target = {
        ["open_stash"] = "[E] Schrank Öffnen",
        ["outfits"] = "[E] Outfit Ändern",
        ["change_character"] = "[E] Charakter Ändern",
    },
    log = {
        ["house_created"] = "Haus erstellt:",
        ["house_address"] = "**Addresse**: %{label}\n\n**Preis**: %{price}\n\n**Interieur Stufe**: %{tier}\n\n**Makler**: %{agent}",
        ["house_purchased"] = "Haus Verkauft:",
        ["house_purchased_by"] = "**Addresse**: %{house}\n\n**Preis**: %{price}\n\n**Käufer**: %{firstname} %{lastname}"
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
