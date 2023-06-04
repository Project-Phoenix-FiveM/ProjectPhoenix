local Translations = {
    error = {
        to_far_from_door = 'Du är för långt ifrån dörrklockan',
        nobody_home = 'Det är ingen hemma..',
        nobody_at_door = 'Det är ingen vid dörren...'
    },
    success = {
        receive_apart = 'Du fick en lägenhet',
        changed_apart = 'Du bytte lägenhet',
    },
    info = {
        at_the_door = 'Någon är vid dörren!',
    },
    text = {
        options = '[E] Lägenhetsalternativ',
        enter = 'Gå in i lägenheten',
        ring_doorbell = 'Ring på dörrklockan',
        logout = 'Logga ut karaktär',
        change_outfit = 'Byt kläder',
        open_stash = 'Öppna förråd',
        move_here = 'Flytta hit',
        open_door = 'Öppna dörr',
        leave = 'Lämna lägenhet',
        close_menu = '⬅ Stäng meny',
        tennants = 'Hyresgäster',
    },
}

if GetConvar('qb_locale', 'en') == 'sv' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
