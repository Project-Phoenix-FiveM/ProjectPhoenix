local Translations = {
    notify = {
        ydhk = 'Vous n\'avez pas de clés de ce véhicule.',
        nonear = 'Il n\'y a personne à proximité.',
        vlock = 'Véhicule verrouillé!',
        vunlock = 'Véhicule déverrouillé!',
        vlockpick = 'Vous avez réussi à ouvrir le véhicule!',
        fvlockpick = 'Vous n\'avez pas réussi à ouvrir le véhicule et vous êtes frustré.',
        vgkeys = 'Vous donnez les clés.',
        vgetkeys = 'Vous obtenez les clés du véhicule!',
        fpid = 'Remplissez les arguments ID et plaque.',
        cjackfail = 'Le détournement de voiture a échoué',
        vehclose = 'Thers no close vehicle!',
    },
    progress = {
        takekeys = 'Prend les clés du corps..',
        hskeys = 'Cherche les clés du véhicule..',
        acjack = 'Tentative de vol de carjack..',
    },
    info = {
        skeys = '~g~[H]~w~ - Chercher les clés',
        tlock = 'Verrouiller/Déverrouiller le véhicule',
        palert = 'Vol de véhicule en cours. Type: ',
        engine = 'Allumer/Eteindre le moteur',
    },
    addcom = {
        givekeys = 'Donner les clés à quelqu\'un. Si aucun ID, donne à la personne la plus proche ou à tout le monde dans le véhicule.',
        givekeys_id = 'id',
        givekeys_id_help = 'ID du joueur',
        addkeys = 'Ajouter les clés à un véhicule pour quelqu\'un.',
        addkeys_id = 'id',
        addkeys_id_help = 'ID du joueur',
        addkeys_plate = 'plaque',
        addkeys_plate_help = 'Plaque',
        rkeys = 'Retirer les clés à un véhicule pour quelqu\'un.',
        rkeys_id = 'id',
        rkeys_id_help = 'ID du joueur',
        rkeys_plate = 'plaque',
        rkeys_plate_help = 'Plaque',
    }

}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
