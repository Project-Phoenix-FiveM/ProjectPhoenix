local Translations = {
    error = {
        ["missing_something"] = "يبدو أنك تفتقد شيئًا ما",
        ["not_enough_police"] = "لا يوجد ما يكفي من الشرطة",
        ["door_open"] = "الباب مفتوح بالفعل",
        ["cancelled"] = "تم إلغاء العملية",
        ["didnt_work"] = "إنها لا تعمل",
        ["emty_box"] = "الصندوق فارغ",
        ["injail"] = "شهر %{Time} أنت في السجن بسبب",
        ["item_missing"] = "أنت تفتقد عنصر",
        ["escaped"] = "أنت هربت أخرج من هنا بسرعه",
        ["do_some_work"] = "%{currentjob} وظيفتك في السجن سوف تساعدك في الخروج بسرعة و هي:",
    },
    success = {
        ["found_phone"] = "لقد عثرت على هاتف",
        ["time_cut"] = "لقد عملت بعض الوقت من عقوبتك",
        ["free_"] = "أنت حر! استمتع بها! :)",
        ["timesup"] = "حان وقتك! تحقق من نفسك في مركز الزوار",
    },
    info = {
        ["timeleft"] = "شهر %{JAILTIME} لا يزال عليك",
        ["lost_job"] = "أنت عاطل عن العمل",
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
