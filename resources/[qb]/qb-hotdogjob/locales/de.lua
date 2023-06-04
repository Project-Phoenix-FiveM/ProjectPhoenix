local Translations = {
    error = {
        no_money = 'Nicht genug Geld',
        too_far = 'Sie sind zu weit von Ihrem Hot Dog Stand entfernt',
        no_stand = 'Sie haben keinen Hotdog-Stand',
        cust_refused = 'Kunde verweigert!',
        no_stand_found = 'Ihr Hotdog-Stand war nirgends zu sehen. Sie erhalten Ihre Kaution nicht zurück!',
        no_more = 'Du hast keine %{value} in deinem Stand',
        deposit_notreturned = 'Du hast keinen HotDog Stand',
    },
    success = {
        deposit = 'Sie haben eine Kaution in Höhe von 250 Dollar hinterlegt!',
        deposit_returned = 'Ihre 250 $ Anzahlung wurde zurückerstattet!',
        sold_hotdogs = '%{value} x Hotdog(\'s) verkauft für $%{value2}',
        made_hotdog = 'Du hast einen %{value} HotDog hergestellt.',
        made_luck_hotdog = 'Du hast %{value} x %{value2} Hot Dogs',
    },
    info = {
        command = "Stand Löschen (Admins Only)",
        blip_name = 'Hotdog Stand',
        start_working = '[~g~E~s~] Starte zu Arbeiten',
        start_work = 'Starte zu Arbeiten',
        stop_working = '[~g~E~s~] Stope zu Arbeiten',
        stop_work = 'Stope zu Arbeiten',
        grab_stall = '[~g~G~s~] Stand nehmen',
        drop_stall = '[~g~G~s~] Stand hinstellen',
        grab = 'Stand nehmen',
        selling_prep = '[~g~E~s~] HotDog herstellen [Status: ~g~Verkauf Geöffnet~w~]',
        not_selling = '[~g~E~s~] Hotdog prepare [Status: ~r~Verkauf Geschlossen~w~]',
        sell_dogs = '[~g~7~s~] Verkaufe %{value} x HotDogs für $%{value2} / [~g~8~s~] Ablehnen',
        admin_removed = "Hot Dog Stand Eingelagert.",
        label_a = "Perfekt (A)",
        label_b = "Selten (B)",
        label_c = "Gewöhnlich (C)"
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
