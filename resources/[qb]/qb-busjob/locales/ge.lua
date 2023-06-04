local Translations = {
    error = {
        already_driving_bus = 'უკვე ატარებ ავტობუსს',
        not_in_bus = 'შენ არ იმყოფები ავტობუსში',
        one_bus_active = 'შეგიძლია გყავდეს მხოლოდ ერთი აქტიური ავტობუსი',
        drop_off_passengers = 'ჩამოსვი ყველა მგზავრი სანამ დაასრულებ მუშაობას'
    },
    success = {
        dropped_off = 'მგზავრი ჩავიდა',
    },
    info = {
        bus = 'სტანდარტული ავტობუსი',
        goto_busstop = 'წადი ავტობუსის გაჩერებაზე',
        busstop_text = '[E] ავტობუსის გაჩერება',
        bus_plate = 'BUS', -- Can be 3 or 4 characters long (uses random 4 digits)
        bus_depot = 'ავტობუსის სადგური',
        bus_stop_work = '[E] სამუშაოს დასრულება',
        bus_job_vehicles = '[E] სამსახურის ავტომობილები'
    },
    menu = {
        bus_header = 'ავტობუსები',
        bus_close = '⬅ ნავიგაციის გახურვა'
    }
}

if GetConvar('qb_locale', 'en') == 'ge' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
