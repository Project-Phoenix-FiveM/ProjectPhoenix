local Translations = {
    error = {
        already_driving_bus = 'أنت تقود حافلة بالفعل',
        not_in_bus = 'أنت لست في حافلة',
        one_bus_active = 'يمكنك امتلاك حافلة نشطة واحدة فقط في كل مرة',
        drop_off_passengers = 'أنزل الركاب قبل أن تتوقف عن العمل'
    },
    success = {
        dropped_off = 'تم إنزال الشخص',
    },
    info = {
        bus = 'حافلة',
        goto_busstop = 'اذهب إلى محطة الحافلات',
        busstop_text = '[E] ﺹﺎﺑ ﻒﻗﻮﻣ',
        bus_plate = 'BUS', -- Can be 3 or 4 characters long (uses random 4 digits)
        bus_depot = 'ﺕﻼﻓﺎﺤﻟﺍ ﻉﺩﻮﺘﺴﻣ', -- you need arabic 
        bus_stop_work = '[E] - ﻞﻤﻌﻟﺍ ﻦﻋ ﻒﻗﻮﺗ',
        bus_job_vehicles = '[E] - ﻞﻤﻌﻟﺍ ﺕﺍﺭﺎﻴﺳ'
    },
    menu = {
        bus_header = 'سيارات العمل',
        bus_close = '⬅ اغلاق'
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
