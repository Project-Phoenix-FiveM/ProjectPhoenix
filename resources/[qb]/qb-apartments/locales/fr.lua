local Translations = {
    error = {
        to_far_from_door = 'Vous êtes trop loin de la sonnette',
        nobody_home = 'Il n\'y a personne à la maison..',
        nobody_at_door = 'Il n\'y a personne à la porte...'
    },
    success = {
        receive_apart = 'Vous avez un appartement',
        changed_apart = 'Vous avez changé d\'appartement',
    },
    info = {
        at_the_door = 'Quelqu\'un est à la porte !',
    },
    text = {
        options = '[E] Options d\'appartement',
        enter = 'Entrez dans l\'appartement',
        ring_doorbell = 'Sonnette de porte',
        logout = 'Déconnexion Personnage',
        change_outfit = 'Changez de tenue',
        open_stash = 'Ouvrir le coffre',
        move_here = 'Déplacez-vous ici',
        open_door = 'Ouvrir la porte',
        leave = 'Quitter l\'appartement',
        close_menu = '⬅ Fermer le menu',
        tennants = 'Locataire',
    },
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
