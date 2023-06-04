local Translations = {
    error = {
        to_far_from_door = 'Du er for langt væk fra dørklokken',
        nobody_home = 'Der er ingen hjemme..',
    },
    success = {
        receive_apart = 'Du modtog en lejlighed',
        changed_apart = 'Du flyttede lejlighed',
    },
    info = {
        at_the_door = 'Nogen ringer på døren!',
    },
    text = {
        enter = 'Gå ind i lejlighed',
        ring_doorbell = 'Ring Dørklokken',
        logout = 'Log Ud',
        change_outfit = 'Outfits',
        open_stash = 'Åben Lager',
        move_here = 'Flyt Her',
        open_door = 'Åben Dør',
        leave = 'Forlad Lejlighed',
        close_menu = '⬅ Luk Menu',
        tennants = 'Lejere',
    },
}

if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
