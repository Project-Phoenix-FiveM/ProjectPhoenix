local Translations = {
    error = {
        no_money = 'Pole piisavalt raha!',
        too_far = 'Olete oma Hot Dog Standist liiga kaugel',
        no_stand = 'Teil ei ole hotdogi alust',
        cust_refused = 'Klient keeldus!',
        no_stand_found = 'Teie hot dogi kioski polnud kuskil näha, Te ei saa oma tagatisraha tagasi!',
        no_more = 'Teil pole selle kohta volikogu ees %{value} rohkem',
        deposit_notreturned = 'Teil ei olnud Hot Dogi Standi',
        no_dogs = 'Teil pole hotdoge',
    },
    success = {
        deposit = 'Maksite sissemakse $%{deposit}!',
        deposit_returned = 'Teie sissemakse $%{deposit} on tagastatud!',
        sold_hotdogs = '%{value} x Hotdog(id) müüdi hinnaga $%{value2}',
        made_hotdog = 'Tegite %{value} hot Dogi',
        made_luck_hotdog = 'Tegite %{value} x %{value2} hot Dogi',
    },
    info = {
        command = "Kustuta alus (ainult administraator)",
        blip_name = 'HotDogi kiosk',
        start_working = '[E] Alusta töötamist',
        start_work = 'Alusta töötamist',
        stop_working = '[E] Lõpeta töötamine',
        stop_work = 'Lõpeta töötamine',
        grab_stall = '[~g~G~s~] Haara Stall',
        drop_stall = '[~g~G~s~] Vabastage Stall',
        grab = 'Haara Stall',
        prepare = 'Valmistage HotDogi',
        toggle_sell = 'Lülitage müümine sisse',
        selling_prep = '[~g~E~s~] Hotdog valmistada [Müük: ~g~Müün~w~]',
        not_selling = '[~g~E~s~] Hotdog valmistada [Müük: ~r~Ei müü~w~]',
        sell_dogs = '[~g~7~s~] Müü %{value} x HotDogs hinnaga $%{value2} / [~g~8~s~] Keeldu',
        sell_dogs_target = 'Müü %{value} x HotDogs hinnaga $%{value2}',
        admin_removed = "Hot Dogi Stand eemaldatud",
        label_a = "Täiuslik (A)",
        label_b = "Harv (B)",
        label_c = "Tavaline (C)"
    },
        keymapping = {
        gkey = 'Laske hotdogi alus lahti',
        
    }
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
