local Translations = {
    error = {
        to_far_from_door = 'თქვენ ძალიან შორს ხართ კარის ზარისგან',
        nobody_home = 'სახლში არავინაა..',
    },
    success = {
        receive_apart = 'შენ გაქვს ბინა',
        changed_apart = 'თქვენ გადაიტანეთ ბინები',
    },
    info = {
        at_the_door = 'ვიღაც კარებთან არის!',
    },
    text = {
        enter = 'ბინაში შესვლა',
        ring_doorbell = 'დარეკეთ კარზე',
        logout = 'გამოსვლის სიმბოლო',
        change_outfit = 'შეცვალეთ ტანსაცმელი',
        open_stash = 'გახსენით სეიფი',
        move_here = 'გადაადგილება აქ',
        open_door = 'Ღია კარი',
        leave = 'ბინის დატოვება',
        close_menu = '⬅ მენიუს დახურვა',
        tennants = 'მოიჯარეები',
    },
}

if GetConvar('qb_locale', 'en') == 'ge' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
