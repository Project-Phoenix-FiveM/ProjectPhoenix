local Translations = {
    error = {
        ["invalid_job"] = "არამგონია აქ ვიმუშაო...",
        ["invalid_items"] = "თქვენ არ გაქვთ სწორი ნივთები!",
        ["no_items"] = "თქვენ არ გაქვთ რაიმე ნივთი!",
    },
    progress = {
        ["pick_grapes"] = "ყურძნის კრეფა ..",
        ["process_grapes"] = "ყურძნის გადამუშავება..",
    },
    task = {
        ["start_task"] = "[E] Დაწყება",
        ["load_ingrediants"] = "[E] ჩატვირთეთ ინგრედიენტები",
        ["wine_process"] = "[E] დაიწყეთ ღვინის პროცესი",
        ["get_wine"] = "[E] მიიღეთ ღვინო",
        ["make_grape_juice"] = "[E] მოამზადეთ ყურძნის წვენი",
        ["countdown"] = "Დარჩენილი დრო %{time}s",
        ['cancel_task'] = "თქვენ გააუქმეთ დავალება"
    }
}

if GetConvar('qb_locale', 'en') == 'ge' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
