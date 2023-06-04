local Translations = {
    notify = {
        ydhk = 'ليس لديك مفاتيح لهذه السيارة.',
        nonear = 'لا يوجد أحد في الجوار لتسليم المفاتيح إليه',
        vlock = 'السيارة مقفلة!',
        vunlock = 'السيارة مقفلة!',
        vlockpick = 'لقد تمكنت من فتح قفل الباب!',
        fvlockpick = 'أنت تفشل في العثور على المفاتيح وتحبط.',
        vgkeys = 'أنت تسلم المفاتيح.',
        vgetkeys = 'تحصل على مفاتيح السيارة!',
        fpid = 'قم بتعبئة معرف اللاعب وحجج اللوحة',
        cjackfail = 'فشل سرقة السيارة!',
        vehclose = 'لا توجد سيارة قريبة!',
    },
    progress = {
        takekeys = 'أخذ المفاتيح من الجسد...',
        hskeys = 'البحث عن مفاتيح السيارة...',
        acjack = 'محاولة سرقة السيارات...',
    },
    info = {
        skeys = '~g~[H]~w~ - Search for Keys',
        tlock = 'تبديل أقفال السيارة',
        palert = 'سرقة السيارة قيد التقدم. يكتب: ',
        engine = 'تبديل المحرك',
    },
    addcom = {
        givekeys = 'Hand over the keys to someone. If no ID, gives to closest person or everyone in the vehicle.',
        givekeys_id = 'id',
        givekeys_id_help = 'Player ID',
        addkeys = 'Adds keys to a vehicle for someone.',
        addkeys_id = 'id',
        addkeys_id_help = 'Player ID',
        addkeys_plate = 'plate',
        addkeys_plate_help = 'Plate',
        rkeys = 'Remove keys to a vehicle for someone.',
        rkeys_id = 'id',
        rkeys_id_help = 'Player ID',
        rkeys_plate = 'plate',
        rkeys_plate_help = 'Plate',
    }

}

if GetConvar('qb_locale', 'en') == 'ar' then
  Lang = Locale:new({
      phrases = Translations,
      warnOnMissing = true
  })
end
