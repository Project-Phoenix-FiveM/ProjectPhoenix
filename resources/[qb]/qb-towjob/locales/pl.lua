local Translations = {
    error = {
        finish_work = "Najpierw zakończ swoją pracę",
        vehicle_not_correct = "To nie jest właściwy pojazd",
        failed = "Porażka",
        not_towing_vehicle = "Najpierw musiałeś być w pojeździe ciągnącym",
        too_far_away = 'Jesteś zbyt daleko',
        no_work_done = "Nie wykonałeś jeszcze żadnej pracy.",
        no_deposit = "$%{value} Depozyt wymagany",
    },
    success = {
        paid_with_cash = "$%{value} Depozyt zapłacony gotówką",
        paid_with_bank = "$%{value} Depozyt zapłacony z banku",
        refund_to_cash = "$%{value} Depozyt zapłacony gotówką",
        you_earned = "Zarobiłeś $%{value}",
    },
    menu = {
        header = "Dostępne ciężarówki",
        close_menu = "⬅ Zamknij menu",
    },
    mission = {
        delivered_vehicle = "Dostarczyłeś pojazd",
        get_new_vehicle = "Można odebrać nowy pojazd",
        towing_vehicle = "Podnoszenie pojazdu...",
        goto_depot = "Zabierz pojazd do magazynu Hayes",
        vehicle_towed = "Pojazd odholowany",
        untowing_vehicle = "Usuń pojazd",
        vehicle_takenoff = "Zdjęty pojazd",
    },
    info = {
        tow = "Umieść samochód z tyłu swojej ciężarówki",
        toggle_npc = "Przełącz zadanie Npc",
    }
}

if GetConvar('qb_locale', 'en') == 'pl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
