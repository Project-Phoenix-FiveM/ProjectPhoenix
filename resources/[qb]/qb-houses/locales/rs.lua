local Translations = {
    error = {
        ["no_keys"] = "Nemate kljuceve od kuce...",
        ["not_in_house"] = "Niste u kuci!",
        ["out_range"] = "Izasli ste iz dometa",
        ["no_key_holders"] = "Nema nikoga u blizini ili osoba ne poseduje kljuc..",
        ["invalid_tier"] = "Nevalidan nivo kuce",
        ["no_house"] = "U vasoj blizini nema kuce",
        ["no_door"] = "Nisi dovoljno blizu vrata..",
        ["locked"] = "Kuca je zakljucana!",
        ["no_one_near"] = "Nema nikoga u blizini!",
        ["not_owner"] = "Niste vlasnik ove kuce.",
        ["no_police"] = "Policija nije prisutna..",
        ["already_open"] = "Ova kuca je vec otvorena..",
        ["failed_invasion"] = "Nije uspelo pokusaj ponovo",
        ["inprogress_invasion"] = "Neko vec radi na vratima..",
        ["no_invasion"] = "Ova vrata nisu razvaljena..",
        ["realestate_only"] = "Samo realestate moze koristiti ovu komandu",
        ["emergency_services"] = "Ovo je moguce samo za hitne sluzbe!",
        ["already_owned"] = "Ova kuca je vec u vlasnistvu!",
        ["not_enough_money"] = "Nemate dovoljno novca..",
        ["remove_key_from"] = "Uklonjeni su kljucevi od %{firstname} %{lastname}",
        ["already_keys"] = "Osoba vec ima kljuceve od kuce!",
        ["something_wrong"] = "Nesto nije u redu, pokusajte ponovo!",
        ["nobody_at_door"] = 'Na vratima nema nikoga...'
    },
    success = {
        ["unlocked"] = "Kuca je otkljucana!",
        ["home_invasion"] = "Vrata su sada otvorena.",
        ["lock_invasion"] = "Ponovo ste zakljucali kucu..",
        ["recieved_key"] = "Dobili ste kljuceve od %{value}",
        ["house_purchased"] = "Uspesno ste kupili kucu!"
    },
    info = {
        ["door_ringing"] = "Neko zvoni na vrata!",
        ["speed"] = "Brzina je %{value}",
        ["added_house"] = "Dodali ste kucu: %{value}",
        ["added_garage"] = "Dodali ste garazu: %{value}",
        ["exit_camera"] = "Izadji iz kamere",
        ["house_for_sale"] = "Kuca na prodaju",
        ["decorate_interior"] = "Ukrasite enterijer",
        ["create_house"] = "Napravi kucu (Samo Real Estate)",
        ["price_of_house"] = "Cena kuce",
        ["tier_number"] = "Broj nivoa kuce",
        ["add_garage"] = "Dodajte garazu za kucu (Samo Real Estate)",
        ["ring_doorbell"] = "Pozvoni na vrata"
    },
    menu = {
        ["house_options"] = "Opcije Kuce",
        ["close_menu"] = "⬅ Zatvori Meni",
        ["enter_house"] = "Udjite u svoju kucu",
        ["give_house_key"] = "Dajte kljuc od kuce",
        ["exit_property"] = "Izadjite iz kuce",
        ["front_camera"] = "Prednja kamera",
        ["back"] = "Nazad",
        ["remove_key"] = "Ukloni Kljuc",
        ["open_door"] = "Otvori vrata",
        ["view_house"] = "Pogledaj kucu",
        ["ring_door"] = "Pozvoni",
        ["exit_door"] = "Izadjite iz kuce",
        ["open_stash"] = "Otvori sef",
        ["stash"] = "Sef",
        ["change_outfit"] = "Promeni Odelo",
        ["outfits"] = "Odela",
        ["change_character"] = "Promeni Karaktera",
        ["characters"] = "Karakteri",
        ["enter_unlocked_house"] = "Udjite u otkljucanu kucu",
        ["lock_door_police"] = "Zakljucaj Vrata"
    },
    target = {
        ["open_stash"] = "[E] Otvori Sef",
        ["outfits"] = "[E] Promeni Odelo",
        ["change_character"] = "[E] Promeni Karaktera",
    },
    log = {
        ["house_created"] = "Kuca Napravljena:",
        ["house_address"] = "**Adresa**: %{label}\n\n**Cena**: %{price}\n\n**Nivo**: %{tier}\n\n**Napravio**: %{agent}",
        ["house_purchased"] = "Kuca Kupljena:",
        ["house_purchased_by"] = "**Adresa**: %{house}\n\n**Cena**: %{price}\n\n**Kupac**: %{firstname} %{lastname}"
    }
}

if GetConvar('qb_locale', 'en') == 'rs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
