local Translations = {
    error = {
        to_far_from_door = 'Estás demasiado longe da campainha',
        nobody_home = 'Não está ninguém em casa..',
        nobody_at_door = 'Ninguém á porta...'
    },
    success = {
        receive_apart = 'Adquiriste um apartamento',
        changed_apart = 'Mudaste-te para este apartamento',
    },
    info = {
        at_the_door = 'Está alguém à porta!',
    },
    text = {
        options = '[E] Menu - Apartamento',
        enter = 'Entrar No Apartamento',
        ring_doorbell = 'Tocar À Campainha',
        logout = 'Sair Da Personagem',
        change_outfit = 'Mudar de Roupa',
        open_stash = 'Abrir Baú',
        move_here = 'Mudar Para Cá',
        open_door = 'Abrir Porta',
        leave = 'Sair Do Apartamento',
        close_menu = '⬅ Fechar Menu',
        tennants = 'Moradores',
    },
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
