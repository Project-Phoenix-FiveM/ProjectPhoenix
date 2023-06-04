local Translations = {
    error = {
        ["no_keys"] = "Nemáš kľúče od tohto domu...",
        ["not_in_house"] = "Nie si v dome!",
        ["out_range"] = "Si mimo dosah",
        ["no_key_holders"] = "Nenašli sa žiadne držiaky pre kľúče..",
        ["invalid_tier"] = "Neplatná úroveň domu",
        ["no_house"] = "V tvojej blízkosti sa nenašiel žiaden dom",
        ["no_door"] = "Nie si dosť blízko pri dverách..",
        ["locked"] = "Dom je zatvorený!",
        ["no_one_near"] = "Nikto naokolo!",
        ["not_owner"] = "Nevlastníš tento dom.",
        ["no_police"] = "Nie je prítomný žiadny policajt..",
        ["already_open"] = "Dom už je otvorený..",
        ["failed_invasion"] = "Nepodarilo sa to skúsiť znova",
        ["inprogress_invasion"] = "Niekto už na dverách pracuje..",
        ["no_invasion"] = "Tieto dvere nie sú vylomené..",
        ["realestate_only"] = "Iba správca nehnuteľností môže použiť tento príkaz",
        ["emergency_services"] = "To je možné len pre pohotovostné složky!",
        ["already_owned"] = "Tento dom už niekto vlastní!",
        ["not_enough_money"] = "Nemáš dostatok peňazí..",
        ["remove_key_from"] = "Kľúče boli odobrané od %{firstname} %{lastname}",
        ["already_keys"] = "Táto osoba už má kľúče od domu!",
        ["something_wrong"] = "Niečo sa pokazilo, skús to znova!",
    },
    success = {
        ["unlocked"] = "Otvorili ste dom!",
        ["home_invasion"] = "Dvere sú teraz otvorené.",
        ["lock_invasion"] = "Znova ste zatvorili dom..",
        ["recieved_key"] = "Dostali ste kľúče %{value} !"
    },
    info = {
        ["door_ringing"] = "Niekto zvoní!",
        ["speed"] = "Rýchlosť je %{value}",
        ["added_house"] = "Do domu si pridal: %{value}",
        ["added_garage"] = "Do garáže si pridal: %{value}",
        ["exit_camera"] = "Ukončiť kameru",
        ["house_for_sale"] = "Dom na predaj",
        ["decorate_interior"] = "Ozdobte interiér",
        ["create_house"] = "Vytvoriť dom (iba nehnuteľnosti)",
        ["price_of_house"] = "Cena domu",
        ["tier_number"] = "Číslo radu domu",
        ["add_garage"] = "Pridať garáž (iba nehnuteľnosti)",
        ["ring_doorbell"] = "Zazvoňte na zvonček"
    },
    menu = {
        ["house_options"] = "Možnosti domu",
        ["enter_house"] = "Vstúptiť do svojho domu",
        ["give_house_key"] = "Dať kľúč od domu",
        ["exit_property"] = "Opustiť dom",
        ["front_camera"] = "Predná kamera",
        ["back"] = "Späť",
        ["remove_key"] = "Odobrať kľúč",
        ["open_door"] = "Otvoriť dvere",
        ["view_house"] = "Pozrieť dom",
        ["ring_door"] = "Zvonček",
        ["exit_door"] = "Odísť",
        ["open_stash"] = "Otovriť skrýšu",
        ["stash"] = "Skrýša",
        ["change_outfit"] = "Zmeniť oblečenie",
        ["outfits"] = "Oblečenia",
        ["change_character"] = "Zmeniť charakter",
        ["characters"] = "Charaktery",
        ["enter_unlocked_house"] = "Vstúpiť do otvoreného domu",
        ["lock_door_police"] = "Zatvoriť dvere"
    },
    log = {
        ["house_created"] = "Dom vytvorený:",
        ["house_address"] = "**Adresa**: %{label}\n\n**Katalógová cena**: %{price}\n\n**Tier**: %{tier}\n\n**Záznamový agent**: %{agent}",
        ["house_purchased"] = "Dom odkúpený:",
        ["house_purchased_by"] = "**Adresa**: %{house}\n\n**Kúpna cena**: %{price}\n\n**Kupujúci**: %{firstname} %{lastname}"
    }
}

if GetConvar('qb_locale', 'en') == 'sk' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
