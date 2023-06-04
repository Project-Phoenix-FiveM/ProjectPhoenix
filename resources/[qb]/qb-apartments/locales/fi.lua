local Translations = {
    error = {
        to_far_from_door = 'Olet liian kaukana ovikellosta',
        nobody_home = 'Kukaan ei ole kotona..',
    },
    success = {
        receive_apart = 'Ostit asunnon',
        changed_apart = 'Vaihdoit asuntoa',
    },
    info = {
        at_the_door = 'Joku koputtaa ovella!',
    },
    text = {
        enter = 'Astu sisään asuntoon',
        ring_doorbell = 'Soita ovikelloa',
        logout = 'Vaihda hahmoa',
        change_outfit = 'Vaihda vaatteita',
        open_stash = 'Avaa kaappi',
        move_here = 'Muuta tänne',
        open_door = 'Avaa ovi',
        leave = 'Poistu asunnosta',
        close_menu = '⬅ Sulje valikko',
        tennants = 'Vuokralaiset',
    },
}

if GetConvar('qb_locale', 'en') == 'fi' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
