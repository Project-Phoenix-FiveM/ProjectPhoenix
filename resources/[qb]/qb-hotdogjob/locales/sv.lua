local Translations = {
    error = {
        no_money = 'Inte tillräckligt med pengar',
        too_far = 'Du är för långt ifrån korv-vagnen',
        no_stand = 'Du har ingen korv-vagn',
        cust_refused = 'Kunden vägrar!',
        no_stand_found = 'Din korv-vagn går inte att hitta någonstans, du får inte tillbaka din deposition!',
        no_more = 'Du har inga %{value} kvar inför fullmäktige',
        deposit_notreturned = 'Du hade ingen korv-vagn',
    },
    success = {
        deposit = 'Du betalade %{deposit} kr i deposition!',
        deposit_returned = 'Dina %{deposit} kr för deposition är återlämnade till dig!',
        sold_hotdogs = '%{value} x varmkorv(\ar) såldes för %{value2} kr',
        made_hotdog = 'Du gjorde %{value} varmkorvar',
        made_luck_hotdog = 'Du gjorde %{value} x %{value2} Varmkorvar',
    },
    info = {
        command = "Ta bord korv-vagn (Endast Admin)",
        blip_name = 'Korv-vagn',
        start_working = '[~g~E~s~] Börja jobba',
        start_work = 'Börja jobba',
        stop_working = '[~g~E~s~] Sluta jobba',
        stop_work = 'Sluta jobba',
        grab_stall = '[~g~G~s~] Greppa vagnen',
        drop_stall = '[~g~G~s~] Släpp vagnen',
        grab = 'Greppa vagnen',
        selling_prep = '[~g~E~s~] Förberedelse av korv [Försäljning: ~g~Säljer~w~]',
        not_selling = '[~g~E~s~] Förberedelse av korv [Försäljning: ~r~Säljer inte~w~]',
        sell_dogs = '[~g~7~s~] Sälj %{value} x varmkorvar för $%{value2} / [~g~8~s~] Avböj',
        admin_removed = "Korv-vagnen borttagen",
        label_a = "Perfekt (A)",
        label_b = "Mycket bra (B)",
        label_c = "Ok (C)"
    }
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
