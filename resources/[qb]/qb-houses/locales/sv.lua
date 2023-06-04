local Translations = {
    error = {
        ["no_keys"] = "Du har inte nycklar till det här huset...",
        ["not_in_house"] = "Du är inte i ett hus!",
        ["out_range"] = "Du är för långt ifrån",
        ["no_key_holders"] = "Ingen nyckelbärare hittad..",
        ["invalid_tier"] = "Felaktig husnivå",
        ["no_house"] = "Det finns inget hus i närheten",
        ["no_door"] = "Du är för långt ifrån dörren..",
        ["locked"] = "Huset är låst!",
        ["no_one_near"] = "Ingen är i närheten!",
        ["not_owner"] = "Du äger inte detta hus.",
        ["no_police"] = "Det finns ingen polisstyrka i närheten..",
        ["already_open"] = "Det här huset är redan öppet..",
        ["failed_invasion"] = "Det gick inte, försök igen",
        ["inprogress_invasion"] = "Det är redan någon som jobbar med dörren..",
        ["no_invasion"] = "Den här dörren är inte uppbruten..",
        ["realestate_only"] = "Endast mäklaren kan använda detta kommando",
        ["emergency_services"] = "Det här är endast möjligt för Räddningstjänst!",
        ["already_owned"] = "Det här huset ägs redan!",
        ["not_enough_money"] = "Du har inte tillräckligt med pengar..",
        ["remove_key_from"] = "%{firstname} %{lastname} har blivit av med nycklarna",
        ["already_keys"] = "Den här personen har redan nycklarna till huset!",
        ["something_wrong"] = "Något gick fel, försök igen!",
    },
    success = {
        ["unlocked"] = "Huset är olåst!",
        ["home_invasion"] = "Dörren är öppen.",
        ["lock_invasion"] = "Du låste huset igen..",
        ["recieved_key"] = "Du har tagit emot nycklarna till %{value}!"
    },
    info = {
        ["door_ringing"] = "Någon plingar på dörren!",
        ["speed"] = "Hastigheten är %{value}",
        ["added_house"] = "Du har laggt till ett hus: %{value}",
        ["added_garage"] = "Du har lagt till ett garage: %{value}",
        ["exit_camera"] = "Gå ur kamera",
        ["house_for_sale"] = "Huset är till salu",
        ["decorate_interior"] = "Dekorera interiör",
        ["create_house"] = "Skapa hus (Endast Mäklare)",
        ["price_of_house"] = "Huspriset",
        ["tier_number"] = "Husnivånummer",
        ["add_garage"] = "Lägg till garage (Endast Mäklare)",
        ["ring_doorbell"] = "Ring på klockan"
    },
    menu = {
        ["house_options"] = "Husalternativ",
        ["enter_house"] = "Gå in i ditt hus",
        ["give_house_key"] = "Ge husnyckel",
        ["exit_property"] = "Lämna fastighet",
        ["front_camera"] = "Frontkamera",
        ["back"] = "Bakåt",
        ["remove_key"] = "Ta bort nyckel",
        ["open_door"] = "Öppna dörr",
        ["view_house"] = "Visa hus",
        ["ring_door"] = "Ring på dörrklocka",
        ["exit_door"] = "Lämna fastighet",
        ["open_stash"] = "Öppna förråd",
        ["stash"] = "Förråd",
        ["change_outfit"] = "Ändra klädsel",
        ["outfits"] = "Kläder",
        ["change_character"] = "Byt karaktär",
        ["characters"] = "Karaktärer",
        ["enter_unlocked_house"] = "Gå in i olåst hus",
        ["lock_door_police"] = "Lås dörr"
    },
    log = {
        ["house_created"] = "Hus skapat:",
        ["house_address"] = "**Adress**: %{label}\n\n**Listpris**: %{price}\n\n**Nivå**: %{tier}\n\n**Mäklare**: %{agent}",
        ["house_purchased"] = "Hus köpt:",
        ["house_purchased_by"] = "**Adress**: %{house}\n\n**Köpeskilling**: %{price}\n\n**Köpare**: %{firstname} %{lastname}"
    }
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
