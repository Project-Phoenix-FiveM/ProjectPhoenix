local Translations = {
    error = {
        to_far_from_door = 'Jste příliš daleko od zvonku',
        nobody_home = 'Nikdo není doma..',
    },
    success = {
        receive_apart = 'Přestěhovali jste se',
        changed_apart = 'Přestěhovali jste se',
    },
    info = {
        at_the_door = 'Někdo je u dveří!',
    },
    text = {
        enter = 'Vstoupit do apartmánu',
        ring_doorbell = 'Zazvonit',
        logout = 'Odhlásit se z postavy',
        change_outfit = 'Převléknout se',
        open_stash = 'Otevřít skrýš',
        move_here = 'Přestěhovat se sem',
        open_door = 'Otevřít dveře',
        leave = 'Opustit apartmán',
        close_menu = '⬅ Uzavřít Menu',
        tennants = 'Nájemníci',
    },
}

if GetConvar('qb_locale', 'en') == 'cs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
