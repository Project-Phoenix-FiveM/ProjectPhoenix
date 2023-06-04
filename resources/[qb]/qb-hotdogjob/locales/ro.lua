--[[
Romanian language base translation
Martin Riggs#0807 on Discord for any clarifications required
]]--
local Translations = {
    error = {
        no_money = 'Nu ai suficienti bani',
        too_far = 'Esti prea departe de carutul de Hot Dog',
        no_stand = 'Nu ai un carut de Hot Dogs',
        cust_refused = 'Client refuzat!',
        no_stand_found = 'Se pare ca ai ratacit carutul de Hot Dog, ca atare, nu o sa primesti inapoi garantia depozitata!',
        no_more = 'Nu mai ai %{value} in fata consiliului :)',
        deposit_notreturned = 'Nu ai avut un carut de Hot Dogs',
        no_dogs = 'Se pare ca nu ai niciun Hod Dog!',
    },
    success = {
        deposit = 'Ai platit suma de $%{deposit} ca si garantie!',
        deposit_returned = 'Suma de $%{deposit} reprezentand garantia depusa, ti-a fost returnata!',
        sold_hotdogs = 'Ai vandut %{value} x Hotdog(\'s) pentru suma de $%{value2}',
        made_hotdog = 'Ai preparat %{value} Hot Dogs',
        made_luck_hotdog = 'Ai preparat %{value} x %{value2} Hot Dogs',
    },
    info = {
        command = "Sterge carutul (Admin Only)",
        blip_name = 'Carut Hotdog',
        start_working = '[E]-Incepe munca',
        start_work = 'Incepe munca',
        stop_working = '[E]-Opreste munca',
        stop_work = 'Opreste munca',
        grab_stall = '[~g~G~s~]-Misca carutul',
        drop_stall = '[~g~G~s~]-Opreste carutul',
        grab = 'Misca carutul',
        prepare = 'Prepara un Hotdog',
        toggle_sell = 'Activeaza/dezactiveaza vanzarea',
        selling_prep = '[~g~E~s~]-Pregateste un hotdog [Vanzare: ~g~Activa~w~]',
        not_selling = '[~g~E~s~]-Pregateste un hotdog [Vanzare: ~r~Inactiva~w~]',
        sell_dogs = '[~g~7~s~] Vinde %{value} x HotDogs pentru suma de $%{value2} / [~g~8~s~] Refuza',
        sell_dogs_target = 'Vinde %{value} x HotDogs pentru suma de $%{value2}',
        admin_removed = "Carutul de Hot Dog a fost sters",
        label_a = "Perfect (A)",
        label_b = "Rar (B)",
        label_c = "Normal (C)"
    },
    keymapping = {
        gkey = 'Da drumul carutului de Hot Dog',
    }
}

if GetConvar('qb_locale', 'en') == 'ro' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
