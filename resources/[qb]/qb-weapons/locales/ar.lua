local Translations = {
    error = {
        canceled = 'الغيت',
        max_ammo = 'اقصى عدد ل الذخيرة',
        no_weapon = 'ليس لديك سلاح',
        no_support_attachment = 'هذا السلاح لا يدعم هذه الاضافة',
        no_weapon_in_hand = 'أنت لا تملك سلاح في يدك',
        weapon_broken = 'هذا السلاح مكسور و لا يمكن استخدامه',
        no_damage_on_weapon = 'هذا السلاح غير مكسور',
        weapon_broken_need_repair = 'تم كسر سلاحك و تحتاج إلى إصلاحه قبل أن لا تتمكن من استخدامه مرة أخرى',
        attachment_already_on_weapon = 'في سلاحك %{value} لديك من قبل'
    },
    success = {
        reloaded = 'إعادة التحميل'
    },
    info = {
        loading_bullets = 'تحميل الرصاص',
        repairshop_not_usable = 'ﻖﻠﻐﻣ ﺔﻈﺤﻠﻟﺍ ﻩﺬﻫ ﻲﻓ ﺢﻴﻠﺼﺘﻟﺍ ﺮﺠﺘﻣ', -- you need font arabic
        weapon_will_repair = 'ﻚﺣﻼﺳ ﺡﻼﺻﺇ ﻢﺘﻴﺳ',
        take_weapon_back = '~g~E~w~ - ﻚﺣﻼﺳ ﺪﺧ',
        repair_weapon_price = '~g~E~w~ - ~g~$%{value}~w~ ﺢﻴﻠﺼﺗ',
        removed_attachment = 'من سلاحك %{value} نزعت',
        hp_of_weapon = 'متانة سلاحك'
    },
    mail = {
        sender = 'عامل',
        subject = 'متجر التصليح',
        message = '%{value} تم إصلاحه يمكنك استلامه في الموقع <br><br> باي باي'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
