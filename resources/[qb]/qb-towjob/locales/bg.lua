local Translations = {
    error = {
        finish_work = "Завърши цялата работа!",
        vehicle_not_correct = "Това НЕ Е правилното ППС!",
        failed = "Провали се!",
        not_towing_vehicle = "Трябва да бъдеш в репатрак!",
        too_far_away = "Твърде далеч си!",
        no_work_done = "Нямаш възложена работа все още!",
        no_deposit = "$%{value} изисква се депозит",
    },
    success = {
        paid_with_cash = "$%{value} Платен депозит (кеш)",
        paid_with_bank = "$%{value} Платен депозит (банка)",
        refund_to_cash = "$%{value} Платен депозит (кеш)",
        you_earned = "Получи $%{value}",
    },
    menu = {
        header = "Налични автомобили",
        close_menu = "⬅ Затвори",
    },
    mission = {
        delivered_vehicle = "Прибрахте репатрака",
        get_new_vehicle = "Има нов сигнал от местен гражданин!",
        towing_vehicle = "Вдигане на автомобила...",
        goto_depot = "Закарай автомобила до Hayes Depo!",
        vehicle_towed = "Автомобилът е качен!",
        untowing_vehicle = "Сваляне на автомобила...",
        vehicle_takenoff = "Автомобилът е свален...",
    },
    info = {
        tow = "Качете автомобила на платформата",
        toggle_npc = "Започни работа",
    }
}

if GetConvar('qb_locale', 'en') == 'bg' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
