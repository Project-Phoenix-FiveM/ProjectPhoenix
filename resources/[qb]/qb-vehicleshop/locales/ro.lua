--[[
Romanian base language translation for qb-vehicleshop
Translation done by wanderrer (Martin Riggs#0807 on Discord)
]]--
local Translations = {
    error = {
        testdrive_alreadyin = "Testezi deja un vehicul",
        testdrive_return = "Acesta nu este vehiculul tau de test",
        Invalid_ID = "S-a furnizat un ID invalid de jucator",
        playertoofar = "Acest jucator, nu este suficient de aproape de tine",
        notenoughmoney = "Nu ai suficienti bani",
        minimumallowed = "Suma minima de plata este $",
        overpaid = "Ai platit prea mult",
        alreadypaid = "Vehiculul este achitat deja",
        notworth = "Vehiculul nu valoreaza atat de mult",
        downtoosmall = "Avansul platit, este prea mic",
        exceededmax = "Suma maxima de plata depasita",
        repossessed = "Vehiculul cu numarul %{plate} a fost confiscat",
        buyerinfo = "Nu am putut obtine informatiile cumparatorului",
        notinveh = "Trebuie sa fi in vehiculul pe care vrei sa-l transferi altcuiva",
        vehinfo = "Nu am putut obtine informatiile vehiculului",
        notown = "Acest vehicul nu este al tau",
        buyertoopoor = "Cumparatorul nu are suficienti bani!",
        nofinanced = "Nu ai niciun vehicul cumparat in leasing",
        financed = "Acest vehicul este inca in leasing",
    },
    success = {
        purchased = "Felicitari pentru achizitie!",
        earned_commission = "Ai castigat $ %{amount} comision de vanzare!",
        gifted = "Ai dat vehiculul cadou",
        received_gift = "Ai primit cadou un vehicul",
        soldfor = "Ai vandut vehiculul pentru suma de $",
        boughtfor = "Ai cumparat vehiculul pentru suma de $",
    },
    menus = {
        vehHeader_header = "Optiuni vehicul",
        vehHeader_txt = "Interactioneaza cu vehiculul curent",
        financed_header = "Vehicule finantate",
        finance_txt = "Verifica vehiculele tale",
        returnTestDrive_header = "Termina testarea vehiculului",
        goback_header = "Inapoi",
        veh_price = "Pret: $",
        veh_platetxt = "Numar: ",
        veh_finance = "Plata vehiculului",
        veh_finance_balance = "Sold total ramas",
        veh_finance_currency = "$",
        veh_finance_total = "Total plati ramase",
        veh_finance_reccuring = "Suma de plata recurenta",
        veh_finance_pay = "Fa o plata",
        veh_finance_payoff = "Achita integral vehicul",
        veh_finance_payment = "Suma de plata ($)",
        submit_text = "Trimite",
        test_header = "Testarea vehiculului",
        finance_header = "Cumpara vehicul in rate",
        swap_header = "Schimba vehicul",
        swap_txt = "Schimba vehiculul selectat",
        financesubmit_downpayment = "Minimul sumei de avans ",
        financesubmit_totalpayment = "Numar de plati maxime ",
        --Free Use
        freeuse_test_txt = "Testeaza vehiculul selectat",
        freeuse_buy_header = "Cumpara vehiculul",
        freeuse_buy_txt = "Cumpara vehiculul selectat",
        freeuse_finance_txt = "Cumpara in rate vehiculul selectat",
        --Managed
        managed_test_txt = "Permite jucatorilor sa testeze vehiculele",
        managed_sell_header = "Vinde vehiculul",
        managed_sell_txt = "Vinde vehiculul jcatorului",
        managed_finance_txt = "Vinde vehiculul in rate unui jucator",
        submit_ID = "ID-ul serverului (#)",
    },
    general = {
        testdrive_timer = "Timp ramas pentru testare:",
        vehinteraction = "Interactiuni cu vehiculul",
        testdrive_timenoti = "Au mai ramas %{testdrivetime} minute din testare",
        testdrive_complete = "S-a terminat testarea vehiculului",
        paymentduein = "Au mai ramas %{time} minute, pana la plata ratei",
        command_transfervehicle = "Ofera cadou sau vine vehiculul",
        command_transfervehicle_help = "ID-ul cumparatorului",
        command_transfervehicle_amount = "Suma de plata (optionnal)",
    }
}

if GetConvar('qb_locale', 'en') == 'ro' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
