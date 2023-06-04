local Translations = {
    error = {
        to_far_from_door = 'Kapı zilinden çok uzaktasın',
        nobody_home = 'Evde kimse yok..',
    },
    success = {
        receive_apart = 'Bir daire aldın',
        changed_apart = 'Daireni taşıdın',
    },
    info = {
        at_the_door = 'Kapıda birisi var!',
    },
    text = {
        enter = 'Daireye Girin',
        ring_doorbell = 'Zili Çal',
        logout = 'Oturumu Kapat',
        change_outfit = 'Kıyafet Değiştir',
        open_stash = 'Zulayı Aç',
        move_here = 'Buraya Taşın',
        open_door = 'Kapıyı Aç',
        leave = 'Apartmandan Ayrıl',
        close_menu = '⬅ Menüyü Kapat',
        tennants = 'Kiracılar',
    },
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
